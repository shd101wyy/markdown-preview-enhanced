{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, ScrollView}  = require 'atom-space-pen-views'
{MediumEditor} = require 'medium-editor'

module.exports =
class MarsView extends ScrollView
  constructor: (uri) ->
    super

    @uri = uri

    @zeroWidthCharacter = '\u200b' # zero-width character
    @nbsp = String.fromCharCode(160)
    window.mars = this

    @editor = new MediumEditor @element,
                               toolbar: false,
                               placeholder:
                                 text: 'Write markdown here',
                                 hideOnClick: true

  @content: ->
    @div class: 'markdown-preview-enhanced native-key-bindings mars'

  getTitle: ->
    'Mars'

  getURI: ->
    @uri


  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element
