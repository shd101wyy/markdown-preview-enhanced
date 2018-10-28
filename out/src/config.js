"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class MarkdownPreviewEnhancedConfig {
    static getCurrentConfig() {
        return new MarkdownPreviewEnhancedConfig();
    }
    constructor() {
        /*
         * MarkdownEngineConfig properties
         */
        this.usePandocParser = atom.config.get("markdown-preview-enhanced.usePandocParser");
        this.breakOnSingleNewLine = atom.config.get("markdown-preview-enhanced.breakOnSingleNewLine");
        this.enableTypographer = atom.config.get("markdown-preview-enhanced.enableTypographer");
        this.enableLinkify = atom.config.get("markdown-preview-enhanced.enableLinkify");
        this.enableWikiLinkSyntax = atom.config.get("markdown-preview-enhanced.enableWikiLinkSyntax");
        this.enableEmojiSyntax = atom.config.get("markdown-preview-enhanced.enableEmojiSyntax");
        this.enableExtendedTableSyntax = atom.config.get("markdown-preview-enhanced.enableExtendedTableSyntax");
        this.enableCriticMarkupSyntax = atom.config.get("markdown-preview-enhanced.enableCriticMarkupSyntax");
        this.wikiLinkFileExtension = atom.config.get("markdown-preview-enhanced.wikiLinkFileExtension");
        this.protocolsWhiteList = atom.config.get("markdown-preview-enhanced.protocolsWhiteList");
        this.mathRenderingOption = atom.config.get("markdown-preview-enhanced.mathRenderingOption");
        try {
            this.mathInlineDelimiters = JSON.parse(atom.config.get("markdown-preview-enhanced.mathInlineDelimiters"));
        }
        catch (error) {
            this.mathInlineDelimiters = [["$", "$"], ["\\(", "\\)"]];
        }
        try {
            this.mathBlockDelimiters = JSON.parse(atom.config.get("markdown-preview-enhanced.mathBlockDelimiters"));
        }
        catch (error) {
            this.mathBlockDelimiters = [["$$", "$$"], ["\\[", "\\]"]];
        }
        this.codeBlockTheme = atom.config.get("markdown-preview-enhanced.codeBlockTheme");
        this.previewTheme = atom.config.get("markdown-preview-enhanced.previewTheme");
        this.revealjsTheme = atom.config.get("markdown-preview-enhanced.revealjsTheme");
        this.mermaidTheme = atom.config.get("markdown-preview-enhanced.mermaidTheme");
        this.frontMatterRenderingOption = atom.config.get("markdown-preview-enhanced.frontMatterRenderingOption");
        this.imageFolderPath = atom.config.get("markdown-preview-enhanced.imageFolderPath");
        this.printBackground = atom.config.get("markdown-preview-enhanced.printBackground");
        this.phantomPath = atom.config.get("markdown-preview-enhanced.phantomPath");
        this.pandocPath = atom.config.get("markdown-preview-enhanced.pandocPath");
        this.pandocMarkdownFlavor = atom.config.get("markdown-preview-enhanced.pandocMarkdownFlavor");
        this.pandocArguments =
            atom.config
                .get("markdown-preview-enhanced.pandocArguments")
                .split(",")
                .map((x) => x.trim())
                .filter((x) => x.length) || [];
        this.latexEngine = atom.config.get("markdown-preview-enhanced.latexEngine");
        this.enableScriptExecution = atom.config.get("markdown-preview-enhanced.enableScriptExecution");
        /*
         * Extra configs for mpe
         */
        this.fileExtension = atom.config
            .get("markdown-preview-enhanced.fileExtension")
            .split(",")
            .map((x) => x.trim())
            .filter((x) => x.length) || [".md", ".mmark", ".markdown"];
        this.singlePreview = atom.config.get("markdown-preview-enhanced.singlePreview");
        this.scrollSync = atom.config.get("markdown-preview-enhanced.scrollSync");
        this.liveUpdate = atom.config.get("markdown-preview-enhanced.liveUpdate");
        this.previewPanePosition = atom.config.get("markdown-preview-enhanced.previewPanePosition");
        this.openPreviewPaneAutomatically = atom.config.get("markdown-preview-enhanced.openPreviewPaneAutomatically");
        this.automaticallyShowPreviewOfMarkdownBeingEdited = atom.config.get("markdown-preview-enhanced.automaticallyShowPreviewOfMarkdownBeingEdited");
        this.closePreviewAutomatically = atom.config.get("markdown-preview-enhanced.closePreviewAutomatically");
        // this.enableZenMode = atom.config.get('markdown-preview-enhanced.enableZenMode')
        this.imageUploader = atom.config.get("markdown-preview-enhanced.imageUploader");
        this.imageDropAction = atom.config.get("markdown-preview-enhanced.imageDropAction");
    }
    onDidChange(subscriptions, callback) {
        subscriptions.add(atom.config.onDidChange("markdown-preview-enhanced.usePandocParser", ({ newValue }) => {
            this.usePandocParser = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.breakOnSingleNewLine", ({ newValue }) => {
            this.breakOnSingleNewLine = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.enableTypographer", ({ newValue }) => {
            this.enableTypographer = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.enableLinkify", ({ newValue }) => {
            this.enableLinkify = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.enableWikiLinkSyntax", ({ newValue }) => {
            this.enableWikiLinkSyntax = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.enableEmojiSyntax", ({ newValue }) => {
            this.enableEmojiSyntax = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.enableExtendedTableSyntax", ({ newValue }) => {
            this.enableExtendedTableSyntax = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.enableCriticMarkupSyntax", ({ newValue }) => {
            this.enableCriticMarkupSyntax = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.wikiLinkFileExtension", ({ newValue }) => {
            this.wikiLinkFileExtension = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.protocolsWhiteList", ({ newValue }) => {
            this.protocolsWhiteList = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.mathRenderingOption", ({ newValue }) => {
            this.mathRenderingOption = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.mathInlineDelimiters", ({ newValue }) => {
            let mathInlineDelimiters;
            try {
                mathInlineDelimiters = JSON.parse(newValue);
                if (JSON.stringify(mathInlineDelimiters) !==
                    JSON.stringify(this.mathInlineDelimiters)) {
                    this.mathInlineDelimiters = mathInlineDelimiters;
                    callback();
                }
            }
            catch (error) {
                mathInlineDelimiters = [["$", "$"], ["\\(", "\\)"]];
            }
        }), atom.config.onDidChange("markdown-preview-enhanced.mathBlockDelimiters", ({ newValue }) => {
            let mathBlockDelimiters;
            try {
                mathBlockDelimiters = JSON.parse(newValue);
                if (JSON.stringify(mathBlockDelimiters) !==
                    JSON.stringify(this.mathBlockDelimiters)) {
                    this.mathBlockDelimiters = mathBlockDelimiters;
                    callback();
                }
            }
            catch (error) {
                mathBlockDelimiters = [["$$", "$$"], ["\\[", "\\]"]];
            }
        }), atom.config.onDidChange("markdown-preview-enhanced.codeBlockTheme", ({ newValue }) => {
            this.codeBlockTheme = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.previewTheme", ({ newValue }) => {
            this.previewTheme = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.revealjsTheme", ({ newValue }) => {
            this.revealjsTheme = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.mermaidTheme", ({ newValue }) => {
            this.mermaidTheme = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.frontMatterRenderingOption", ({ newValue }) => {
            this.frontMatterRenderingOption = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.imageFolderPath", ({ newValue }) => {
            this.imageFolderPath = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.printBackground", ({ newValue }) => {
            this.printBackground = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.phantomPath", ({ newValue }) => {
            this.phantomPath = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.pandocPath", ({ newValue }) => {
            this.pandocPath = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.pandocMarkdownFlavor", ({ newValue }) => {
            this.pandocMarkdownFlavor = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.pandocArguments", ({ newValue }) => {
            this.pandocArguments =
                newValue
                    .split(",")
                    .map((x) => x.trim())
                    .filter((x) => x.length) || [];
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.latexEngine", ({ newValue }) => {
            this.latexEngine = newValue;
            // callback()
        }), atom.config.onDidChange("markdown-preview-enhanced.enableScriptExecution", ({ newValue }) => {
            this.enableScriptExecution = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.fileExtension", ({ newValue }) => {
            this.fileExtension =
                newValue
                    .split(",")
                    .map((x) => x.trim())
                    .filter((x) => x.length) || [];
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.singlePreview", ({ newValue }) => {
            this.singlePreview = newValue;
            // callback() // <= No need to call callback. will cause error here.
        }), atom.config.onDidChange("markdown-preview-enhanced.scrollSync", ({ newValue }) => {
            this.scrollSync = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.liveUpdate", ({ newValue }) => {
            this.liveUpdate = newValue;
            // callback()
        }), atom.config.onDidChange("markdown-preview-enhanced.previewPanePosition", ({ newValue }) => {
            this.previewPanePosition = newValue;
        }), atom.config.onDidChange("markdown-preview-enhanced.openPreviewPaneAutomatically", ({ newValue }) => {
            this.openPreviewPaneAutomatically = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.automaticallyShowPreviewOfMarkdownBeingEdited", ({ newValue }) => {
            this.automaticallyShowPreviewOfMarkdownBeingEdited = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.closePreviewAutomatically", ({ newValue }) => {
            this.closePreviewAutomatically = newValue;
            callback();
        }), 
        /*
        atom.config.onDidChange('markdown-preview-enhanced.enableZenMode', ({newValue})=> {
          this.enableZenMode = newValue
          // callback()
        }),
        */
        atom.config.onDidChange("markdown-preview-enhanced.imageUploader", ({ newValue }) => {
            this.imageUploader = newValue;
            callback();
        }), atom.config.onDidChange("markdown-preview-enhanced.imageDropAction", ({ newValue }) => {
            this.imageDropAction = newValue;
        }));
    }
}
exports.MarkdownPreviewEnhancedConfig = MarkdownPreviewEnhancedConfig;
//# sourceMappingURL=config.js.map