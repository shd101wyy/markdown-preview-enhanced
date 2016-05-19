{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, View, TextEditorView}  = require 'atom-space-pen-views'
imgur = require 'imgur'

class InsertImageView extends View
  initialize: ()->
    @bindEvents()

    atom.commands.add @element,
      'core:cancel': => @hidePanel(),
      'core:confirm': => @insertImageURL()

  @content: ->
    @div class: 'insert-image-view', =>
      @h4 'Image Helper'
      @div class: 'upload-div', =>
        @label 'Link'
        @subview "urlEditor", new TextEditorView(mini: true, placeholderText: 'enter image URL here, then press Enter to insert.')

        @div class: 'splitter'

        @label 'Upload'
        @div class: 'drop-area', =>
          @p 'Drop image file here or click me'
        #@input type: 'checkbox'
        #@label 'Copy to local ./assets folder and use relative path'
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
        @uploadImageFile(event.originalEvent.dataTransfer.files[0])

    dropArea.on 'click', (e) =>
      e.preventDefault()
      e.stopPropagation()
      $(this).find('input[type="file"]').click()

    fileUploader.on 'click', (e)=>
      e.stopPropagation()

    fileUploader.on 'change', (e)=>
      @uploadImageFile(e.target.files[0])
      fileUploader.val('')

  replaceHint: (editor, lineNo, hint, withStr)->
    if editor && editor.buffer && editor.buffer.lines[lineNo].indexOf(hint) >= 0
      line = editor.buffer.lines[lineNo]
      editor.buffer.setTextInRange([[lineNo, 0], [lineNo+1, 0]], line.replace(hint, withStr + '\n'))
      return true
    return false

  uploadImageFile: (file)->
    # console.log(file)
    fileName = file.name

    @hidePanel()

    editor = @editor
    hint = "![Uploading #{fileName}…]()"
    curPos = editor.getCursorBufferPosition()
    editor.insertText(hint)

    atom.views.getView(@editor).focus()

    # A single image
    imgur.uploadFile(file.path)
         .then (json)=>
            if fileName.lastIndexOf('.')
              description = fileName.slice(0, fileName.lastIndexOf('.'))
            else
              description = fileName

            buffer = editor.buffer
            line = editor.buffer.lines[curPos.row]

            withStr = "![#{description}](#{json.data.link})"

            if not @replaceHint(editor, curPos.row, hint, withStr)
              i = curPos.row - 20
              while i <= curPos.row + 20
                if (@replaceHint(editor, i, hint, withStr))
                  break
                i++

            #buffer.setTextInRange([[curPos.row, 0], [curPos.row+1, 0]], line.replace(hint, "![#{description}](#{json.data.link})") + '\n')
            #editor.setText(editor.getText().replace(hint, "![#{description}](#{json.data.link})"))

         .catch (err)=>
            atom.notifications.addError(err.message)

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
