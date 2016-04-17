'use strict'

/**
 * atom-markdown-katex plugin for atom editor
 * By Yiyi Wang (shd101wyy)
 *
 */

let startMDPreview = require('./md-preview.js').startMDPreview,
    MarkdownPreviewEditor = require('./md-preview-editor')

// open new window to show rendered markdown html
function beginMarkdownKatexPreview() {
  // get current selected active editor
  let activeEditor = atom.workspace.getActiveTextEditor()
  startMDPreview(activeEditor)
}

// customize markdown preview css
function customizeCSS() {
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
  let editor = atom.workspace.getActiveTextEditor()

  if (editor && startMDPreview(editor)) {
    editor.insertText(`\n<!-- toc -->\n`)
  }
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
  atom.commands.add('atom-workspace', 'markdown-katex-preview:customize-css', customizeCSS)
  atom.commands.add('atom-workspace', 'markdown-katex-preview:toc-create', createTOC)
  atom.commands.add('atom-workspace', 'markdown-katex-preview:toggle', beginMarkdownKatexPreview)
  atom.commands.add('atom-workspace', 'markdown-katex-preview:toggle-scroll-sync', toggleScrollSync)

  // close all atom-markdown-katex: uri pane
  let paneItems = atom.workspace.getPaneItems()
  for (let i = 0; i < paneItems.length; i++) {
    let uri = paneItems[i].getURI()
    if (uri && uri.startsWith('atom-markdown-katex:/') && uri.endsWith(' preview')) {
      paneItems[i].destroy()
    }
  }

  // set opener
  atom.workspace.addOpener((uri)=> {
    if (uri.startsWith('atom-markdown-katex://') && uri.endsWith(' preview')) {
      return new MarkdownPreviewEditor(uri)
    }
  })

  atom.workspace.onDidOpen(function(event) {
    if (atom.config.get('atom-markdown-katex.openPreviewPaneAutomatically')) {
      if (event.uri && event.item && (event.uri.endsWith('.md') || event.uri.endsWith('.markdown'))) {
        let editor = event.item
        let previewUrl = 'atom-markdown-katex://' + editor.getPath() + ' preview'
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
