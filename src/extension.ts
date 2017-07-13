/// <reference types="atom-typings" />

import * as path from "path"
import {CompositeDisposable} from "atom"

import * as mume from "@shd101wyy/mume"
const utility = mume.utility

import {MarkdownPreviewEnhancedConfig} from "./config"
import {MarkdownPreviewEnhancedView} from "./content-provider"

let subscriptions:CompositeDisposable = null
let config:MarkdownPreviewEnhancedConfig = null

/**
 * Key is editor.getPath()
 * Value is MarkdownPreviewEnhancedView object
 */
let previewsMap:{[key:string]:MarkdownPreviewEnhancedView} = {}

/**
 * Check if the `filePath` is a markdown file. 
 * @param filePath 
 */
function isMarkdownFile(filePath:string=''):boolean {
  if (filePath.startsWith('mpe://')) return false // this is preview

  const ext = path.extname(filePath)
  for (let i = 0; i < config.fileExtension.length; i++) {
    if (config.fileExtension[i] === ext) {
      return true 
    }
  }
  return false
}
/**
 * This function will be called when `config` is changed.  
 * @param config 
 */
function onDidChangeConfig():void {
  for (let sourceUri in previewsMap) {
    const preview = previewsMap[sourceUri]
    preview.updateConfiguration()
    preview.loadPreview()
  }
}

/**
 * As the function name pointed...
 */
function getSinglePreview() {
  return previewsMap[Object.keys(previewsMap)[0]]
}

/**
 * Return the preview object for editor(editorFilePath).
 * @param editor 
 */
function getPreviewForEditor(editor) {
  if (config.singlePreview) {
    return getSinglePreview()
  } else if (typeof(editor) === 'string') {
    return previewsMap[editor]
  } else if (editor instanceof MarkdownPreviewEnhancedView) {
    return editor
  } else if (editor && editor.getPath) {
    return previewsMap[editor.getPath()]
  } else {
    return null
  }
}

/**
 * Toggle markdown preview
 */
function togglePreview() {
  const editor = atom.workspace.getActivePaneItem()
  const preview = getPreviewForEditor(editor)

  if (preview && preview['getEditor'] && preview['getEditor']()) { // preview is already on, so remove it.
    const pane = atom.workspace.paneForItem(preview)
    pane.destroyItem(preview) // this will trigger preview.destroy()
    removePreviewFromMap(preview)
  } else {
    startPreview(editor)
  }
} 

/**
 * Remove preview from `previewsMap`
 * @param preview 
 */
function removePreviewFromMap(preview:MarkdownPreviewEnhancedView) {
  for (let key in previewsMap) {
    if (previewsMap[key] === preview)
      delete previewsMap[key]
  }
}

/**
 * Start preview for editor
 * @param editor 
 */
function startPreview(editor) {
  if (!(isMarkdownFile(editor.getPath()))) 
    return 

  let preview = getPreviewForEditor(editor)

  if (!preview) {
    if (config.singlePreview) {
      preview = new MarkdownPreviewEnhancedView('mpe://single_preview', config)
      previewsMap['single_preview'] = preview
    } else {
      preview = new MarkdownPreviewEnhancedView('mpe://' + editor.getPath(), config)
      previewsMap[editor.getPath()] = preview
    }
    preview.onPreviewDidDestroy(removePreviewFromMap)
  }

  if (preview.getEditor() !== editor) {
    preview.bindEditor(editor)
  }
}

/**
 * Receive message from MarkdownPreviewEnhancedView iframe
 */
function initMessageReceiver() {
  window.addEventListener('message', (event)=> {
    // console.log('receive message: ')
    // console.log(event)
    if (event.origin !== 'file://') return 
    const data = event.data
    if (typeof(data) !== 'object' || !('command' in data)) return
    const command = data['command'],
          args = data['args']

    if (command in MESSAGE_DISPATCH_EVENTS) {
      MESSAGE_DISPATCH_EVENTS[command].apply(null, args)
    }
  }, false)
}

/**
 * Messages Events
 */
