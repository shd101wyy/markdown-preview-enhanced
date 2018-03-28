import { TextEditor } from "atom";
import * as mume from "mume-with-litvis";
import { MarkdownPreviewEnhancedConfig } from "./config";
/**
 * The markdown previewer
 */
export declare class MarkdownPreviewEnhancedView {
    private element;
    private webview;
    private uri;
    private disposables;
    /**
     * The editor binded to this preview.
     */
    private editor;
    /**
     * Configs.
     */
    private config;
    /**
     * Markdown engine.
     */
    private engine;
    /**
     * An array of strings of js and css file paths.
     */
    private JSAndCssFiles;
    private editorScrollDelay;
    private scrollTimeout;
    private zoomLevel;
    private _webviewDOMReady;
    private _destroyCB;
    constructor(uri: string, config: MarkdownPreviewEnhancedConfig);
    getURI(): string;
    getIconName(): string;
    getTitle(): string;
    private updateTabTitle();
    private initEvents();
    /**
     * Get the markdown editor for this preview
     */
    getEditor(): TextEditor;
    /**
     * Get markdown engine
     */
    getMarkdownEngine(): mume.MarkdownEngine;
    /**
     * Bind editor to preview
     * @param editor
     */
    bindEditor(editor: TextEditor): void;
    /**
     * This function will
     * 1. Create a temp *.html file
     * 2. Write preview html template
     * 3. this.webview will load that *.html file.
     */
    loadPreview(): Promise<void>;
    /**
     * Wait until this.webview is attached to DOM and dom-ready event is emitted.
     */
    private waitUtilWebviewDOMReady();
    /**
     * Webview finished loading content.
     */
    private webviewStopLoading();
    /**
     * Received message from webview.
     * @param event
     */
    private webviewReceiveMessage(event);
    static MESSAGE_DISPATCH_EVENTS: {
        webviewFinishLoading(sourceUri: any): void;
        refreshPreview(sourceUri: any): void;
        revealLine(sourceUri: any, line: any): void;
        insertImageUrl(sourceUri: any, imageUrl: any): void;
        pasteImageFile(sourceUri: any, imageUrl: any): void;
        uploadImageFile(sourceUri: any, imageUrl: any, imageUploader: any): void;
        openInBrowser(sourceUri: any): void;
        htmlExport(sourceUri: any, offline: any): void;
        chromeExport(sourceUri: any, fileType: any): void;
        phantomjsExport(sourceUri: any, fileType: any): void;
        princeExport(sourceUri: any): void;
        eBookExport(sourceUri: any, fileType: any): void;
        pandocExport(sourceUri: any): void;
        markdownExport(sourceUri: any): void;
        cacheCodeChunkResult(sourceUri: any, id: any, result: any): void;
        runCodeChunk(sourceUri: any, codeChunkId: any): void;
        runAllCodeChunks(sourceUri: any): void;
        clickTagA(sourceUri: any, href: any): void;
        clickTaskListCheckbox(sourceUri: any, dataLine: any): void;
        setZoomLevel(sourceUri: any, zoomLevel: any): void;
        showUploadedImageHistory(sourceUri: any): void;
    };
    private webviewConsoleMessage(event);
    private webviewKeyDown(event);
    private initEditorEvents();
    private initPreviewEvents();
    /**
     * sync preview to match source.
     * @param forced whether to override scroll sync.
     */
    private syncPreview(forced?);
    /**
     * Render markdown
     */
    renderMarkdown(triggeredBySave?: boolean): Promise<void>;
    /**
     * Please notice that row is in center.
     * @param row The buffer row
     */
    scrollToBufferPosition(row: any): void;
    /**
     * Get the project directory path of current this.editor
     */
    private getProjectDirectoryPath();
    /**
     * Get the project directory path of the editor
     */
    static getProjectDirectoryPathForEditor(editor: TextEditor): string;
    /**
     * Post message to this.webview
     * @param data
     */
    private postMessage(data);
    updateConfiguration(): void;
    refreshPreview(): void;
    openInBrowser(): void;
    htmlExport(offline: any): void;
    chromeExport(fileType?: string): void;
    phantomjsExport(fileType?: string): void;
    princeExport(): void;
    eBookExport(fileType: any): void;
    pandocExport(): void;
    markdownExport(): void;
    cacheCodeChunkResult(id: any, result: any): void;
    runCodeChunk(codeChunkId: string): void;
    runAllCodeChunks(): void;
    sendRunCodeChunkCommand(): void;
    startImageHelper(): void;
    setZoomLevel(zoomLevel: number): void;
    static pasteImageFile(editor: TextEditor, imageFolderPath: string, imageFilePath: string): Promise<void>;
    private static replaceHint(editor, bufferRow, hint, withStr);
    private static setUploadedImageURL(editor, imageFileName, url, hint, bufferRow);
    /**
     * Upload image at imageFilePath by this.config.imageUploader.
     * Then insert markdown image url to markdown file.
     * @param imageFilePath
     */
    static uploadImageFile(editor: TextEditor, imageFilePath: string, imageUploader?: string): void;
    private activatePaneForEditor();
    destroy(): void;
    /**
     * cb will be called when this preview is destroyed.
     * @param cb
     */
    onPreviewDidDestroy(cb: (preview: MarkdownPreviewEnhancedView) => void): void;
}
export declare function isMarkdownFile(sourcePath: string): boolean;
