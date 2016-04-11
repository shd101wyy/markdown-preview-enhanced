'use strict'

let md = require('./md.js'),
    path = require('path'),
    exec = require('child_process').exec,
    parseMD = md.parseMD,
    buildScrollMap = md.buildScrollMap,
    CompositeDisposable = require('atom').CompositeDisposable,
    getMarkdownPreviewCSS = require('./style.js').getMarkdownPreviewCSS

let globalKatexStyle = null

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

  // <a href="" > ... </a> click event
  function bindTagAClickEvent(markdownHtmlView) {
    let as = markdownHtmlView.querySelectorAll('a')
    for (let i = 0; i < as.length; i++) {
      let a = as[i],
          href = a.getAttribute('href')
      if (href && href[0] === '#') {
        let targetElement = markdownHtmlView.querySelector(`[id="${href.slice(1)}"]`) // fix number id bug
        if (targetElement) {
          a.onclick = function() {
            // jump to tag position
            markdownHtmlView.scrollTop = targetElement.offsetTop
          }
        }
      } else {
        a.onclick = function() {
          // open file
          // same to the one in atom-markdown-katex.js
          let cmd = process.platform === 'win32' ? 'explorer' :
                    process.platform === 'darwin' ? 'open' : 'xdg-open'

          // open md and markdown preview
          if (href.endsWith('.md')) {
            let mdFilePath = path.resolve(rootDirectoryPath, href)
            atom.workspace.open(mdFilePath, {
              split: 'left',
              searchAllPanes: true
            }).then(function(editor) {
              if (editor && !editor.markdownHtmlView) {
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

  function renderMarkdown(activeEditor) {
    if (!activeEditor) return

    let markdownHtmlView = activeEditor.markdownHtmlView

    if (!markdownHtmlView) return

    let html = parseMD(activeEditor.getText(), rootDirectoryPath)

    markdownHtmlView.innerHTML = html

    bindTagAClickEvent(markdownHtmlView)
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
        markdownHtmlView.style.height = '96%' // cannot use 100%... use 100% doesn't display well
        markdownHtmlView.style.margin = '0'
        markdownHtmlView.style.zIndex = '999'
        markdownHtmlView.style.overflow = 'scroll'
        markdownHtmlView.style.fontSize = '16px' // this is important as 'em' is relative to this px.
        markdownHtmlView.style.display = 'block'

        markdownHtmlView.className = 'markdown-katex-preview'


        let dom = document.createElement('div')
        dom.style.width = '100%'
        dom.style.height = '100%'
        dom.style.margin = '0'
        dom.style.padding = '0' // this one is important
        dom.style.zIndex = '999'
        dom.style.overflow = 'hidden'
        dom.style.display = 'inline-flex'
        dom.className = 'markdown-katex-preview'

        parentElement.insertBefore(dom, textEditorElement)
        parentElement.removeChild(textEditorElement)

        let shadowDom = dom.createShadowRoot()
        /*
        <link rel="stylesheet"
              href="${path.resolve(__dirname, '../katex-style/katex.min.css')}">
         */

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
        shadowDom.appendChild(markdownHtmlView)

        // atom editor update styles, then update markdown preview styles as well
        /*
        atom.styles.onDidUpdateStyleElement(function() {
          //console.log('onDidUpdateStyleElement')
          if (markdownStyle) {
            markdownStyle.innerHTML = getMarkdownPreviewCSS()
          }
        })
        */

        atom.styles.onDidAddStyleElement(function(s) {
          //console.log('onDidAddStyleElement')
          if (markdownStyle) {
            markdownStyle.innerHTML = getMarkdownPreviewCSS()
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

        htmlPreviewEditor.onDidDestroy(function() {
          dom.remove()
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

        // github syntax theme?
        disposables.add(atom.config.observe('atom-markdown-katex.useGitHubSyntaxTheme', (useGitHubSyntaxTheme)=> {
            markdownHtmlView.setAttribute("data-use-github-syntax-theme", useGitHubSyntaxTheme ? 'true' : 'false')
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