const MESSAGE_DISPATCH_EVENTS = {
  'webviewFinishLoading': function(sourceUri) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) preview.renderMarkdown()
  },
  'refreshPreview': function(sourceUri) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) preview.refreshPreview()
  },
  'revealLine': function(sourceUri, line) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) {
      preview.scrollToBufferPosition(line)
    }
  },
  'insertImageUrl': function(sourceUri, imageUrl) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) {
      const editor = preview.getEditor()
      if (editor) {
        editor.insertText(`![enter image description here](${imageUrl})`)
      }
    }
  },
  'pasteImageFile': function(sourceUri, imageUrl) {
    // TODO:
    console.log('pasteImageFile: ' + imageUrl) 
  },
  'uploadImageFile': function(sourceUri, imageUrl) {
    // TODO:
    console.log('uploadImageFile: ' + imageUrl)
  },
  'openInBrowser': function(sourceUri) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) preview.openInBrowser()
  },
  'htmlExport': function(sourceUri, offline) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) preview.htmlExport(offline)
  },
  'phantomjsExport': function(sourceUri, fileType) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) preview.phantomjsExport(fileType)
  },
  'princeExport': function(sourceUri) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) preview.princeExport()
  },
  'eBookExport': function(sourceUri, fileType) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) preview.eBookExport(fileType)
  },
  'pandocExport': function(sourceUri) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) preview.pandocExport()
  },
  'markdownExport': function(sourceUri) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) preview.markdownExport()
  },
  'cacheCodeChunkResult': function(sourceUri, id, result) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) preview.cacheCodeChunkResult(id, result)
  },
  'runCodeChunk': function(sourceUri, codeChunkId) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) preview.runCodeChunk(codeChunkId)
  },
  'runCodeChunks': function(sourceUri) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) preview.runAllCodeChunks()
  },
  'clickTagA': function(sourceUri, href) {
    href = decodeURIComponent(href)
		if (['.pdf', '.xls', '.xlsx', '.doc', '.ppt', '.docx', '.pptx'].indexOf(path.extname(href)) >= 0) {
			utility.openFile(href)
		} else if (href.match(/^file\:\/\//)) {
			// openFilePath = href.slice(8) # remove protocal
			let openFilePath = utility.addFileProtocol(href.replace(/(\s*)[\#\?](.+)$/, '')) // remove #anchor and ?params...
      openFilePath = decodeURI(openFilePath)
      atom.workspace.open(utility.removeFileProtocol(openFilePath))
		} else {
			utility.openFile(href)
		}
  },
  'clickTaskListCheckbox': function(sourceUri, dataLine) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) {
      const editor = preview.getEditor()
      if (!editor) return 
      const buffer = editor.buffer
      if (!buffer) return 
      let line = buffer.lines[dataLine]
      if (line.match(/\[ \]/)) {
        line = line.replace('[ ]', '[x]')	
      } else {
        line = line.replace(/\[[xX]\]/, '[ ]')
      }
      buffer.setTextInRange([[dataLine, 0], [dataLine+1, 0]], line + '\n')
    }
  },
  'setZoomLevel': function(sourceUri, zoomLevel) {
    const preview = getPreviewForEditor(sourceUri)
    if (preview) {
      preview.setZoomLevel(zoomLevel)
    }
  }
}

export function activate(state) {
mume.init() // init mume package
.then(()=> {
  subscriptions = new CompositeDisposable()

  // Init config
  config = new MarkdownPreviewEnhancedConfig()
  config.onDidChange(subscriptions, onDidChangeConfig)
  mume.onDidChangeConfigFile(onDidChangeConfig)

  // Set opener
  subscriptions.add(atom.workspace.addOpener((uri)=> {
    if (uri.startsWith('mpe://')) {
      if (config.singlePreview) {
        return getSinglePreview()
      } else {
        return previewsMap[uri.replace('mpe://', '')]
      }
    }
  }))

  // Register commands
  subscriptions.add(
    atom.commands.add('atom-workspace', {
      'markdown-preview-enhanced:toggle': togglePreview,
      'markdown-preview-enhanced:customize-css': customizeCSS,
      'markdown-preview-enhanced:create-toc': createTOC,
      'markdown-preview-enhanced:toggle-scroll-sync': toggleScrollSync,
      'markdown-preview-enhanced:toggle-live-update': toggleLiveUpdate,
      'markdown-preview-enhanced:toggle-break-on-single-newline': toggleBreakOnSingleNewLine,
      'markdown-preview-enhanced:insert-table': insertTable,
      'markdown-preview-enhanced:image-helper': startImageHelper,
      'markdown-preview-enhanced:open-mermaid-config': openMermaidConfig,
      'markdown-preview-enhanced:open-phantomjs-config': openPhantomJSConfig,
      'markdown-preview-enhanced:open-mathjax-config': openMathJaxConfig,
      'markdown-preview-enhanced:extend-parser': extendParser,
      'markdown-preview-enhanced:insert-new-slide': insertNewSlide,
      'markdown-preview-enhanced:insert-page-break': insertPageBreak,
      'markdown-preview-enhanced:toggle-zen-mode': toggleZenMode,
      'markdown-preview-enhanced:run-code-chunk': runCodeChunkCommand,
      'markdown-preview-enhanced:run-all-code-chunks': runAllCodeChunks,
      'markdown-preview-enhanced:show-uploaded-images': showUploadedImages,
      'markdown-preview-enhanced:open-welcome-page': ()=> atom.workspace.open(path.resolve(__dirname, '../../docs/welcome.md'))    
    })
  )

    // When the preview is displayed
    // preview will display the content of editor (pane item) that is activated
    subscriptions.add(atom.workspace.onDidChangeActivePaneItem((editor)=> {
      if (editor &&
          editor['buffer'] &&
          editor['getGrammar'] &&
          editor['getGrammar']().scopeName == 'source.gfm') {
        const preview = getPreviewForEditor(editor)
        if (!preview || !preview.getEditor()) return

        if (config.singlePreview && preview.getEditor() !== editor) {
          preview.bindEditor(editor as AtomCore.TextEditor)
        }

        if (config.automaticallyShowPreviewOfMarkdownBeingEdited) {
          const pane = atom.workspace.paneForItem(preview)
          if (pane && pane !== atom.workspace.getActivePane()) {
            // I think typings here is wrong
            // https://atom.io/docs/api/v1.18.0/Pane#instance-activateItem
            const p = "activate" + "Item"
            pane[p](preview)
          }
        }
      }
    }))


    // automatically open preview when activate a markdown file
    // if 'openPreviewPaneAutomatically' option is enable
    subscriptions.add(atom.workspace.onDidOpen((event)=> {
      if (config.openPreviewPaneAutomatically) {
        if (event.uri &&
            event.item &&
            isMarkdownFile(event.uri) &&
            !event.uri.startsWith('mpe://')) {
          const pane = event.pane
          const panes = atom.workspace.getPanes()

          // if the markdown file is opened on the right pane, then move it to the left pane. Issue #25
          if (pane != panes[0]) {
            pane.moveItemToPane(event.item, panes[0], 0) // move md to left pane.
            panes[0]['setActiveItem'](event.item)
          }

          const editor = event.item
          startPreview(editor)
        }
      }

      // check zen mode
      if (event.uri && event.item && isMarkdownFile(event.uri)) {
        const editor = event.item
        const editorElement = editor['getElement']()
        if (editor && editor['buffer'])
          if (atom.config.get('markdown-preview-enhanced.enableZenMode'))
            editorElement.setAttribute('data-markdown-zen', '')
          else
            editorElement.removeAttribute('data-markdown-zen')
      }
    }))

    // zen mode observation
    subscriptions.add(atom.config.observe('markdown-preview-enhanced.enableZenMode', (enableZenMode)=> {
      const paneItems = atom.workspace.getPaneItems()
      for (let i = 0; i < paneItems.length; i++) {
        const editor = paneItems[i]
        if (editor && editor['getPath'] && isMarkdownFile(editor['getPath']())) {
          if (editor['buffer']) {
            const editorElement = editor['getElement']()
            if (enableZenMode)
              editorElement.setAttribute('data-markdown-zen', '')
            else
              editorElement.removeAttribute('data-markdown-zen')
          }
        }
      }

      if (enableZenMode)
        document.getElementsByTagName('atom-workspace')[0].setAttribute('data-markdown-zen', '')
      else
        document.getElementsByTagName('atom-workspace')[0].removeAttribute('data-markdown-zen')
    }))

    // use single preview
    subscriptions.add(atom.config.onDidChange('markdown-preview-enhanced.singlePreview', (singlePreview)=> {
      for (let sourceUri in previewsMap) {
        const preview = previewsMap[sourceUri]
        const pane = atom.workspace.paneForItem(preview)
        pane.destroyItem(preview) // this will trigger preview.destroy()
      }
      previewsMap = {}
    }))

  // Register message event
  initMessageReceiver()
})
}

/**
 * Open ~/.mume/style.less
 */
function customizeCSS() {
  const globalStyleLessFile = path.resolve(utility.extensionConfigDirectoryPath, './style.less')
  atom.workspace.open(globalStyleLessFile)
}

function createTOC() {
  const editor = atom.workspace.getActiveTextEditor()
  if (editor && editor.buffer)
    editor.insertText('\n<!-- @import "[TOC]" {cmd:"toc", depthFrom:1, depthTo:6, orderedList:false} -->\n')
}

function toggleScrollSync() {
  const flag = atom.config.get('markdown-preview-enhanced.scrollSync')
  atom.config.set('markdown-preview-enhanced.scrollSync', !flag)

  if (!flag)
    atom.notifications.addInfo('Scroll Sync enabled')
  else
    atom.notifications.addInfo('Scroll Sync disabled')
}

function toggleLiveUpdate() {
  const flag = atom.config.get('markdown-preview-enhanced.liveUpdate')
  atom.config.set('markdown-preview-enhanced.liveUpdate', !flag)

  if (!flag)
    atom.notifications.addInfo('Live Update enabled')
  else
    atom.notifications.addInfo('Live Update disabled')
}

function toggleBreakOnSingleNewLine() {
  const flag = atom.config.get('markdown-preview-enhanced.breakOnSingleNewLine')
  atom.config.set('markdown-preview-enhanced.breakOnSingleNewLine', !flag)

  if (!flag)
    atom.notifications.addInfo('Enabled breaking on single newline')
  else
    atom.notifications.addInfo('Disabled breaking on single newline') 
}

function insertTable() {
  const editor = atom.workspace.getActiveTextEditor()
  if (editor && editor.buffer)
    editor.insertText(`|   |   |
|---|---|
|   |   |
`)
}

function startImageHelper() {
  const editor = atom.workspace.getActiveTextEditor()
  const preview = getPreviewForEditor(editor)
  if (!preview) {
    atom.notifications.addError('Please open preview first.')
  } else {
    preview.startImageHelper()
  }
}

function openMermaidConfig() {
	const mermaidConfigFilePath = path.resolve(utility.extensionConfigDirectoryPath, './mermaid_config.js')
  atom.workspace.open(mermaidConfigFilePath)
}

function openPhantomJSConfig() {
	const phantomjsConfigFilePath = path.resolve(utility.extensionConfigDirectoryPath, './phantomjs_config.js')
  atom.workspace.open(phantomjsConfigFilePath)
}

function openMathJaxConfig() {
   const mathjaxConfigFilePath = path.resolve(utility.extensionConfigDirectoryPath, './mathjax_config.js')
   atom.workspace.open(mathjaxConfigFilePath)
}

function extendParser() {
  const parserConfigPath = path.resolve(utility.extensionConfigDirectoryPath, './parser.js')
  atom.workspace.open(parserConfigPath)
}

function insertNewSlide() {
  const editor = atom.workspace.getActiveTextEditor()
  if (editor && editor.buffer)
    editor.insertText('<!-- slide -->\n')
}

function insertPageBreak() {
  const editor = atom.workspace.getActiveTextEditor()
  if (editor && editor.buffer)
    editor.insertText('<!-- pagebreak -->\n')
}

function toggleZenMode() {
  const enableZenMode = atom.config.get('markdown-preview-enhanced.enableZenMode')
  atom.config.set('markdown-preview-enhanced.enableZenMode', !enableZenMode)
  if (!enableZenMode)
    atom.notifications.addInfo('zen mode enabled')
  else
    atom.notifications.addInfo('zen mode disabled')
}

function runCodeChunkCommand() {
  const editor = atom.workspace.getActiveTextEditor()
  const preview = getPreviewForEditor(editor)
  if (!preview) {
    atom.notifications.addError('Please open preview first.')
  } else {
    preview.sendRunCodeChunkCommand()
  }
}

function runAllCodeChunks() {
  const editor = atom.workspace.getActiveTextEditor()
  const preview = getPreviewForEditor(editor)
  if (!preview) {
    atom.notifications.addError('Please open preview first.')
  } else {
    preview.runAllCodeChunks()
  }
}

function showUploadedImages() {
	const imageHistoryFilePath = path.resolve(utility.extensionConfigDirectoryPath, './image_history.md')
  atom.workspace.open(imageHistoryFilePath)
}


export function deactivate() {
  subscriptions.dispose()
}

export {configSchema as config} from "./config-schema"
