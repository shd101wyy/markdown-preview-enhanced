{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, View, TextEditorView}  = require 'atom-space-pen-views'

class InsertImageView extends View
  initialize: ()->
    console.log 'initialize'
    @bindEvents()

    atom.commands.add @element,
      'core:cancel': => @hidePanel(),
      'core:confirm': => @insertImageURL()

  @content: ->
    @div class: 'insert-image-view', =>
      @h1 'Insert Image'
      @div class: 'upload-div', =>
        @subview "urlEditor", new TextEditorView(mini: true, placeholderText: 'enter image URL here, then press Enter to insert.')
        @div class: 'splitter'
        @div class: 'drop-area', =>
          @p 'Drop file here or click me'
        @input type: 'checkbox'
        @label 'Copy to local ./assets folder and use relative path'
        @input class: 'file-uploader', type:'file', style: 'display: none;'
      @div class: 'close-btn btn', 'close'

  hidePanel: ->
    return unless @panel.isVisible()
    @panel.hide()

  bindEvents: ->
    closeBtn = $('.close-btn', @element)
    closeBtn.click ()=>
      @hidePanel()

    addBtn = $('.add-btn', @element)
    addBtn.click ()=>
      @insertImageURL()

    dropArea = $('.drop-area', @element)
    fileUploader = $('.file-uploader', @element)


    dropArea.on "drop dragend dragstart dragenter dragleave drag dragover", (event)=>
      event.preventDefault()
      if (event.type == "drop")
        @insertImageFile(event.originalEvent.dataTransfer.files[0])

    dropArea.on 'click', (e) =>
      e.preventDefault()
      e.stopPropagation()
      $(this).find('input[type="file"]').click()

    fileUploader.on 'click', (e)=>
      e.stopPropagation()

    fileUploader.on 'change', (e)=>
      @insertImageFile(e.target.files[0])

  insertImageFile: (file)->
    console.log(file)

  insertImageURL: ()->
    url = @urlEditor.getText().trim()
    if (url.length)
      @hidePanel()
      curPos = @editor.getCursorBufferPosition()
      @editor.insertText("![enter image description here](#{url})")
      @editor.setSelectedBufferRange([[curPos.row, curPos.column + 2], [curPos.row, curPos.column + 30]])
      atom.views.getView(@editor).focus()


  display: (editor)->
    @panel ?= atom.workspace.addModalPanel(item: this, visible: false)
    @panel.show()
    @urlEditor.focus()

    @editor = editor

insertImageView = new InsertImageView()
module.exports = insertImageView
