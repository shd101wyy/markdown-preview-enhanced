"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const atom_1 = require("atom");
const path = require("path");
const mume = require("@shd101wyy/mume");
/**
 * Key is editor.getPath()
 * Value is temp html file path.
 */
const HTML_FILES_MAP = {};
/**
 * The markdown previewer
 */
class MarkdownPreviewEnhancedView {
    constructor(uri, config) {
        this.element = null;
        this.iframe = null;
        this.uri = '';
        this.disposables = null;
        /**
         * The editor binded to this preview
         */
        this.editor = null;
        /**
         * Configs
         */
        this.config = null;
        /**
         * Markdown engine
         */
        this.engine = null;
        this.uri = uri;
        this.config = config;
        this.element = document.createElement('div');
        this.iframe = document.createElement('iframe');
        this.iframe.style.width = '100%';
        this.iframe.style.height = '100%';
        this.iframe.style.border = 'none';
        this.element.appendChild(this.iframe);
    }
    getURI() {
        return this.uri;
    }
    getIconName() {
        return 'markdown';
    }
    getTitle() {
        return 'mpe preview';
    }
    /**
     * Get the markdown editor for this preview
     */
    getEditor() {
        return this.editor;
    }
    /**
     * Bind editor to preview
     * @param editor
     */
    bindEditor(editor) {
        if (!this.editor) {
            atom.workspace.open(this.uri, {
                split: "right",
                activatePane: false,
                activateItem: false,
                searchAllPanes: false,
                initialLine: 0,
                initialColumn: 0,
                pending: false
            })
                .then(() => {
                this.editor = editor;
                this.initEvents();
            });
        }
        else {
            this.editor = editor;
            this.initEvents();
        }
    }
    initEvents() {
        return __awaiter(this, void 0, void 0, function* () {
            if (this.disposables) {
                this.disposables.dispose();
            }
            this.disposables = new atom_1.CompositeDisposable();
            // reset 
            this.JSAndCssFiles = [];
            // init markdown engine 
            this.engine = new mume.MarkdownEngine({
                filePath: this.editor.getPath(),
                projectDirectoryPath: this.getProjectDirectoryPath(),
                config: this.config
            });
            yield this.loadPreview();
            this.initEditorEvents();
        });
    }
    /**
     * This function will
     * 1. Create a temp *.html file
     * 2. Write preview html template
     * 3. this.iframe will load that *.html file.
     */
    loadPreview() {
        return __awaiter(this, void 0, void 0, function* () {
            const editorFilePath = this.editor.getPath();
            // create temp html file for preview
            let htmlFilePath;
            if (editorFilePath in HTML_FILES_MAP) {
                htmlFilePath = HTML_FILES_MAP[editorFilePath];
            }
            else {
                const info = yield mume.utility.tempOpen({ prefix: 'mpe_preview', suffix: '.html' });
                htmlFilePath = info.path;
                HTML_FILES_MAP[editorFilePath] = htmlFilePath;
            }
            // load preview template
            const html = yield this.engine.generateHTMLTemplateForPreview({
                inputString: this.editor.getText(),
                config: {
                    sourceUri: this.editor.getPath(),
                    initialLine: this.editor.getCursorBufferPosition().row
                },
                webviewScript: path.resolve(__dirname, './webview.js')
            });
            yield mume.utility.writeFile(htmlFilePath, html, { encoding: 'utf-8' });
            // load to iframe
            if (this.iframe.src === htmlFilePath) {
                this.iframe.contentWindow.location.reload();
            }
            else {
                this.iframe.src = htmlFilePath;
            }
            // test postMessage
            /*
            setTimeout(()=> {
              this.iframe.contentWindow.postMessage({type: 'update-html'}, 'file://')
            }, 2000)
            */
        });
    }
    initEditorEvents() {
        const editorElement = this.editor['getElement'](); // dunno why `getElement` not found.
        this.disposables.add(atom.commands.add(editorElement, {
            'markdown-preview-enhanced:sync-preview': () => this.syncPreview()
        }));
        this.disposables.add(this.editor.onDidDestroy(() => {
            if (this.disposables) {
                this.disposables.dispose();
                this.disposables = null;
            }
            this.editor = null;
            if (!this.config.singlePreview && this.config.closePreviewAutomatically) {
                const pane = atom.workspace.paneForItem(this);
                pane.destroyItem(this); // this will trigger @destroy()
            }
        }));
        this.disposables.add(this.editor.onDidStopChanging(() => {
            if (this.config.liveUpdate)
                this.renderMarkdown();
        }));
        this.disposables.add(this.editor.onDidSave(() => {
            if (!this.config.liveUpdate)
                this.renderMarkdown(true);
        }));
        this.disposables.add(this.editor['onDidChangeScrollTop'](() => {
        }));
        this.disposables.add(this.editor.onDidChangeCursorPosition((event) => {
        }));
    }
    syncPreview() {
    }
    /**
     * Render markdown
     */
    renderMarkdown(triggeredBySave = false) {
        // presentation mode 
        if (this.engine.isPreviewInPresentationMode) {
            this.loadPreview(); // restart preview.
        }
        // not presentation mode 
        const text = this.editor.getText();
        // notice iframe that we started parsing markdown
        this.postMessage({ command: 'startParsingMarkdown' });
        this.engine.parseMD(text, { isForPreview: true, useRelativeFilePath: false, hideFrontMatter: false, triggeredBySave })
            .then(({ markdown, html, tocHTML, JSAndCssFiles, yamlConfig }) => {
            if (!mume.utility.isArrayEqual(JSAndCssFiles, this.JSAndCssFiles) || yamlConfig['isPresentationMode']) {
                this.loadPreview(); // restart preview
            }
            else {
                this.postMessage({
                    command: 'updateHTML',
                    html,
                    tocHTML,
                    totalLineCount: this.editor.getLineCount(),
                    sourceUri: this.editor.getPath(),
                    id: yamlConfig.id || '',
                    class: yamlConfig.class || ''
                });
            }
        });
    }
    /**
     * Get the project directory path of current this.editor
     */
    getProjectDirectoryPath() {
        if (!this.editor)
            return '';
        const editorPath = this.editor.getPath();
        const projectDirectories = atom.project.getDirectories();
        for (let i = 0; i < projectDirectories.length; i++) {
            const projectDirectory = projectDirectories[i];
            if (projectDirectory.contains(editorPath))
                return projectDirectory.getPath();
        }
        return '';
    }
    /**
     * Post message to this.iframe
     * @param data
     */
    postMessage(data) {
        if (this.iframe)
            this.iframe.contentWindow.postMessage(data, 'file://');
    }
    updateConfiguration() {
        if (this.engine) {
            this.engine.updateConfiguration(this.config);
        }
    }
    refreshPreview() {
        if (this.engine) {
            this.engine.clearCaches();
            // restart iframe 
            this.loadPreview();
        }
    }
    runCodeChunk(codeChunkId) {
        if (!this.engine)
            return;
        this.engine.runCodeChunk(codeChunkId)
            .then(() => {
            this.renderMarkdown();
        });
    }
    runAllCodeChunks() {
        if (!this.engine)
            return;
        this.engine.runAllCodeChunks()
            .then(() => {
            this.renderMarkdown();
        });
    }
    sendRunCodeChunkCommand() {
        this.postMessage({ command: 'runCodeChunk' });
    }
    startImageHelper() {
        this.postMessage({ command: 'openImageHelper' });
    }
    destroy() {
        this.element.remove();
        this.editor = null;
        if (this.disposables) {
            this.disposables.dispose();
            this.disposables = null;
        }
    }
}
exports.MarkdownPreviewEnhancedView = MarkdownPreviewEnhancedView;
function isMarkdownFile(sourcePath) {
    return false;
}
exports.isMarkdownFile = isMarkdownFile;
