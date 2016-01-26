/**
 * atom-markdown-katex plugin for atom editor
 * By Yiyi Wang (shd101wyy)
 *
 */
'use strict'
let katex = require("katex"), // for katex
    highlightjs = require("highlight.js"), // for highlight
    fs = require("fs"),
    cheerio = require("cheerio"),
    temp = require('temp'),
    exec = require('child_process').exec,
    path = require('path'),
    less = require('less'),
    async = require('async'),
    remarkable = require('remarkable')

let defaults = {
  html:         true,        // Enable HTML tags in source
  xhtmlOut:     false,        // Use '/' to close single tags (<br />)
  breaks:       true,        // Convert '\n' in paragraphs into <br>
  langPrefix:   'language-',  // CSS language prefix for fenced blocks
  linkify:      true,         // autoconvert URL-like texts to links
  linkTarget:   '',           // set target to open link in
  typographer:  true,         // Enable smartypants and other sweet transforms
}

defaults.highlight = function (str, lang) {
  let hljs = highlightjs
  if (lang && hljs.getLanguage(lang)) {
    try {
      return hljs.highlight(lang, str).value;
    } catch (__) {}
  }

  try {
    return hljs.highlightAuto(str).value;
  } catch (__) {}

  return ''
}

let md = new remarkable(defaults)

//
// Inject line numbers for sync scroll. Notes:
//
// - We track only headings and paragraphs on first level. That's enougth.
// - Footnotes content causes jumps. Level limit filter it automatically.
//
md.renderer.rules.paragraph_open = function (tokens, idx) {
  var line
  if (tokens[idx].lines && tokens[idx].level === 0) {
    line = tokens[idx].lines[0]
    return '<p class="line" data-line="' + line + '">'
  }
  return '<p>'
}

md.renderer.rules.heading_open = function (tokens, idx) {
  var line;
  if (tokens[idx].lines && tokens[idx].level === 0) {
    line = tokens[idx].lines[0]
    return '<h' + tokens[idx].hLevel + ' class="line" data-line="' + line + '">'
  }
  return '<h' + tokens[idx].hLevel + '>'
}

// Build offsets for each line (lines can be wrapped)
// That's a bit dirty to process each line everytime, but ok for demo.
// Optimizations are required only for big texts.
function buildScrollMap(editor) {
  var i, offset, nonEmptyList, pos, a, b, lineHeightMap, linesCount, acc, _scrollMap

  let markdownHtmlView = editor.markdownHtmlView
  let lines = editor.getBuffer().getLines()

  // offset = $('.result-html').scrollTop() - $('.result-html').offset().top;
  offset = 0 // markdownHtmlView.scrollTop - markdownHtmlView.offsetTop this is wrong
  _scrollMap = []
  nonEmptyList = []
  lineHeightMap = []

  acc = 0;
  lines.forEach(function(str, n) {
    var h, lh

    lineHeightMap.push(acc);

    if (str.length === 0) {
      acc++
      return
    }

    acc += editor.screenRowForBufferRow(n + 1) - editor.screenRowForBufferRow(n)
  })
  lineHeightMap.push(acc)
  linesCount = acc

  for (let i = 0; i < linesCount; i++) { _scrollMap.push(-1); }

  nonEmptyList.push(0)
  _scrollMap[0] = 0

  let lineElements = markdownHtmlView.querySelectorAll ('.line')
  for (let i = 0; i < lineElements.length; i++) {
    let el = lineElements[i],
        t = el.getAttribute('data-line')
    if (t === '') { return; }
    t = lineHeightMap[Number(t)]
    if (t !== 0) { nonEmptyList.push(t) }
    _scrollMap[t] = Math.round(el.offsetTop + offset)
  }

  nonEmptyList.push(linesCount)
  _scrollMap[linesCount] = markdownHtmlView.scrollHeight;

  pos = 0
  for (i = 1; i < linesCount; i++) {
    if (_scrollMap[i] !== -1) {
      pos++
      continue
    }

    a = nonEmptyList[pos]
    b = nonEmptyList[pos + 1]
    _scrollMap[i] = Math.round((_scrollMap[b] * (i - a) + _scrollMap[a] * (b - i)) / (b - a))
  }
  return _scrollMap  // scrollMap's length == screenLineCount
}
// console.log('0.3.9')


