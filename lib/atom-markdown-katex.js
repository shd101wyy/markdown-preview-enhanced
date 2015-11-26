/**
 * atom-markdown-katex plugin for atom editor
 * By Yiyi Wang (shd101wyy)
 *
 */
var katex = require("katex") // for katex
var marked = require("marked") // for markdown
var highlightjs = require("highlight.js") // for highlight
var fs = require("fs")
var cheerio = require("cheerio")
var temp = require('temp')
var exec = require('child_process').exec
var path = require('path')
console.log('0.4.0')

/*
 * This pdfIFrame is added to document.body once.
 * it is used to render parsed html content from markdown and then print to pdf.
 */
var pdfIFrame = document.createElement('iframe')
pdfIFrame.style.display = 'none';
pdfIFrame.id = 'atom-markdown-katex-pdf'
pdfIFrame.src = 'about:blank'
pdfIFrame.onload = function (){ // show print option when iframe finishes loading
  if (pdfIFrame.src === 'about:blank') return
  pdfIFrame.contentWindow.print()
}
document.body.appendChild(pdfIFrame)

// make marked support code highlight
// Synchronous highlighting with highlight.js
marked.setOptions({
  highlight: function(code) {
    return highlightjs.highlightAuto(code).value
  }
})

// Automatically track and cleanup files at exit
temp.track();

