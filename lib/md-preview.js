'use strict'

let md = require('./md.js'),
    path = require('path'),
    exec = require('child_process').exec,
    mermaid = require('mermaid/dist/mermaid'),
    parseMD = md.parseMD,
    buildScrollMap = md.buildScrollMap,
    CompositeDisposable = require('atom').CompositeDisposable,
    getReplacedTextEditorStyles = require('./style.js').getReplacedTextEditorStyles

let globalKatexStyle = null
let globalTextEditorStyle = null  // this is to replace atom-text-editor to .editor-colors

atom.styles.onDidAddStyleElement(function(s) {
  if (globalTextEditorStyle) {
    globalTextEditorStyle.innerHTML = getReplacedTextEditorStyles()
  }
})

// MarkdownPreview constroller class
// Pass in .md editor
class MarkdownPreview {
  constructor() {
    this.editor = null // need to be binded later
    this.previewEditor = null

    this.htmlView = null

    this.editorScrollDelay = Date.now() + 500
    this.previewScrollDelay = Date.now() + 500
    this.parseDelay = Date.now() + 200

    this.scrollMap = null // for scroll sync
    this.resizeEvent = ()=> { // when resizing window, clear this.scrollMap
      this.scrollMap = null
    }

    window.addEventListener('resize', this.resizeEvent)

    this.rootDirectoryPath = null
    this.projectDirectoryPath = null
    this.uri = 'markdown-preview-enhanced://markdown preview'
    this.disposables = new CompositeDisposable()

    this.liveUpdate = atom.config.get('markdown-preview-enhanced.liveUpdate')
    this.scrollSync = atom.config.get('markdown-preview-enhanced.scrollSync')

    this.textContent = ''
    this.headings = []
    this.tocOrdered = null

    this.mathRenderingOption = null
  }

  // open preview on the right side panel
  bindEditor(editor) {
    this.destroy() // remove all binded events
    this.disposables = new CompositeDisposable() // everytime after we call .dispose() on disposables, we need to create a new CompositeDisposable

    this.editor = editor
    this.rootDirectoryPath = editor.getDirectoryPath()
    this.textContent = editor.getText()

    let editorPath = editor.getPath(),
        projectDirectories = editor.project.rootDirectories
    for (let i = 0; i < projectDirectories.length; i++) {
      if (projectDirectories[i].contains(editorPath)) { // editor belongs to this project
        this.projectDirectoryPath = projectDirectories[i].getPath()
        break
      }
    }


    if (!this.previewEditor) {
      atom.workspace.open(this.uri, {
          split: "right",
          activatePane: false,
          searchAllPanes: true
        }).then((previewEditor)=> {
          this.connectPreviewEditor(previewEditor)
          this.initEvents()
        })
    } else {
      this.htmlView.innerHTML = '<p style="font-size: 24px;"> loading preview... </p>'
      this.initEvents()
    }
  }

  initEvents() {
    // initialize events
    this.initEditorEvent()
    this.initHtmlViewEvents()
    this.initSettingsEvents()

    this.headings = []
    this.scrollMap = null

    this.paneActivateEditor()

    //
    // update tab title
    this.previewEditor.updateTabTitle()
  }

  connectPreviewEditor(previewEditor) {
    this.previewEditor = previewEditor
    this.previewEditor.markdownPreview = this

    this.createPreviewElement()
    this.initPreviewEditorEvents()
  }

  paneActivateEditor() {
    let panes = atom.workspace.getPanes()
    for (let i = 0; i < panes.length; i++) {
      let pane = panes[i]
      if (pane.itemForURI(this.editor.getPath())) {
        pane.activate()
        // pane.activateItemForURI(this.editor)
        break
      }
    }
  }

  // create dom element for preview
  createPreviewElement() {
    let previewEditorElement = atom.views.getView(this.previewEditor)
    previewEditorElement.innerHTML = '' // this line is important!

    this.htmlView = document.createElement('div')
    this.htmlView.style.width = '100%'
    this.htmlView.style.height = '100%'
    this.htmlView.style.margin = '0'
    this.htmlView.style.zIndex = '999'
    this.htmlView.style.overflow = 'scroll'
    this.htmlView.style.fontSize = '16px' // this is important as 'em' is relative to this px.
    this.htmlView.style.display = 'block'
    this.htmlView.style.boxSizing = 'border-box'
    this.htmlView.style.position = 'relative' // this is important for building scrollMap

    this.htmlView.className = 'markdown-preview-enhanced'
    this.htmlView.innerHTML = '<p style="font-size: 24px;"> loading preview... </p>'

    // let shadowDom = previewEditorElement.createShadowRoot()
    previewEditorElement.appendChild(this.htmlView)

    if (!globalKatexStyle) {
      globalKatexStyle = document.createElement('link')
      globalKatexStyle.rel = 'stylesheet'
      globalKatexStyle.href = path.resolve(__dirname, '../node_modules/katex/dist/katex.min.css')
      document.getElementsByTagName('head')[0].appendChild(globalKatexStyle)

      globalTextEditorStyle = document.createElement('style')
      globalTextEditorStyle.innerHTML = getReplacedTextEditorStyles()
      globalTextEditorStyle.setAttribute('for', 'markdown-preview-enhanced')
      let head = document.getElementsByTagName('head')[0],
          atomStyles = document.getElementsByTagName('atom-styles')[0]
      head.insertBefore(globalTextEditorStyle, atomStyles)
    }
  }