/*
 * This pdfIFrame is added to document.body once.
 * it is used to render parsed html content from markdown and then print to pdf.
 */
let pdfIFrame = document.createElement('iframe')
pdfIFrame.style.display = 'none';
pdfIFrame.id = 'atom-markdown-katex-pdf'
pdfIFrame.src = 'about:blank'
pdfIFrame.onload = function (){ // show print option when iframe finishes loading
  if (pdfIFrame.src === 'about:blank') return
  pdfIFrame.contentWindow.print()
}
document.body.appendChild(pdfIFrame)

// Automatically track and cleanup files at exit
temp.track();

// replace string within $...$ or $$...$$ with rendered string
function parseKatex(inputString, mathExpressions) {
  let outputString = "",
      mathExpCount = 0
  // return end
  function findEnd(start, tag) {
    let end = -1
    let j
    for (let i = start; i < inputString.length; i++) {
      if (inputString[i] === "\\") {
        i += 1
        continue;
      }
      let match = true
      for (j = 0; j < tag.length; j++) {
        if (i + j >= inputString.length || inputString[i + j] !== tag[j]) {
          match = false;
          break
        }
      }
      if (match) {
        return i
      }
    }
    return end
  }

  for (let i = 0; i < inputString.length; i++) {
    if (inputString[i] === "\\") {
      // fix dollar sign bug
      // eg  \$12 + \$13   should be rendered as $12 + $13
      if (i + 1 < inputString.length && inputString[i + 1] === '$') {
        outputString += '$'
        i += 1
      } else if (inputString.slice(i + 1, i + 8) === 'newpage') {
        outputString += '<div class="newpage"></div>'
        i += 8
      } else {
        outputString += inputString[i];
        if (i + 1 < inputString.length) {
          i += 1;
          outputString += inputString[i]
        }
      }
    } else if (inputString[i] === '$') {
      let tag = (i + 1 < inputString.length && inputString[i + 1] === '$') ? '$$' : '$'
      let start = i + tag.length
      let end = findEnd(start, tag)
      if (end !== -1) {
        try {
          mathExpressions.push(katex.renderToString(inputString.slice(start, end), {
            displayMode: (tag === '$' ? false : true)
          }))
          outputString += '$me' + mathExpCount + '$'
          mathExpCount += 1
        } catch (e) {
          outputString += '<span style="color: #ee7f49; font-weight: 500;">{ parse error: ' + inputString.slice(start, end) + ' }</span>'
        }
        i = end + tag.length - 1
      } else {
        outputString += tag + inputString.slice(start, inputString.length)
        break
      }
    } else {
      outputString += inputString[i]
    }
  }
  return outputString
}

// resolve image path...
function resolveImagePaths(html, directoryPath) {
  if (!directoryPath) return

  let $ = cheerio.load(html)
  $('img').each(function(i, imgElement) {
    let img = $(imgElement)
    let src = img.attr('src')
    if (src &&
      (!(src.startsWith('http://') ||
        src.startsWith('https://') ||
        src.startsWith('atom://')  ||
        src.startsWith('file://'))) &&
      (src.startsWith('./') ||
        src.startsWith('../') ||
        src[0] !== '/')) {
      img.attr('src', path.resolve(directoryPath,  src))
    }
  })
  return $.html()
}

function replaceMathExpression(html, mathExpressions) {
  for (let i = 0; i < mathExpressions.length; i++) {
    html = html.replace('$me' + i + '$', mathExpressions[i])
  }
  return html
}

// parse markdown content to html
function parseMD(inputString, directoryPath) {
  // replace math expression
  let mathExpressions = []
  let replaced = parseKatex(inputString, mathExpressions)
  // convert to html
  let html = md.render(replaced)

  // replace math expression back
  html = replaceMathExpression(html, mathExpressions)
  return resolveImagePaths(html, directoryPath)
}