// replace string within $...$ or $$...$$ with rendered string
function parseKatex(inputString, mathExpressions) {
  outputString = ""
  mathExpCount = 0
  // return end
  function findEnd(start, tag) {
    var end = -1
    var j
    for (var i = start; i < inputString.length; i++) {
      if (inputString[i] === "\\") {
        i += 1
        continue;
      }
      var match = true
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

  for (var i = 0; i < inputString.length; i++) {
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
    } else if (inputString[i] === '$' || (i + 1 < inputString.length && inputString[i] === '$' && inputString[i + 1] === '$')) {
      var tag = (i + 1 < inputString.length && inputString[i] === '$' && inputString[i + 1] === '$') ? '$$' : '$'
      var start = i + tag.length
      var end = findEnd(start, tag)
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
  $ = cheerio.load(html)
  $('img').each(function(i, imgElement) {
    var img = $(imgElement)
    var src = img.attr('src')
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
  for (var i = 0; i < mathExpressions.length; i++) {
    html = html.replace('$me' + i + '$', mathExpressions[i])
  }
  return html
}

// parse markdown content to html
function parseMD(inputString, directoryPath) {
  // replace math expression
  var mathExpressions = []
  var replaced = parseKatex(inputString, mathExpressions)
  // convert to html
  var html = marked(replaced)
  // replace math expression back
  html = replaceMathExpression(html, mathExpressions)
  if (directoryPath)
    return resolveImagePaths(html, directoryPath)
  else
    return html
}


// open new window to show rendered markdown html
function beginMarkdownKatexPreview() {
  // get current selected active editor
  var activeEditor = atom.workspace.getActiveTextEditor()
  var filePath = activeEditor.buffer.file.path
  var rootDirectoryPath = path.resolve(path.dirname(filePath))

  // already activated
  if (activeEditor.markdownHtmlView) {
    return;
  }
  activeEditor.markdownHtmlView = null

  var uri = "atom-markdown-katex://markdown-katex-preview" //+ editor.id + ".html";

  atom.workspace.onDidChangeActivePaneItem(function(editor) {
    if (editor && editor === activeEditor.htmlPreviewEditor) {
      if (activeEditor.markdownHtmlView) {
        activeEditor.markdownHtmlView.style.display = "inline"
        activeEditor.htmlPreviewEditor.textContent = activeEditor.getText()
        activeEditor.markdownHtmlView.innerHTML = parseMD(activeEditor.getText(), rootDirectoryPath )
      }
    }
  });

  // open new pane to show html
  atom.workspace.open(uri, {
      split: "right",
      activatePane: false,
      searchAllPanes: true
    })
    .done(function(editor) {
      if (activeEditor.markdownHtmlView === null) {
        var htmlPreviewEditor = editor
        htmlPreviewEditor.rootDirectoryPath = rootDirectoryPath

        // htmlPreviewEditor.setText("Test");
        var textEditorElement = atom.views.getView(htmlPreviewEditor)
        var parentElement = textEditorElement.parentElement

        var markdownHtmlView = document.createElement("div")
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

        // add css
        var indexCSS = document.createElement("link")
        indexCSS.rel = "stylesheet"
        indexCSS.type = "text/css"
        indexCSS.href = __dirname + "/index.css"
        document.getElementsByTagName("head")[0].appendChild(indexCSS)

        // add katex css
        var katex_css = document.createElement("link")
        katex_css.rel = "stylesheet"
        katex_css.type = "text/css"
        katex_css.href = __dirname + "/katex/katex.min.css"
        document.getElementsByTagName("head")[0].appendChild(katex_css)

        // add hightlight css
        var highlightCSS = document.createElement("link")
        highlightCSS.rel = "stylesheet"
        highlightCSS.type = "text/css"
        highlightCSS.href = __dirname + "/highlight.js/default.css"
        document.getElementsByTagName("head")[0].appendChild(highlightCSS)

        htmlPreviewEditor.onDidDestroy(function() {
          activeEditor.markdownHtmlView = null
          htmlPreviewEditor = null
        })

        // change markdown content
        activeEditor.onDidStopChanging(function() {
          if (activeEditor.markdownHtmlView) {
            activeEditor.htmlPreviewEditor.textContent = activeEditor.getText()
            activeEditor.markdownHtmlView.innerHTML = parseMD(activeEditor.getText(), rootDirectoryPath )
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
function getOfflineHTMLContent() {
  var editor = atom.workspace.getActiveTextEditor()
  var rootDirectoryPath = editor.rootDirectoryPath
  var textContent = editor.textContent
  var htmlContent = parseMD(textContent, rootDirectoryPath)

  var indexCSS = fs.readFileSync(__dirname + "/index.css", 'utf8')
  var highlightCSS = fs.readFileSync(__dirname + "/highlight.js/default.css", 'utf8')

  htmlContent = '<!DOCTYPE html><html><head><title>pdf_preview</title>  <meta charset="utf-8">' +
    '<style>' + indexCSS + '</style>' +
    '<style>' + highlightCSS + '</style>' +
    // this requires internet
    '<link rel="stylesheet" href="' + __dirname + '/katex/katex.min.css">' +
    '</head><body class="markdown-katex-preview">' + htmlContent + "</body></html>"
  return htmlContent
}

// print PDF file
// using webkit
function saveAsPDF() {
  var htmlContent = getOfflineHTMLContent(htmlContent)

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
}

// copy HTML to clipboard
function copyAsHTML() {
  var editor = atom.workspace.getActiveTextEditor()
  var rootDirectoryPath = editor.rootDirectoryPath
  var textContent = editor.textContent
  var htmlContent = parseMD(textContent, rootDirectoryPath)

  var indexCSS = fs.readFileSync(__dirname + "/index.css", 'utf8')
  var highlightCSS = fs.readFileSync(__dirname + "/highlight.js/default.css", 'utf8')

  htmlContent = '<!DOCTYPE html><html><head><title>pdf_preview</title>  <meta charset="utf-8">' +
    '<style>' + indexCSS + '</style>' +
    '<style>' + highlightCSS + '</style>' +
    // this requires internet
    '<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.3.0/katex.min.css">' +
    '</head><body class="markdown-katex-preview">' + htmlContent + "</body></html>"

  atom.clipboard.write(htmlContent)

  alert("HTML content has bee saved to clipboard")
}

// open HTML in browser
function openInBrowser() {
  var htmlContent = getOfflineHTMLContent()

  temp.open({prefix: 'atom-markdown-katex', suffix: '.html'}, function(err, info) {
    if (err) {
      throw err
    } else {
      fs.write(info.fd, htmlContent, function(error) {
        if (error){ throw error;}
        // open in browser
        var cmd = process.platform === 'win32' ? 'explorer' :
                  process.platform === 'darwin' ? 'open' : 'xdg-open'
        exec(cmd + ' ' + info.path)
      })
    }
  })
}

// customize markdown preview css
function customizeCSS() {
  atom.workspace.open(__dirname + "/index.css")
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
