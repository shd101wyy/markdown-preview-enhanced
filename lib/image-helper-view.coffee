{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, View, TextEditorView}  = require 'atom-space-pen-views'
{Directory} = require 'atom'
imgur = require 'imgur'
path = require 'path'
fs = require 'fs'

class InsertImageView extends View
  initialize: ()->
    @bindEvents()

    atom.commands.add @element,
      'core:cancel': => @hidePanel(),
      'core:confirm': => @insertImageURL()

  @content: ->
    @div class: 'image-helper-view', =>
      @h4 'Image Helper'
      @div class: 'upload-div', =>
        @label 'Link'
        @subview "urlEditor", new TextEditorView(mini: true, placeholderText: 'enter image URL here, then press \'Enter\' to insert.')

        @div class: 'splitter'

        @label class: 'copy-label', 'Copy image to root /assets folder'
        @div class: 'drop-area paster', =>
          @p class: 'paster', 'Drop image file here or click me'
          @input class: 'file-uploader paster', type:'file', style: 'display: none;', multiple: "multiple"

        @div class: 'splitter'

        @label 'Upload'
        @div class: 'drop-area uploader', =>
          @p class: 'uploader', 'Drop image file here or click me'
          @input class: 'file-uploader uploader', type:'file', style: 'display: none;', multiple: "multiple"
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


    dropArea.on "drop dragend dragstart dragenter dragleave drag dragover", (e)=>
      e.preventDefault()
      e.stopPropagation()
      if e.type == "drop"
        if e.target.className.indexOf('paster') >= 0 # paste
          for file in e.originalEvent.dataTransfer.files
            @pasteImageFile file
        else # upload
          for file in e.originalEvent.dataTransfer.files
            @uploadImageFile file

    dropArea.on 'click', (e) ->
      e.preventDefault()
      e.stopPropagation()
      $(this).find('input[type="file"]').click()

    fileUploader.on 'click', (e)->
      e.stopPropagation()

    fileUploader.on 'change', (e)=>
      if e.target.className.indexOf('paster') >= 0 # paste
        for file in e.target.files
          @pasteImageFile file
      else # upload
        for file in e.target.files
          @uploadImageFile file

  replaceHint: (editor, lineNo, hint, withStr)->
    if editor && editor.buffer && editor.buffer.lines[lineNo].indexOf(hint) >= 0
      line = editor.buffer.lines[lineNo]
      editor.buffer.setTextInRange([[lineNo, 0], [lineNo+1, 0]], line.replace(hint, withStr + '\n'))
      return true
    return false

  pasteImageFile: (file)->
    @hidePanel()

    editor = @editor
    projectDirectoryPath = editor.project.getPaths()[0]
    rootImageFolderPath = atom.config.get 'markdown-preview-enhanced.rootImageFolderPath'

    if rootImageFolderPath[rootImageFolderPath.length - 1] == '/'
      rootImageFolderPath = rootImageFolderPath.slice(0, rootImageFolderPath.length - 1)

    if rootImageFolderPath[0] != '/'
      rootImageFolderPath = '/' + rootImageFolderPath

    if file and projectDirectoryPath
      assetDirectory = new Directory(path.resolve(projectDirectoryPath, ".#{rootImageFolderPath}"))

      assetDirectory.create().then (flag)=>
        fileName = file.name
        fs.createReadStream(file.path).pipe(fs.createWriteStream(path.resolve(assetDirectory.path, fileName)))

        atom.notifications.addSuccess("Finish copying image", detail: "#{fileName} has been copied to folder #{assetDirectory.path}")

        if fileName.lastIndexOf('.')
          description = fileName.slice(0, fileName.lastIndexOf('.'))
        else
          description = fileName

        url = "#{rootImageFolderPath}/#{fileName}"
        if url.indexOf(' ') >= 0
          url = "<#{url}>"
        editor.insertText("![#{description}](#{url})")


  uploadImageFile: (file)->
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

    @urlEditor.setText('')
    $(@element).find('input[type="file"]').val('')

    copyLabel = $(@element).find('.copy-label')
    rootImageFolderPath = atom.config.get 'markdown-preview-enhanced.rootImageFolderPath'

    if rootImageFolderPath[rootImageFolderPath.length - 1] == '/'
      rootImageFolderPath = rootImageFolderPath.slice(0, rootImageFolderPath.length - 1)

    if rootImageFolderPath[0] != '/'
      rootImageFolderPath = '/' + rootImageFolderPath

    copyLabel.text  "Copy image to root #{rootImageFolderPath} folder"

insertImageView = new InsertImageView()
module.exports = insertImageView
