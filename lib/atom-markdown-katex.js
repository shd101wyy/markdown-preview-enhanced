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
var opener = require('opener')

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
function parseKatex(inputString, err_obj) {
  outputString = ""
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
      } else {
        outputString += inputString[i];
        if (i + 1 < inputString.length) {
          i += 1;
          outputString += inputString[i]
        }
      }
    } else if (inputString[i] === "$" || (i + 1 < inputString.length && inputString[i] === "$" && inputString[i + 1] === "$")) {
      var tag = ((i + 1 < inputString.length && inputString[i] === "$" && inputString[i + 1] === "$") ? "$$" : "$")
      var start = i + tag.length
      var end = findEnd(start, tag)
      if (end !== -1) {
        try {
          outputString += katex.renderToString(inputString.slice(start, end), {
            displayMode: (tag === "$" ? false : true)
          });
        } catch (e) {
          err_obj[0] = inputString.slice(start, end)
          return (void 0);
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
      img.attr('src', directoryPath + '//' + src)
    }
  })
  return $.html()
}

// parse markdown content to html
function parseMD(inputString, directoryPath) {
  // replace math expression
  var err_obj = []
  var replaced = parseKatex(inputString, err_obj)
  if (replaced === void 0)
    return "<strong>Failed to parse: </strong><br>" + err_obj[0]
  // convert to html
  var html = marked(replaced)
  if (directoryPath)
    return resolveImagePaths(html, directoryPath)
  else
    return html
}


// open new window to show rendered markdown html
function beginMarkdownKatexPreview() {
  // get current selected active editor
  var active_editor = atom.workspace.getActiveTextEditor()
  var filePath = active_editor.buffer.file.path
  var rootDirectoryPath = atom.project.relativizePath(filePath)

  // already activated
  if (active_editor.markdown_html_view) {
    return;
  }
  active_editor.markdown_html_view = null

  var uri = "atom-markdown-katex://markdown-katex-preview" //+ editor.id + ".html";

  atom.workspace.onDidChangeActivePaneItem(function(editor) {
    if (editor && editor === active_editor.html_preview_editor) {
      if (active_editor.markdown_html_view) {
        active_editor.markdown_html_view.style.display = "inline"
        active_editor.html_preview_editor.textContent = active_editor.getText()
        active_editor.markdown_html_view.innerHTML = parseMD(active_editor.getText(), rootDirectoryPath[0])
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
      if (active_editor.markdown_html_view === null) {
        var html_preview_editor = editor
        html_preview_editor.rootDirectoryPath = rootDirectoryPath

        // html_preview_editor.setText("Test");
        var textEditorElement = atom.views.getView(html_preview_editor)
        var parent_element = textEditorElement.parentElement

        var markdown_html_view = document.createElement("div")
        markdown_html_view.style.width = "100%"
        markdown_html_view.style.height = "100%"
        markdown_html_view.style.margin = "0"
        markdown_html_view.style.zIndex = "999"
        markdown_html_view.style.overflow = "scroll"

        markdown_html_view.className = "markdown-katex-preview"

        markdown_html_view.style.backgroundColor = "white"

        // add html view to editor
        parent_element.insertBefore(markdown_html_view, textEditorElement)
        parent_element.removeChild(textEditorElement)

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

        html_preview_editor.onDidDestroy(function() {
          active_editor.markdown_html_view = null
          html_preview_editor = null
        })

        // change markdown content
        active_editor.onDidChange(function() {
          if (active_editor.markdown_html_view) {
            active_editor.html_preview_editor.textContent = active_editor.getText()
            active_editor.markdown_html_view.innerHTML = parseMD(active_editor.getText(), rootDirectoryPath[0])
          }
        })

        active_editor.markdown_html_view = markdown_html_view
        active_editor.html_preview_editor = html_preview_editor
        active_editor.html_preview_editor.textContent = active_editor.getText()
      }

      // set content
      active_editor.markdown_html_view.innerHTML = parseMD(active_editor.getText(), rootDirectoryPath[0])
    });
}

// get offline html content
function getOfflineHTMLContent() {
  var editor = atom.workspace.getActiveTextEditor()
  var rootDirectoryPath = editor.rootDirectoryPath
  var textContent = editor.textContent
  var htmlContent = parseMD(textContent)

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
        pdfIFrame.src = info.path;
      })
    }
  })
}

// copy HTML to clipboard
function copyAsHTML() {
  var editor = atom.workspace.getActiveTextEditor()
  var rootDirectoryPath = editor.rootDirectoryPath
  var textContent = editor.textContent
  var htmlContent = parseMD(textContent)

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
      alert('Failed to open in browser')
    } else {
      fs.write(info.fd, htmlContent, function() {
        opener(info.path) // open in browser
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
