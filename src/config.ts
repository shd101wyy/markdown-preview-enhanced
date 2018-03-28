import { CompositeDisposable } from "atom";
import { MarkdownEngineConfig } from "mume-with-litvis";
import { MathRenderingOption } from "mume-with-litvis/out/src/markdown-engine-config";

export class MarkdownPreviewEnhancedConfig implements MarkdownEngineConfig {
  public static getCurrentConfig() {
    return new MarkdownPreviewEnhancedConfig();
  }

  /*
   * MarkdownEngineConfig properties
   */
  public usePandocParser: boolean;
  public breakOnSingleNewLine: boolean;
  public enableTypographer: boolean;
  public enableWikiLinkSyntax: boolean;
  public wikiLinkFileExtension: string;
  public enableEmojiSyntax: boolean;
  public enableExtendedTableSyntax: boolean;
  public enableCriticMarkupSyntax: boolean;
  public protocolsWhiteList: string;
  public mathRenderingOption: MathRenderingOption;
  public mathInlineDelimiters: string[][];
  public mathBlockDelimiters: string[][];
  public codeBlockTheme: string;
  public previewTheme: string;
  public revealjsTheme: string;
  public mermaidTheme: string;
  public frontMatterRenderingOption: string;
  public imageFolderPath: string;
  public printBackground: boolean;
  public phantomPath: string;
  public pandocPath: string;
  public pandocMarkdownFlavor: string;
  public pandocArguments: string[];
  public latexEngine: string;
  public enableScriptExecution: boolean;

  /*
   * Extra config for mpe
   */

  public fileExtension: string[];
  public singlePreview: boolean;
  public scrollSync: boolean;
  public liveUpdate: boolean;
  public previewPanePosition: string;
  public openPreviewPaneAutomatically: boolean;
  public automaticallyShowPreviewOfMarkdownBeingEdited: boolean;
  public closePreviewAutomatically: boolean;
  // public enableZenMode: boolean
  public imageUploader: string;
  public imageDropAction: string;

