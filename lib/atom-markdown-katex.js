'use strict'

/**
 * atom-markdown-katex plugin for atom editor
 * By Yiyi Wang (shd101wyy)
 *
 */

let fs = require("fs"),
    temp = require('temp'),
    exec = require('child_process').exec,
    path = require('path'),
    less = require('less')

let parseMD = require('./md.js').parseMD,
    startMDPreview = require('./md-preview.js').startMDPreview

// console.log('0.4.1')

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

// open new window to show rendered markdown html
function beginMarkdownKatexPreview() {
  // get current selected active editor
  let activeEditor = atom.workspace.getActiveTextEditor()

  // already activated
  if (activeEditor.markdownHtmlView) {
    return
  } else {
    startMDPreview(activeEditor)
  }
}

// referred from markdown-preview-view.coffee in the official Markdown Preview
function getTextEditorStyles() {
  let textEditorStyles = document.createElement("atom-styles")
  textEditorStyles.initialize(atom.styles)
  textEditorStyles.setAttribute("context", "atom-text-editor")
  document.body.appendChild(textEditorStyles)

  // Extract style elements content
  let style = Array.prototype.slice.apply(textEditorStyles.childNodes).map((styleElement) => styleElement.innerText)

  // delete element
  textEditorStyles.parentNode.removeChild(textEditorStyles)

  return style
}

function getMarkdownPreviewCSS() {
  let markdownPreviewRules = [],
      ruleRegExp = /\.markdown-katex-preview/,
      cssUrlRefExp = /url\(atom:\/\/markdown-katex-preview\/assets\/(.*)\)/


  for (let i = 0; i < document.styleSheets.length; i++) {
    let stylesheet = document.styleSheets[i]
    if (stylesheet.rules.length) {
      for (let j = 0; j < stylesheet.rules.length; j++) {
        let rule = stylesheet.rules[j]

        // We only need `.markdown-katex-preview` css
        if (rule.cssText.match(ruleRegExp)) {
          markdownPreviewRules.push(rule.cssText)
        }
      }
    }
  }

  return markdownPreviewRules.concat(getTextEditorStyles())
}

// get offline html content
// pass in htmlContent to callback function
function getOfflineHTMLContent(callback) {
  let editor = atom.workspace.getActiveTextEditor(),
      rootDirectoryPath = editor.rootDirectoryPath,
      textContent = editor.textContent,
      useGitHubStyle = atom.config.get('atom-markdown-katex.useGitHubStyle'),
      htmlContent = parseMD(textContent, rootDirectoryPath)

  htmlContent = `
  <!DOCTYPE html>
  <html>
    <head>
      <title>${editor.getFileName()}</title>
      <meta charset="utf-8">
      <style> ${getMarkdownPreviewCSS().join('\n')} </style>
      <link rel="stylesheet"
            href="${path.resolve(__dirname, '../katex-style/katex.min.css')}">
    </head>
    <body class="markdown-katex-preview" data-use-github-style="${useGitHubStyle}">
    ${htmlContent}
    </body>
  </html>
  `
  callback(htmlContent)
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
  let editor = atom.workspace.getActiveTextEditor(),
      rootDirectoryPath = editor.rootDirectoryPath,
      textContent = editor.textContent,
      useGitHubStyle = atom.config.get('atom-markdown-katex.useGitHubStyle'),
      htmlContent = parseMD(textContent, rootDirectoryPath)

  htmlContent = `
  <!DOCTYPE html>
  <html>
    <head>
      <title>${editor.getFileName()}</title>
      <meta charset="utf-8">
      <style> ${getMarkdownPreviewCSS().join('\n')} </style>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.5.1/katex.min.css">
    </head>
    <body class="markdown-katex-preview" data-use-github-style="${useGitHubStyle}">
    ${htmlContent}
    </body>
  </html>
  `
  atom.clipboard.write(htmlContent)

  alert("HTML content has bee saved to clipboard")
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
  atom.commands.add("atom-workspace", "markdown-katex-preview:toggle", beginMarkdownKatexPreview)
}

module.exports = {
  activate: activateFn
}
