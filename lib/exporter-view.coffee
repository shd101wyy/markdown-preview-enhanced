{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, View, TextEditorView}  = require 'atom-space-pen-views'

class ExporterView extends View
  initialize: ()->

    atom.commands.add @element,
      'core:cancel': => @hidePanel()

  @content: ->
    @div class: 'exporter-view', =>
      @h4 'Export to disk'
      @label 'HTML'
      @subview 'htmlTitle', new TextEditorView(mini: true, placeholderText: 'enter html title here')
      @input type: 'checkbox'

  @hidePanel: ->
    return unless @panel.isVisible()
    @panel.hide()

  @display: (markdownPreview)->
    @panel ?= atom.workspace.addModalPanel(item: this, visible: false)
    @panel.show()

documentExporter = new ExporterView()
module.exports = documentExporter
