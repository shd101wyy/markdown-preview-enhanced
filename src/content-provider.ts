import {CompositeDisposable} from "atom"
import * as path from "path"

import * as mume from "@shd101wyy/mume"
import {MarkdownPreviewEnhancedConfig} from "./config"

// TODO: presentation PDF export.
// TODO: <!-- @import [toc] -->

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
  private disposables: CompositeDisposable = null

  /**
   * The editor binded to this preview.
   */
  private editor:AtomCore.TextEditor = null
  /**
   * Configs.
   */
  private config:MarkdownPreviewEnhancedConfig = null
  /**
   * Markdown engine.
   */
  private engine:mume.MarkdownEngine = null
  /**
   * An array of strings of js and css file paths.
   */
  private JSAndCssFiles: string[]

  private editorScrollDelay: number = Date.now()
  private scrollTimeout = null

  constructor(uri:string, config:MarkdownPreviewEnhancedConfig) {
    this.uri = uri
    this.config = config

    this.element = document.createElement('div')
    
    this.iframe = document.createElement('iframe')
    this.iframe.style.width = '100%'
    this.iframe.style.height = '100%'
    this.iframe.style.border = 'none'
    this.iframe.src = path.resolve(__dirname, '../../html/loading.html')

    this.element.appendChild(this.iframe)
  }

  public getURI() {
    return this.uri
  }

  public getIconName() {
    return 'markdown'
  }

  public getTitle() {
    let fileName = 'unknown'
    if (this.editor) {
      fileName = this.editor['getFileName']()
    }
    return `${fileName} preview`
  }

  private updateTabTitle() {
    if (!this.config.singlePreview) return 

    const title = this.getTitle()
    const tabTitle = document.querySelector('[data-type="MarkdownPreviewEnhancedView"] div.title') as HTMLElement
    if (tabTitle)
      tabTitle.innerText = title
  }

  /**
   * Get the markdown editor for this preview
   */
  public getEditor() {
    return this.editor
  }

  /**
   * Get markdown engine
   */
  public getMarkdownEngine() {
    return this.engine
  }

  /**
   * Bind editor to preview
   * @param editor 
   */
  public bindEditor(editor:AtomCore.TextEditor) {
    if (!this.editor) {
      this.editor = editor
      atom.workspace.open(this.uri, {
        split: "right",
        activatePane: false,
        activateItem: true,
        searchAllPanes: false,
        initialLine: 0,
        initialColumn: 0,
        pending: false
      })
      .then(()=> {
        this.initEvents()
      })
    } else { // preview already on
      this.editor = editor
      this.initEvents()
    } 
  }

  private async initEvents() {
    if (this.disposables) { // remove all binded events
      this.disposables.dispose()
    }
    this.disposables = new CompositeDisposable()

    // reset tab title
    this.updateTabTitle()

    // reset 
    this.JSAndCssFiles = []

    // init markdown engine 
    this.engine = new mume.MarkdownEngine({
      filePath: this.editor.getPath(),
      projectDirectoryPath: this.getProjectDirectoryPath(),
      config: this.config
    })

    await this.loadPreview()
    this.initEditorEvents()
  }

  /**
   * This function will 
   * 1. Create a temp *.html file
   * 2. Write preview html template
   * 3. this.iframe will load that *.html file.
   */
  public async loadPreview() {    
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

    // load preview template
    const html = await this.engine.generateHTMLTemplateForPreview({
      inputString: this.editor.getText(),
      config:{
        sourceUri: this.editor.getPath(),
        initialLine: this.editor.getCursorBufferPosition().row
      },
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
    /*
    setTimeout(()=> {
      this.iframe.contentWindow.postMessage({type: 'update-html'}, 'file://')
    }, 2000)
    */
  }

  private initEditorEvents() {
    const editorElement = this.editor['getElement']() // dunno why `getElement` not found.

    this.disposables.add(atom.commands.add(editorElement, {
      'markdown-preview-enhanced:sync-preview': ()=> this.syncPreview()
    }))

    this.disposables.add(this.editor.onDidDestroy(()=> {
      if (this.disposables) {
        this.disposables.dispose()
        this.disposables = null
      }
      this.editor = null

      if (!this.config.singlePreview && this.config.closePreviewAutomatically) {
        const pane = atom.workspace.paneForItem(this)
        pane.destroyItem(this) // this will trigger @destroy()
      }
    }))

    this.disposables.add(this.editor.onDidStopChanging(()=> {
      if (this.config.liveUpdate)
        this.renderMarkdown()
    }))

    this.disposables.add(this.editor.onDidSave(()=> {
      if (!this.config.liveUpdate)
        this.renderMarkdown(true)
    }))

    this.disposables.add(this.editor['onDidChangeScrollTop'](()=> {
      if (!this.config.scrollSync) return
      if (Date.now() < this.editorScrollDelay) return
      const firstVisibleScreenRow = this.editor['getFirstVisibleScreenRow']()
      if (firstVisibleScreenRow === 0) {
        return this.postMessage({
          command: 'changeTextEditorSelection',
          line: 0,
          topRatio: 0
        })
      }
      
      const lastVisibleScreenRow = this.editor['getLastVisibleScreenRow']()
      if (lastVisibleScreenRow === this.editor.getLastScreenRow()) {
        return this.postMessage({
          command: 'changeTextEditorSelection',
          line: this.editor.getLastBufferRow(),
          topRatio: 1
        })
      }

      let midBufferRow = this.editor['bufferRowForScreenRow'](Math.floor((lastVisibleScreenRow + firstVisibleScreenRow) / 2))

      this.postMessage({
        command: 'changeTextEditorSelection',
        line: midBufferRow,
        topRatio: 0.5
      })
    }))

    this.disposables.add(this.editor.onDidChangeCursorPosition((event)=> {
      if (!this.config.scrollSync) return 
      if (Date.now() < this.editorScrollDelay) return

      const firstVisibleScreenRow = this.editor['getFirstVisibleScreenRow']()
      const lastVisibleScreenRow = this.editor['getLastVisibleScreenRow']()
      const topRatio = (event.newScreenPosition.row - firstVisibleScreenRow) / (lastVisibleScreenRow - firstVisibleScreenRow)

      this.postMessage({
        command: 'changeTextEditorSelection',
        line: event.newBufferPosition.row,
        topRatio: topRatio
      })
    }))
  }

  private syncPreview() {

  }

  /**
   * Render markdown
   */
  public renderMarkdown(triggeredBySave:boolean=false) {
    // presentation mode 
    if (this.engine.isPreviewInPresentationMode) {
      this.loadPreview() // restart preview.
    }

    // not presentation mode 
    const text = this.editor.getText()

    // notice iframe that we started parsing markdown
    this.postMessage({command: 'startParsingMarkdown'})

    this.engine.parseMD(text, {isForPreview: true, useRelativeFilePath: false, hideFrontMatter: false, triggeredBySave})
      .then(({markdown, html, tocHTML, JSAndCssFiles, yamlConfig})=> {
      if (!mume.utility.isArrayEqual(JSAndCssFiles, this.JSAndCssFiles) || yamlConfig['isPresentationMode']) {
        this.loadPreview() // restart preview
      } else {
        this.postMessage({
          command: 'updateHTML',
          html,
          tocHTML,
          totalLineCount: this.editor.getLineCount(),
          sourceUri: this.editor.getPath(),
          id: yamlConfig.id || '',
          class: yamlConfig.class || ''
        })
      }
    })
  }

  /**
   * Please notice that row is in center.
   * @param row The buffer row
   */
  public scrollToBufferPosition(row) {
    if (!this.editor) return
    if (row < 0) return 
    this.editorScrollDelay = Date.now() + 500

    if (this.scrollTimeout) {
      clearTimeout(this.scrollTimeout)
    }

    const editorElement = this.editor['getElement']()
    const delay = 10
    const screenRow = this.editor.screenPositionForBufferPosition([row, 0]).row
    const scrollTop = screenRow * this.editor['getLineHeightInPixels']() - this.element.offsetHeight / 2

    const helper = (duration=0)=> {
      this.scrollTimeout = setTimeout(() => {
        if (duration <= 0) {
          this.editorScrollDelay = Date.now() + 500
          editorElement.setScrollTop(scrollTop)
          return
        }

        const difference = scrollTop - editorElement.getScrollTop()

        const perTick = difference / duration * delay

        // disable editor onscroll
        this.editorScrollDelay = Date.now() + 500

        const s = editorElement.getScrollTop() + perTick
        editorElement.setScrollTop(s)

        if (s == scrollTop) return 
        helper(duration-delay)
      }, delay)
    }

    const scrollDuration = 120
    helper(scrollDuration)
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

  /**
   * Post message to this.iframe
   * @param data 
   */
  private postMessage(data:any) {
    if (this.iframe && this.iframe.contentWindow)
      this.iframe.contentWindow.postMessage(data, 'file://')
  }

  public updateConfiguration() {
    if (this.engine) {
      this.engine.updateConfiguration(this.config)
    }
  }

  public refreshPreview() {
    if (this.engine) {
      this.engine.clearCaches()
      // restart iframe 
      this.loadPreview()
    }
  }

  public openInBrowser() {
    this.engine.openInBrowser({})
    .catch((error)=> {
      atom.notifications.addError(error)
    })
  }

  public htmlExport(offline) {
    atom.notifications.addInfo('Your document is being prepared')
    this.engine.htmlExport({offline})
    .then((dest)=> {
      atom.notifications.addSuccess(`File ${path.basename(dest)} was created at path: ${dest}`)
    })
    .catch((error)=> {
      atom.notifications.addError(error)
    })
  }  

  public phantomjsExport(fileType='pdf') {
    atom.notifications.addInfo('Your document is being prepared')
    this.engine.phantomjsExport({fileType})
    .then((dest)=> {
      atom.notifications.addSuccess(`File ${path.basename(dest)} was created at path: ${dest}`)
    })
    .catch((error)=> {
      atom.notifications.addError(error)
    })
  }

  public princeExport() {
    atom.notifications.addInfo('Your document is being prepared')
    this.engine.princeExport({})
    .then((dest)=> {
      atom.notifications.addSuccess(`File ${path.basename(dest)} was created at path: ${dest}`)
    })
    .catch((error)=> {
      atom.notifications.addError(error)
    })
  }

  public eBookExport(fileType) {
    atom.notifications.addInfo('Your document is being prepared')
    this.engine.eBookExport({fileType})
    .then((dest)=> {
      atom.notifications.addSuccess(`File ${path.basename(dest)} was created at path: ${dest}`)
    })
    .catch((error)=> {
      atom.notifications.addError(error)
    })
  }

  public pandocExport() {
    atom.notifications.addInfo('Your document is being prepared')
    this.engine.pandocExport({})
    .then((dest)=> {
      atom.notifications.addSuccess(`File ${path.basename(dest)} was created at path: ${dest}`)
    })
    .catch((error)=> {
      atom.notifications.addError(error)
    })
  }

  public markdownExport() {
    atom.notifications.addInfo('Your document is being prepared')
    this.engine.markdownExport({})
    .then((dest)=> {
      atom.notifications.addSuccess(`File ${path.basename(dest)} was created at path: ${dest}`)
    })
    .catch((error)=> {
      atom.notifications.addError(error)
    })
  }

  public cacheCodeChunkResult(id, result) {
    this.engine.cacheCodeChunkResult(id, result)
  }

  public runCodeChunk(codeChunkId: string) {
    if (!this.engine) return
    this.engine.runCodeChunk(codeChunkId)
    .then(()=> {
      this.renderMarkdown()
    })
  }

  public runAllCodeChunks() {
    if (!this.engine) return
    this.engine.runAllCodeChunks()
    .then(()=> {
      this.renderMarkdown()
    })
  }

  public sendRunCodeChunkCommand() {
    this.postMessage({command:'runCodeChunk'})
  }

  public startImageHelper() {
    this.postMessage({command: 'openImageHelper'})
  }

  public destroy() {
    if (this.disposables) {
      this.disposables.dispose()
      this.disposables = null
    }
    this.element.remove()
    this.editor = null
  }
}

export function isMarkdownFile(sourcePath:string):boolean {
  return false
}