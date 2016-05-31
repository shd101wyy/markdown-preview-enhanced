'use strict'
/**
 * markdown-preview-enhanced plugin for atom editor
 * By Yiyi Wang (shd101wyy)
 *
 */

const startMDPreview = require('./md-preview.js').startMDPreview,
      globalMarkdownPreview = require('./md-preview.js').globalMarkdownPreview,
      MarkdownPreviewEditor = require('./md-preview-editor'),
      insertImageView = require('./insert-image-view')

// open new window to show rendered markdown html
function toggleMarkdownPreviewEnhanced() {
  // get current selected active editor
  let activeEditor = atom.workspace.getActiveTextEditor()

  if (globalMarkdownPreview.previewEditor) {
    globalMarkdownPreview.previewEditor.destroy()
  } else {
    startMDPreview(activeEditor)
  }
}

// customize markdown preview css
function customizeCSS() {
  atom.workspace
      .open("atom://.atom/stylesheet")
      .then(function(editor) {
        let customCssTemplate = `\n
/*
 * markdown-preview-enhanced custom style
 */
.markdown-preview-enhanced-custom {
  // please write your custom style here
  // eg:
  //  color: blue;          // change font color
  //  font-size: 14px;      // change font size
  //

  // custom pdf output style
  @media print {

  }
}

// please don't modify the .markdown-preview-enhanced section below
.markdown-preview-enhanced {
  .markdown-preview-enhanced-custom() !important;
}
        `
        let text = editor.getText()
        if (text.indexOf('.markdown-preview-enhanced-custom {') < 0 ||         text.indexOf('.markdown-preview-enhanced {') < 0) {
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

function addSpace(num) {
  let output = ''
  for (let i = 0; i < num; i++) {
    output += ' '
  }
  return output
}

function insertTable() {
  let editor = atom.workspace.getActiveTextEditor()
  if (editor && editor.getGrammar().scopeName === 'source.gfm') {
    let cursorPos = editor.getCursorBufferPosition()
    editor.insertText(`|  |  |
${addSpace(cursorPos.column)}|--|--|
${addSpace(cursorPos.column)}|  |  |
`)
    editor.setCursorBufferPosition([cursorPos.row, cursorPos.column + 2])
  } else {
    atom.notifications.addError('Insert Table targets only markdown file')
  }
}

function startImageHelper() {
  let editor = atom.workspace.getActiveTextEditor()
  if (editor && editor.getGrammar().scopeName === 'source.gfm') {
    insertImageView.display(editor)
  } else {
    atom.notifications.addError('Image Helper targets only markdown file')
  }
}

function toggleScrollSync() {
  let flag = atom.config.get('markdown-preview-enhanced.scrollSync')
  atom.config.set('markdown-preview-enhanced.scrollSync', !flag)

  if (!flag) {
    atom.notifications.addInfo('Scroll Sync enabled')
  } else {
    atom.notifications.addInfo('Scroll Sync disabled')
  }
}

function activateFn(state) {
  atom.commands.add('atom-workspace', 'markdown-preview-enhanced:customize-css', customizeCSS)
  atom.commands.add('atom-workspace', 'markdown-preview-enhanced:toc-create', createTOC)
  atom.commands.add('atom-workspace', 'markdown-preview-enhanced:toggle', toggleMarkdownPreviewEnhanced)
  atom.commands.add('atom-workspace', 'markdown-preview-enhanced:toggle-scroll-sync', toggleScrollSync)
  atom.commands.add('atom-workspace', 'markdown-preview-enhanced:insert-table', insertTable)
  atom.commands.add('atom-workspace', 'markdown-preview-enhanced:image-helper', startImageHelper)

  // set opener
  atom.workspace.addOpener((uri)=> {
    if (uri.startsWith('markdown-preview-enhanced://') && uri.endsWith(' preview')) {
      return new MarkdownPreviewEditor(uri)
    }
  })

  atom.workspace.onDidChangeActivePaneItem(function(editor) {
    if (editor &&
        editor.buffer && 
        editor.getGrammar &&
        editor.getGrammar().scopeName === 'source.gfm' &&
        globalMarkdownPreview &&
        globalMarkdownPreview.previewEditor) {

      if (globalMarkdownPreview.editor !== editor) {
        globalMarkdownPreview.bindEditor(editor)
      }
    }
  })

  atom.workspace.onDidOpen(function(event) {
    if (atom.config.get('markdown-preview-enhanced.openPreviewPaneAutomatically')) {
      if (event.uri && event.item && (event.uri.endsWith('.md') || event.uri.endsWith('.markdown'))) {
        let pane = event.pane
        let panes = atom.workspace.getPanes()

        // if the markdown file is opened on the right pane, then move it to the left pane. Issue #25
        if (pane !== panes[0]) {
          pane.moveItemToPane(event.item, panes[0], 0) // move md to left pane.
          panes[0].setActiveItem(event.item)
        }

        let editor = event.item
        startMDPreview(editor)
      }
    }
  })
}

module.exports = {
  activate: activateFn
}
