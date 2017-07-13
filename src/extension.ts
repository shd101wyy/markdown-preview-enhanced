/// <reference types="atom-typings" />

import {CompositeDisposable} from "atom"
import {MarkdownPreviewEnhancedConfig} from "./config"

let subscriptions:CompositeDisposable = null;

export function activate(state) {
  subscriptions = new CompositeDisposable()

  // Set opener
  subscriptions.add(atom.workspace.addOpener((uri)=> {
    if (uri.startsWith('mpe://')) {

    }
  }))
}

export function deactivate() {
  subscriptions.dispose()
}

export {configSchema as config} from "./config-schema"
