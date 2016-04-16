## Unfortunately, I have to write this in coffeescript

{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, ScrollView}  = require 'atom-space-pen-views'

class MarkdownPreviewEditor extends ScrollView
  constructor: (uri)->
    super
    @uri = uri
    @protocal = 'atom-markdown-katex://'
    @emitter = new Emitter
    @disposables = new CompositeDisposable

  @content: ->
    @div class: 'markdown-katex-preview-editor'

  getTitle: ->
    @uri.slice(@protocal.length)

  getFileName: ->
    @uri.slice(@protocal.length, @uri.indexOf(' preview')).trim()

  getIconName: ->
    "markdown"

  getURI: ->
    @uri

  detached: ->
    @emitter.emit 'destroy'

  onDidDestroy: (callback)->
    @emitter.on 'destroy', callback

  destroy: ->
    @disposables.dispose()

module.exports = MarkdownPreviewEditor
