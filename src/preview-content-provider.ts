import * as mume from "@shd101wyy/mume";
import { CompositeDisposable, TextEditor } from "atom";
import * as fs from "fs";
import * as path from "path";
import { MarkdownPreviewEnhancedConfig } from "./config";

/**
 * Key is editor.getPath()
 * Value is temp html file path.
 */
const HTML_FILES_MAP = {};

/**
 * Key is editor.getPath()
 * Value is MarkdownEngine
 * This data structure prevents MarkdownPreviewEnhancedView from creating
 * markdown engine for one file more than once.
 */
const MARKDOWN_ENGINES_MAP: { [key: string]: mume.MarkdownEngine } = {};

/**
 * The markdown previewer
 */
export class MarkdownPreviewEnhancedView {
  private element: HTMLDivElement = null;
  private webview = null;
  private uri: string = "";
  private disposables: CompositeDisposable = null;

  /**
   * The editor binded to this preview.
   */
  private editor: TextEditor = null;
  /**
   * Configs.
   */
  private config: MarkdownPreviewEnhancedConfig = null;
  /**
   * Markdown engine.
   */
  private engine: mume.MarkdownEngine = null;
  /**
   * An array of strings of js and css file paths.
   */
  private JSAndCssFiles: string[];

  private editorScrollDelay: number = Date.now();
  private scrollTimeout = null;

  private zoomLevel: number = 1;

  // tslint:disable-next-line:variable-name
  private _webviewDOMReady: boolean = false;

  // tslint:disable-next-line:variable-name
  private _destroyCB: (preview: MarkdownPreviewEnhancedView) => void = null;

  constructor(uri: string, config: MarkdownPreviewEnhancedConfig) {
    this.uri = uri;
    this.config = config;

    this.element = document.createElement("div");

    // Prevent atom keyboard event.
    this.element.classList.add("native-key-bindings");
    this.element.classList.add("mpe-preview");

    // Prevent atom context menu from popping up.
    this.element.oncontextmenu = (event) => {
      event.preventDefault();
      event.stopPropagation();
    };

    // Webview for markdown preview.
    // Please note that the webview will load
    // the controller script at:
    // https://github.com/shd101wyy/mume/blob/master/src/webview.ts
    this.webview = document.createElement("webview");
    this.webview.style.width = "100%";
    this.webview.style.height = "100%";
    this.webview.style.border = "none";
    this.webview.src = path.resolve(__dirname, "../../html/loading.html");
    this.webview.preload = mume.utility.addFileProtocol(
      path.resolve(
        mume.utility.extensionDirectoryPath,
        "./dependencies/electron-webview/preload.js",
      ),
    );
    this.webview.setAttribute("enableremotemodule", "true");

    this.webview.addEventListener("dom-ready", () => {
      this._webviewDOMReady = true;
    });
    this.webview.addEventListener(
      "did-stop-loading",
      this.webviewStopLoading.bind(this),
    );
    this.webview.addEventListener(
      "ipc-message",
      this.webviewReceiveMessage.bind(this),
    );
    this.webview.addEventListener(
      "console-message",
      this.webviewConsoleMessage.bind(this),
    );
    // https://github.com/electron/electron/issues/14258#issuecomment-416893856
    this.element.appendChild(this.webview);
  }

  public getURI() {
    return this.uri;
  }

  public getIconName() {
    return "markdown";
  }

  public getTitle() {
    let fileName = "unknown";
    if (this.editor) {
      fileName = this.editor["getFileName"]();
    }
    return `${fileName} preview`;
  }

  private updateTabTitle() {
    if (!this.config.singlePreview) {
      return;
    }

    const title = this.getTitle();
    const tabTitle = document.querySelector(
      '[data-type="MarkdownPreviewEnhancedView"] div.title',
    ) as HTMLElement;
    if (tabTitle) {
      tabTitle.innerText = title;
    }
  }

