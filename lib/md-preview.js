'use strict'

let md = require('./md.js'),
    path = require('path'),
    exec = require('child_process').exec,
    parseMD = md.parseMD,
    buildScrollMap = md.buildScrollMap,
    CompositeDisposable = require('atom').CompositeDisposable,
    getMarkdownPreviewCSS = require('./style.js').getMarkdownPreviewCSS

let globalKatexStyle = null

// MarkdownPreview constroller class
// Pass in .md editor
class MarkdownPreview {
  constructor(editor) {
    this.editor = editor
    this.previewEditor = null

    this.htmlView = null

    this.editorScrollDelay = Date.now() + 500
    this.previewScrollDelay = Date.now() + 500
    this.parseDelay = Date.now() + 200

    this.sourceMap = null // for scroll sync

    this.rootDirectoryPath = path.resolve(path.dirname(editor.buffer.file.path))
    this.uri = 'atom-markdown-katex://' + editor.getPath() + ' preview'
    this.disposables = new CompositeDisposable()

    this.liveUpdate = atom.config.get('atom-markdown-katex.liveUpdate')
    this.scrollSync = atom.config.get('atom-markdown-katex.scrollSync')

    this.textContent = this.editor.getText()
    this.headings = []

    this.initialize()
  }

  // open preview on the right side panel
  initialize() {
    atom.workspace.open(this.uri, {
        split: "right",
        activatePane: false,
        searchAllPanes: true
      }).then((previewEditor)=> {
        this.previewEditor = previewEditor
        this.previewEditor.markdownPreview = this

        this.createPreviewElement()

        // initialize events
        this.initEditorEvent()
        this.initPreviewEditorEvents()
        this.initHtmlViewEvents()
        this.initSettingsEvents()

        this.headings = []

        this.paneActivateEditor()
      })
  }

  paneActivateEditor() {
    let panes = atom.workspace.getPanes()
    for (let i = 0; i < panes.length; i++) {
      let pane = panes[i]
      if (pane.itemForURI(this.editor.getPath())) {
        pane.activate()
        pane.activateItemForURI(this.editor)
        break
      }
    }
  }

  // create dom element for preview
  createPreviewElement() {
    let previewEditorElement = atom.views.getView(this.previewEditor)

    this.htmlView = document.createElement('div')
    this.htmlView.style.width = '100%'
    this.htmlView.style.height = '100%'
    this.htmlView.style.margin = '0'
    this.htmlView.style.zIndex = '999'
    this.htmlView.style.overflow = 'scroll'
    this.htmlView.style.fontSize = '16px' // this is important as 'em' is relative to this px.
    this.htmlView.style.display = 'block'
    this.htmlView.style.boxSizing = "border-box"

    this.htmlView.className = 'markdown-katex-preview'

    let shadowDom = previewEditorElement.createShadowRoot()

    // http://stackoverflow.com/questions/35858494/how-to-let-imported-css-have-effects-on-elements-in-the-shadow-dom
    // in order to load font correctly
    // 1, Declare the Font in main document
    // 2, Import the Stylesheet in shadow dom
    if (!globalKatexStyle) {
      globalKatexStyle = document.createElement('link')
      globalKatexStyle.rel = 'stylesheet'
      globalKatexStyle.href = path.resolve(__dirname, '../katex-style/katex.min.css')
      document.getElementsByTagName('head')[0].appendChild(globalKatexStyle)
    }

    // Notice:
    // Here I replaced all '\' with '/' because if not then
    // it doesn't work on Windows...
    // I think that is @import bug
    let katexStyle = document.createElement('style')
    katexStyle.innerHTML = `@import url("${path.resolve(__dirname, '../katex-style/katex.min.css').replace(/\\/g, '/')}");`

    let markdownStyle = document.createElement('style')
    markdownStyle.innerHTML = getMarkdownPreviewCSS()

    shadowDom.appendChild(katexStyle)
    shadowDom.appendChild(markdownStyle)
    shadowDom.appendChild(this.htmlView)

    // udpate markdown style
    this.disposables.add(
      atom.styles.onDidAddStyleElement(function(s) {
        if (markdownStyle) {
          markdownStyle.innerHTML = getMarkdownPreviewCSS()
        }
      }))
  }

