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
    uslug = require('uslug'),
    toc = require('markdown-toc'),
    parseMD = require('./md.js').parseMD,
    startMDPreview = require('./md-preview.js').startMDPreview,
    getMarkdownPreviewCSS = require('./style.js').getMarkdownPreviewCSS,
    MarkdownPreviewEditor = require('./md-preview-editor')

// console.log('0.4.7') #fff

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

// open html file in browser or open pdf file in reader ... etc
function openFile(filePath) {
  // open in browser
  let cmd = process.platform === 'win32' ? 'explorer' :
            process.platform === 'darwin' ? 'open' : 'xdg-open'
  exec(cmd + ' ' + filePath)
}

// get offline html content
// pass in htmlContent to callback function
function getOfflineHTMLContent(callback, isForPrint) {
  let editor = atom.workspace.getActivePaneItem(),
      markdownPreview = editor.markdownPreview
  if (!markdownPreview) return

  let textContent = markdownPreview.textContent,
      useGitHubStyle = atom.config.get('atom-markdown-katex.useGitHubStyle'),
      useGitHubSyntaxTheme = atom.config.get('atom-markdown-katex.useGitHubSyntaxTheme'),
      useKaTeX = atom.config.get('atom-markdown-katex.useKaTeX'),
      htmlContent = parseMD(markdownPreview)

  // as for example black color background doesn't produce nice pdf
  // therefore, I decide to print only github style...
  if (isForPrint) {
    useGitHubStyle = atom.config.get('atom-markdown-katex.pdfUseGithub')
  }

  let katexStyle = useKaTeX ? `<link rel="stylesheet"
        href="${path.resolve(__dirname, '../katex-style/katex.min.css')}">` : ''

  htmlContent = `
  <!DOCTYPE html>
  <html>
    <head>
      <title>${editor.getFileName()}</title>
      <meta charset="utf-8">
      <style> ${getMarkdownPreviewCSS()} </style>
      ${katexStyle}
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
function printPDF(htmlPath) {
  const BrowserWindow = require('remote').require('browser-window')
  var win = new BrowserWindow({show: false })
  win.on('closed', function() {
    win = null
  })

  win.loadUrl(htmlPath)
  // win.show()

  let editor = atom.workspace.getActivePaneItem(),
      markdownPreview = editor.markdownPreview

  if (!markdownPreview) return

  let rootDirectoryPath = markdownPreview.rootDirectoryPath,
      fileName = editor.getFileName(), //.split(' ')[0],
      pdfName = fileName + '.pdf'

  if (fileName.lastIndexOf('.') > 0) {
    pdfName = fileName.slice(0, fileName.lastIndexOf('.') + 1) + 'pdf'
  }

  // get margins type
  let marginsType = atom.config.get('atom-markdown-katex.marginsType')
  if (marginsType === 'default margin') {
    marginsType = 0
  } else if (marginsType === 'no margin') {
    marginsType = 1
  } else {
    marginsType = 2
  }

  // get orientation
  let landscape = (atom.config.get('atom-markdown-katex.orientation') === 'landscape')


  win.webContents.on('did-finish-load', function() {
   //console.log('finish loading');
   win.webContents.printToPDF({
     pageSize: atom.config.get('atom-markdown-katex.exportPDFPageFormat'),
     landscape: landscape,
     printBackground: atom.config.get('atom-markdown-katex.printBackground'),
     marginsType: marginsType  // 0 default; 1 none; 2 minimum
   }, function(err, data) {
       // atom.notifications.addInfo(`Start converting ${fileName}`)
       let dist = path.resolve(rootDirectoryPath, pdfName)
       if (err) throw err
       fs.writeFile(dist, data, function(err) {
         if(err) throw ('genearte pdf error' + err)
         else {
           atom.notifications.addInfo(`File ${pdfName} was created in the same directory`, {detail: 'path: ' + dist})

           // open pdf
           if (atom.config.get('atom-markdown-katex.pdfOpenAutomatically')) {
             openFile(dist)
           }
         }
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

// print HTML file
function saveAsHTML() {
  getOfflineHTMLContent(function(htmlContent) {
    let editor = atom.workspace.getActivePaneItem(),
        markdownPreview = editor.markdownPreview

    if (!markdownPreview) return

    let rootDirectoryPath = markdownPreview.rootDirectoryPath,
        fileName = editor.getFileName(), //.split(' ')[0],
        htmlFileName = fileName + '.html'

        if (fileName.lastIndexOf('.') > 0) {
          htmlFileName = fileName.slice(0, fileName.lastIndexOf('.') + 1) + 'html'
        }

        let dist = path.resolve(rootDirectoryPath, htmlFileName)
        fs.writeFile(dist, htmlContent, function(err) {
          if (err) throw err
          else {
            atom.notifications.addInfo(`File ${htmlFileName} was created in the same directory`, {detail: 'path: ' + dist})
          }
        })

  })
}

// copy HTML to clipboard
function copyAsHTML() {
  let editor = atom.workspace.getActivePaneItem(),
      markdownPreview = editor.markdownPreview

  if (!markdownPreview) return

  let rootDirectoryPath = markdownPreview.rootDirectoryPath,
      textContent = markdownPreview.textContent,
      useGitHubStyle = atom.config.get('atom-markdown-katex.useGitHubStyle'),
      useGitHubSyntaxTheme = atom.config.get('atom-markdown-katex.useGitHubSyntaxTheme'),
      useKaTeX = atom.config.get('atom-markdown-katex.useKaTeX'),
      htmlContent = parseMD(markdownPreview)

  let katexStyle = useKaTeX ? `<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.5.1/katex.min.css">` : ''

  htmlContent = `
  <!DOCTYPE html>
  <html>
    <head>
      <title>${editor.getFileName()}</title>
      <meta charset="utf-8">
      <style> ${getMarkdownPreviewCSS()} </style>
      ${katexStyle}
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
          openFile(info.path)
        })
      }
    })
  })
}

// customize markdown preview css
function customizeCSS() {
  // atom.workspace.open(path.resolve(__dirname, "../styles/custom.less"))
  atom.workspace
      .open("atom://.atom/stylesheet")
      .then(function(editor) {
        let customCssTemplate = `\n
/*
 * atom-markdown-katex custom style
 */
.markdown-katex-preview-custom {
  // please write your custom style here
  // eg:
  //  color: blue;          // change font color
  //  font-size: 14px;      // change font size
  //

  // custom pdf output style
  @media print {

  }
}

// please don't modify the .markdown-katex-preview section below
.markdown-katex-preview {
  .markdown-katex-preview-custom() !important;
}
        `
        let text = editor.getText()
        if (text.indexOf('.markdown-katex-preview-custom {') < 0 ||         text.indexOf('.markdown-katex-preview {') < 0) {
          editor.setText(text + customCssTemplate)
        }
      })
}

function createTOC() {
  let editor = atom.workspace.getActiveTextEditor(),
      content = editor.getText(),
      tocObject = toc(content, {slugify: uslug})

  editor.insertText(`
<!-- toc -->

${tocObject.content}

<!-- tocstop -->
    `)
}

function toggleScrollSync() {
  let flag = atom.config.get('atom-markdown-katex.scrollSync')
  atom.config.set('atom-markdown-katex.scrollSync', !flag)

  if (!flag) {
    atom.notifications.addInfo('Scroll Sync enabled')
  } else {
    atom.notifications.addInfo('Scroll Sync disabled')
  }
}

function activateFn(state) {
  // console.log('active atom-markdown-katex')
  atom.commands.add('.markdown-katex-preview-editor', 'markdown-katex-preview:save-as-pdf', saveAsPDF)
  atom.commands.add('.markdown-katex-preview-editor', 'markdown-katex-preview:save-as-html', saveAsHTML)
  atom.commands.add('.markdown-katex-preview-editor', 'markdown-katex-preview:copy-as-html', copyAsHTML)
  atom.commands.add('.markdown-katex-preview-editor', 'markdown-katex-preview:open-in-browser', openInBrowser)

  atom.commands.add('atom-workspace', 'markdown-katex-preview:customize-css', customizeCSS)
  atom.commands.add('atom-workspace', 'markdown-katex-preview:toc-create', createTOC)
  atom.commands.add('atom-workspace', 'markdown-katex-preview:toggle', beginMarkdownKatexPreview)
  atom.commands.add('atom-workspace', 'markdown-katex-preview:toggle-scroll-sync', toggleScrollSync)

  // close all atom-markdown-katex: uri pane
  let paneItems = atom.workspace.getPaneItems()
  for (let i = 0; i < paneItems.length; i++) {
    if (paneItems[i].getURI().startsWith('atom-markdown-katex:/')) {
      paneItems[i].destroy()
    }
  }

  // set opener
  atom.workspace.addOpener((uri)=> {
    if (uri.startsWith('atom-markdown-katex://') && uri.endsWith(' preview')) {
      console.log('enter here')
      return new MarkdownPreviewEditor(uri)
    }
  })

  atom.workspace.onDidOpen(function(event) {
    if (atom.config.get('atom-markdown-katex.openPreviewPaneAutomatically')) {
      if (event.uri && event.item && (event.uri.endsWith('.md') || event.uri.endsWith('.markdown'))) {
        let editor = event.item
        let previewUrl = 'atom-markdown-katex://' + editor.getFileName() + ' preview'
        let previewPane = atom.workspace.paneForURI(previewUrl)
        if (!previewPane) {
          startMDPreview(editor)
        }
      }
    }
  })

}

module.exports = {
  activate: activateFn
}
