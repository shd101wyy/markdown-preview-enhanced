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
    startMDPreview = require('./md-preview.js').startMDPreview,
    getMarkdownPreviewCSS = require('./style.js').getMarkdownPreviewCSS

// console.log('0.4.7')

// Automatically track and cleanup files at exit
temp.track();

// open new window to show rendered markdown html
function beginMarkdownKatexPreview() {
  // get current selected active editor
  let activeEditor = atom.workspace.getActiveTextEditor()

  // already activated
  if (!activeEditor || activeEditor.markdownHtmlView) {
    return
  } else {
    startMDPreview(activeEditor)
  }
}

// get offline html content
// pass in htmlContent to callback function
function getOfflineHTMLContent(callback, isForPrint) {
  let editor = atom.workspace.getActiveTextEditor(),
      rootDirectoryPath = editor.rootDirectoryPath,
      textContent = editor.textContent,
      useGitHubStyle = atom.config.get('atom-markdown-katex.useGitHubStyle'),
      useGitHubSyntaxTheme = atom.config.get('atom-markdown-katex.useGitHubSyntaxTheme'),
      htmlContent = parseMD(textContent, rootDirectoryPath)

  // as for example black color background doesn't produce nice pdf
  // therefore, I decide to print only github style...
  if (isForPrint) {
    useGitHubStyle = true
  }

  htmlContent = `
  <!DOCTYPE html>
  <html>
    <head>
      <title>${editor.getFileName()}</title>
      <meta charset="utf-8">
      <style> ${getMarkdownPreviewCSS()} </style>
      <link rel="stylesheet"
            href="${path.resolve(__dirname, '../katex-style/katex.min.css')}">
    </head>
    <body class="markdown-katex-preview" data-use-github-style="${useGitHubStyle}" data-use-github-syntax-theme="${useGitHubSyntaxTheme}" style="font-size: 16px;">
    ${htmlContent}
    </body>
  </html>
  `
  callback(htmlContent)
}

// api doc [printToPDF] function
// https://github.com/atom/electron/blob/master/docs/api/web-contents.md
function printPDF(htmlPath, savePath) {
  const BrowserWindow = require('remote').require('browser-window')
  var win = new BrowserWindow({show: false })
  win.on('closed', function() {
    win = null
  })

  win.loadUrl(htmlPath)
  // win.show()

  win.webContents.on('did-finish-load', function() {
   //console.log('finish loading');
   win.webContents.printToPDF({
     landscape: false, // true,
     printBackground: true,
     marginsType: 0  // 0 default; 1 none; 2 minimum
   }, function(err, data) {
       var dist = '/Users/wangyiyi/Desktop/test3.pdf'
       if (err) throw err
       fs.writeFile(dist, data, function(err) {
         if(err) throw ('genearte pdf error' + err)
       })
     })
   })
}

// print PDF file
// using webkit
function saveAsPDF() {
  getOfflineHTMLContent(function(htmlContent) {
    temp.open({prefix: 'atom-markdown-katex', suffix: '.html'}, function(err, info) {
      if (err) {
        throw err
      } else {
        fs.write(info.fd, htmlContent, function(error) {
          if (error){ throw error;}
          // print pdf
          printPDF(`file://${info.path}`)
        })
      }
    })
  }, true)
}

// copy HTML to clipboard
function copyAsHTML() {
  let editor = atom.workspace.getActiveTextEditor(),
      rootDirectoryPath = editor.rootDirectoryPath,
      textContent = editor.textContent,
      useGitHubStyle = atom.config.get('atom-markdown-katex.useGitHubStyle'),
      useGitHubSyntaxTheme = atom.config.get('atom-markdown-katex.useGitHubSyntaxTheme'),
      htmlContent = parseMD(textContent, rootDirectoryPath)

  htmlContent = `
  <!DOCTYPE html>
  <html>
    <head>
      <title>${editor.getFileName()}</title>
      <meta charset="utf-8">
      <style> ${getMarkdownPreviewCSS()} </style>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.5.1/katex.min.css">
    </head>
    <body class="markdown-katex-preview" data-use-github-style="${useGitHubStyle}" data-use-github-syntax-theme="${useGitHubSyntaxTheme}" style="font-size: 16px;">
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