  public constructor() {
    /*
     * MarkdownEngineConfig properties
     */
    this.usePandocParser = atom.config.get(
      "markdown-preview-enhanced-with-litvis.usePandocParser",
    );
    this.breakOnSingleNewLine = atom.config.get(
      "markdown-preview-enhanced-with-litvis.breakOnSingleNewLine",
    );
    this.enableTypographer = atom.config.get(
      "markdown-preview-enhanced-with-litvis.enableTypographer",
    );
    this.enableWikiLinkSyntax = atom.config.get(
      "markdown-preview-enhanced-with-litvis.enableWikiLinkSyntax",
    );
    this.enableEmojiSyntax = atom.config.get(
      "markdown-preview-enhanced-with-litvis.enableEmojiSyntax",
    );
    this.enableExtendedTableSyntax = atom.config.get(
      "markdown-preview-enhanced-with-litvis.enableExtendedTableSyntax",
    );
    this.enableCriticMarkupSyntax = atom.config.get(
      "markdown-preview-enhanced-with-litvis.enableCriticMarkupSyntax",
    );
    this.wikiLinkFileExtension = atom.config.get(
      "markdown-preview-enhanced-with-litvis.wikiLinkFileExtension",
    );
    this.protocolsWhiteList = atom.config.get(
      "markdown-preview-enhanced-with-litvis.protocolsWhiteList",
    );
    this.mathRenderingOption = atom.config.get(
      "markdown-preview-enhanced-with-litvis.mathRenderingOption",
    );

    try {
      this.mathInlineDelimiters = JSON.parse(
        atom.config.get("markdown-preview-enhanced-with-litvis.mathInlineDelimiters"),
      );
    } catch (error) {
      this.mathInlineDelimiters = [["$", "$"], ["\\(", "\\)"]];
    }
    try {
      this.mathBlockDelimiters = JSON.parse(
        atom.config.get("markdown-preview-enhanced-with-litvis.mathBlockDelimiters"),
      );
    } catch (error) {
      this.mathBlockDelimiters = [["$$", "$$"], ["\\[", "\\]"]];
    }

    this.codeBlockTheme = atom.config.get(
      "markdown-preview-enhanced-with-litvis.codeBlockTheme",
    );
    this.previewTheme = atom.config.get(
      "markdown-preview-enhanced-with-litvis.previewTheme",
    );
    this.revealjsTheme = atom.config.get(
      "markdown-preview-enhanced-with-litvis.revealjsTheme",
    );
    this.mermaidTheme = atom.config.get(
      "markdown-preview-enhanced-with-litvis.mermaidTheme",
    );
    this.frontMatterRenderingOption = atom.config.get(
      "markdown-preview-enhanced-with-litvis.frontMatterRenderingOption",
    );
    this.imageFolderPath = atom.config.get(
      "markdown-preview-enhanced-with-litvis.imageFolderPath",
    );
    this.printBackground = atom.config.get(
      "markdown-preview-enhanced-with-litvis.printBackground",
    );
    this.phantomPath = atom.config.get("markdown-preview-enhanced-with-litvis.phantomPath");
    this.pandocPath = atom.config.get("markdown-preview-enhanced-with-litvis.pandocPath");
    this.pandocMarkdownFlavor = atom.config.get(
      "markdown-preview-enhanced-with-litvis.pandocMarkdownFlavor",
    );
    this.pandocArguments =
      atom.config
        .get("markdown-preview-enhanced-with-litvis.pandocArguments")
        .split(",")
        .map((x) => x.trim())
        .filter((x) => x.length) || [];
    this.latexEngine = atom.config.get("markdown-preview-enhanced-with-litvis.latexEngine");
    this.enableScriptExecution = atom.config.get(
      "markdown-preview-enhanced-with-litvis.enableScriptExecution",
    );

    /*
     * Extra configs for mpe
     */
    this.fileExtension = atom.config
      .get("markdown-preview-enhanced-with-litvis.fileExtension")
      .split(",")
      .map((x) => x.trim())
      .filter((x) => x.length) || [".md", ".mmark", ".markdown"];
    this.singlePreview = atom.config.get(
      "markdown-preview-enhanced-with-litvis.singlePreview",
    );
    this.scrollSync = atom.config.get("markdown-preview-enhanced-with-litvis.scrollSync");
    this.liveUpdate = atom.config.get("markdown-preview-enhanced-with-litvis.liveUpdate");
    this.previewPanePosition = atom.config.get(
      "markdown-preview-enhanced-with-litvis.previewPanePosition",
    );
    this.openPreviewPaneAutomatically = atom.config.get(
      "markdown-preview-enhanced-with-litvis.openPreviewPaneAutomatically",
    );
    this.automaticallyShowPreviewOfMarkdownBeingEdited = atom.config.get(
      "markdown-preview-enhanced-with-litvis.automaticallyShowPreviewOfMarkdownBeingEdited",
    );
    this.closePreviewAutomatically = atom.config.get(
      "markdown-preview-enhanced-with-litvis.closePreviewAutomatically",
    );
    // this.enableZenMode = atom.config.get('markdown-preview-enhanced-with-litvis.enableZenMode')
    this.imageUploader = atom.config.get(
      "markdown-preview-enhanced-with-litvis.imageUploader",
    );
    this.imageDropAction = atom.config.get(
      "markdown-preview-enhanced-with-litvis.imageDropAction",
    );
  }

