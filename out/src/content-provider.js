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
            // init markdown engine 
            this.engine = new mume.MarkdownEngine({
                filePath: this.editor.getPath(),
                projectDirectoryPath: this.getProjectDirectoryPath(),
                config: this.config
            });
            // load preview template
            const html = yield this.engine.generateHTMLTemplateForPreview({
                inputString: this.editor.getText(),
                config: {},
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
            setTimeout(() => {
                this.iframe.contentWindow.postMessage({ type: 'update-html' }, 'file://');
            }, 2000);
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
    destroy() {
        this.element.remove();
    }
}
exports.MarkdownPreviewEnhancedView = MarkdownPreviewEnhancedView;
function isMarkdownFile(sourcePath) {
    return false;
}
exports.isMarkdownFile = isMarkdownFile;
