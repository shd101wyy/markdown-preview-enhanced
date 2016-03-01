'use strict'

let md = require('./md.js'),
    parseMD = md.parseMD,
    buildScrollMap = md.buildScrollMap,
    path = require('path'),
    CompositeDisposable = require('atom').CompositeDisposable

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

  atom.workspace.onDidChangeActivePaneItem(function(editor) {
    if (editor && activeEditor && editor === activeEditor.htmlPreviewEditor) {
      if (activeEditor.markdownHtmlView) {
        activeEditor.markdownHtmlView.style.display = "inline"
        activeEditor.htmlPreviewEditor.textContent = activeEditor.getText()
        activeEditor.markdownHtmlView.innerHTML = parseMD(activeEditor.getText(), rootDirectoryPath )
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
        markdownHtmlView.style.height = '100%'
        markdownHtmlView.style.margin = '0'
        markdownHtmlView.style.zIndex = '999'
        markdownHtmlView.style.overflow = 'scroll'

        markdownHtmlView.className = 'markdown-katex-preview'


        // add html view to editor
        parentElement.insertBefore(markdownHtmlView, textEditorElement)
        parentElement.removeChild(textEditorElement)

        window.editor = htmlPreviewEditor

        function updateMarkdown() {
          if (!activeEditor.markdownHtmlView) return

          // track currnet time to disable onDidChangeScrollTop
          activeEditor.delay = Date.now() + 500
          // disable markdownHtmlView onscroll
          markdownHtmlView.delay = Date.now() + 500

          activeEditor.htmlPreviewEditor.textContent = activeEditor.getText()
          activeEditor.markdownHtmlView.innerHTML = parseMD(activeEditor.getText(), rootDirectoryPath )
          activeEditor.sourceMap = null
        }

        htmlPreviewEditor.onDidDestroy(function() {
          activeEditor.markdownHtmlView = null
          disposables.dispose()
          htmlPreviewEditor = null
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
          if (!activeEditor.markdownHtmlView || !scrollSync || !liveUpdate) return

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
          if (!activeEditor.markdownHtmlView || !scrollSync || !liveUpdate) return

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
            markdownHtmlView.innerHTML = parseMD(activeEditor.getText(), rootDirectoryPath)
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
            markdownHtmlView.innerHTML = parseMD(activeEditor.getText(), rootDirectoryPath)
          }, 500)
        }))

        activeEditor.markdownHtmlView = markdownHtmlView
        activeEditor.htmlPreviewEditor = htmlPreviewEditor
        activeEditor.htmlPreviewEditor.textContent = activeEditor.getText()
      }

      // set content
      activeEditor.markdownHtmlView.innerHTML = parseMD(activeEditor.getText(), rootDirectoryPath)
    })
}

module.exports = {
  startMDPreview: startMDPreview
}
