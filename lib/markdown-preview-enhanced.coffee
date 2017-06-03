{CompositeDisposable, Emitter, Directory, File} = require 'atom'
path = require 'path'
fs = require 'fs'
{loadPreviewTheme} = require './style'
Hook = require './hook'
configSchema = require './config-schema'
MarkdownPreviewEnhancedView = null
ExporterView = null
PACKAGE = null

module.exports = MarkdownPreviewEnhanced =
  previewsMap: {}, # key is filePath, value is MarkdownPreviewEnhancedView object.
  singlePreview: true,
  katexStyle: null,
  documentExporterView: null,
  imageHelperView: null,
  fileExtensions: null,
  config: configSchema,

  activate: (state) ->
    # console.log 'actvate markdown-preview-enhanced', state
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    @emitter = new Emitter
    @hook = new Hook

    # file extensions?
    @fileExtensions = atom.config.get('markdown-preview-enhanced.fileExtension').split(',').map((x)->x.trim()) or ['.md', '.mmark', '.markdown']

    # set opener
    @subscriptions.add atom.workspace.addOpener (uri)=>
      if (uri.startsWith('markdown-preview-enhanced://'))
        if @singlePreview
          return @getSinglePreview()
        else
          return @previewsMap[uri.slice(28)]

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'markdown-preview-enhanced:toggle': => @toggle()
      'markdown-preview-enhanced:customize-css': => @customizeCSS()
      'markdown-preview-enhanced:create-toc': => @createTOC()
      'markdown-preview-enhanced:toggle-scroll-sync': => @toggleScrollSync()
      'markdown-preview-enhanced:toggle-live-update': => @toggleLiveUpdate()
      'markdown-preview-enhanced:toggle-break-on-single-newline': => @toggleBreakOnSingleNewline()
      'markdown-preview-enhanced:insert-table': => @insertTable()
      'markdown-preview-enhanced:image-helper': => @startImageHelper()
      'markdown-preview-enhanced:open-mermaid-config': => @openMermaidConfig()
      'markdown-preview-enhanced:open-header-footer-config': => @openHeaderFooterConfig()
      'markdown-preview-enhanced:open-mathjax-config': => @openMathJaxConfig()
      'markdown-preview-enhanced:insert-new-slide': => @insertNewSlide()
      'markdown-preview-enhanced:insert-page-break': => @insertPageBreak()
      'markdown-preview-enhanced:toggle-zen-mode': => @toggleZenMode()
      'markdown-preview-enhanced:run-code-chunk': => @runCodeChunk()
      'markdown-preview-enhanced:run-all-code-chunks': => @runAllCodeChunks()
      'markdown-preview-enhanced:open-welcome-page': => atom.workspace.open path.resolve(__dirname, '../WELCOME.md')

    # When the preview is displayed
    # preview will display the content of editor (pane item) that is activated
    @subscriptions.add atom.workspace.onDidChangeActivePaneItem (editor)=>
        return if !@singlePreview
        preview = @getSinglePreview()
        if editor and
            editor.buffer and
          	editor.getGrammar and
          	editor.getGrammar().scopeName == 'source.gfm' and
          	preview?.isOnDom()
          if preview.editor != editor
            preview.bindEditor(editor)

    # automatically open preview when activate a markdown file
    # if 'openPreviewPaneAutomatically' option is enable
    @subscriptions.add atom.workspace.onDidOpen (event)=>
      if atom.config.get('markdown-preview-enhanced.openPreviewPaneAutomatically')
        if event.uri and
            event.item and
            path.extname(event.uri) in @fileExtensions and
            !event.uri.startsWith('markdown-preview-enhanced://')
          pane = event.pane
          panes = atom.workspace.getPanes()

          # if the markdown file is opened on the right pane, then move it to the left pane. Issue #25
          if pane != panes[0]
            pane.moveItemToPane(event.item, panes[0], 0) # move md to left pane.
            panes[0].setActiveItem(event.item)

          editor = event.item
          @startMDPreview(editor)

      # check zen mode
      if event.uri and event.item and path.extname(event.uri) in @fileExtensions
        editor = event.item
        editorElement = editor.getElement()
        if editor and editor.buffer
          if atom.config.get('markdown-preview-enhanced.enableZenMode')
            editorElement.setAttribute('data-markdown-zen', '')
          else
            editorElement.removeAttribute('data-markdown-zen')

    # zen mode observation
    @subscriptions.add atom.config.observe 'markdown-preview-enhanced.enableZenMode', (enableZenMode)=>
      paneItems = atom.workspace.getPaneItems()
      for editor in paneItems
        if editor and editor.getPath and path.extname(editor.getPath() or '') in @fileExtensions
          if editor.buffer
            editorElement = editor.getElement()
            if enableZenMode
              editorElement.setAttribute('data-markdown-zen', '')
            else
              editorElement.removeAttribute('data-markdown-zen')

      if enableZenMode
        document.getElementsByTagName('atom-workspace')?[0]?.setAttribute('data-markdown-zen', '')
      else
        document.getElementsByTagName('atom-workspace')?[0]?.removeAttribute('data-markdown-zen')

    # use single preview
    @subscriptions.add atom.config.observe 'markdown-preview-enhanced.singlePreview', (singlePreview)=>
      @singlePreview = singlePreview
      for key of @previewsMap
        preview = @previewsMap[key]
        continue if !preview
        pane = atom.workspace.paneForItem(preview)
        pane.destroyItem(preview) # this will trigger preview.destroy()
      @previewsMap = {}

    @openWelcomePage()

  openWelcomePage: ->
    PACKAGE ?= require('../package.json')
    packageJSONPath = path.resolve(atom.config.configDirPath, './markdown-preview-enhanced/package.json')

    helper = ()->
      atom.workspace.open path.resolve(__dirname, '../WELCOME.md')
      fs.writeFile packageJSONPath, JSON.stringify({version: PACKAGE.version})

    try
      packageJSON = require(packageJSONPath)
      if packageJSON.version != PACKAGE.version
        helper()
    catch error
      helper()

  deactivate: ->
    @subscriptions.dispose()
    @emitter.dispose()
    @hook.dispose()

    @imageHelperView?.destroy()
    @imageHelperView = null
    @documentExporterView?.destroy()
    @documentExporterView = null

    for key of @previewsMap
      @previewsMap[key]?.destroy()
    @previewsMap = {}

    # console.log 'deactivate markdown-preview-enhanced'

  toggle: ->
    editor = atom.workspace.getActivePaneItem()
    preview = @getPreviewForEditor(editor)

    if preview?.isOnDom()
      pane = atom.workspace.paneForItem(preview)
      pane.destroyItem(preview) # this will trigger preview.destroy()
      @removePreviewFromMap preview
    else
      ## check if it is valid markdown file
      @startMDPreview(editor)

  startMDPreview: (editor)->
    MarkdownPreviewEnhancedView ?= require './markdown-preview-enhanced-view'
    ExporterView ?= require './exporter-view'

    preview = @getPreviewForEditor(editor)
    if !preview
      if @singlePreview
        preview = new MarkdownPreviewEnhancedView('markdown-preview-enhanced://single_preview', this)
        @previewsMap['single_preview'] = preview
      else
        preview = new MarkdownPreviewEnhancedView('markdown-preview-enhanced://' + editor.getPath(), this)
        @previewsMap[editor.getPath()] = preview

    if preview.editor == editor
      return true
    else if @checkValidMarkdownFile(editor)
      @appendGlobalStyle()
      preview.bindEditor(editor)

      @documentExporterView ?= new ExporterView()
      preview.documentExporterView = @documentExporterView
      return true
    else
      return false

  getPreviewForEditor: (editor)->
    if @singlePreview
      return @getSinglePreview()
    else if editor.getURI?().startsWith('markdown-preview-enhanced://')
      return editor
    else
      return @previewsMap[editor?.getPath?()]

  getSinglePreview: ->
    return @previewsMap[Object.keys(@previewsMap)[0]]

  removePreviewFromMap: (preview)->
    for key of @previewsMap
      if (@previewsMap[key] == preview)
        delete @previewsMap[key]

  checkValidMarkdownFile: (editor)->
    if !editor or !editor.getFileName()
      atom.notifications.addError('Markdown file should be saved first.')
      return false

    fileName = editor.getFileName() or ''
    if !(path.extname(fileName) in @fileExtensions)
      atom.notifications.addError("Invalid Markdown file: #{fileName} with wrong extension #{path.extname(fileName)}.", detail: "only '#{@fileExtensions.join(', ')}' are supported." )
      return false

    buffer = editor.buffer
    if !buffer
      atom.notifications.addError('Invalid Markdown file: ' + fileName)
      return false

    return true

  appendGlobalStyle: ()->
    if not @katexStyle
      @katexStyle = document.createElement 'link'
      @katexStyle.rel = 'stylesheet'
      @katexStyle.href = path.resolve(__dirname, '../node_modules/katex/dist/katex.min.css')
      document.getElementsByTagName('head')[0].appendChild(@katexStyle)

      # change theme
      # @subscriptions.add atom.config.observe 'core.themes', ()=>
      @initPreviewTheme()

  initPreviewTheme: ()->
    previewTheme = atom.config.get('markdown-preview-enhanced.previewTheme')
    loadPreviewTheme previewTheme, {changeStyleElement: true}, ()=>
      changeTheme = ()->
        previewTheme = atom.config.get('markdown-preview-enhanced.previewTheme')
        loadPreviewTheme previewTheme, {changeStyleElement: true}
      @subscriptions.add atom.config.observe 'markdown-preview-enhanced.previewTheme', changeTheme
      @subscriptions.add atom.config.observe 'markdown-preview-enhanced.whiteBackground', changeTheme

  customizeCSS: ()->
    atom.workspace
      .open("atom://.atom/stylesheet")
      .then (editor)->
        customCssTemplate = """\n
/*
 * markdown-preview-enhanced custom style
 */
.markdown-preview-enhanced.markdown-preview-enhanced {
  // please write your custom style here
  // eg:
  //  color: blue;          // change font color
  //  font-size: 14px;      // change font size
  //

  // custom pdf output style
  @media print {

  }

  // custom prince pdf export style
  &.prince {

  }

  // custom phantomjs png/jpeg export style
  &.phantomjs-image {

  }

  //custom phantomjs pdf export style
  &.phantomjs-pdf {

  }

  // custom presentation style
  .preview-slides .slide,
  &[data-presentation-mode] {
    // eg
    // background-color: #000;
  }
}
"""
        text = editor.getText()
        if text.indexOf('.markdown-preview-enhanced.markdown-preview-enhanced {') < 0
          editor.setText(text + customCssTemplate)

  # insert toc table
  # if markdown preview is not opened, then open the preview
  createTOC: ()->
    editor = atom.workspace.getActiveTextEditor()

    if editor and @startMDPreview(editor)
      editor.insertText('\n<!-- toc orderedList:0 depthFrom:1 depthTo:6 -->\n<!-- tocstop -->\n')

  toggleScrollSync: ()->
    flag = atom.config.get 'markdown-preview-enhanced.scrollSync'
    atom.config.set('markdown-preview-enhanced.scrollSync', !flag)

    if !flag
      atom.notifications.addInfo('Scroll Sync enabled')
    else
      atom.notifications.addInfo('Scroll Sync disabled')

  toggleLiveUpdate: ()->
    flag = atom.config.get 'markdown-preview-enhanced.liveUpdate'
    atom.config.set('markdown-preview-enhanced.liveUpdate', !flag)

    if !flag
      atom.notifications.addInfo('Live Update enabled')
    else
      atom.notifications.addInfo('Live Update disabled')

  toggleBreakOnSingleNewline: ()->
    flag = atom.config.get 'markdown-preview-enhanced.breakOnSingleNewline'
    atom.config.set('markdown-preview-enhanced.breakOnSingleNewline', !flag)

    if !flag
      atom.notifications.addInfo('Enabled breaking on single newline')
    else
      atom.notifications.addInfo('Disabled breaking on single newline')

  insertTable: ()->
    addSpace = (num)->
      output = ''
      for i in [0...num]
        output += ' '
      return output

    editor = atom.workspace.getActiveTextEditor()
    if editor and editor.buffer
      cursorPos = editor.getCursorBufferPosition()
      editor.insertText """|   |   |
  #{addSpace(cursorPos.column)}|---|---|
  #{addSpace(cursorPos.column)}|   |   |
  """
      editor.setCursorBufferPosition([cursorPos.row, cursorPos.column + 2])
    else
      atom.notifications.addError('Failed to insert table')

  # start image helper
  startImageHelper: ()->
    ImageHelperView = require './image-helper-view'

    editor = atom.workspace.getActiveTextEditor()
    if editor and editor.buffer
      @imageHelperView ?= new ImageHelperView()
      @imageHelperView.display(editor)
    else
      atom.notifications.addError('Failed to open Image Helper panel')

  openMermaidConfig: ()->
    atom.workspace.open(path.resolve(atom.config.configDirPath, './markdown-preview-enhanced/mermaid_config.js'))

  openHeaderFooterConfig: ()->
    atom.workspace.open(path.resolve(atom.config.configDirPath, './markdown-preview-enhanced/phantomjs_header_footer_config.js'))

  openMathJaxConfig: ()->
    require('./mathjax-wrapper').loadMathJaxConfig()
    atom.workspace.open(path.resolve(atom.config.configDirPath, './markdown-preview-enhanced/mathjax_config.js'))

  toggleZenMode: ()->
    enableZenMode = atom.config.get('markdown-preview-enhanced.enableZenMode')
    atom.config.set('markdown-preview-enhanced.enableZenMode', !enableZenMode)
    if !enableZenMode
      atom.notifications.addInfo('zen mode enabled')
    else
      atom.notifications.addInfo('zen mode disabled')

  insertNewSlide: ()->
    editor = atom.workspace.getActiveTextEditor()
    if editor and editor.buffer
      editor.insertText '<!-- slide -->\n'

  insertPageBreak: ()->
    editor = atom.workspace.getActiveTextEditor()
    if editor and editor.buffer
      editor.insertText '<!-- pagebreak -->\n'

  # HOOKS Issue #101
  onWillParseMarkdown: (callback)->
    @hook.on 'on-will-parse-markdown', callback

  onDidParseMarkdown: (callback)->
    @hook.on 'on-did-parse-markdown', callback

  onDidRenderPreview: (callback)->
    @emitter.on 'on-did-render-preview', callback


  runCodeChunk: ()->
    editor = atom.workspace.getActivePaneItem()
    preview = @getPreviewForEditor(editor)
    if preview?.isOnDom()
      preview.runCodeChunk()
    else
      atom.notifications.addInfo('You need to start markdown-preview-enhanced preview first')

  runAllCodeChunks: ()->
    editor = atom.workspace.getActivePaneItem()
    preview = @getPreviewForEditor(editor)
    if preview?.isOnDom()
      preview.runAllCodeChunks()
    else
      atom.notifications.addInfo('You need to start markdown-preview-enhanced preview first')