  reinitialize() {
    if (!this.previewEditor) {
      this.initialize()
    }
  }

  initEditorEvent() {
    // TODO: 这里有问题
    // close editor
    this.disposables.add(
      this.editor.onDidDestroy(()=> {
        this.editor = null

        // close preview editor
        if (atom.config.get('atom-markdown-katex.closePreviewWhenClosingEditor')) {
          this.previewEditor.destroy()
        }

        this.destroy()
      })
    )

    this.disposables.add(
      this.editor.onDidStopChanging(()=> {
        if (this.liveUpdate) {
          this.updateMarkdown()
        }
      })
    )

    this.disposables.add(
      this.editor.onDidSave(()=> {
        if (!this.liveUpdate) {
          this.updateMarkdown()
        }
      })
    )

    this.disposables.add(
      this.editor.onDidChangeScrollTop(()=> {
        if (!this.htmlView || !this.scrollSync || !this.liveUpdate) return
        if (Date.now() < this.editorScrollDelay) return

        let editorHeight = this.editor.getHeight()

        let firstVisibleScreenRow = this.editor.getFirstVisibleScreenRow()
        let lastVisibleScreenRow = firstVisibleScreenRow + Math.floor(editorHeight / this.editor.getLineHeightInPixels())

        let lineNo = Math.floor((firstVisibleScreenRow + lastVisibleScreenRow) / 2)

        if (!this.sourceMap) {
          this.sourceMap = buildScrollMap(this)
        }

        // disable markdownHtmlView onscroll
        this.previewScrollDelay = Date.now() + 500

        this.htmlView.scrollTop = this.sourceMap[/*firstVisibleScreenRow*/lineNo] - editorHeight / 2
      })
    )

    // match markdown preview to cursor position
    this.disposables.add(
      this.editor.onDidChangeCursorPosition((event)=> {
        if (!this.htmlView || !this.scrollSync || !this.liveUpdate) return

        // track currnet time to disable onDidChangeScrollTop
        this.editorScrollDelay = Date.now() + 500
        // disable preview onscroll
        this.previewScrollDelay = Date.now() + 500

        if (event.oldScreenPosition.row !== event.newScreenPosition.row || event.oldScreenPosition.column == 0) {
          if (!this.sourceMap) {
            this.sourceMap = buildScrollMap(this)
          }

          if (event.newScreenPosition.row === 0) {
            this.htmlView.scrollTop = 0
            return
          }

          let lineNo = event.newScreenPosition.row,
              cursor = event.cursor,
              firstVisibleScreenRow = this.editor.getFirstVisibleScreenRow(),
              posRatio = (lineNo - firstVisibleScreenRow) / (this.editor.getHeight() / this.editor.getLineHeightInPixels()),
              scrollTop = this.sourceMap[lineNo] - (posRatio > 1 ? 1 : posRatio) * this.editor.getHeight()

          this.htmlView.scrollTop = scrollTop
        }
      })
    )

  }

  initPreviewEditorEvents() {
    this.disposables.add(
      this.previewEditor.onDidDestroy(()=> {
        this.previewEditor = null

        this.destroy()
      })
    )
  }

  initHtmlViewEvents() {
    // preview scroll
    this.htmlView.onscroll = ()=> {
      if (!this.editor || !this.scrollSync || !this.liveUpdate) return
      if (Date.now() < this.previewScrollDelay) return

      let top = this.htmlView.scrollTop + this.htmlView.offsetHeight / 2

      // try to find corresponding screen buffer row
      if (!this.sourceMap) {
        this.sourceMap = buildScrollMap(this)
      }

      let sourceMap = this.sourceMap,
          i = 0,
          j = sourceMap.length - 1,
          count = 0,
          screenRow = -1

      while(count < 20) {
        if (Math.abs(top - sourceMap[i]) < 20) {
          screenRow = i
          break
        } else if (Math.abs(top - sourceMap[j]) < 20) {
          screenRow = j
          break
        } else {
          let mid = Math.floor((i + j) / 2)
          if (top > sourceMap[mid]) {
            i = mid
          } else {
            j = mid
          }
        }
        count++
      }

      if (screenRow >= 0) {
        this.editor.setScrollTop(screenRow * this.editor.getLineHeightInPixels() - this.htmlView.offsetHeight / 2)

        // track currnet time to disable onDidChangeScrollTop
        this.editorScrollDelay = Date.now() + 500
      }
    }
  }

