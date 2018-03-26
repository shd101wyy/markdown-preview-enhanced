export declare const configSchema: {
    fileExtension: {
        type: string;
        default: string;
        description: string;
        order: number;
    };
    singlePreview: {
        title: string;
        type: string;
        default: boolean;
        order: number;
    };
    previewPanePosition: {
        title: string;
        type: string;
        default: string;
        enum: string[];
        order: number;
    };
    openPreviewPaneAutomatically: {
        title: string;
        type: string;
        default: boolean;
        order: number;
    };
    automaticallyShowPreviewOfMarkdownBeingEdited: {
        title: string;
        type: string;
        default: boolean;
        order: number;
    };
    closePreviewAutomatically: {
        title: string;
        description: string;
        type: string;
        default: boolean;
        order: number;
    };
    breakOnSingleNewLine: {
        type: string;
        default: boolean;
        description: string;
        order: number;
    };
    enableTypographer: {
        type: string;
        default: boolean;
        description: string;
        order: number;
    };
    enableZenMode: {
        title: string;
        type: string;
        default: boolean;
        description: string;
        order: number;
    };
    codeBlockTheme: {
        description: string;
        default: string;
        type: string;
        enum: string[];
        order: number;
    };
    previewTheme: {
        description: string;
        default: string;
        type: string;
        enum: string[];
        order: number;
    };
    revealjsTheme: {
        description: string;
        default: string;
        type: string;
        enum: string[];
        order: number;
    };
    mermaidTheme: {
        description: string;
        default: string;
        type: string;
        enum: string[];
        order: number;
    };
    protocolsWhiteList: {
        title: string;
        type: string;
        default: string;
        description: string;
        order: number;
    };
    mathRenderingOption: {
        type: string;
        default: string;
        description: string;
        enum: string[];
        order: number;
    };
    mathInlineDelimiters: {
        title: string;
        type: string;
        default: string;
        description: string;
        order: number;
    };
    mathBlockDelimiters: {
        title: string;
        type: string;
        default: string;
        description: string;
        order: number;
    };
    usePandocParser: {
        title: string;
        type: string;
        default: boolean;
        description: string;
        order: number;
    };
    pandocPath: {
        title: string;
        type: string;
        default: string;
        description: string;
        order: number;
    };
    pandocArguments: {
        title: string;
        type: string;
        default: string;
        description: string;
        order: number;
    };
    pandocMarkdownFlavor: {
        type: string;
        default: string;
        title: string;
        description: string;
        order: number;
    };
    latexEngine: {
        type: string;
        default: string;
        title: string;
        description: string;
        order: number;
    };
    phantomPath: {
        title: string;
        type: string;
        default: string;
        description: string;
        order: number;
    };
    enableWikiLinkSyntax: {
        title: string;
        type: string;
        default: boolean;
        description: string;
        order: number;
    };
    wikiLinkFileExtension: {
        title: string;
        type: string;
        default: string;
        description: string;
        order: number;
    };
    enableEmojiSyntax: {
        title: string;
        type: string;
        default: boolean;
        description: string;
        order: number;
    };
    enableExtendedTableSyntax: {
        title: string;
        type: string;
        default: boolean;
        description: string;
        order: number;
    };
    enableCriticMarkupSyntax: {
        title: string;
        type: string;
        default: boolean;
        description: string;
        order: number;
    };
    liveUpdate: {
        type: string;
        default: boolean;
        description: string;
        order: number;
    };
    frontMatterRenderingOption: {
        title: string;
        type: string;
        description: string;
        default: string;
        enum: string[];
        order: number;
    };
    scrollSync: {
        type: string;
        default: boolean;
        description: string;
        order: number;
    };
    printBackground: {
        title: string;
        type: string;
        default: boolean;
        description: string;
        order: number;
    };
    imageFolderPath: {
        title: string;
        description: string;
        type: string;
        default: string;
        order: number;
    };
    imageUploader: {
        title: string;
        description: string;
        type: string;
        default: string;
        enum: string[];
        order: number;
    };
    imageDropAction: {
        title: string;
        description: string;
        type: string;
        default: string;
        enum: string[];
        order: number;
    };
    AccessKey: {
        type: string;
        default: string;
        title: string;
        order: number;
    };
    SecretKey: {
        type: string;
        default: string;
        title: string;
        description: string;
        order: number;
    };
    Bucket: {
        type: string;
        default: string;
        title: string;
        description: string;
        order: number;
    };
    Domain: {
        type: string;
        default: string;
        title: string;
        description: string;
        order: number;
    };
    enableScriptExecution: {
        title: string;
        description: string;
        type: string;
        default: boolean;
        order: number;
    };
};
