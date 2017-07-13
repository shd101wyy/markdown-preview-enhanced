/// <reference types="atom-typings" />

import * as path from "path"
import {CompositeDisposable} from "atom"
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
function isMarkdownFile(filePath:string='') {
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
function onDidChangeConfig(config:MarkdownPreviewEnhancedConfig):void {
  console.log('config changed')
}

/**
 * As the function name pointed...
 */
function getSinglePreview() {
  return previewsMap[Object.keys(previewsMap)[0]]
}

/**
 * Return the preview object for editor.
 * @param editor 
 */
function getPreviewForEditor(editor) {
  if (config.singlePreview) {
    return getSinglePreview()
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

  if (preview && preview['isOnDom'] && preview['isOnDom']()) { // preview is already on, so remove it.
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
    

  }, false)
}

export function activate(state) {
  subscriptions = new CompositeDisposable()

  // Init config
  config = new MarkdownPreviewEnhancedConfig()
  config.onDidChange(subscriptions, onDidChangeConfig)

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
      'markdown-preview-enhanced:toggle': togglePreview
    })
  )

  // Register message event
  initMessageReceiver()
}

export function deactivate() {
  subscriptions.dispose()
}

export {configSchema as config} from "./config-schema"