  public onDidChange(subscriptions: CompositeDisposable, callback) {
    subscriptions.add(
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.usePandocParser",
        ({ newValue }) => {
          this.usePandocParser = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.breakOnSingleNewLine",
        ({ newValue }) => {
          this.breakOnSingleNewLine = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.enableTypographer",
        ({ newValue }) => {
          this.enableTypographer = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.enableWikiLinkSyntax",
        ({ newValue }) => {
          this.enableWikiLinkSyntax = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.enableEmojiSyntax",
        ({ newValue }) => {
          this.enableEmojiSyntax = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.enableExtendedTableSyntax",
        ({ newValue }) => {
          this.enableExtendedTableSyntax = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.enableCriticMarkupSyntax",
        ({ newValue }) => {
          this.enableCriticMarkupSyntax = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.wikiLinkFileExtension",
        ({ newValue }) => {
          this.wikiLinkFileExtension = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.protocolsWhiteList",
        ({ newValue }) => {
          this.protocolsWhiteList = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.mathRenderingOption",
        ({ newValue }) => {
          this.mathRenderingOption = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.mathInlineDelimiters",
        ({ newValue }) => {
          let mathInlineDelimiters;
          try {
            mathInlineDelimiters = JSON.parse(newValue);
            if (
              JSON.stringify(mathInlineDelimiters) !==
              JSON.stringify(this.mathInlineDelimiters)
            ) {
              this.mathInlineDelimiters = mathInlineDelimiters;
              callback();
            }
          } catch (error) {
            mathInlineDelimiters = [["$", "$"], ["\\(", "\\)"]];
          }
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.mathBlockDelimiters",
        ({ newValue }) => {
          let mathBlockDelimiters;
          try {
            mathBlockDelimiters = JSON.parse(newValue);
            if (
              JSON.stringify(mathBlockDelimiters) !==
              JSON.stringify(this.mathBlockDelimiters)
            ) {
              this.mathBlockDelimiters = mathBlockDelimiters;
              callback();
            }
          } catch (error) {
            mathBlockDelimiters = [["$$", "$$"], ["\\[", "\\]"]];
          }
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.codeBlockTheme",
        ({ newValue }) => {
          this.codeBlockTheme = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.previewTheme",
        ({ newValue }) => {
          this.previewTheme = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.revealjsTheme",
        ({ newValue }) => {
          this.revealjsTheme = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.mermaidTheme",
        ({ newValue }) => {
          this.mermaidTheme = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.frontMatterRenderingOption",
        ({ newValue }) => {
          this.frontMatterRenderingOption = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.imageFolderPath",
        ({ newValue }) => {
          this.imageFolderPath = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.printBackground",
        ({ newValue }) => {
          this.printBackground = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.phantomPath",
        ({ newValue }) => {
          this.phantomPath = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.pandocPath",
        ({ newValue }) => {
          this.pandocPath = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.pandocMarkdownFlavor",
        ({ newValue }) => {
          this.pandocMarkdownFlavor = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.pandocArguments",
        ({ newValue }) => {
          this.pandocArguments =
            newValue
              .split(",")
              .map((x) => x.trim())
              .filter((x) => x.length) || [];
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.latexEngine",
        ({ newValue }) => {
          this.latexEngine = newValue;
          // callback()
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.enableScriptExecution",
        ({ newValue }) => {
          this.enableScriptExecution = newValue;
          callback();
        },
      ),

      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.fileExtension",
        ({ newValue }) => {
          this.fileExtension =
            newValue
              .split(",")
              .map((x) => x.trim())
              .filter((x) => x.length) || [];
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.singlePreview",
        ({ newValue }) => {
          this.singlePreview = newValue;
          // callback() // <= No need to call callback. will cause error here.
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.scrollSync",
        ({ newValue }) => {
          this.scrollSync = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.liveUpdate",
        ({ newValue }) => {
          this.liveUpdate = newValue;
          // callback()
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.previewPanePosition",
        ({ newValue }) => {
          this.previewPanePosition = newValue;
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.openPreviewPaneAutomatically",
        ({ newValue }) => {
          this.openPreviewPaneAutomatically = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.automaticallyShowPreviewOfMarkdownBeingEdited",
        ({ newValue }) => {
          this.automaticallyShowPreviewOfMarkdownBeingEdited = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.closePreviewAutomatically",
        ({ newValue }) => {
          this.closePreviewAutomatically = newValue;
          callback();
        },
      ),
      /*
      atom.config.onDidChange('markdown-preview-enhanced-with-litvis.enableZenMode', ({newValue})=> {
        this.enableZenMode = newValue
        // callback()
      }),
      */
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.imageUploader",
        ({ newValue }) => {
          this.imageUploader = newValue;
          callback();
        },
      ),
      atom.config.onDidChange(
        "markdown-preview-enhanced-with-litvis.imageDropAction",
        ({ newValue }) => {
          this.imageDropAction = newValue;
        },
      ),
    );
  }

  [key: string]: any;
}
