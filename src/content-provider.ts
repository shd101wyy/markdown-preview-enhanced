import {CompositeDisposable} from "atom"
import * as path from "path"

import * as mume from "@shd101wyy/mume"
import {MarkdownPreviewEnhancedConfig} from "./config"

/**
 * Key is editor.getPath()
 * Value is temp html file path.  
 */
const HTML_FILES_MAP = {}

/**
 * The markdown previewer
 */
export class MarkdownPreviewEnhancedView {
  private element: HTMLDivElement = null
  private iframe: HTMLIFrameElement = null
  private uri: string = ''
  /**
   * The editor binded to this preview
   */
  private editor:AtomCore.TextEditor = null
  /**
   * Configs
   */
  private config:MarkdownPreviewEnhancedConfig = null
  /**
   * Markdown engine
   */
  private engine:mume.MarkdownEngine = null

  constructor(uri:string, config:MarkdownPreviewEnhancedConfig) {
    this.uri = uri
    this.config = config

    this.element = document.createElement('div')
    
    this.iframe = document.createElement('iframe')
    this.iframe.style.width = '100%'
    this.iframe.style.height = '100%'
    this.iframe.style.border = 'none'
    this.element.appendChild(this.iframe)
  }

  public getURI() {
    return this.uri
  }

  public getIconName() {
    return 'markdown'
  }

  public getTitle() {
    return 'mpe preview'
  }

  /**
   * Get the markdown editor for this preview
   */
  public getEditor() {
    return this.editor
  }

  /**
   * Bind editor to preview
   * @param editor 
   */
  public bindEditor(editor:AtomCore.TextEditor) {
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
      .then(()=> {
        this.editor = editor
        this.initEvents()
      })
    } else { // preview already on
      this.editor = editor
      this.initEvents()
    } 
  }

  private async initEvents() {
    const editorFilePath = this.editor.getPath()

    // create temp html file for preview
    let htmlFilePath
    if (editorFilePath in HTML_FILES_MAP) {
      htmlFilePath = HTML_FILES_MAP[editorFilePath]
    } else {
      const info = await mume.utility.tempOpen({prefix: 'mpe_preview', suffix: '.html'})
      htmlFilePath = info.path
      HTML_FILES_MAP[editorFilePath] = htmlFilePath
    }

    // init markdown engine 
    this.engine = new mume.MarkdownEngine({
      filePath: this.editor.getPath(),
      projectDirectoryPath: this.getProjectDirectoryPath(),
      config: this.config
    })

    // load preview template
    const html = await this.engine.generateHTMLTemplateForPreview({
      inputString: this.editor.getText(),
      config:{},
      webviewScript: path.resolve(__dirname, './webview.js')
    })
    await mume.utility.writeFile(htmlFilePath, html, {encoding: 'utf-8'})

    // load to iframe
    if (this.iframe.src === htmlFilePath) {
      this.iframe.contentWindow.location.reload()
    } else {
      this.iframe.src = htmlFilePath
    }

    // test postMessage
    setTimeout(()=> {
      this.iframe.contentWindow.postMessage({type: 'update-html'}, 'file://')

    }, 2000)
  }

  /**
   * Get the project directory path of current this.editor
   */
  private getProjectDirectoryPath() {
    if (!this.editor)
      return ''

    const editorPath = this.editor.getPath()
    const projectDirectories = atom.project.getDirectories()

    for (let i = 0; i < projectDirectories.length; i++) {
      const projectDirectory = projectDirectories[i]
      if (projectDirectory.contains(editorPath)) // editor belongs to this project
        return projectDirectory.getPath()
    }
    return ''
  }

  public destroy() {
    this.element.remove()
  }
}

export function isMarkdownFile(sourcePath:string):boolean {
  return false
}