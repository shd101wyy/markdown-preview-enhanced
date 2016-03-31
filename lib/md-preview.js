'use strict'

let md = require('./md.js'),
    parseMD = md.parseMD,
    buildScrollMap = md.buildScrollMap,
    path = require('path'),
    CompositeDisposable = require('atom').CompositeDisposable,
    getMarkdownPreviewCSS = require('./style.js').getMarkdownPreviewCSS

function startMDPreview(activeEditor) {
  if (!activeEditor || !activeEditor.getFileName()) {
    alert('Invalid Markdown file')
    return
  }
  let buffer = activeEditor.buffer
  if (!buffer) {
    alert('Invalid Markdown file: ' + activeEditor.getFileName())
    return
  }
  let filePath = buffer.file.path,
      rootDirectoryPath = path.resolve(path.dirname(filePath)),
      uri = "atom-markdown-katex://" + activeEditor.getFileName() + ' preview',
      disposables = new CompositeDisposable(),
      liveUpdate = true,
      scrollSync = true

  activeEditor.markdownHtmlView = null

  function renderMarkdown(activeEditor) {
    if (!activeEditor) return

    let markdownHtmlView = activeEditor.markdownHtmlView

    if (!markdownHtmlView) return

    let html = parseMD(activeEditor.getText(), rootDirectoryPath)

    markdownHtmlView.innerHTML = html
  }

  atom.workspace.onDidChangeActivePaneItem(function(editor) {
    if (editor && activeEditor && editor === activeEditor.htmlPreviewEditor) {
      if (activeEditor.markdownHtmlView) {
        activeEditor.domContainer.style.display = 'inline-flex'
        activeEditor.htmlPreviewEditor.textContent = activeEditor.getText()
        renderMarkdown(activeEditor)
      }
    }
  })

  // open new pane to show html
  atom.workspace.open(uri, {
      split: "right",
      activatePane: false,
      searchAllPanes: true
    })
    .then(function(editor) {
      if (activeEditor.markdownHtmlView === null) {
        let htmlPreviewEditor = editor
        htmlPreviewEditor.rootDirectoryPath = rootDirectoryPath

        let textEditorElement = atom.views.getView(htmlPreviewEditor)
        let parentElement = textEditorElement.parentElement

        let markdownHtmlView = document.createElement('div')
        markdownHtmlView.style.width = '100%'
        // markdownHtmlView.style.height = '100%'
        markdownHtmlView.style.margin = '0'
        markdownHtmlView.style.zIndex = '999'
        markdownHtmlView.style.overflow = 'scroll'
        markdownHtmlView.style.fontSize = '16px' // this is important as 'em' is relative to this px.

        markdownHtmlView.className = 'markdown-katex-preview'


        let dom = document.createElement('div')
        dom.style.width = '100%'
        dom.style.height = '100%'
        dom.style.margin = '0'
        dom.style.padding = '0' // this one is important
        dom.style.zIndex = '999'
        dom.style.overflow = 'scroll'
        dom.style.display = 'inline-flex'
        dom.className = 'markdown-katex-preview'

        parentElement.insertBefore(dom, textEditorElement)
        parentElement.removeChild(textEditorElement)

        let shadowDom = dom.createShadowRoot()
        let style = document.createElement('style')
        style.innerHTML = getMarkdownPreviewCSS()

        shadowDom.appendChild(style)
        shadowDom.appendChild(markdownHtmlView)

        // atom editor update styles, then update markdown preview styles as well
        atom.styles.onDidUpdateStyleElement(function() {
          if (style) {
            style.innerHTML = getMarkdownPreviewCSS()
          }
        })



        function updateMarkdown() {
          if (!activeEditor || !markdownHtmlView) return

          // track currnet time to disable onDidChangeScrollTop
          activeEditor.delay = Date.now() + 500
          // disable markdownHtmlView onscroll
          markdownHtmlView.delay = Date.now() + 500

          activeEditor.htmlPreviewEditor.textContent = activeEditor.getText()
          renderMarkdown(activeEditor)
          activeEditor.sourceMap = null
        }

        htmlPreviewEditor.onDidDestroy(function() {
          disposables.dispose()
          markdownHtmlView = null
          htmlPreviewEditor = null
          if (activeEditor) {
            activeEditor.markdownHtmlView = null
            activeEditor.htmlPreviewEditor = null
          }
          // activeEditor.disposables.dispose()
        })

        activeEditor.onDidDestroy(function() {
          activeEditor = null
          // htmlPreviewEditor.destroy();
        })

        activeEditor.onDidStopChanging(function() {
          if (liveUpdate) {
            updateMarkdown()
          }
        })

        activeEditor.onDidSave(function() {
          if (!liveUpdate) {
            updateMarkdown()
          }
        })

        activeEditor.onDidChangeScrollTop(function() {
          if (!markdownHtmlView || !scrollSync || !liveUpdate) return

          if (activeEditor.delay && Date.now() < activeEditor.delay) return

          let editorHeight = activeEditor.getHeight()

          let firstVisibleScreenRow = activeEditor.getFirstVisibleScreenRow()
          let lastVisibleScreenRow = firstVisibleScreenRow + Math.floor(editorHeight / activeEditor.getLineHeightInPixels())

          let lineNo = Math.floor((firstVisibleScreenRow + lastVisibleScreenRow) / 2)

          if (!activeEditor.sourceMap) {
            activeEditor.sourceMap = buildScrollMap(activeEditor)
          }

          // disable markdownHtmlView onscroll
          markdownHtmlView.delay = Date.now() + 500

          activeEditor.markdownHtmlView.scrollTop = activeEditor.sourceMap[/*firstVisibleScreenRow*/lineNo] - editorHeight / 2

        })

        // match markdown preview to cursor position
        activeEditor.onDidChangeCursorPosition(function(event) {
          if (!markdownHtmlView || !scrollSync || !liveUpdate) return

          // track currnet time to disable onDidChangeScrollTop
          activeEditor.delay = Date.now() + 500
          // disable markdownHtmlView onscroll
          markdownHtmlView.delay = Date.now() + 500

          if (!event.textChanged || event.oldScreenPosition.row !== event.newScreenPosition.row || event.oldScreenPosition.column == 0) {
            if (!activeEditor.sourceMap) {
              activeEditor.sourceMap = buildScrollMap(activeEditor)
            }

            if (event.newScreenPosition.row === 0) {
              activeEditor.markdownHtmlView.scrollTop = 0
              return
            }

            let lineNo = event.newScreenPosition.row,
                cursor = event.cursor,
                firstVisibleScreenRow = activeEditor.getFirstVisibleScreenRow(),
                posRatio = (lineNo - firstVisibleScreenRow) / (activeEditor.getHeight() / activeEditor.getLineHeightInPixels()),
                scrollTop = activeEditor.sourceMap[lineNo] - (posRatio > 1 ? 1 : posRatio) * activeEditor.getHeight()

            activeEditor.markdownHtmlView.scrollTop = scrollTop
          }
        })

        // preview scroll
        markdownHtmlView.onscroll = function() {
          if (!activeEditor || !scrollSync || !liveUpdate) return
          if (markdownHtmlView.delay && Date.now() < markdownHtmlView.delay) return

          let top = markdownHtmlView.scrollTop + markdownHtmlView.offsetHeight / 2

          // try to find corresponding screen buffer row
          if (!activeEditor.sourceMap) {
            activeEditor.sourceMap = buildScrollMap(activeEditor)
          }

          let sourceMap = activeEditor.sourceMap,
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
            activeEditor.setScrollTop(screenRow * activeEditor.getLineHeightInPixels() - markdownHtmlView.offsetHeight / 2)

            // track currnet time to disable onDidChangeScrollTop
            activeEditor.delay = Date.now() + 500
          }
        }

        /* settings changed */
        // github style?
        disposables.add(atom.config.observe('atom-markdown-katex.useGitHubStyle', (useGitHubStyle)=> {
            markdownHtmlView.setAttribute("data-use-github-style", useGitHubStyle ? 'true' : 'false')
        }))

        // break line?
        disposables.add(atom.config.observe('atom-markdown-katex.breakOnSingleNewline', (breakOnSingleNewline)=> {
          setTimeout(()=> {
            renderMarkdown(activeEditor)
          }, 500)
        }))

        // liveUpdate?
        disposables.add(atom.config.observe('atom-markdown-katex.liveUpdate', (lFlag)=> {
          liveUpdate = lFlag
        }))

        // scrollSync?
        disposables.add(atom.config.observe('atom-markdown-katex.scrollSync', (sFlag)=> {
          scrollSync = sFlag
        }))

        // KaTeX?
        disposables.add(atom.config.observe('atom-markdown-katex.useKaTeX', (useKaTeX)=> {
          setTimeout(()=> {
            renderMarkdown(activeEditor)
          }, 500)
        }))

        activeEditor.markdownHtmlView = markdownHtmlView
        activeEditor.htmlPreviewEditor = htmlPreviewEditor
        activeEditor.htmlPreviewEditor.textContent = activeEditor.getText()
        activeEditor.domContainer = dom
      }

      // set content
      renderMarkdown(activeEditor)
    })
}

module.exports = {
  startMDPreview: startMDPreview
}