  initSettingsEvents() {
    /* settings changed */
    // github style?
    this.disposables.add(atom.config.observe('atom-markdown-katex.useGitHubStyle', (useGitHubStyle)=> {
        this.htmlView.setAttribute("data-use-github-style", useGitHubStyle ? 'true' : 'false')
    }))

    // github syntax theme?
    this.disposables.add(atom.config.observe('atom-markdown-katex.useGitHubSyntaxTheme', (useGitHubSyntaxTheme)=> {
        this.htmlView.setAttribute("data-use-github-syntax-theme", useGitHubSyntaxTheme ? 'true' : 'false')
    }))

    // break line?
    this.disposables.add(atom.config.observe('atom-markdown-katex.breakOnSingleNewline', (breakOnSingleNewline)=> {
      setTimeout(()=> {
        this.renderMarkdown()
      }, 500)
    }))

    // liveUpdate?
    this.disposables.add(atom.config.observe('atom-markdown-katex.liveUpdate', (lFlag)=> {
      this.liveUpdate = lFlag
    }))

    // scrollSync?
    this.disposables.add(atom.config.observe('atom-markdown-katex.scrollSync', (sFlag)=> {
      this.scrollSync = sFlag
    }))

    // KaTeX?
    this.disposables.add(atom.config.observe('atom-markdown-katex.useKaTeX', (useKaTeX)=> {
      setTimeout(()=> {
        this.renderMarkdown()
      }, 500)
    }))
  }

  // <a href="" > ... </a> click event
  bindTagAClickEvent() {
    let as = this.htmlView.querySelectorAll('a')
    for (let i = 0; i < as.length; i++) {
      let a = as[i],
          href = a.getAttribute('href')
      if (href && href[0] === '#') {
        let targetElement = this.htmlView.querySelector(`[id="${href.slice(1)}"]`) // fix number id bug
        if (targetElement) {
          a.onclick = ()=> {
            // jump to tag position
            this.htmlView.scrollTop = targetElement.offsetTop
          }
        }
      } else {
        a.onclick = ()=> {
          // open file
          // same to the one in atom-markdown-katex.js
          let cmd = process.platform === 'win32' ? 'explorer' :
                    process.platform === 'darwin' ? 'open' : 'xdg-open'

          // open md and markdown preview
          if (href.endsWith('.md')) {
            let mdFilePath = path.resolve(this.rootDirectoryPath, href)
            atom.workspace.open(mdFilePath, {
              split: 'left',
              searchAllPanes: true
            }).then(function(editor) {
              if (editor) {
                startMDPreview(editor)
              }
            })
          } else {
            exec(cmd + ' ' + href)
          }
        }
      }
    }
  }

  updateMarkdown() {
    this.editorScrollDelay = Date.now() + 500
    this.previewScrollDelay = Date.now() + 500

    this.renderMarkdown()
  }

  renderMarkdown() {
      if (!this.htmlView) return
      if (Date.now() < this.parseDelay) return
      this.parseDelay = Date.now() + 200

      this.textContent = this.editor.getText()

      let html = parseMD(this) // TODO: change this later
      this.htmlView.innerHTML = html

      this.bindTagAClickEvent()

      this.sourceMap = null
  }

  destroy() {
    this.disposables.dispose()

    this.htmlView = null
  }
}

function startMDPreview(activeEditor) {
  if (!activeEditor || !activeEditor.getFileName()) {
    atom.notifications.addError('Invalid Markdown file')
    return false
  }

  let fileName = activeEditor.getFileName().trim()
  if (!(fileName.endsWith('.md') || fileName.endsWith('.markdown'))) {
    atom.notifications.addError('Invalid Markdown file: ' + fileName)
    return false
  }

  let buffer = activeEditor.buffer
  if (!buffer) {
    atom.notifications.addError('Invalid Markdown file: ' + fileName)
    return false
  }

  if (activeEditor.markdownPreview) {
    activeEditor.markdownPreview.reinitialize()
  } else {
    activeEditor.markdownPreview = new MarkdownPreview(activeEditor)
  }
  return true
}

module.exports = {
  startMDPreview: startMDPreview
}