  private async initEvents() {
    if (this.disposables) {
      // remove all binded events
      this.disposables.dispose();
    }
    this.disposables = new CompositeDisposable();

    // reset tab title
    this.updateTabTitle();

    // reset
    this.JSAndCssFiles = [];

    // init markdown engine
    if (this.editor.getPath() in MARKDOWN_ENGINES_MAP) {
      this.engine = MARKDOWN_ENGINES_MAP[this.editor.getPath()];
    } else {
      this.engine = new mume.MarkdownEngine({
        filePath: this.editor.getPath(),
        projectDirectoryPath: this.getProjectDirectoryPath(),
        config: this.config,
      });
      MARKDOWN_ENGINES_MAP[this.editor.getPath()] = this.engine;
    }

    await this.loadPreview();
    this.initEditorEvents();
    this.initPreviewEvents();
  }

  /**
   * Get the markdown editor for this preview
   */
  public getEditor() {
    return this.editor;
  }

  /**
   * Get markdown engine
   */
  public getMarkdownEngine() {
    return this.engine;
  }

  /**
   * Bind editor to preview
   * @param editor
   */
  public bindEditor(editor: TextEditor) {
    if (!this.editor) {
      this.editor = editor; // this has to be put here, otherwise the tab title will be `unknown`

      let previewPosition = this.config.previewPanePosition;
      if (previewPosition === "center") {
        previewPosition = undefined;
      } else if (
        previewPosition === "left" &&
        atom.workspace.getCenter().getPanes().length === 1
      ) {
        const pane = atom.workspace.getActivePane();
        pane.splitLeft();
        pane.activate();
      } else if (
        previewPosition === "up" &&
        atom.workspace.getCenter().getPanes().length === 1
      ) {
        const pane = atom.workspace.getActivePane();
        pane.splitUp();
        pane.activate();
      }

      atom.workspace
        .open(this.uri, {
          split: previewPosition as any, // left | right | up | down
          activatePane: false,
          activateItem: true, // <= this has to be true otherwise the webview will throw an error.
          searchAllPanes: false,
          initialLine: 0,
          initialColumn: 0,
          pending: false,
        })
        .then(() => {
          this.activatePaneForEditor();
          this.initEvents();
        });
    } else {
      // preview already on
      this.editor = editor;
      this.initEvents();
    }
  }

  /**
   * This function will
   * 1. Create a temp *.html file
   * 2. Write preview html template
   * 3. this.webview will load that *.html file.
   */
  public async loadPreview() {
    const editorFilePath = this.editor.getPath();
    this.postMessage({ command: "startParsingMarkdown" });

    // create temp html file for preview
    let htmlFilePath;
    if (editorFilePath in HTML_FILES_MAP) {
      htmlFilePath = HTML_FILES_MAP[editorFilePath];
    } else {
      const info = await mume.utility.tempOpen({
        prefix: "mpe_preview",
        suffix: ".html",
      });
      htmlFilePath = info.path;
      HTML_FILES_MAP[editorFilePath] = htmlFilePath;
    }

    // load preview template
    const html = await this.engine.generateHTMLTemplateForPreview({
      inputString: this.editor.getText(),
      config: {
        sourceUri: this.editor.getPath(),
        initialLine: this.editor.getCursorBufferPosition().row,
        zoomLevel: this.zoomLevel,
      },
      head: "", // <base url=""> will cause mermaid not able to render arrow.
      // webviewScript: path.resolve(__dirname, './webview.js') // NVM, use default `mume` webview script.
    });
    await mume.utility.writeFile(htmlFilePath, html, { encoding: "utf-8" });

    // load to webview
    await this.waitUtilWebviewDOMReady();
    if (this.webview.getURL() === htmlFilePath) {
      this.webview.reload();
    } else {
      this.webview.loadURL(mume.utility.addFileProtocol(htmlFilePath)); // This will crash Atom if webview is not visible.
    }
  }