  initEditorEvent() {
    let editor = this.editor
    // TODO: 这里有问题
    // close editor
    this.disposables.add(
      editor.onDidDestroy(()=> {
        this.previewEditor.setTabTitle('unknown preview')

        this.htmlView.innerHTML = '<p style="font-size: 24px;"> Open a markdown file to start preview </p>'

        this.editor = null

        this.destroy()
      })
    )

    this.disposables.add(
      editor.onDidStopChanging(()=> {
        if (this.liveUpdate) {
          this.updateMarkdown()
        }
      })
    )

    this.disposables.add(
      editor.onDidSave(()=> {
        if (!this.liveUpdate) {
          this.updateMarkdown()
        }
      })
    )

    this.disposables.add(
      editor.onDidChangeScrollTop(()=> {
        if (!this.htmlView || !this.scrollSync || !this.liveUpdate) return
        if (Date.now() < this.editorScrollDelay) return

        let editorElement = editor.getElement()

        let editorHeight = editorElement.getHeight()

        let firstVisibleScreenRow = editor.getFirstVisibleScreenRow()
        let lastVisibleScreenRow = firstVisibleScreenRow + Math.floor(editorHeight / editor.getLineHeightInPixels())

        let lineNo = Math.floor((firstVisibleScreenRow + lastVisibleScreenRow) / 2)

        if (!this.scrollMap) {
          this.scrollMap = buildScrollMap(this)
        }

        // disable markdownHtmlView onscroll
        this.previewScrollDelay = Date.now() + 500

        this.htmlView.scrollTop = this.scrollMap[/*firstVisibleScreenRow*/lineNo] - editorHeight / 2
      })
    )

    // match markdown preview to cursor position
    this.disposables.add(
      editor.onDidChangeCursorPosition((event)=> {
        if (!this.htmlView || !this.scrollSync || !this.liveUpdate) return

        // track currnet time to disable onDidChangeScrollTop
        this.editorScrollDelay = Date.now() + 500
        // disable preview onscroll
        this.previewScrollDelay = Date.now() + 500

        if (event.oldScreenPosition.row !== event.newScreenPosition.row || event.oldScreenPosition.column == 0) {
          if (event.newScreenPosition.row === 0) {
            this.htmlView.scrollTop = 0
            return
          }

          let lineNo = event.newScreenPosition.row
          this.scrollSyncToLineNo(lineNo)
        }
      })
    )
  }

  initPreviewEditorEvents() {
    let disposable = this.previewEditor.onDidDestroy(()=> {
      this.previewEditor = null
      this.htmlView = null
      this.destroy()
      disposable.dispose()
    })
  }

