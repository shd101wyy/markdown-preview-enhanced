{Emitter, CompositeDisposable, File, Directory} = require 'atom'
{$, $$$, ScrollView}  = require 'atom-space-pen-views'
path = require 'path'
fs = require 'fs'
temp = require('temp').track()
{exec} = require 'child_process'
pdf = require 'html-pdf'
katex = require 'katex'
matter = require('gray-matter')
{allowUnsafeEval, allowUnsafeNewFunction} = require 'loophole'
cheerio = null

{getMarkdownPreviewCSS} = require './style'
plantumlAPI = require './puml'
ebookConvert = require './ebook-convert'
{loadMathJax} = require './mathjax-wrapper'
pandocConvert = require './pandoc-convert'
markdownConvert = require './markdown-convert'
codeChunkAPI = require './code-chunk'
CACHE = require './cache'
{protocolsWhiteListRegExp} = require './protocols-whitelist'

module.exports =
class MarkdownPreviewEnhancedView extends ScrollView
  constructor: (uri, mainModule)->
    super

    @uri = uri
    @mainModule = mainModule
    @protocal = 'markdown-preview-enhanced://'
    @editor = null

    @tocConfigs = null
    @scrollMap = null
    @fileDirectoryPath = null
    @projectDirectoryPath = null

    @disposables = null

    @liveUpdate = true
    @scrollSync = true
    @scrollDuration = null
    @textChanged = false

    @mathRenderingOption = atom.config.get('markdown-preview-enhanced.mathRenderingOption')
    @mathRenderingOption = if @mathRenderingOption == 'None' then null else @mathRenderingOption
    @mathJaxProcessEnvironments = atom.config.get('markdown-preview-enhanced.mathJaxProcessEnvironments')

    @parseDelay = Date.now()
    @editorScrollDelay = Date.now()
    @previewScrollDelay = Date.now()

    @documentExporterView = null # binded in markdown-preview-enhanced.coffee startMD function

    # this two variables will be got from './md'
    @parseMD = null
    @buildScrollMap = null
    @processFrontMatter = null

    # this variable will be got from 'viz.js'
    @Viz = null

    # this variable will check if it is the first time to render markdown
    @firstTimeRenderMarkdowon = true

    # presentation mode
    @presentationMode = false
    @slideConfigs = null

    # graph data used to save rendered graphs
    @graphData = null
    @codeChunksData = {}

    # files cache for document import
    @filesCache = {}

    # when resize the window, clear the editor
    window.addEventListener 'resize', @resizeEvent.bind(this)

    # right click event
    atom.commands.add @element,
      'markdown-preview-enhanced:open-in-browser': => @openInBrowser()
      'markdown-preview-enhanced:export-to-disk': => @exportToDisk()
      'markdown-preview-enhanced:pandoc-document-export': => @pandocDocumentExport()
      'markdown-preview-enhanced:save-as-markdown': => @saveAsMarkdown()
      'core:copy': => @copyToClipboard()

    # init settings
    @settingsDisposables = new CompositeDisposable()
    @initSettingsEvents()

  @content: ->
    @div class: 'markdown-preview-enhanced native-key-bindings', tabindex: -1, =>
      @p style: 'font-size: 24px', 'loading preview...'

  getTitle: ->
    @getFileName() + ' preview'

  getFileName: ->
    if @editor
      @editor.getFileName()
    else
      'unknown'

  getIconName: ->
    'markdown'

  getURI: ->
    @uri

  getProjectDirectoryPath: ->
    if !@editor
      return ''

    editorPath = @editor.getPath()
    projectDirectories = atom.project.rootDirectories
    for projectDirectory in projectDirectories
      if (projectDirectory.contains(editorPath)) # editor belongs to this project
        return projectDirectory.getPath()

    return ''

  setTabTitle: (title)->
    tabTitle = $('[data-type="MarkdownPreviewEnhancedView"] div.title')
    if tabTitle.length
      tabTitle[0].innerText = title

  updateTabTitle: ->
    @setTabTitle(@getTitle())

  setMermaidTheme: (mermaidTheme)->
    mermaidThemeStyle = fs.readFileSync(path.resolve(__dirname, '../dependencies/mermaid/'+mermaidTheme), {encoding: 'utf-8'}).toString()
    mermaidStyle = document.getElementById('mermaid-style')

    if mermaidStyle
      mermaidStyle.remove()

    mermaidStyle = document.createElement('style')
    mermaidStyle.id = 'mermaid-style'
    document.getElementsByTagName('head')[0].appendChild(mermaidStyle)

    mermaidStyle.innerHTML = mermaidThemeStyle

    # render mermaid graphs again
    # els = @element.getElementsByClassName('mermaid')
    @graphData?.mermaid_s = []
    @renderMarkdown()

  bindEditor: (editor)->
    if not @editor
      atom.workspace
          .open @uri,
                split: 'right',
                activatePane: false,
                searchAllPanes: false
          .then (e)=>
            setTimeout(()=>
              @initEvents(editor)
            , 0)

    else
      # save cache
      CACHE[@editor.getPath()] = {
        html: @element?.innerHTML or '',
        codeChunksData: @codeChunksData,
        graphData: @graphData,
        presentationMode: @presentationMode,
        slideConfigs: @slideConfigs,
        filesCache: @filesCache,
      }

      # @element.innerHTML = '<p style="font-size: 24px;"> loading preview... <br>type something if preview doesn\'t render :( </p>'

      setTimeout(()=>
        @initEvents(editor)
      , 0)

  initEvents: (editor)->
    @editor = editor
    @updateTabTitle()

    if not @parseMD
      {@parseMD, @buildScrollMap, @processFrontMatter} = require './md'
      require '../dependencies/wavedrom/default.js'
      require '../dependencies/wavedrom/wavedrom.min.js'

    @tocConfigs = null
    @scrollMap = null
    @fileDirectoryPath = @editor.getDirectoryPath()
    @projectDirectoryPath = @getProjectDirectoryPath()
    @firstTimeRenderMarkdowon = true
    @filesCache = {}

    if @disposables # remove all binded events
      @disposables.dispose()
    @disposables = new CompositeDisposable()

    @initEditorEvent()
    @initViewEvent()

    # restore preview
    d = CACHE[@editor.getPath()]
    if d
      @element.innerHTML = d.html
      @graphData = d.graphData
      @codeChunksData = d.codeChunksData
      @presentationMode = d.presentationMode
      @slideConfigs = d.slideConfigs
      @filesCache = d.filesCache

      if @presentationMode
        @element.setAttribute 'data-presentation-preview-mode', ''
      else
        @element.removeAttribute 'data-presentation-preview-mode'

      @setInitialScrollPos()
      # console.log 'restore ' + @editor.getPath()

      # reset back to top button onclick event
      @element.getElementsByClassName('back-to-top-btn')?[0]?.onclick = ()=>
        @element.scrollTop = 0

      # reset refresh button onclick event
      @element.getElementsByClassName('refresh-btn')?[0]?.onclick = ()=>
        @filesCache = {}
        codeChunkAPI.clearCache()
        @renderMarkdown()

      # rebind tag a click event
      @bindTagAClickEvent()

      # render plantuml in case
      @renderPlantUML()

      # reset code chunks
      @setupCodeChunks()
    else
      @renderMarkdown()
    @scrollMap = null

  initEditorEvent: ->
    editorElement = @editor.getElement()

    @disposables.add @editor.onDidDestroy ()=>
      @setTabTitle('unknown preview')
      if @disposables
        @disposables.dispose()
        @disposables = null
      @editor = null
      @element.onscroll = null

      @element.innerHTML = '<p style="font-size: 24px;"> Open a markdown file to start preview </p>'

    @disposables.add @editor.onDidStopChanging ()=>
      # @textChanged = true # this line has problem.
      if @liveUpdate
        @updateMarkdown()

    @disposables.add @editor.onDidSave ()=>
      if not @liveUpdate
        @textChanged = true
        @updateMarkdown()

    @disposables.add @editor.onDidChangeModified ()=>
      if not @liveUpdate
        @textChanged = true

    @disposables.add editorElement.onDidChangeScrollTop ()=>
      if !@scrollSync or !@element or @textChanged or !@editor or @presentationMode
        return
      if Date.now() < @editorScrollDelay
        return

      editorHeight = @editor.getElement().getHeight()

      firstVisibleScreenRow = @editor.getFirstVisibleScreenRow()
      lastVisibleScreenRow = firstVisibleScreenRow + Math.floor(editorHeight / @editor.getLineHeightInPixels())

      lineNo = Math.floor((firstVisibleScreenRow + lastVisibleScreenRow) / 2)

      @scrollMap ?= @buildScrollMap(this)

      # disable markdownHtmlView onscroll
      @previewScrollDelay = Date.now() + 500

      # @element.scrollTop = @scrollMap[lineNo] - editorHeight / 2
      if lineNo of @scrollMap then @scrollToPos(@scrollMap[lineNo]-editorHeight / 2)

    # match markdown preview to cursor position
    @disposables.add @editor.onDidChangeCursorPosition (event)=>
      if !@scrollSync or !@element or @textChanged
        return
      if Date.now() < @parseDelay
        return

      # track currnet time to disable onDidChangeScrollTop
      @editorScrollDelay = Date.now() + 500
      # disable preview onscroll
      @previewScrollDelay = Date.now() + 500

      if @presentationMode and @slideConfigs
        return @scrollSyncForPresentation(event.newBufferPosition.row)

      if event.oldScreenPosition.row != event.newScreenPosition.row or event.oldScreenPosition.column == 0
        lineNo = event.newScreenPosition.row
        if lineNo <= 1  # first 2nd rows
          @scrollToPos(0)
          return
        else if lineNo >= @editor.getScreenLineCount() - 2 # last 2nd rows
          @scrollToPos(@element.scrollHeight - 16)
          return

        @scrollSyncToLineNo(lineNo)

  initViewEvent: ->
    @element.onscroll = ()=>
      if !@editor or !@scrollSync or @textChanged or @presentationMode
        return
      if Date.now() < @previewScrollDelay
        return

      top = @element.scrollTop + @element.offsetHeight / 2

      # try to find corresponding screen buffer row
      @scrollMap ?= @buildScrollMap(this)

      i = 0
      j = @scrollMap.length - 1
      count = 0
      screenRow = -1

      while count < 20
        if Math.abs(top - @scrollMap[i]) < 20
          screenRow = i
          break
        else if Math.abs(top - @scrollMap[j]) < 20
          screenRow = j
          break
        else
          mid = Math.floor((i + j) / 2)
          if top > @scrollMap[mid]
            i = mid
          else
            j = mid

        count++

      if screenRow == -1
        screenRow = mid

      @scrollToPos(screenRow * @editor.getLineHeightInPixels() - @element.offsetHeight / 2, @editor.getElement())
      # @editor.getElement().setScrollTop

      # track currnet time to disable onDidChangeScrollTop
      @editorScrollDelay = Date.now() + 500

  initSettingsEvents: ->
    # settings changed
    # github style?
    @settingsDisposables.add atom.config.observe 'markdown-preview-enhanced.useGitHubStyle',
      (useGitHubStyle) =>
        if useGitHubStyle
          @element.setAttribute('data-use-github-style', '')
        else
          @element.removeAttribute('data-use-github-style')

    # github syntax theme
    @settingsDisposables.add atom.config.observe 'markdown-preview-enhanced.useGitHubSyntaxTheme',
      (useGitHubSyntaxTheme)=>
        if useGitHubSyntaxTheme
          @element.setAttribute('data-use-github-syntax-theme', '')
        else
          @element.removeAttribute('data-use-github-syntax-theme')

    # break line?
    @settingsDisposables.add atom.config.observe 'markdown-preview-enhanced.breakOnSingleNewline',
      (breakOnSingleNewline)=>
        @parseDelay = Date.now() # <- fix 'loading preview' stuck bug
        @renderMarkdown()

    # typographer?
    @settingsDisposables.add atom.config.observe 'markdown-preview-enhanced.enableTypographer',
      (enableTypographer)=>
        @renderMarkdown()

    # liveUpdate?
    @settingsDisposables.add atom.config.observe 'markdown-preview-enhanced.liveUpdate',
      (flag) =>
        @liveUpdate = flag
        @scrollMap = null

    # scroll sync?
    @settingsDisposables.add atom.config.observe 'markdown-preview-enhanced.scrollSync',
      (flag) =>
        @scrollSync = flag
        @scrollMap = null

    # scroll duration
    @settingsDisposables.add atom.config.observe 'markdown-preview-enhanced.scrollDuration', (duration)=>
      duration = parseInt(duration) or 0
      if duration < 0
        @scrollDuration = 120
      else
        @scrollDuration = duration

    # math?
    @settingsDisposables.add atom.config.observe 'markdown-preview-enhanced.mathRenderingOption',
      (option) =>
        @mathRenderingOption = option
        @renderMarkdown()

    # mermaid theme
    @settingsDisposables.add atom.config.observe 'markdown-preview-enhanced.mermaidTheme',
      (theme) =>
        @setMermaidTheme theme # hack to solve https://github.com/exupero/saveSvgAsPng/issues/128 problem
        # @element.setAttribute 'data-mermaid-theme', theme

    # render front matter as table?
    @settingsDisposables.add atom.config.observe 'markdown-preview-enhanced.frontMatterRenderingOption', () =>
      @renderMarkdown()

    # show back to top button?
    @settingsDisposables.add atom.config.observe 'markdown-preview-enhanced.showBackToTopButton', (flag)=>
      @showBackToTopButton = flag
      if flag
        @addBackToTopButton()
      else
        document.getElementsByClassName('back-to-top-btn')[0]?.remove()

  scrollSyncForPresentation: (bufferLineNo)->
    i = @slideConfigs.length - 1
    while i >= 0
      if bufferLineNo >= @slideConfigs[i].line
        break
      i-=1
    slideElement = @element.querySelector(".slide[data-offset=\"#{i}\"]")

    return if not slideElement

    # set slide to middle of preview
    @element.scrollTop = -@element.offsetHeight/2 + (slideElement.offsetTop + slideElement.offsetHeight/2)*parseFloat(slideElement.style.zoom)

  # lineNo here is screen buffer row.
  scrollSyncToLineNo: (lineNo)->
    @scrollMap ?= @buildScrollMap(this)

    editorElement = @editor.getElement()

    firstVisibleScreenRow = @editor.getFirstVisibleScreenRow()
    posRatio = (lineNo - firstVisibleScreenRow) / (editorElement.getHeight() / @editor.getLineHeightInPixels())

    scrollTop = @scrollMap[lineNo] - (if posRatio > 1 then 1 else posRatio) * editorElement.getHeight()
    scrollTop = 0 if scrollTop < 0

    @scrollToPos scrollTop

  # smooth scroll @element to scrollTop
  # if editorElement is provided, then editorElement.setScrollTop(scrollTop)
  scrollToPos: (scrollTop, editorElement=null)->
    if @scrollTimeout
      clearTimeout @scrollTimeout
      @scrollTimeout = null

    if not @editor or not @editor.alive or scrollTop < 0
      return

    delay = 10

    helper = (duration=0)=>
      @scrollTimeout = setTimeout =>
        if duration <= 0
          if editorElement
            @editorScrollDelay = Date.now() + 500
            editorElement.setScrollTop scrollTop
          else
            @previewScrollDelay = Date.now() + 500
            @element.scrollTop = scrollTop
          return

        if editorElement
          difference = scrollTop - editorElement.getScrollTop()
        else
          difference = scrollTop - @element.scrollTop

        perTick = difference / duration * delay

        if editorElement
          # disable editor scroll
          @editorScrollDelay = Date.now() + 500

          s = editorElement.getScrollTop() + perTick
          editorElement.setScrollTop s
          return if s == scrollTop
        else
          # disable preview onscroll
          @previewScrollDelay = Date.now() + 500

          @element.scrollTop += perTick
          return if @element.scrollTop == scrollTop

        helper duration-delay
      , delay

    helper(@scrollDuration)

  formatStringBeforeParsing: (str)->
    @mainModule.hook.chain('on-will-parse-markdown', str)

  formatStringAfterParsing: (str)->
    @mainModule.hook.chain('on-did-parse-markdown', str)

  updateMarkdown: ->
    @editorScrollDelay = Date.now() + 500
    @previewScrollDelay = Date.now() + 500

    @renderMarkdown()

  renderMarkdown: ->
    if Date.now() < @parseDelay or !@editor or !@element
      @textChanged = false
      return
    @parseDelay = Date.now() + 200

    {html, slideConfigs, yamlConfig} = @parseMD(@formatStringBeforeParsing(@editor.getText()), {isForPreview: true, markdownPreview: this, @fileDirectoryPath, @projectDirectoryPath})

    html = @formatStringAfterParsing(html)

    if slideConfigs.length
      html = @parseSlides(html, slideConfigs, yamlConfig)
      @element.setAttribute 'data-presentation-preview-mode', ''
      @presentationMode = true
      @slideConfigs = slideConfigs
    else
      @element.removeAttribute 'data-presentation-preview-mode'
      @presentationMode = false

    @element.innerHTML = html
    @graphData = {}
    @bindEvents()

    @mainModule.emitter.emit 'on-did-render-preview', {htmlString: html, previewElement: @element}

    @setInitialScrollPos()
    @addBackToTopButton()
    @addRefreshButton()

    @textChanged = false

  setInitialScrollPos: ->
    if @firstTimeRenderMarkdowon
      @firstTimeRenderMarkdowon = false
      cursor = @editor.cursors[0]
      return if not cursor
      if @presentationMode
        @scrollSyncForPresentation cursor.getBufferRow()
      else
        t = @scrollDuration
        @scrollDuration = 0
        @scrollSyncToLineNo cursor.getScreenRow()
        @scrollDuration = t

  addBackToTopButton: ->
    # TODO: check config

    # add back to top button #222
    if @showBackToTopButton and @element.scrollHeight > @element.offsetHeight
      backToTopBtn = document.createElement('div')
      backToTopBtn.classList.add('back-to-top-btn')
      backToTopBtn.classList.add('btn')
      backToTopBtn.innerHTML = '<span>⬆︎</span>'
      @element.appendChild(backToTopBtn)

      backToTopBtn.onclick = ()=>
        @element.scrollTop = 0

  addRefreshButton: ->
    refreshBtn = document.createElement('div')
    refreshBtn.classList.add('refresh-btn')
    refreshBtn.classList.add('btn')
    refreshBtn.innerHTML = '<span>⟳</span>'
    @element.appendChild(refreshBtn)

    refreshBtn.onclick = ()=>
      # clear cache
      @filesCache = {}
      codeChunkAPI.clearCache()

      # render again
      @renderMarkdown()

  bindEvents: ->
    @bindTagAClickEvent()
    @setupCodeChunks()
    @initTaskList()
    @renderMermaid()
    @renderPlantUML()
    @renderWavedrom()
    @renderViz()
    @renderKaTeX()
    @renderMathJax()
    @scrollMap = null

  # <a href="" > ... </a> click event
  bindTagAClickEvent: ()->
    as = @element.getElementsByTagName('a')

    analyzeHref = (href)=>
      if href and href[0] == '#'
        targetElement = @element.querySelector("[id=\"#{href.slice(1)}\"]") # fix number id bug
        if targetElement
          a.onclick = ()=>
            # jump to tag position
            offsetTop = 0
            el = targetElement
            while el and el != @element
              offsetTop += el.offsetTop
              el = el.offsetParent

            if @element.scrollTop > offsetTop
              @element.scrollTop = offsetTop - 32 - targetElement.offsetHeight
            else
              @element.scrollTop = offsetTop
      else
        a.onclick = ()=>
          return if !href
          return if href.match(/^(http|https)\:\/\//) # the default behavior will open browser for that url.

          if path.extname(href) in ['.pdf', '.xls', '.xlsx', '.doc', '.ppt', '.docx', '.pptx'] # issue #97
            @openFile href
          else if href.match(/^file\:\/\/\//)
            # if href.startsWith 'file:///'
            openFilePath = href.slice(8) # remove protocal
            openFilePath = openFilePath.replace(/\.md(\s*)\#(.+)$/, '.md') # remove #anchor
            atom.workspace.open openFilePath,
              split: 'left',
              searchAllPanes: true
          else
            @openFile href

    for a in as
      href = a.getAttribute('href')
      analyzeHref(href)

  setupCodeChunks: ()->
    codeChunks = @element.getElementsByClassName('code-chunk')
    return if !codeChunks.length

    newCodeChunksData = {}
    needToSetupChunksId = false
    setupCodeChunk = (codeChunk)=>
      dataArgs = codeChunk.getAttribute('data-args')
      idMatch = dataArgs.match(/\s*id\s*:\s*\"([^\"]*)\"/)
      if idMatch and idMatch[1]
        id = idMatch[1]
        codeChunk.id = 'code_chunk_' + id
        running = @codeChunksData[id]?.running or false
        codeChunk.classList.add('running') if running

        # remove output-div and output-element
        children = codeChunk.children
        i = children.length - 1
        while i >= 0
          child = children[i]
          if child.classList.contains('output-div') or child.classList.contains('output-element')
            child.remove()
          i -= 1

        outputDiv = @codeChunksData[id]?.outputDiv
        outputElement = @codeChunksData[id]?.outputElement

        codeChunk.appendChild(outputElement) if outputElement
        codeChunk.appendChild(outputDiv) if outputDiv

        newCodeChunksData[id] = {running, outputDiv, outputElement}
      else # id not exist, create new id
        needToSetupChunksId = true

      runBtn = codeChunk.getElementsByClassName('run-btn')[0]
      runBtn?.addEventListener 'click', ()=>
        @runCodeChunk(codeChunk)

      runAllBtn = codeChunk.getElementsByClassName('run-all-btn')[0]
      runAllBtn?.addEventListener 'click', ()=>
        @runAllCodeChunks()

    for codeChunk in codeChunks
      break if needToSetupChunksId
      setupCodeChunk(codeChunk)

    if needToSetupChunksId
      @setupCodeChunksId()

    @codeChunksData = newCodeChunksData # key is codeChunkId, value is {running, outputDiv}

  setupCodeChunksId: ()->
    buffer = @editor.buffer
    return if !buffer

    lines = buffer.lines
    lineNo = 0
    curScreenPos = @editor.getCursorScreenPosition()

    while lineNo < lines.length
      line = lines[lineNo]
      match = line.match(/^\`\`\`\{(.+)\}(\s*)/)
      if match
        cmd = match[1]
        dataArgs = ''
        i = cmd.indexOf(' ')
        if i > 0
          dataArgs = cmd.slice(i + 1, cmd.length).trim()
          cmd = cmd.slice(0, i)

        idMatch = match[1].match(/\s*id\s*:\s*\"([^\"]*)\"/)
        if !idMatch
          id = (new Date().getTime()).toString(36)

          line = line.trimRight()
          line = line.replace(/}$/, (if !dataArgs then '' else ',') + ' id:"' + id + '"}')

          @parseDelay = Date.now() + 500 # prevent renderMarkdown

          buffer.setTextInRange([[lineNo, 0], [lineNo+1, 0]], line + '\n')

      lineNo += 1

    @editor.setCursorScreenPosition(curScreenPos) # restore cursor position.

      # This will cause Maximum size exceeded
      # @parseDelay = Date.now()
      # @renderMarkdown()

  getNearestCodeChunk: ()->
    bufferRow = @editor.getCursorBufferPosition().row
    codeChunks = @element.getElementsByClassName('code-chunk')
    i = codeChunks.length - 1
    while i >= 0
      codeChunk = codeChunks[i]
      lineNo = parseInt(codeChunk.getAttribute('data-line'))
      if lineNo <= bufferRow
        return codeChunk
      i-=1
    return null

  # return false if meet error
  # otherwise return
  # {
  #   cmd,
  #   options,
  #   code,
  #   id,
  # }
  parseCodeChunk: (codeChunk)->
    code = codeChunk.getAttribute('data-code')
    dataArgs = codeChunk.getAttribute('data-args')

    options = null
    try
      allowUnsafeEval ->
        options = eval("({#{dataArgs}})")
      # options = JSON.parse '{'+dataArgs.replace((/([(\w)|(\-)]+)(:)/g), "\"$1\"$2").replace((/'/g), "\"")+'}'
    catch error
      atom.notifications.addError('Invalid options', detail: dataArgs)
      return false

    id = options.id

    # check options.continue
    if options.continue
      last = null
      if options.continue == true
        codeChunks = @element.getElementsByClassName 'code-chunk'
        i = codeChunks.length - 1
        while i >= 0
          if codeChunks[i] == codeChunk
            last = codeChunks[i - 1]
            break
          i--
      else # id
        last = document.getElementById('code_chunk_' + options.continue)

      if last
        {code: lastCode, options: lastOptions} = @parseCodeChunk(last) or {}
        lastOptions = lastOptions or {}
        code = (lastCode or '') + '\n' + code

        options = Object.assign({}, lastOptions, options)
      else
        atom.notifications.addError('Invalid continue for code chunk ' + (options.id or ''), detail: options.continue.toString())
        return false

    cmd =  options.cmd or codeChunk.getAttribute('data-lang') # need to put here because options might be modified before
    return {cmd, options, code, id}



  runCodeChunk: (codeChunk=null)->
    codeChunk = @getNearestCodeChunk() if not codeChunk
    return if not codeChunk
    return if codeChunk.classList.contains('running')

    parseResult = @parseCodeChunk(codeChunk)
    return if !parseResult
    {code, options, cmd, id} = parseResult

    if !id
      return atom.notifications.addError('Code chunk error', detail: 'id is not found or just updated.')

    codeChunk.classList.add('running')
    if @codeChunksData[id]
      @codeChunksData[id].running = true
    else
      @codeChunksData[id] = {running: true}

    # check options `element`
    if options.element
      outputElement = codeChunk.getElementsByClassName('output-element')?[0]
      if !outputElement # create and append `output-element` div
        outputElement = document.createElement 'div'
        outputElement.classList.add 'output-element'
        codeChunk.appendChild outputElement

      outputElement.innerHTML = options.element
    else
      codeChunk.getElementsByClassName('output-element')?[0]?.remove()
      outputElement = null

    codeChunkAPI.run code, @fileDirectoryPath, cmd, options, (error, data, options)=>
      # get new codeChunk
      codeChunk = document.getElementById('code_chunk_' + id)
      return if not codeChunk
      codeChunk.classList.remove('running')

      return if error # or !data
      data = (data or '').toString()

      outputDiv = codeChunk.getElementsByClassName('output-div')?[0]
      if !outputDiv
        outputDiv = document.createElement 'div'
        outputDiv.classList.add 'output-div'
      else
        outputDiv.innerHTML = ''

      if options.output == 'html'
        outputDiv.innerHTML = data
      else if options.output == 'png'
        imageElement = document.createElement 'img'
        imageData = Buffer(data).toString('base64')
        imageElement.setAttribute 'src',  "data:image/png;charset=utf-8;base64,#{imageData}"
        outputDiv.appendChild imageElement
      else if options.output == 'markdown'
        {html} = @parseMD(data, {@fileDirectoryPath, @projectDirectoryPath})
        outputDiv.innerHTML = html
      else if options.output == 'none'
        outputDiv.remove()
        outputDiv = null
      else
        if data?.length
          preElement = document.createElement 'pre'
          preElement.innerText = data
          preElement.classList.add('editor-colors')
          preElement.classList.add('lang-text')
          outputDiv.appendChild preElement

      if outputDiv
        codeChunk.appendChild outputDiv
        @scrollMap = null

      # check matplotlib | mpl
      if options.matplotlib or options.mpl
        scriptElements = outputDiv.getElementsByTagName('script')
        if scriptElements.length
          window.d3 ?= require('../dependencies/mpld3/d3.v3.min.js')
          window.mpld3 ?= require('../dependencies/mpld3/mpld3.v0.3.min.js')
          for scriptElement in scriptElements
            code = scriptElement.innerHTML
            allowUnsafeNewFunction -> allowUnsafeEval ->
              eval(code)

      @codeChunksData[id] = {running: false, outputDiv, outputElement}

  runAllCodeChunks: ()->
    codeChunks = @element.getElementsByClassName('code-chunk')
    for chunk in codeChunks
      @runCodeChunk(chunk)

  initTaskList: ()->
    checkboxs = @element.getElementsByClassName('task-list-item-checkbox')
    for checkbox in checkboxs
      this_ = this
      checkbox.onclick = ()->
        if !this_.editor
          return

        checked = this.checked
        buffer = this_.editor.buffer

        if !buffer
          return

        lineNo = parseInt(this.parentElement.getAttribute('data-line'))
        line = buffer.lines[lineNo]

        if checked
          line = line.replace('[ ]', '[x]')
        else
          line = line.replace(/\[(x|X)\]/, '[ ]')

        this_.parseDelay = Date.now() + 500

        buffer.setTextInRange([[lineNo, 0], [lineNo+1, 0]], line + '\n')

  renderMermaid: ()->
    els = @element.getElementsByClassName('mermaid mpe-graph')
    if els.length
      @graphData.mermaid_s = Array.prototype.slice.call(els)

      notProcessedEls = @element.querySelectorAll('.mermaid.mpe-graph:not([data-processed])')

      if notProcessedEls.length
        mermaid.init null, notProcessedEls

      ###
      # the code below doesn't seem to be working
      # I think mermaidAPI.render function has bug
      cb = (el)->
        (svgGraph)->
          el.innerHTML = svgGraph
          el.setAttribute 'data-processed', 'true'

          # the code below is a hackable way to solve mermaid bug
          el.firstChild.style.height = el.getAttribute('viewbox').split(' ')[3] + 'px'

      for el in els
        offset = parseInt(el.getAttribute('data-offset'))
        el.id = 'mermaid'+offset

        mermaidAPI.render el.id, el.getAttribute('data-original'), cb(el)
      ###

      # disable @element onscroll
      @previewScrollDelay = Date.now() + 500

  renderWavedrom: ()->
    els = @element.getElementsByClassName('wavedrom mpe-graph')
    if els.length
      @graphData.wavedrom_s = Array.prototype.slice.call(els)

      # WaveDrom.RenderWaveForm(0, WaveDrom.eva('a0'), 'a')
      for el in els
        if el.getAttribute('data-processed') != 'true'
          offset = parseInt(el.getAttribute('data-offset'))
          el.id = 'wavedrom'+offset
          text = el.getAttribute('data-original').trim()
          continue if not text.length

          allowUnsafeEval =>
            try
              content = eval("(#{text})") # eval function here
              WaveDrom.RenderWaveForm(offset, content, 'wavedrom')
              el.setAttribute 'data-processed', 'true'

              @scrollMap = null
            catch error
              el.innerText = 'failed to eval WaveDrom code.'

      # disable @element onscroll
      @previewScrollDelay = Date.now() + 500

  renderPlantUML: ()->
    els = @element.getElementsByClassName('plantuml mpe-graph')

    if els.length
      @graphData.plantuml_s = Array.prototype.slice.call(els)

    helper = (el, text)->
      plantumlAPI.render text, (outputHTML)=>
        el.innerHTML = outputHTML
        el.setAttribute 'data-processed', true
        @scrollMap = null

    for el in els
      if el.getAttribute('data-processed') != 'true'
        helper(el, el.getAttribute('data-original'))
        el.innerText = 'rendering graph...\n'

  renderViz: (element=@element)->
    els = element.getElementsByClassName('viz mpe-graph')

    if els.length
      @graphData.viz_s = Array.prototype.slice.call(els)

      @Viz ?= require('../dependencies/viz/viz.js')
      for el in els
        if el.getAttribute('data-processed') != 'true'
          try
            content = el.getAttribute('data-original')
            options = {}

            # check engine
            content = content.trim().replace /^engine(\s)*[:=]([^\n]+)/, (a, b, c)->
              options.engine = c.trim() if c?.trim() in ['circo', 'dot', 'fdp', 'neato', 'osage', 'twopi']
              return ''

            el.innerHTML = @Viz(content, options) # default svg
            el.setAttribute 'data-processed', true
          catch error
            el.innerHTML = error

  renderMathJax: ()->
    return if @mathRenderingOption != 'MathJax'
    if typeof(MathJax) == 'undefined'
      return loadMathJax document, ()=> @renderMathJax()

    if @mathJaxProcessEnvironments
      return MathJax.Hub.Queue ['Typeset', MathJax.Hub, @element], ()=> @scrollMap = null

    els = @element.getElementsByClassName('mathjax-exps')
    return if !els.length

    unprocessedElements = []
    for el in els
      if !el.hasAttribute('data-processed')
        el.setAttribute 'data-original', el.textContent
        unprocessedElements.push el

    callback = ()=>
      for el in unprocessedElements
        el.setAttribute 'data-processed', true
      @scrollMap = null

    if unprocessedElements.length == els.length
      MathJax.Hub.Queue ['Typeset', MathJax.Hub, @element], callback
    else if unprocessedElements.length
      MathJax.Hub.Typeset unprocessedElements, callback

  renderKaTeX: ()->
    return if @mathRenderingOption != 'KaTeX'
    els = @element.getElementsByClassName('katex-exps')

    for el in els
      if el.hasAttribute('data-processed')
        continue
      else
        displayMode = el.hasAttribute('display-mode')
        dataOriginal = el.textContent
        try
          katex.render(el.textContent, el, {displayMode})
        catch error
          el.innerHTML = "<span style=\"color: #ee7f49; font-weight: 500;\">#{error}</span>"

        el.setAttribute('data-processed', 'true')
        el.setAttribute('data-original', dataOriginal)

  resizeEvent: ()->
    @scrollMap = null

  ###
  convert './a.txt' '/a.txt'
  ###
  resolveFilePath: (filePath='', relative=false)->
    if filePath.match(protocolsWhiteListRegExp)
      return filePath
    else if filePath.startsWith('/')
      if relative
        return path.relative(@fileDirectoryPath, path.resolve(@projectDirectoryPath, '.'+filePath))
      else
        return 'file:///'+path.resolve(@projectDirectoryPath, '.'+filePath)
    else
      if relative
        return filePath
      else
        return 'file:///'+path.resolve(@fileDirectoryPath, filePath)

  ## Utilities
  openInBrowser: (isForPresentationPrint=false)->
    return if not @editor

    htmlContent = @getHTMLContent offline: true, isForPrint: isForPresentationPrint

    temp.open
      prefix: 'markdown-preview-enhanced',
      suffix: '.html', (err, info)=>
        throw err if err

        fs.write info.fd, htmlContent, (err)=>
          throw err if err
          if isForPresentationPrint
            url = 'file:///' + info.path + '?print-pdf'
            atom.notifications.addInfo('Please copy and open the link below in Chrome.\nThen Right Click -> Print -> Save as Pdf.', dismissable: true, detail: url)
          else
            ## open in browser
            @openFile info.path

  exportToDisk: ()->
    @documentExporterView.display(this)

  # open html file in browser or open pdf file in reader ... etc
  openFile: (filePath)->
    if process.platform == 'win32'
      cmd = 'explorer'
    else if process.platform == 'darwin'
      cmd = 'open'
    else
      cmd = 'xdg-open'

    exec "#{cmd} #{filePath}"

  ##
  ## {Function} callback (htmlContent)
  insertCodeChunksResult: (htmlContent)->
    # insert outputDiv and outputElement accordingly
    cheerio ?= require 'cheerio'
    $ = cheerio.load(htmlContent, {decodeEntities: false})
    codeChunks = $('.code-chunk')
    jsCode = ''
    requireCache = {} # key is path
    scriptsStr = ""

    for codeChunk in codeChunks
      $codeChunk = $(codeChunk)
      dataArgs = $codeChunk.attr('data-args').unescape()

      options = null
      try
        allowUnsafeEval ->
          options = eval("({#{dataArgs}})")
      catch e
        continue

      id = options.id
      continue if !id

      cmd = options.cmd or $codeChunk.attr('data-lang')
      code = $codeChunk.attr('data-code').unescape()

      outputDiv = @codeChunksData[id]?.outputDiv
      outputElement = @codeChunksData[id]?.outputElement

      if outputDiv # append outputDiv result
        $codeChunk.append("<div class=\"output-div\">#{outputDiv.innerHTML}</div>")
        if options.matplotlib or options.mpl
          # remove innerHTML of <div id="fig_..."></div>
          # this is for fixing mpld3 exporting issue.
          gs = $('.output-div > div', $codeChunk)
          if gs
            for g in gs
              $g = $(g)
              if $g.attr('id')?.match(/fig\_/)
                $g.html('')

          ss = $('.output-div > script', $codeChunk)
          if ss
            for s in ss
              $s = $(s)
              c = $s.html()
              $s.remove()
              jsCode += (c + '\n')

      if options.element
        $codeChunk.append("<div class=\"output-element\">#{options.element}</div>")

      if cmd == 'javascript'
        requires = options.require or []
        if typeof(requires) == 'string'
          requires = [requires]
        requiresStr = ""
        for requirePath in requires
          # TODO: css
          if requirePath.match(/^(http|https)\:\/\//)
            if (!requireCache[requirePath])
              requireCache[requirePath] = true
              scriptsStr += "<script src=\"#{requirePath}\"></script>\n"
          else
            requirePath = path.resolve(@fileDirectoryPath, requirePath)
            if !requireCache[requirePath]
              requiresStr += (fs.readFileSync(requirePath, {encoding: 'utf-8'}) + '\n')
              requireCache[requirePath] = true

        jsCode += (requiresStr + code + '\n')

    html = $.html()
    html += "#{scriptsStr}\n" if scriptsStr
    html += "<script data-js-code>#{jsCode}</script>" if jsCode
    return html

  ##
  # {Function} callback (htmlContent)
  getHTMLContent: ({isForPrint, offline, useRelativeImagePath, phantomjsType}, callback)->
    isForPrint ?= false
    offline ?= false
    useRelativeImagePath ?= false
    phantomjsType ?= false # pdf | png | jpeg | false
    return if not @editor

    useGitHubStyle = atom.config.get('markdown-preview-enhanced.useGitHubStyle')
    useGitHubSyntaxTheme = atom.config.get('markdown-preview-enhanced.useGitHubSyntaxTheme')
    mathRenderingOption = atom.config.get('markdown-preview-enhanced.mathRenderingOption')

    res = @parseMD(@formatStringBeforeParsing(@editor.getText()), {useRelativeImagePath, @fileDirectoryPath, @projectDirectoryPath, markdownPreview: this, hideFrontMatter: true})
    htmlContent = @formatStringAfterParsing(res.html)
    slideConfigs = res.slideConfigs
    yamlConfig = res.yamlConfig or {}


    # replace code chunks inside htmlContent
    htmlContent = @insertCodeChunksResult htmlContent

    # as for example black color background doesn't produce nice pdf
    # therefore, I decide to print only github style...
    if isForPrint
      useGitHubStyle = atom.config.get('markdown-preview-enhanced.pdfUseGithub')

    if mathRenderingOption == 'KaTeX'
      if offline
        mathStyle = "<link rel=\"stylesheet\"
              href=\"file:///#{path.resolve(__dirname, '../node_modules/katex/dist/katex.min.css')}\">"
      else
        mathStyle = "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.7.1/katex.min.css\">"
    else if mathRenderingOption == 'MathJax'
      inline = atom.config.get('markdown-preview-enhanced.indicatorForMathRenderingInline')
      block = atom.config.get('markdown-preview-enhanced.indicatorForMathRenderingBlock')
      mathJaxProcessEnvironments = atom.config.get('markdown-preview-enhanced.mathJaxProcessEnvironments')
      if offline
        mathStyle = "
        <script type=\"text/x-mathjax-config\">
          MathJax.Hub.Config({
            messageStyle: 'none',
            tex2jax: {inlineMath: #{inline},
                      displayMath: #{block},
                      processEnvironments: #{mathJaxProcessEnvironments},
                      processEscapes: true}
          });
        </script>
        <script type=\"text/javascript\" async src=\"file://#{path.resolve(__dirname, '../dependencies/mathjax/MathJax.js?config=TeX-AMS_CHTML')}\"></script>
        "
      else
        # inlineMath: [ ['$','$'], ["\\(","\\)"] ],
        # displayMath: [ ['$$','$$'], ["\\[","\\]"] ]
        mathStyle = "
        <script type=\"text/x-mathjax-config\">
          MathJax.Hub.Config({
            messageStyle: 'none',
            tex2jax: {inlineMath: #{inline},
                      displayMath: #{block},
                      processEnvironments: #{mathJaxProcessEnvironments},
                      processEscapes: true}
          });
        </script>
        <script type=\"text/javascript\" async src=\"https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML\"></script>
        "
    else
      mathStyle = ''

    # presentation
    if slideConfigs.length
      htmlContent = @parseSlidesForExport(htmlContent, slideConfigs, useRelativeImagePath)
      if offline
        presentationScript = "
        <script src='file:///#{path.resolve(__dirname, '../dependencies/reveal/lib/js/head.min.js')}'></script>
        <script src='file:///#{path.resolve(__dirname, '../dependencies/reveal/js/reveal.js')}'></script>"
      else
        presentationScript = "
        <script src='https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.4.1/lib/js/head.min.js'></script>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.4.1/js/reveal.min.js'></script>"

      presentationConfig = yamlConfig['presentation'] or {}
      dependencies = presentationConfig.dependencies or []
      if presentationConfig.enableSpeakerNotes
        if offline
          dependencies.push {src: path.resolve(__dirname, '../dependencies/reveal/plugin/notes/notes.js'), async: true}
        else
          dependencies.push {src: 'revealjs_deps/notes.js', async: true} # TODO: copy notes.js file to corresponding folder
      presentationConfig.dependencies = dependencies

      #       <link rel=\"stylesheet\" href='file:///#{path.resolve(__dirname, '../dependencies/reveal/reveal.css')}'>
      presentationStyle = """

      <style>
      #{fs.readFileSync(path.resolve(__dirname, '../dependencies/reveal/reveal.css'))}

      #{if isForPrint then fs.readFileSync(path.resolve(__dirname, '../dependencies/reveal/pdf.css')) else ''}
      </style>
      """
      presentationInitScript = """
      <script>
        Reveal.initialize(#{JSON.stringify(Object.assign({margin: 0.1}, presentationConfig))})
      </script>
      """
    else
      presentationScript = ''
      presentationStyle = ''
      presentationInitScript = ''

    # phantomjs
    phantomjsClass = ""
    if phantomjsType
      if phantomjsType == '.pdf'
        phantomjsClass = 'phantomjs-pdf'
      else if phantomjsType == '.png' or phantomjsType == '.jpeg'
        phantomjsClass = 'phantomjs-image'

    title = @getFileName()
    title = title.slice(0, title.length - path.extname(title).length) # remove '.md'
    htmlContent = "
  <!DOCTYPE html>
  <html>
    <head>
      <title>#{title}</title>
      <meta charset=\"utf-8\">
      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">

      #{presentationStyle}

      <style>
      #{getMarkdownPreviewCSS()}
      </style>

      #{mathStyle}

      #{presentationScript}
    </head>
    <body class=\"markdown-preview-enhanced #{phantomjsClass}\"
        #{if useGitHubStyle then 'data-use-github-style' else ''}
        #{if useGitHubSyntaxTheme then 'data-use-github-syntax-theme' else ''}
        #{if @presentationMode then 'data-presentation-mode' else ''}>

    #{htmlContent}

    </body>
    #{presentationInitScript}
  </html>
    "

  # api doc [printToPDF] function
  # https://github.com/atom/electron/blob/master/docs/api/web-contents.md
  printPDF: (htmlPath, dest)->
    return if not @editor

    {BrowserWindow} = require('electron').remote
    win = new BrowserWindow show: false
    win.loadURL htmlPath

    # get margins type
    marginsType = atom.config.get('markdown-preview-enhanced.marginsType')
    marginsType = if marginsType == 'default margin' then 0 else
                  if marginsType == 'no margin' then 1 else 2


    # get orientation
    landscape = atom.config.get('markdown-preview-enhanced.orientation') == 'landscape'

    lastIndexOfSlash = dest.lastIndexOf '/' or 0
    pdfName = dest.slice(lastIndexOfSlash + 1)

    win.webContents.on 'did-finish-load', ()=>
      setTimeout(()=>
        win.webContents.printToPDF
          pageSize: atom.config.get('markdown-preview-enhanced.exportPDFPageFormat'),
          landscape: landscape,
          printBackground: atom.config.get('markdown-preview-enhanced.printBackground'),
          marginsType: marginsType, (err, data)=>
            throw err if err

            destFile = new File(dest)
            destFile.create().then (flag)=>
              destFile.write data
              atom.notifications.addInfo "File #{pdfName} was created", detail: "path: #{dest}"
              # open pdf
              if atom.config.get('markdown-preview-enhanced.pdfOpenAutomatically')
                @openFile dest
      , 500)

  saveAsPDF: (dest)->
    return if not @editor

    if @presentationMode # for presentation, need to print from chrome
      @openInBrowser(true)
      return

    htmlContent = @getHTMLContent isForPrint: true, offline: true
    temp.open
      prefix: 'markdown-preview-enhanced',
      suffix: '.html', (err, info)=>
        throw err if err
        fs.write info.fd, htmlContent, (err)=>
          throw err if err
          @printPDF "file://#{info.path}", dest

  saveAsHTML: (dest, offline=true, useRelativeImagePath)->
    return if not @editor

    htmlContent = @getHTMLContent isForPrint: false, offline: offline, useRelativeImagePath: useRelativeImagePath

    htmlFileName = path.basename(dest)

    # presentation speaker notes
    # copy dependency files
    if !offline and htmlContent.indexOf('[{"src":"revealjs_deps/notes.js","async":true}]') >= 0
      depsDirName = path.resolve(path.dirname(dest), 'revealjs_deps')
      depsDir = new Directory(depsDirName)
      depsDir.create().then (flag)->
        true
        fs.createReadStream(path.resolve(__dirname, '../dependencies/reveal/plugin/notes/notes.js')).pipe(fs.createWriteStream(path.resolve(depsDirName, 'notes.js')))
        fs.createReadStream(path.resolve(__dirname, '../dependencies/reveal/plugin/notes/notes.html')).pipe(fs.createWriteStream(path.resolve(depsDirName, 'notes.html')))

    destFile = new File(dest)
    destFile.create().then (flag)->
      destFile.write htmlContent
      atom.notifications.addInfo("File #{htmlFileName} was created", detail: "path: #{dest}")

  ####################################################
  ## Presentation
  ##################################################
  parseSlides: (html, slideConfigs, yamlConfig)->
    slides = html.split '<div class="new-slide"></div>'
    slides = slides.slice(1)
    output = ''

    offset = 0
    width = 960
    height = 700

    if yamlConfig and yamlConfig['presentation']
      presentationConfig = yamlConfig['presentation']
      width = presentationConfig['width'] or 960
      height = presentationConfig['height'] or 700

    ratio = height / width * 100 + '%'
    zoom = (@element.offsetWidth - 128)/width ## 64 is 2*padding

    for slide in slides
      # slide = slide.trim()
      # if slide.length
      slideConfig = slideConfigs[offset]
      styleString = ''
      videoString = ''
      iframeString = ''
      if slideConfig['data-background-image']
        styleString += "background-image: url('#{@resolveFilePath(slideConfig['data-background-image'])}');"

        if slideConfig['data-background-size']
          styleString += "background-size: #{slideConfig['data-background-size']};"
        else
          styleString += "background-size: cover;"

        if slideConfig['data-background-position']
          styleString += "background-position: #{slideConfig['data-background-position']};"
        else
          styleString += "background-position: center;"

        if slideConfig['data-background-repeat']
          styleString += "background-repeat: #{slideConfig['data-background-repeat']};"
        else
          styleString += "background-repeat: no-repeat;"

      else if slideConfig['data-background-color']
        styleString += "background-color: #{slideConfig['data-background-color']} !important;"

      else if slideConfig['data-background-video']
        videoMuted = slideConfig['data-background-video-muted']
        videoLoop = slideConfig['data-background-video-loop']

        muted_ = if videoMuted then 'muted' else ''
        loop_ = if videoLoop then 'loop' else ''

        videoString = """
        <video #{muted_} #{loop_} playsinline autoplay class=\"background-video\" src=\"#{@resolveFilePath(slideConfig['data-background-video'])}\">
        </video>
        """
        #           <source src=\"#{slideConfig['data-background-video']}\">

      else if slideConfig['data-background-iframe']
        iframeString = """
        <iframe class=\"background-iframe\" src=\"#{@resolveFilePath(slideConfig['data-background-iframe'])}\" frameborder="0" > </iframe>
        <div class=\"background-iframe-overlay\"></div>
        """

      output += """
        <div class='slide' data-offset='#{offset}' style="width: #{width}px; height: #{height}px; zoom: #{zoom}; #{styleString}">
          #{videoString}
          #{iframeString}
          <section>#{slide}</section>
        </div>
      """
      offset += 1

    # remove <aside class="notes"> ... </aside>
    output = output.replace(/(<aside\b[^>]*>)[^<>]*(<\/aside>)/ig, '')

    """
    <div class="preview-slides">
      #{output}
    </div>
    """

  parseSlidesForExport: (html, slideConfigs, useRelativeImagePath)->
    slides = html.split '<div class="new-slide"></div>'
    slides = slides.slice(1)
    output = ''

    parseAttrString = (slideConfig)=>
      attrString = ''
      if slideConfig['data-background-image']
        attrString += " data-background-image='#{@resolveFilePath(slideConfig['data-background-image'], useRelativeImagePath)}'"

      if slideConfig['data-background-size']
        attrString += " data-background-size='#{slideConfig['data-background-size']}'"

      if slideConfig['data-background-position']
        attrString += " data-background-position='#{slideConfig['data-background-position']}'"

      if slideConfig['data-background-repeat']
        attrString += " data-background-repeat='#{slideConfig['data-background-repeat']}'"

      if slideConfig['data-background-color']
        attrString += " data-background-color='#{slideConfig['data-background-color']}'"

      if slideConfig['data-notes']
        attrString += " data-notes='#{slideConfig['data-notes']}'"

      if slideConfig['data-background-video']
        attrString += " data-background-video='#{@resolveFilePath(slideConfig['data-background-video'], useRelativeImagePath)}'"

      if slideConfig['data-background-video-loop']
        attrString += " data-background-video-loop"

      if slideConfig['data-background-video-muted']
        attrString += " data-background-video-muted"

      if slideConfig['data-transition']
        attrString += " data-transition='#{slideConfig['data-transition']}'"

      if slideConfig['data-background-iframe']
        attrString += " data-background-iframe='#{@resolveFilePath(slideConfig['data-background-iframe'], useRelativeImagePath)}'"
      attrString

    i = 0
    while i < slides.length
      slide = slides[i]
      slideConfig = slideConfigs[i]
      attrString = parseAttrString(slideConfig)

      if !slideConfig['vertical']
        if i > 0 and slideConfigs[i-1]['vertical'] # end of vertical slides
          output += '</section>'
        if i < slides.length - 1 and slideConfigs[i+1]['vertical'] # start of vertical slides
          output += "<section>"

      output += "<section #{attrString}>#{slide}</section>"
      i += 1

    if i > 0 and slideConfigs[i-1]['vertical'] # end of vertical slides
      output += "</section>"

    """
    <div class="reveal">
      <div class="slides">
        #{output}
      </div>
    </div>
    """

  ####################################################
  ## PhantomJS
  ##################################################
  loadPhantomJSHeaderFooterConfig: ()->
    # mermaid_config.js
    configPath = path.resolve(atom.config.configDirPath, './markdown-preview-enhanced/phantomjs_header_footer_config.js')
    try
      delete require.cache[require.resolve(configPath)] # return uncached
      return require(configPath) or {}
    catch error
      configFile = new File(configPath)
      configFile.create().then (flag)->
        if !flag # already exists
          atom.notifications.addError('Failed to load phantomjs_header_footer_config.js', detail: 'there might be errors in your config file')
          return

        configFile.write """
'use strict'
/*
configure header and footer (and other options)
more information can be found here:
    https://github.com/marcbachmann/node-html-pdf
Attention: this config will override your config in exporter panel.

eg:

  let config = {
    "header": {
      "height": "45mm",
      "contents": '<div style="text-align: center;">Author: Marc Bachmann</div>'
    },
    "footer": {
      "height": "28mm",
      "contents": '<span style="color: #444;">{{page}}</span>/<span>{{pages}}</span>'
    }
  }
*/
// you can edit the 'config' variable below
let config = {
}

module.exports = config || {}
"""
      return {}

  phantomJSExport: (dest)->
    return if not @editor

    if @presentationMode # for presentation, need to print from chrome
      @openInBrowser(true)
      return

    htmlContent = @getHTMLContent isForPrint: true, offline: true, phantomjsType: path.extname(dest)

    fileType = atom.config.get('markdown-preview-enhanced.phantomJSExportFileType')
    format = atom.config.get('markdown-preview-enhanced.exportPDFPageFormat')
    orientation = atom.config.get('markdown-preview-enhanced.orientation')
    margin = atom.config.get('markdown-preview-enhanced.phantomJSMargin').trim()

    if !margin.length
      margin = '1cm'
    else
      margin = margin.split(',').map (m)->m.trim()
      if margin.length == 1
        margin = margin[0]
      else if margin.length == 2
        margin = {'top': margin[0], 'bottom': margin[0], 'left': margin[1], 'right': margin[1]}
      else if margin.length == 4
        margin = {'top': margin[0], 'right': margin[1], 'bottom': margin[2], 'left': margin[3]}
      else
        margin = '1cm'

    # get header and footer
    config = @loadPhantomJSHeaderFooterConfig()

    pdf
      .create htmlContent, Object.assign({type: fileType, format: format, orientation: orientation, border: margin, quality: '75', timeout: 60000, script: path.join(__dirname, '../dependencies/phantomjs/pdf_a4_portrait.js')}, config)
      .toFile dest, (err, res)=>
        if err
          atom.notifications.addError err
        # open pdf
        else
          lastIndexOfSlash = dest.lastIndexOf '/' or 0
          fileName = dest.slice(lastIndexOfSlash + 1)

          atom.notifications.addInfo "File #{fileName} was created", detail: "path: #{dest}"
          if atom.config.get('markdown-preview-enhanced.pdfOpenAutomatically')
            @openFile dest

  ## EBOOK
  generateEbook: (dest)->
    {html, yamlConfig} = @parseMD(@formatStringBeforeParsing(@editor.getText()), {isForEbook: true, @fileDirectoryPath, @projectDirectoryPath, hideFrontMatter:true})
    html = @formatStringAfterParsing(html)

    ebookConfig = null
    if yamlConfig
      ebookConfig = yamlConfig['ebook']

    if !ebookConfig
      return atom.notifications.addError('ebook config not found', detail: 'please insert ebook front-matter to your markdown file')
    else
      atom.notifications.addInfo('Your document is being prepared', detail: ':)')

      if ebookConfig.cover # change cover to absolute path if necessary
        cover = ebookConfig.cover
        if cover.startsWith('./') or cover.startsWith('../')
          cover = path.resolve(@fileDirectoryPath, cover)
          ebookConfig.cover = cover
        else if cover.startsWith('/')
          cover = path.resolve(@projectDirectoryPath, '.'+cover)
          ebookConfig.cover = cover

      div = document.createElement('div')
      div.innerHTML = html

      structure = [] # {level:0, filePath: 'path to file', heading: '', id: ''}
      headingOffset = 0

      # load the last ul, analyze toc links.
      getStructure = (ul, level)->
        for li in ul.children
          a = li.children[0]?.getElementsByTagName('a')?[0]
          continue if not a
          filePath = a.getAttribute('href') # assume markdown file path
          heading = a.innerHTML
          id = 'ebook-heading-id-'+headingOffset

          structure.push {level: level, filePath: filePath, heading: heading, id: id}
          headingOffset += 1

          a.href = '#'+id # change id

          if li.childElementCount > 1
            getStructure(li.children[1], level+1)

      children = div.children
      i = children.length - 1
      while i >= 0
        if children[i].tagName == 'UL' # find table of contents
          getStructure(children[i], 0)
          break
        i -= 1

      outputHTML = div.innerHTML

      # append files according to structure
      for obj in structure
        heading = obj.heading
        id = obj.id
        level = obj.level
        filePath = obj.filePath

        if filePath.startsWith('file:///')
          filePath = filePath.slice(8)

        try
          text = fs.readFileSync(filePath, {encoding: 'utf-8'})
          {html} = @parseMD @formatStringBeforeParsing(text), {isForEbook: true, projectDirectoryPath: @projectDirectoryPath, fileDirectoryPath: path.dirname(filePath)}
          html = @formatStringAfterParsing(html)

          # add to TOC
          div.innerHTML = html
          if div.childElementCount
            div.children[0].id = id
            div.children[0].setAttribute('ebook-toc-level-'+(level+1), '')
            div.children[0].setAttribute('heading', heading)

          outputHTML += div.innerHTML
        catch error
          atom.notifications.addError('Ebook generation: Failed to load file', detail: filePath + '\n ' + error)
          return

      # render viz
      div.innerHTML = outputHTML
      @renderViz(div)

      # download images for .epub and .mobi
      imagesToDownload = []
      if path.extname(dest) in ['.epub', '.mobi']
        for img in div.getElementsByTagName('img')
          src = img.getAttribute('src')
          if src.startsWith('http://') or src.startsWith('https://')
            imagesToDownload.push(img)

      request = require('request')
      async = require('async')

      if imagesToDownload.length
        atom.notifications.addInfo('downloading images...')

      asyncFunctions = imagesToDownload.map (img)=>
        (callback)=>
          httpSrc = img.getAttribute('src')
          savePath = Math.random().toString(36).substr(2, 9) + '_' + path.basename(httpSrc)
          savePath =  path.resolve(@fileDirectoryPath, savePath)

          stream = request(httpSrc).pipe(fs.createWriteStream(savePath))

          stream.on 'finish', ()->
            img.setAttribute 'src', 'file:///'+savePath
            callback(null, savePath)


      async.parallel asyncFunctions, (error, downloadedImagePaths=[])=>
        # convert image to base64 if output html
        if path.extname(dest) == '.html'
          # check cover
          if ebookConfig.cover
            cover = if ebookConfig.cover[0] == '/' then 'file:///' + ebookConfig.cover else ebookConfig.cover
            coverImg = document.createElement('img')
            coverImg.setAttribute('src', cover)
            div.insertBefore(coverImg, div.firstChild)

          imageElements = div.getElementsByTagName('img')
          for img in imageElements
            src = img.getAttribute('src')
            if src.startsWith('file:///')
              src = src.slice(8)
              imageType = path.extname(src).slice(1)
              try
                base64 = new Buffer(fs.readFileSync(src)).toString('base64')

                img.setAttribute('src', "data:image/#{imageType};charset=utf-8;base64,#{base64}")
              catch error
                throw 'Image file not found: ' + src

        # retrieve html
        outputHTML = div.innerHTML

        useGitHubSyntaxTheme = atom.config.get('markdown-preview-enhanced.useGitHubSyntaxTheme')

        title = ebookConfig.title or 'no title'

        mathStyle = ''
        if outputHTML.indexOf('class="katex"') > 0
          if path.extname(dest) == '.html' and ebookConfig.html?.cdn
            mathStyle = "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.7.1/katex.min.css\">"
          else
            mathStyle = "<link rel=\"stylesheet\" href=\"file:///#{path.resolve(__dirname, '../node_modules/katex/dist/katex.min.css')}\">"

        outputHTML = """
    <!DOCTYPE html>
    <html>
      <head>
        <title>#{title}</title>
        <meta charset=\"utf-8\">
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">

        <style>
        #{getMarkdownPreviewCSS()}
        </style>

        #{mathStyle}
      </head>
      <body class=\"markdown-preview-enhanced\" data-use-github-style
          #{if useGitHubSyntaxTheme then 'data-use-github-syntax-theme' else ''}>

      #{outputHTML}

      </body>
    </html>
        """

        fileName = path.basename(dest)

        # save as html
        if path.extname(dest) == '.html'
          fs.writeFile dest, outputHTML, (err)=>
            throw err if err
            atom.notifications.addInfo("File #{fileName} was created", detail: "path: #{dest}")
          return

        # this func will be called later
        deleteDownloadedImages = ()->
          downloadedImagePaths.forEach (imagePath)->
            fs.unlink(imagePath)

        # use ebook-convert to generate ePub, mobi, PDF.
        temp.open
          prefix: 'markdown-preview-enhanced',
          suffix: '.html', (err, info)=>
            if err
              deleteDownloadedImages()
              throw err

            fs.write info.fd, outputHTML, (err)=>
              if err
                deleteDownloadedImages()
                throw err

              ebookConvert info.path, dest, ebookConfig, (err)=>
                deleteDownloadedImages()
                throw err if err
                atom.notifications.addInfo "File #{fileName} was created", detail: "path: #{dest}"

  pandocDocumentExport: ->
    {data} = @processFrontMatter(@editor.getText())

    content = @editor.getText().trim()
    if content.startsWith('---\n')
      end = content.indexOf('---\n', 4)
      content = content.slice(end+4)

    pandocConvert content, {@fileDirectoryPath, @projectDirectoryPath, sourceFilePath: @editor.getPath()}, data, (err, outputFilePath)->
      if err
        return atom.notifications.addError 'pandoc error', detail: err
      atom.notifications.addInfo "File #{path.basename(outputFilePath)} was created", detail: "path: #{outputFilePath}"

  saveAsMarkdown: ()->
    {data} = @processFrontMatter(@editor.getText())
    data = data or {}

    content = @editor.getText().trim()
    if content.startsWith('---\n')
      end = content.indexOf('---\n', 4)
      content = content.slice(end+4)

    config = data.markdown or {}
    if !config.image_dir
      config.image_dir = atom.config.get('markdown-preview-enhanced.imageFolderPath')

    if !config.path
      config.path = path.basename(@editor.getPath()).replace(/\.md$/, '_.md')

    if config.front_matter
      content = matter.stringify(content, config.front_matter)

    markdownConvert content, {@projectDirectoryPath, @fileDirectoryPath}, config

  copyToClipboard: ->
    return false if not @editor

    selection = window.getSelection()
    selectedText = selection.toString()

    atom.clipboard.write(selectedText)
    true

  # Tear down any state and detach
  destroy: ->
    @element.remove()
    @editor = null

    if @disposables
      @disposables.dispose()
      @disposables = null

    if @settingsDisposables
      @settingsDisposables.dispose()
      @settingsDisposables = null

    # clear CACHE
    for key of CACHE
      delete(CACHE[key])

    @mainModule.preview = null # unbind

  getElement: ->
    @element