  /**
   * Wait until this.webview is attached to DOM and dom-ready event is emitted.
   */
  private async waitUtilWebviewDOMReady(): Promise<void> {
    if (this._webviewDOMReady) {
      return;
    }
    while (true) {
      await mume.utility.sleep(500);
      if (this._webviewDOMReady) {
        return;
      }
    }
  }

  /**
   * Webview finished loading content.
   */
  private async webviewStopLoading() {
    // #584
    while (!this.engine) {
      await mume.utility.sleep(500);
    }
    if (!this.engine.isPreviewInPresentationMode) {
      this.renderMarkdown();
    }
  }

  /**
   * Received message from webview.
   * @param event
   */
  private webviewReceiveMessage(event) {
    const data = event.args[0].data;
    const command = data["command"];
    const args = data["args"];
    if (command in MarkdownPreviewEnhancedView.MESSAGE_DISPATCH_EVENTS) {
      MarkdownPreviewEnhancedView.MESSAGE_DISPATCH_EVENTS[command].apply(
        this,
        args,
      );
    }
  }

  public static MESSAGE_DISPATCH_EVENTS = {
    webviewFinishLoading(sourceUri) {
      /**
       * This event does nothing now, because the preview backgroundIframe
       * `onload` function does this.
       */
      // const preview = getPreviewForEditor(sourceUri)
      // if (preview) preview.renderMarkdown()
    },
    keydown(sourceUri, event) {
      this.webviewKeyDown(event);
    },
    refreshPreview(sourceUri) {
      this.refreshPreview();
    },
    revealLine(sourceUri, line) {
      this._scrollToBufferPosition(line);
    },
    insertImageUrl(sourceUri, imageUrl) {
      if (this.editor) {
        this.editor.insertText(`![enter image description here](${imageUrl})`);
      }
    },
    pasteImageFile(sourceUri, imageUrl) {
      MarkdownPreviewEnhancedView.pasteImageFile(
        this.editor,
        this.config.imageFolderPath,
        imageUrl,
      );
    },
    uploadImageFile(sourceUri, imageUrl, imageUploader) {
      if (!this.editor) {
        return;
      }
      MarkdownPreviewEnhancedView.uploadImageFile(
        this.editor,
        imageUrl,
        imageUploader,
      );
    },
    openInBrowser(sourceUri) {
      this.openInBrowser();
    },
    htmlExport(sourceUri, offline) {
      this.htmlExport(offline);
    },
    chromeExport(sourceUri, fileType) {
      this.chromeExport(fileType);
    },
    princeExport(sourceUri) {
      this.princeExport();
    },
    eBookExport(sourceUri, fileType) {
      this.eBookExport(fileType);
    },
    pandocExport(sourceUri) {
      this.pandocExport();
    },
    markdownExport(sourceUri) {
      this.markdownExport();
    },
    cacheCodeChunkResult(sourceUri, id, result) {
      this.cacheCodeChunkResult(id, result);
    },
    runCodeChunk(sourceUri, codeChunkId) {
      this.runCodeChunk(codeChunkId);
    },
    runAllCodeChunks(sourceUri) {
      this.runAllCodeChunks();
    },
    clickTagA(sourceUri, href) {
      href = decodeURIComponent(href);
      if (
        [".pdf", ".xls", ".xlsx", ".doc", ".ppt", ".docx", ".pptx"].indexOf(
          path.extname(href),
        ) >= 0
      ) {
        mume.utility.openFile(href);
      } else if (href.match(/^file\:\/\//)) {
        // openFilePath = href.slice(8) # remove protocal
        let openFilePath = mume.utility.addFileProtocol(
          href.replace(/(\s*)[\#\?](.+)$/, ""),
        ); // remove #anchor and ?params...
        openFilePath = decodeURI(openFilePath);
        this.activatePaneForEditor();
        atom.workspace.open(mume.utility.removeFileProtocol(openFilePath), {
          activateItem: true,
          activatePane: true,
          initialLine: 0,
          initialColumn: 0,
          split: null,
          pending: false,
          searchAllPanes: true,
        });
      } else {
        mume.utility.openFile(href);
      }
    },
    clickTaskListCheckbox(sourceUri, dataLine) {
      const editor = this.editor;
      if (!editor) {
        return;
      }
      const buffer = editor.buffer;
      if (!buffer) {
        return;
      }
      const lines = buffer.getLines();
      if (dataLine >= lines.length) {
        return;
      }
      let line = lines[dataLine];
      if (line.match(/\[ \]/)) {
        line = line.replace("[ ]", "[x]");
      } else {
        line = line.replace(/\[[xX]\]/, "[ ]");
      }
      buffer.setTextInRange(
        [
          [dataLine, 0],
          [dataLine + 1, 0],
        ],
        line + "\n",
      );
    },
    setZoomLevel(sourceUri, zoomLevel) {
      this.setZoomLevel(zoomLevel);
    },
    showUploadedImageHistory(sourceUri) {
      this.activatePaneForEditor();
      const imageHistoryFilePath = path.resolve(
        mume.getExtensionConfigPath(),
        "./image_history.md",
      );
      atom.workspace.open(imageHistoryFilePath);
    },
    setPreviewTheme(sourceUri, previewTheme) {
      atom.config.set("markdown-preview-enhanced.previewTheme", previewTheme);
    },
  };

  private webviewConsoleMessage(event) {
    // tslint:disable-next-line:no-console
    // console.log("webview: ", event.message);
  }

  private webviewKeyDown(event) {
    let found = false;
    if (event.shiftKey && event.ctrlKey && event.which === 83) {
      // ctrl+shift+s preview sync source
      found = true;
      return this.postMessage({ command: "previewSyncSource" });
    } else if (event.metaKey || event.ctrlKey) {
      // ctrl+c copy
      if (event.which === 67) {
        // [c] copy
        found = true;
        this.postMessage({ command: "copy" });
      } else if (event.which === 187) {
        // [+] zoom in
        found = true;
        this.postMessage({ command: "zommIn" });
      } else if (event.which === 189) {
        // [-] zoom out
        found = true;
        this.postMessage({ command: "zoomOut" });
      } else if (event.which === 48) {
        // [0] reset zoom
        found = true;
        this.postMessage({ command: "resetZoom" });
      } else if (event.which === 38) {
        // [ArrowUp] scroll to the most top
        found = true;
        this.postMessage({ command: "scrollPreviewToTop" });
      }
    } else if (event.which === 27) {
      // [esc] toggle sidebar toc
      found = true;
      this.postMessage({ command: "escPressed" });
    }

    if (found) {
      event.preventDefault();
      event.stopPropagation();
    }
  }

  private initEditorEvents() {
    const editorElement = this.editor["getElement"](); // dunno why `getElement` not found.

    this.disposables.add(
      atom.commands.add(editorElement, {
        "markdown-preview-enhanced:sync-preview": () => {
          this.syncPreview(true);
        },
      }),
    );

    this.disposables.add(
      this.editor.onDidDestroy(() => {
        if (this.disposables) {
          this.disposables.dispose();
          this.disposables = null;
        }
        this.editor = null;

        if (
          !this.config.singlePreview &&
          this.config.closePreviewAutomatically
        ) {
          const pane = atom.workspace.paneForItem(this);
          pane.destroyItem(this); // this will trigger @destroy()
        }
      }),
    );

    this.disposables.add(
      this.editor.onDidStopChanging(() => {
        if (this.config.liveUpdate) {
          this.renderMarkdown();
        }
      }),
    );

    this.disposables.add(
      this.editor.onDidSave(() => {
        this.renderMarkdown(true);
      }),
    );

    this.disposables.add(
      editorElement["onDidChangeScrollTop"](() => {
        if (!this.config.scrollSync) {
          return;
        }
        if (Date.now() < this.editorScrollDelay) {
          return;
        }
        this.syncPreview();
      }),
    );

    this.disposables.add(
      this.editor.onDidChangeCursorPosition((event) => {
        if (!this.config.scrollSync) {
          return;
        }
        if (Date.now() < this.editorScrollDelay) {
          return;
        }

        const screenRow = event.newScreenPosition.row;
        const firstVisibleScreenRow = this.editor["getFirstVisibleScreenRow"]();
        const lastVisibleScreenRow = this.editor["getLastVisibleScreenRow"]();
        const topRatio =
          (screenRow - firstVisibleScreenRow) /
          (lastVisibleScreenRow - firstVisibleScreenRow);

        this.postMessage({
          command: "changeTextEditorSelection",
          line: event.newBufferPosition.row,
          topRatio,
        });
      }),
    );
  }

  private initPreviewEvents() {
    // as esc key doesn't work in atom,
    // I created command.
    this.disposables.add(
      atom.commands.add(this.element, {
        "markdown-preview-enhanced:esc-pressed": () => {
          // tslint:disable-next-line:no-console
          console.log("esc pressed");
        },
      }),
    );
  }

  /**
   * sync preview to match source.
   * @param forced whether to override scroll sync.
   */
  private syncPreview(forced = false) {
    if (!this.editor) {
      return;
    }

    const firstVisibleScreenRow = this.editor["getFirstVisibleScreenRow"]();
    if (firstVisibleScreenRow === 0) {
      return this.postMessage({
        command: "changeTextEditorSelection",
        line: 0,
        topRatio: 0,
        forced,
      });
    }

    const lastVisibleScreenRow = this.editor["getLastVisibleScreenRow"]();
    if (lastVisibleScreenRow === this.editor.getLastScreenRow()) {
      return this.postMessage({
        command: "changeTextEditorSelection",
        line: this.editor.getLastBufferRow(),
        topRatio: 1,
        forced,
      });
    }

    const midBufferRow = this.editor["bufferRowForScreenRow"](
      Math.floor((lastVisibleScreenRow + firstVisibleScreenRow) / 2),
    );

    this.postMessage({
      command: "changeTextEditorSelection",
      line: midBufferRow,
      topRatio: 0.5,
      forced,
    });
  }

  /**
   * Render markdown
   */
  public renderMarkdown(triggeredBySave: boolean = false) {
    if (!this.editor || !this.engine) {
      return;
    }

    // presentation mode
    if (this.engine.isPreviewInPresentationMode) {
      return this.loadPreview(); // restart preview.
    }

    // not presentation mode
    const text = this.editor.getText();

    // notice webview that we started parsing markdown
    this.postMessage({ command: "startParsingMarkdown" });

    this.engine
      .parseMD(text, {
        isForPreview: true,
        useRelativeFilePath: false,
        hideFrontMatter: false,
        triggeredBySave,
      })
      .then(({ markdown, html, tocHTML, JSAndCssFiles, yamlConfig }) => {
        if (
          !mume.utility.isArrayEqual(JSAndCssFiles, this.JSAndCssFiles) ||
          yamlConfig["isPresentationMode"]
        ) {
          this.JSAndCssFiles = JSAndCssFiles;
          this.loadPreview(); // restart preview
        } else {
          this.postMessage({
            command: "updateHTML",
            html,
            tocHTML,
            totalLineCount: this.editor.getLineCount(),
            sourceUri: this.editor.getPath(),
            id: yamlConfig.id || "",
            class: yamlConfig.class || "",
          });
        }
      });
  }

  /**
   * Please notice that row is in center.
   * @param row The buffer row
   */
  public _scrollToBufferPosition(row) {
    if (!this.editor) {
      return;
    }
    if (row < 0) {
      return;
    }
    this.editorScrollDelay = Date.now() + 500;

    if (this.scrollTimeout) {
      clearTimeout(this.scrollTimeout);
    }

    const editorElement = this.editor["getElement"]();
    const delay = 10;
    const screenRow = this.editor.screenPositionForBufferPosition({
      row,
      column: 0,
    }).row;
    const scrollTop =
      screenRow * this.editor["getLineHeightInPixels"]() -
      this.element.offsetHeight / 2;

    const helper = (duration = 0) => {
      this.scrollTimeout = setTimeout(() => {
        if (duration <= 0) {
          this.editorScrollDelay = Date.now() + 500;
          editorElement.setScrollTop(scrollTop);
          return;
        }

        const difference = scrollTop - editorElement.getScrollTop();

        const perTick = (difference / duration) * delay;

        // disable editor onscroll
        this.editorScrollDelay = Date.now() + 500;

        const s = editorElement.getScrollTop() + perTick;
        editorElement.setScrollTop(s);

        if (s === scrollTop) {
          return;
        }
        helper(duration - delay);
      }, delay);
    };

    const scrollDuration = 120;
    helper(scrollDuration);
  }

  /**
   * Get the project directory path of current this.editor
   */
  private getProjectDirectoryPath() {
    return MarkdownPreviewEnhancedView.getProjectDirectoryPathForEditor(
      this.editor,
    );
  }

  /**
   * Get the project directory path of the editor
   */
  public static getProjectDirectoryPathForEditor(editor: TextEditor) {
    if (!editor) {
      return "";
    }

    const editorPath = editor.getPath();
    const projectDirectories = atom.project.getDirectories();

    for (let i = 0; i < projectDirectories.length; i++) {
      const projectDirectory = projectDirectories[i];
      if (projectDirectory.contains(editorPath)) {
        // editor belongs to this project
        return projectDirectory.getPath();
      }
    }
    return "";
  }

  /**
   * Post message to this.webview
   * @param data
   */
  private postMessage(data: any) {
    if (this.webview && this.webview.send && this._webviewDOMReady) {
      this.webview.send("_postMessage", data);
    }
  }

  public updateConfiguration() {
    if (this.config.singlePreview) {
      for (const sourceUri in MARKDOWN_ENGINES_MAP) {
        if (MARKDOWN_ENGINES_MAP.hasOwnProperty(sourceUri)) {
          MARKDOWN_ENGINES_MAP[sourceUri].updateConfiguration(this.config);
        }
      }
    } else if (this.engine) {
      this.engine.updateConfiguration(this.config);
    }
  }

  public refreshPreview() {
    if (this.engine) {
      this.engine.clearCaches();
      // restart webview
      this.loadPreview();
    }
  }

  public openInBrowser() {
    this.engine.openInBrowser({}).catch((error) => {
      atom.notifications.addError(error.toString());
    });
  }

  public htmlExport(offline) {
    atom.notifications.addInfo("Your document is being prepared");
    this.engine
      .htmlExport({ offline })
      .then((dest) => {
        atom.notifications.addSuccess(
          `File \`${path.basename(dest)}\` was created at path: \`${dest}\``,
        );
      })
      .catch((error) => {
        atom.notifications.addError(error.toString());
      });
  }

  public chromeExport(fileType = "pdf") {
    atom.notifications.addInfo("Your document is being prepared");
    this.engine
      .chromeExport({ fileType, openFileAfterGeneration: true })
      .then((dest) => {
        atom.notifications.addSuccess(
          `File \`${path.basename(dest)}\` was created at path: \`${dest}\``,
        );
      })
      .catch((error) => {
        atom.notifications.addError(error.toString());
      });
  }

  public princeExport() {
    atom.notifications.addInfo("Your document is being prepared");
    this.engine
      .princeExport({ openFileAfterGeneration: true })
      .then((dest) => {
        if (dest.endsWith("?print-pdf")) {
          // presentation pdf
          atom.notifications.addSuccess(
            `Please copy and open the following link in Chrome, then print as PDF`,
            {
              dismissable: true,
              detail: `Path: \`${dest}\``,
            },
          );
        } else {
          atom.notifications.addSuccess(
            `File \`${path.basename(dest)}\` was created at path: \`${dest}\``,
          );
        }
      })
      .catch((error) => {
        atom.notifications.addError(error.toString());
      });
  }

  public eBookExport(fileType) {
    atom.notifications.addInfo("Your document is being prepared");
    this.engine
      .eBookExport({ fileType })
      .then((dest) => {
        atom.notifications.addSuccess(
          `File \`${path.basename(dest)}\` was created at path: \`${dest}\``,
        );
      })
      .catch((error) => {
        atom.notifications.addError(error.toString());
      });
  }

  public pandocExport() {
    atom.notifications.addInfo("Your document is being prepared");
    this.engine
      .pandocExport({ openFileAfterGeneration: true })
      .then((dest) => {
        atom.notifications.addSuccess(
          `File \`${path.basename(dest)}\` was created at path: \`${dest}\``,
        );
      })
      .catch((error) => {
        atom.notifications.addError(error.toString());
      });
  }

  public markdownExport() {
    atom.notifications.addInfo("Your document is being prepared");
    this.engine
      .markdownExport({})
      .then((dest) => {
        atom.notifications.addSuccess(
          `File \`${path.basename(dest)}\` was created at path: \`${dest}\``,
        );
      })
      .catch((error) => {
        atom.notifications.addError(error.toString());
      });
  }

  public cacheCodeChunkResult(id, result) {
    this.engine.cacheCodeChunkResult(id, result);
  }

  public runCodeChunk(codeChunkId: string) {
    if (!this.engine) {
      return;
    }
    this.engine.runCodeChunk(codeChunkId).then(() => {
      this.renderMarkdown();
    });
  }

  public runAllCodeChunks() {
    if (!this.engine) {
      return;
    }
    this.engine.runCodeChunks().then(() => {
      this.renderMarkdown();
    });
  }

  public sendRunCodeChunkCommand() {
    this.postMessage({ command: "runCodeChunk" });
  }

  public startImageHelper() {
    this.postMessage({ command: "openImageHelper" });
  }

  public setZoomLevel(zoomLevel: number) {
    this.zoomLevel = zoomLevel || 1;
  }

  public static async pasteImageFile(
    editor: TextEditor,
    imageFolderPath: string,
    imageFilePath: string,
  ) {
    if (!editor) {
      return;
    }
    let imageFileName = path.basename(imageFilePath);
    const projectDirectoryPath = MarkdownPreviewEnhancedView.getProjectDirectoryPathForEditor(
      editor,
    );
    let assetDirectoryPath;
    let description;
    if (imageFolderPath[0] === "/") {
      assetDirectoryPath = path.resolve(
        projectDirectoryPath,
        "." + imageFolderPath,
      );
    } else {
      assetDirectoryPath = path.resolve(
        path.dirname(editor.getPath()),
        imageFolderPath,
      );
    }

    const destPath = path.resolve(
      assetDirectoryPath,
      path.basename(imageFilePath),
    );

    fs.mkdir(assetDirectoryPath, (error) => {
      fs.stat(destPath, (err, stat) => {
        if (err == null) {
          // file existed
          const lastDotOffset = imageFileName.lastIndexOf(".");
          const uid =
            "_" +
            Math.random()
              .toString(36)
              .substr(2, 9);

          if (lastDotOffset > 0) {
            description = imageFileName.slice(0, lastDotOffset);
            imageFileName =
              imageFileName.slice(0, lastDotOffset) +
              uid +
              imageFileName.slice(lastDotOffset, imageFileName.length);
          } else {
            description = imageFileName;
            imageFileName = imageFileName + uid;
          }

          fs.createReadStream(imageFilePath).pipe(
            fs.createWriteStream(
              path.resolve(assetDirectoryPath, imageFileName),
            ),
          );
        } else if (err.code === "ENOENT") {
          // file doesn't exist
          fs.createReadStream(imageFilePath).pipe(
            fs.createWriteStream(destPath),
          );

          if (imageFileName.lastIndexOf(".")) {
            description = imageFileName.slice(
              0,
              imageFileName.lastIndexOf("."),
            );
          } else {
            description = imageFileName;
          }
        } else {
          return atom.notifications.addError(err.toString());
        }

        atom.notifications.addInfo(
          `Image ${imageFileName} has been copied to folder ${assetDirectoryPath}`,
        );

        let url = `${imageFolderPath}/${imageFileName}`;
        if (url.indexOf(" ") >= 0) {
          url = url.replace(/ /g, "%20");
        }

        editor.insertText(`![${description}](${url})`);
      });
    });
  }

  private static replaceHint(
    editor: TextEditor,
    bufferRow: number,
    hint: string,
    withStr: string,
  ): boolean {
    if (!editor) {
      return false;
    }
    const lines = editor.getBuffer().getLines();
    const textLine = lines[bufferRow] || "";
    if (textLine.indexOf(hint) >= 0) {
      editor.getBuffer().setTextInRange(
        [
          [bufferRow, 0],
          [bufferRow, textLine.length],
        ],
        textLine.replace(hint, withStr),
      );
      return true;
    }
    return false;
  }

  private static setUploadedImageURL(
    editor: TextEditor,
    imageFileName: string,
    url: string,
    hint: string,
    bufferRow: number,
  ) {
    let description;
    if (imageFileName.lastIndexOf(".")) {
      description = imageFileName.slice(0, imageFileName.lastIndexOf("."));
    } else {
      description = imageFileName;
    }

    const withStr = `![${description}](${url})`;

    if (!this.replaceHint(editor, bufferRow, hint, withStr)) {
      let i = bufferRow - 20;
      while (i <= bufferRow + 20) {
        if (this.replaceHint(editor, i, hint, withStr)) {
          break;
        }
        i++;
      }
    }
  }

  /**
   * Upload image at imageFilePath by this.config.imageUploader.
   * Then insert markdown image url to markdown file.
   * @param imageFilePath
   */
  public static uploadImageFile(
    editor: TextEditor,
    imageFilePath: string,
    imageUploader: string = "imgur",
  ) {
    if (!editor) {
      return;
    }

    const imageFileName = path.basename(imageFilePath);

    const uid = Math.random()
      .toString(36)
      .substr(2, 9);
    const hint = `![Uploading ${imageFileName}… (${uid})]()`;
    const bufferRow = editor.getCursorBufferPosition().row;
    const AccessKey =
      atom.config.get("markdown-preview-enhanced.AccessKey") || "";
    const SecretKey =
      atom.config.get("markdown-preview-enhanced.SecretKey") || "";
    const Bucket = atom.config.get("markdown-preview-enhanced.Bucket") || "";
    const Domain = atom.config.get("markdown-preview-enhanced.Domain") || "";

    editor.insertText(hint);

    mume.utility
      .uploadImage(imageFilePath, {
        method: imageUploader,
        qiniu: { AccessKey, SecretKey, Bucket, Domain },
      })
      .then((url) => {
        this.setUploadedImageURL(editor, imageFileName, url, hint, bufferRow);
      })
      .catch((err) => {
        atom.notifications.addError(err.toString());
      });
  }

  private activatePaneForEditor() {
    if (this.editor) {
      const pane = atom.workspace.paneForItem(this.editor);
      pane.activate();
    }
  }

  public destroy() {
    if (this.disposables) {
      this.disposables.dispose();
      this.disposables = null;
    }
    this.element.remove();
    this.editor = null;

    if (this._destroyCB) {
      this._destroyCB(this);
    }
  }

  /**
   * cb will be called when this preview is destroyed.
   * @param cb
   */
  public onPreviewDidDestroy(
    cb: (preview: MarkdownPreviewEnhancedView) => void,
  ) {
    this._destroyCB = cb;
  }
}

export function isMarkdownFile(sourcePath: string): boolean {
  return false;
}
