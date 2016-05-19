{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, View, TextEditorView}  = require 'atom-space-pen-views'

class InsertImageView extends View
  initialize: ()->
    console.log 'initialize'
    @bindEvents()

    atom.commands.add @element,
      'core:cancel': => @hidePanel(),
      'core:confirm': => console.log('confirm')

  @content: ->
    @div class: 'insert-image-view', =>
      @h1 'Insert Image'
      @div class: 'upload-div', =>
        @subview "urlEditor", new TextEditorView(mini: true, placeholderText: 'URL')
        @div class: 'drop-area', =>
          @p 'Drop file here or click me'
        @input type: 'checkbox'
        @label 'Copy to local ./assets folder'
        @input class: 'file-uploader', type:'file', style: 'display: none;'
      @div class: 'close-btn btn', 'close'
      @div class: 'add-btn btn', 'add'

  hidePanel: ->
    return unless @panel.isVisible()
    @panel.hide()


  bindEvents: ->
    closeBtn = $('.close-btn', @element)
    closeBtn.click ()=>
      @hidePanel()

    dropArea = $('.drop-area', @element)
    fileUploader = $('.file-uploader', @element)


    dropArea.on "drop dragend dragstart dragenter dragleave drag dragover", (event)->
      event.preventDefault()
      if (event.type == "drop")
        console.log(event.originalEvent.dataTransfer.files)

    dropArea.on 'click', (e) =>
      e.preventDefault()
      e.stopPropagation()
      $(this).find('input[type="file"]').click()

    fileUploader.on 'click', (e)=>
      e.stopPropagation()

    fileUploader.on 'change', (e)=>
      console.log(e.target.files)

  display: ->
    @panel ?= atom.workspace.addModalPanel(item: this, visible: false)
    @panel.show()
    @urlEditor.focus()

insertImageView = new InsertImageView()
module.exports = insertImageView