  initHtmlViewEvents() {
    // preview scroll
    this.htmlView.onscroll = ()=> {
      if (!this.editor || !this.scrollSync || !this.liveUpdate) return
      if (Date.now() < this.previewScrollDelay) return

      let top = this.htmlView.scrollTop + this.htmlView.offsetHeight / 2

      // try to find corresponding screen buffer row
      if (!this.scrollMap) {
        this.scrollMap = buildScrollMap(this)
      }

      let scrollMap = this.scrollMap,
          i = 0,
          j = scrollMap.length - 1,
          count = 0,
          screenRow = -1

      while(count < 20) {
        if (Math.abs(top - scrollMap[i]) < 20) {
          screenRow = i
          break
        } else if (Math.abs(top - scrollMap[j]) < 20) {
          screenRow = j
          break
        } else {
          let mid = Math.floor((i + j) / 2)
          if (top > scrollMap[mid]) {
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
    this.disposables.add(atom.config.observe('markdown-preview-enhanced.useGitHubStyle', (useGitHubStyle)=> {
        this.htmlView.setAttribute("data-use-github-style", useGitHubStyle ? 'true' : 'false')
    }))

    // github syntax theme?
    this.disposables.add(atom.config.observe('markdown-preview-enhanced.useGitHubSyntaxTheme', (useGitHubSyntaxTheme)=> {
        this.htmlView.setAttribute("data-use-github-syntax-theme", useGitHubSyntaxTheme ? 'true' : 'false')
    }))

    // break line?
    this.disposables.add(atom.config.observe('markdown-preview-enhanced.breakOnSingleNewline', (breakOnSingleNewline)=> {
      this.renderMarkdown()
    }))

    // liveUpdate?
    this.disposables.add(atom.config.observe('markdown-preview-enhanced.liveUpdate', (lFlag)=> {
      this.liveUpdate = lFlag
    }))

    // scrollSync?
    this.disposables.add(atom.config.observe('markdown-preview-enhanced.scrollSync', (sFlag)=> {
      this.scrollSync = sFlag
    }))

    // KaTeX?
    this.disposables.add(atom.config.observe('markdown-preview-enhanced.mathRenderingOption', (option)=> {
      this.mathRenderingOption = option
      this.renderMarkdown()
    }))
  }

  scrollSyncToLineNo(lineNo) {
    if (!this.scrollMap) {
      this.scrollMap = buildScrollMap(this)
    }

    let editorElement = this.editor.getElement()

    let firstVisibleScreenRow = this.editor.getFirstVisibleScreenRow(),
        posRatio = (lineNo - firstVisibleScreenRow) / (editorElement.getHeight() / this.editor.getLineHeightInPixels()),
        scrollTop = this.scrollMap[lineNo] - (posRatio > 1 ? 1 : posRatio) * editorElement.getHeight()

    this.htmlView.scrollTop = scrollTop
  }

  // <a href="" > ... </a> click event
  bindTagAClickEvent() {
    let as = this.htmlView.getElementsByTagName('a'),
        length = as.length
    for (let i = 0; i < length; i++) {
      let a = as[i],
          href = a.getAttribute('href')
      if (href && href[0] === '#') {
        let targetElement = this.htmlView.querySelector(`[id="${href.slice(1)}"]`) // fix number id bug
        if (targetElement) {
          a.onclick = ()=> {
            // jump to tag position
            let offsetTop = 0,
                el = targetElement
            while (el && el != this.htmlView) {
              offsetTop += el.offsetTop
              el = el.offsetParent
            }

            if (this.htmlView.scrollTop > offsetTop) {
              this.htmlView.scrollTop = offsetTop - 32
            } else {
              this.htmlView.scrollTop = offsetTop
            }
          }
        }
      } else {
        a.onclick = ()=> {
          // open md and markdown preview
          if (href && href.endsWith('.md')) {
            let mdFilePath = path.resolve(this.rootDirectoryPath, href)
            if (href[0] === '/') {
              mdFilePath = path.resolve(this.projectDirectoryPath, '.' + href)
            }
            atom.workspace.open(mdFilePath, {
              split: 'left',
              searchAllPanes: true
            })
          }
        }
      }
    }
  }

  initTaskList() {
    let checkboxs = this.htmlView.getElementsByClassName('task-list-item-checkbox'),
        length = checkboxs.length

    for (let i = 0; i < length; i++) {
      let checkbox = checkboxs[i]
      let this_ = this
      checkbox.onclick = function() {
        if (!this_.editor) return

        let checked = this.checked,
            buffer = this_.editor.buffer

        if (!buffer) return

        let lineNo = parseInt(this.parentElement.getAttribute('data-line'))
        let line = buffer.lines[lineNo]

        if (checked) {
          line = line.replace('[ ]', '[x]')
        } else {
          line = line.replace(/\[(x|X)\]/, '[ ]')
        }

        this_.parseDelay = Date.now() + 500

        buffer.setTextInRange([[lineNo, 0], [lineNo+1, 0]], line + '\n')
      }
    }
  }

  renderMermaid() {
    let els = this.htmlView.getElementsByClassName('mermaid')
    if (els.length) {
      mermaid.init()
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

      if (this.mathRenderingOption === 'MathJax' && typeof(MathJax) !== 'undefined') {
        let temp = document.createElement('div')
        temp.innerHTML = html

        MathJax.Hub.Queue(['Typeset', MathJax.Hub, temp],
                          ()=> {
                            if (this.htmlView) {
                              this.htmlView.innerHTML = temp.innerHTML
                              this.bindEvents()
                            }
                          })

      } else {
        this.htmlView.innerHTML = html

        this.bindEvents()
      }
  }

  bindEvents() {
    this.bindTagAClickEvent()
    this.initTaskList()
    this.renderMermaid()
    this.scrollMap = null
  }

  destroy() {
    this.disposables.dispose()

    if (this.htmlView) {
      this.htmlView.onscroll = null
    }
  }
}

let globalMarkdownPreview = new MarkdownPreview() // singleton

function startMDPreview(activeEditor) {
  if (!activeEditor || !activeEditor.getFileName()) {
    atom.notifications.addError('Markdown file should be saved first.')
    return false
  }

  let fileName = activeEditor.getFileName().trim()
  if (!(fileName.endsWith('.md') || fileName.endsWith('.markdown'))) {
    atom.notifications.addError('Invalid Markdown file: ' + fileName + '. The file extension should be .md or .markdown' )
    return false
  }

  let buffer = activeEditor.buffer
  if (!buffer) {
    atom.notifications.addError('Invalid Markdown file: ' + fileName)
    return false
  }

  if (globalMarkdownPreview.editor !== activeEditor || !globalMarkdownPreview.previewEditor) {
    globalMarkdownPreview.bindEditor(activeEditor)
  }
  return true
}

module.exports = {
  startMDPreview,
  globalMarkdownPreview
}