// open new window to show rendered markdown html
function beginMarkdownKatexPreview() {
  // get current selected active editor
  let activeEditor = atom.workspace.getActiveTextEditor()
  let filePath = activeEditor.buffer.file.path
  let rootDirectoryPath = path.resolve(path.dirname(filePath))

  // already activated
  if (activeEditor.markdownHtmlView) {
    return
  }
  activeEditor.markdownHtmlView = null

  let uri = "atom-markdown-katex://markdown-katex-preview" //+ editor.id + ".html";

  atom.workspace.onDidChangeActivePaneItem(function(editor) {
    if (editor && editor === activeEditor.htmlPreviewEditor) {
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

        let markdownHtmlView = document.createElement("div")
        markdownHtmlView.style.width = "100%"
        markdownHtmlView.style.height = "100%"
        markdownHtmlView.style.margin = "0"
        markdownHtmlView.style.zIndex = "999"
        markdownHtmlView.style.overflow = "scroll"

        markdownHtmlView.className = "markdown-katex-preview"

        markdownHtmlView.style.backgroundColor = "white"

        // add html view to editor
        parentElement.insertBefore(markdownHtmlView, textEditorElement)
        parentElement.removeChild(textEditorElement)

        htmlPreviewEditor.onDidDestroy(function() {
          activeEditor.markdownHtmlView = null
          htmlPreviewEditor = null
        })

        // change markdown content
        activeEditor.onDidStopChanging(function() {
          if (activeEditor.markdownHtmlView) {
            activeEditor.htmlPreviewEditor.textContent = activeEditor.getText()
            activeEditor.markdownHtmlView.innerHTML = parseMD(activeEditor.getText(), rootDirectoryPath )
            activeEditor.sourceMap = null

            // keep view at bottom
            if (activeEditor.getCursorScreenPosition().row + 1 === activeEditor.getScreenLineCount()) {
              activeEditor.markdownHtmlView.scrollTop = activeEditor.markdownHtmlView.scrollHeight
              activeEditor.disableChangeScrollTop = 1
            }
          }
        })

        // the line below is for debugging
        // window.activeEditor = activeEditor

        // TODO: Implement scroll sync in the future.
        activeEditor.onDidChangeScrollTop(function() {
          if (activeEditor && activeEditor.markdownHtmlView) {
            if (activeEditor.disableChangeScrollTop) {
              activeEditor.disableChangeScrollTop -= 1
              return
            }

            if (activeEditor.getScrollTop() <= 6 ) {
              activeEditor.markdownHtmlView.scrollTop = 0
              return
            }

            let editorHeight = activeEditor.getHeight()

            let firstVisibleScreenRow = activeEditor.getFirstVisibleScreenRow()
            let lastVisibleScreenRow = firstVisibleScreenRow + Math.floor(editorHeight / activeEditor.getLineHeightInPixels())

            let lineNo = Math.floor((firstVisibleScreenRow + lastVisibleScreenRow) / 2)

            if (!activeEditor.sourceMap) {
              activeEditor.sourceMap = buildScrollMap(activeEditor)
            }
            activeEditor.markdownHtmlView.scrollTop = activeEditor.sourceMap[/*firstVisibleScreenRow*/lineNo] - editorHeight / 2
          }
        })

        activeEditor.markdownHtmlView = markdownHtmlView
        activeEditor.htmlPreviewEditor = htmlPreviewEditor
        activeEditor.htmlPreviewEditor.textContent = activeEditor.getText()
      }

      // set content
      activeEditor.markdownHtmlView.innerHTML = parseMD(activeEditor.getText(), rootDirectoryPath )
    })
}

