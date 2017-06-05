{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, View, TextEditorView}  = require 'atom-space-pen-views'
{Directory} = require 'atom'
imgur = require 'imgur'
path = require 'path'
fs = require 'fs'

smAPI = require './sm'

class ImageHelperView extends View
  subscriptions: new CompositeDisposable

  initialize: ()->
    @bindEvents()

    @subscriptions.add atom.commands.add @element,
      'core:cancel': => @hidePanel(),
      'core:confirm': => @insertImageURL()

  destroy: ->
    @subscriptions.dispose()
    @panel?.destroy()
    @panel = null
    @editor = null

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
        @div class: 'uploader-choice', =>
          @span 'use'
          @select class: 'uploader-select', =>
            @option 'imgur'
            @option 'sm.ms'
          @span 'to upload images'
      @div class: 'close-btn btn', 'close'

  bindEvents: ->
    closeBtn = $('.close-btn', @element)
    closeBtn.click ()=>
      @hidePanel()

    addBtn = $('.add-btn', @element)
    addBtn.click ()=>
      @insertImageURL()

    dropArea = $('.drop-area', @element)
    fileUploader = $('.file-uploader', @element)

    uploaderSelect = $('.uploader-select', @element)

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

    dropArea.on 'click', (e)->
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

    uploaderSelect.on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.imageUploader', this.value)

  replaceHint: (editor, lineNo, hint, withStr)->
    if editor && editor.buffer && editor.buffer.lines[lineNo].indexOf(hint) >= 0
      line = editor.buffer.lines[lineNo]
      editor.buffer.setTextInRange([[lineNo, 0], [lineNo+1, 0]], line.replace(hint, withStr + '\n'))
      return true
    return false

  pasteImageFile: (file)->
    @hidePanel()

    editor = @editor
    editorPath = editor.getPath()
    editorDirectoryPath = editor.getDirectoryPath()
    imageFolderPath = atom.config.get 'markdown-preview-enhanced.imageFolderPath'

    if imageFolderPath[imageFolderPath.length - 1] == '/'
      imageFolderPath = imageFolderPath.slice(0, imageFolderPath.length - 1)

    if file
      if imageFolderPath[0] == '/' # root folder
        projectDirectoryPath = null
        for projectDirectory in atom.project.rootDirectories
          if projectDirectory.contains(editorPath)
            projectDirectoryPath = projectDirectory.getPath()
            break
        if !projectDirectoryPath
          atom.notifications.addError('You have to \'Add Project Folder\' first', detail: 'project directory path not found')
          return
        assetDirectory = new Directory(path.resolve(projectDirectoryPath, ".#{imageFolderPath}"))
      else # relative folder
        assetDirectory = new Directory(path.resolve(editorDirectoryPath, imageFolderPath))

      assetDirectory.create().then (flag)=>
        fileName = file.name
        destPath = path.resolve(assetDirectory.path, fileName)

        fs.stat destPath, (err, stat)=>
          if err == null # file existed
            lastDotOffset = fileName.lastIndexOf('.')
            uid = '_' + Math.random().toString(36).substr(2, 9)

            if lastDotOffset > 0
              description = fileName.slice(0, lastDotOffset)
              fileName = fileName.slice(0, lastDotOffset) + uid + fileName.slice(lastDotOffset, fileName.length)
            else
              description = fileName
              fileName = fileName + uid

            fs.createReadStream(file.path).pipe(fs.createWriteStream(path.resolve(assetDirectory.path, fileName)))

          else if err.code == 'ENOENT' # file does not exist
            fs.createReadStream(file.path).pipe(fs.createWriteStream(destPath))

            if fileName.lastIndexOf('.')
              description = fileName.slice(0, fileName.lastIndexOf('.'))
            else
              description = fileName
          else
            atom.notifications.addError("Error: #{err}")
            return


          atom.notifications.addSuccess("Finish copying image", detail: "#{file.name} has been copied to folder #{assetDirectory.path}")

          url = "#{imageFolderPath}/#{fileName}"
          if url.indexOf(' ') >= 0
            url = "<#{url}>"
          editor.insertText("![#{description}](#{url})")

  addImageURLToHistory: (markdownImage)->
    imageHistoryPath = path.resolve(atom.config.configDirPath, './markdown-preview-enhanced/image_history.md')
    fs.readFile imageHistoryPath, (error, data)->
      if error
        data = ''
      data = """
#{markdownImage}

`#{markdownImage}`

#{(new Date()).toString()}

---

""" + data
      fs.writeFile imageHistoryPath, data

  setUploadedImageURL: (fileName, url, editor, hint, curPos)->
    if fileName.lastIndexOf('.')
      description = fileName.slice(0, fileName.lastIndexOf('.'))
    else
      description = fileName

    buffer = editor.buffer
    line = editor.buffer.lines[curPos.row]

    withStr = "![#{description}](#{url})"

    if not @replaceHint(editor, curPos.row, hint, withStr)
      i = curPos.row - 20
      while i <= curPos.row + 20
        if (@replaceHint(editor, i, hint, withStr))
          break
        i++

    @addImageURLToHistory(withStr)

  uploadImageFile: (file)->
    fileName = file.name

    @hidePanel()

    editor = @editor
    uid = Math.random().toString(36).substr(2, 9)
    hint = "![Uploading #{fileName}… (#{uid})]()"
    curPos = editor.getCursorBufferPosition()
    uploader = atom.config.get 'markdown-preview-enhanced.imageUploader'

    editor.insertText(hint)
    atom.views.getView(editor).focus()

    if uploader == 'imgur'
      # A single image
      imgur.uploadFile(file.path)
           .then (json)=>
             @setUploadedImageURL fileName, json.data.link, editor, hint, curPos
           .catch (err)=>
              atom.notifications.addError(err.message.message)
    else # sm.ms
      smAPI.uploadFile file.path,
        (err, url)=>
          if err
            atom.notifications.addError(err)
          else
            @setUploadedImageURL fileName, url, editor, hint, curPos

  insertImageURL: ()->
    url = @urlEditor.getText().trim()
    if url.indexOf(' ') >= 0
      url = "<#{url}>"
    if (url.length)
      @hidePanel()
      curPos = @editor.getCursorBufferPosition()
      @editor.insertText("![enter image description here](#{url})")
      @editor.setSelectedBufferRange([[curPos.row, curPos.column + 2], [curPos.row, curPos.column + 30]])
      atom.views.getView(@editor).focus()

  hidePanel: ->
    return unless @panel?.isVisible()
    @panel.hide()

  display: (editor)->
    @panel ?= atom.workspace.addModalPanel(item: this, visible: false)
    @panel.show()
    @urlEditor.focus()

    @editor = editor

    @urlEditor.setText('')
    $(@element).find('input[type="file"]').val('')

    copyLabel = $(@element).find('.copy-label')
    imageFolderPath = atom.config.get 'markdown-preview-enhanced.imageFolderPath'

    if imageFolderPath[imageFolderPath.length - 1] == '/'
      imageFolderPath = imageFolderPath.slice(0, imageFolderPath.length - 1)

    copyLabel.html  "Copy image to #{if imageFolderPath[0] == '/' then 'root' else 'relative'} <a>#{imageFolderPath}</a> folder"

    copyLabel.find('a').on 'click', ()=>
      try
        atom.workspace.open('atom://config/packages/markdown-preview-enhanced', {split: 'right'})
        @hidePanel()
      catch e
        @hidePanel()

    uploader = atom.config.get 'markdown-preview-enhanced.imageUploader'
    $(@element).find('.uploader-select').val(uploader)

module.exports = ImageHelperView
