{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, View, TextEditorView}  = require 'atom-space-pen-views'

class ExporterView extends View
  initialize: ()->

    atom.commands.add @element,
      'core:cancel': => @hidePanel()

    @bindEvents()

  @content: ->
    @div class: 'exporter-view', =>
      @h4 'Export to disk'
      @div class: 'document-type-div clearfix', =>
        @div class: 'document-type selected', "HTML"
        @div class: 'document-type', "PDF"
        @div class: 'document-type', "PNG"
        @div class: 'document-type', "JPEG"

      @label class: 'save-as-label', 'Save as'
      @subview 'fileNameInput', new TextEditorView(mini: true, placeholderText: 'enter filename here')

      #@div class: 'html-div', =>
      #  @label 'CDN (network required)'
      #  @input class: 'cdn-checkbox', type: 'checkbox', style: 'margin-left: 12px;'

      @div class: 'pdf-div', =>
        @div class: 'splitter'
        @label 'Format'
        @select class: 'format-select', =>
          @option 'Letter'
          @option 'A3'
          @option 'A4'
          @option 'A5'
          @option 'Legal'
          @option 'Tabloid'
        @br()
        @label 'Orientation'
        @select class: 'orientation-select', =>
          @option 'portrait'
          @option 'landscape'
        @br()
        @div 'splitter'
        @label 'header'
        # @label 'image quality'
        # @input type: 'text', class: 'image-quality-input'

      @div class: 'button-group', =>
        @div class: 'close-btn btn', 'close'
        @div class: 'export-btn btn', 'export'

  bindEvents: ->
    $('.close-btn', @element).click ()=> @hidePanel()

  hidePanel: ->
    return unless @panel.isVisible()
    @panel.hide()

  display: (markdownPreview)->
    @panel ?= atom.workspace.addModalPanel(item: this, visible: false)
    @panel.show()

    @fileNameInput.focus()

documentExporter = new ExporterView()
module.exports = documentExporter