// get offline html content
// pass in htmlContent to callback function
function getOfflineHTMLContent(callback) {
  let editor = atom.workspace.getActiveTextEditor()
  let rootDirectoryPath = editor.rootDirectoryPath
  let textContent = editor.textContent
  let htmlContent = parseMD(textContent, rootDirectoryPath)

  let indexLess = fs.readFileSync(path.resolve(__dirname,  '../styles/atom-markdown-katex.less'), 'utf8')
  let customLess = fs.readFileSync(path.resolve(__dirname,  '../styles/custom.less'), 'utf8')
  let highlightCSS = fs.readFileSync(path.resolve(__dirname,  '../styles/highlight.css'), 'utf8')

  async.parallel([
    function(callback){
      less.render(indexLess, function(e, output) {
        callback(null, output.css)
      })
    },
    function(callback){
      less.render(customLess, function(e, output) {
        callback(null, output.css)
      })
    }
  ], function(err, results) {
    htmlContent = '<!DOCTYPE html><html><head><title>pdf_preview</title>  <meta charset="utf-8">' +
      '<style>' + results[0] + results[1] + '</style>' +
      '<style>' + highlightCSS + '</style>' +
      // this requires internet
      '<link rel="stylesheet" href="' + path.resolve(__dirname, '../katex-style/katex.min.css') + '">' +
      '</head><body class="markdown-katex-preview">' + htmlContent + "</body></html>"
    callback(htmlContent)
  })
}

// print PDF file
// using webkit
function saveAsPDF() {
  getOfflineHTMLContent(function(htmlContent) {
    temp.open({prefix: 'atom-markdown-katex', suffix: '.html'}, function(err, info) {
      if (err) {
        alert('Failed to save as pdf')
      } else {
        fs.write(info.fd, htmlContent, function() {
          // set the src last.
          pdfIFrame.src = info.path
        })
      }
    })
  })
}

// copy HTML to clipboard
function copyAsHTML() {
  let editor = atom.workspace.getActiveTextEditor()
  let rootDirectoryPath = editor.rootDirectoryPath
  let textContent = editor.textContent
  let htmlContent = parseMD(textContent, rootDirectoryPath)

  let indexLess = fs.readFileSync(path.resolve(__dirname,  '../styles/atom-markdown-katex.less'), 'utf8')
  let customLess = fs.readFileSync(path.resolve(__dirname,  '../styles/custom.less'), 'utf8')
  let highlightCSS = fs.readFileSync(path.resolve(__dirname,  '../styles/highlight.css'), 'utf8')

  async.parallel([
    function(callback){
      less.render(indexLess, function(e, output) {
        callback(null, output.css)
      })
    },
    function(callback){
      less.render(customLess, function(e, output) {
        callback(null, output.css)
      })
    }
  ], function(err, results) {
    htmlContent = '<!DOCTYPE html><html><head><title>pdf_preview</title>  <meta charset="utf-8">' +
      '<style>' + results[0] + results[1] + '</style>' +
      '<style>' + highlightCSS + '</style>' +
      // this requires internet
      '<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.5.1/katex.min.css">' +
      '</head><body class="markdown-katex-preview">' + htmlContent + "</body></html>"

      atom.clipboard.write(htmlContent)

      alert("HTML content has bee saved to clipboard")  })
}

// open HTML in browser
function openInBrowser() {
  getOfflineHTMLContent(function(htmlContent) {
    temp.open({prefix: 'atom-markdown-katex', suffix: '.html'}, function(err, info) {
      if (err) {
        throw err
      } else {
        fs.write(info.fd, htmlContent, function(error) {
          if (error){ throw error;}
          // open in browser
          let cmd = process.platform === 'win32' ? 'explorer' :
                    process.platform === 'darwin' ? 'open' : 'xdg-open'
          exec(cmd + ' ' + info.path)
        })
      }
    })
  })
}

// customize markdown preview css
function customizeCSS() {
  atom.workspace.open(path.resolve(__dirname, "../styles/custom.less"))
}

function activateFn() {
  atom.commands.add(".markdown-katex-preview", "markdown-katex-preview:save-as-pdf", saveAsPDF)
  atom.commands.add(".markdown-katex-preview", "markdown-katex-preview:copy-as-html", copyAsHTML)
  atom.commands.add(".markdown-katex-preview", "markdown-katex-preview:open-in-browser", openInBrowser)

  atom.commands.add("atom-workspace", "markdown-katex-preview:customize-css", customizeCSS)
  return atom.commands.add("atom-workspace", "markdown-katex-preview:toggle", beginMarkdownKatexPreview)
}

module.exports = {
  activate: activateFn
}
