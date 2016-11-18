{Emitter, CompositeDisposable, File} = require 'atom'
{$, $$$, ScrollView}  = require 'atom-space-pen-views'
path = require 'path'
fs = require 'fs'
temp = require('temp').track()
{exec} = require 'child_process'
pdf = require 'html-pdf'
katex = require 'katex'

{getMarkdownPreviewCSS} = require './style'
plantumlAPI = require './puml'
ebookConvert = require './ebook-convert'
{loadMathJax} = require './mathjax-wrapper'
pandocConvert = require './pandoc-wrapper'
codeChunkAPI = require './code-chunk'

codeChunksDataCache = {} # key is @editor.getFilePath(), value is @codeChunksData

module.exports =
class MarkdownPreviewEnhancedView extends ScrollView
  constructor: (uri, mainModule)->
    super

    @uri = uri
    @mainModule = mainModule
    @protocal = 'markdown-preview-enhanced://'
    @editor = null

    @headings = []
    @scrollMap = null
    @rootDirectoryPath = null
    @projectDirectoryPath = null

    @disposables = null

    @liveUpdate = true
    @scrollSync = true
    @scrollDuration = null

    @mathRenderingOption = atom.config.get('markdown-preview-enhanced.mathRenderingOption')
    @mathRenderingOption = if @mathRenderingOption == 'None' then null else @mathRenderingOption

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

    # when resize the window, clear the editor
    window.addEventListener 'resize', @resizeEvent.bind(this)

    # right click event
    atom.commands.add @element,
      'markdown-preview-enhanced:open-in-browser': => @openInBrowser()
      'markdown-preview-enhanced:export-to-disk': => @exportToDisk()
      'markdown-preview-enhanced:pandoc-document-export': => @pandocDocumentExport()
      'core:copy': => @copyToClipboard()

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
      @element.innerHTML = '<p style="font-size: 24px;"> loading preview... </p>'

      # save codeChunksDataCache
      codeChunksDataCache[@editor.getPath()] = @codeChunksData || {}

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

    @headings = []
    @scrollMap = null
    @rootDirectoryPath = @editor.getDirectoryPath()
    @projectDirectoryPath = @getProjectDirectoryPath()
    @firstTimeRenderMarkdowon = true

    if @disposables # remove all binded events
      @disposables.dispose()
    @disposables = new CompositeDisposable()

    # restore codeChunksData if already in cache
    if codeChunksDataCache[@editor.getPath()]
      @codeChunksData = codeChunksDataCache[@editor.getPath()]

    @initEditorEvent()
    @initViewEvent()
    @initSettingsEvents()

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
      if @liveUpdate
        @updateMarkdown()

    @disposables.add @editor.onDidSave ()=>
      if not @liveUpdate
        @updateMarkdown()

    @disposables.add editorElement.onDidChangeScrollTop ()=>
      if !@scrollSync or !@element or !@liveUpdate or !@editor or @presentationMode
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
      @scrollToPos(@scrollMap[lineNo]-editorHeight / 2)

    # match markdown preview to cursor position
    @disposables.add @editor.onDidChangeCursorPosition (event)=>
      if !@scrollSync or !@element or !@liveUpdate
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
      if !@editor or !@scrollSync or !@liveUpdate or @presentationMode
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
    @disposables.add atom.config.observe 'markdown-preview-enhanced.useGitHubStyle',
      (useGitHubStyle) =>
        if useGitHubStyle
          @element.setAttribute('data-use-github-style', '')
        else
          @element.removeAttribute('data-use-github-style')

    # github syntax theme
    @disposables.add atom.config.observe 'markdown-preview-enhanced.useGitHubSyntaxTheme',
      (useGitHubSyntaxTheme)=>
        if useGitHubSyntaxTheme
          @element.setAttribute('data-use-github-syntax-theme', '')
        else
          @element.removeAttribute('data-use-github-syntax-theme')

    # break line?
    @disposables.add atom.config.observe 'markdown-preview-enhanced.breakOnSingleNewline',
      (breakOnSingleNewline)=>
        @parseDelay = Date.now() # <- fix 'loading preview' stuck bug
        @renderMarkdown()

    # typographer?
    @disposables.add atom.config.observe 'markdown-preview-enhanced.enableTypographer',
      (enableTypographer)=>
        @renderMarkdown()

    # liveUpdate?
    @disposables.add atom.config.observe 'markdown-preview-enhanced.liveUpdate',
      (flag) => @liveUpdate = flag

    # scroll sync?
    @disposables.add atom.config.observe 'markdown-preview-enhanced.scrollSync',
      (flag) =>
        @scrollSync = flag
        @scrollMap = null

    # scroll duration
    @disposables.add atom.config.observe 'markdown-preview-enhanced.scrollDuration', (duration)=>
      duration = parseInt(duration) or 0
      if duration < 0
        @scrollDuration = 120
      else
        @scrollDuration = duration

    # math?
    @disposables.add atom.config.observe 'markdown-preview-enhanced.mathRenderingOption',
      (option) =>
        @mathRenderingOption = option
        @renderMarkdown()

    # mermaid theme
    @disposables.add atom.config.observe 'markdown-preview-enhanced.mermaidTheme',
      (theme) =>
        @element.setAttribute 'data-mermaid-theme', theme

    # render front matter as table?
    @disposables.add atom.config.observe 'markdown-preview-enhanced.frontMatterRenderingOption', (theme) =>
      @renderMarkdown()

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
      return
    @parseDelay = Date.now() + 200

    {html, slideConfigs, yamlConfig} = @parseMD(@formatStringBeforeParsing(@editor.getText()), {isForPreview: true, markdownPreview: this, @rootDirectoryPath, @projectDirectoryPath})

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
          # open md and markdown preview
          if href and not (href.startsWith('https://') or href.startsWith('http://'))
            if path.extname(href) in ['.pdf', '.xls', '.xlsx', '.doc', '.ppt', '.docx', '.pptx'] # issue #97
              @openFile href
            else
              if href.startsWith 'file:///'
                href = href.slice(8) # remove protocal
              atom.workspace.open href,
                split: 'left',
                searchAllPanes: true

    for a in as
      href = a.getAttribute('href')
      analyzeHref(href)

  setupCodeChunks: ()->
    codeChunks = @element.getElementsByClassName('code-chunk')
    return if !codeChunks.length

    newCodeChunksData = {}
    setupCodeChunk = (codeChunk)=>
      dataArgs = codeChunk.getAttribute('data-args')
      idMatch = dataArgs.match(/\s*id\s*:\s*\"([^\"]*)\"/)
      if idMatch and idMatch[1]
        id = idMatch[1]
        codeChunk.id = 'code_chunk_' + id
        running = @codeChunksData[id]?.running or false
        codeChunk.classList.add('running') if running
        newCodeChunksData[id] = {running, outputDiv: codeChunk.getElementsByClassName('output-div')[0]}

      runBtn = codeChunk.getElementsByClassName('run-btn')[0]
      runBtn?.addEventListener 'click', ()=>
        @runCodeChunk(codeChunk)

      runAllBtn = codeChunk.getElementsByClassName('run-all-btn')[0]
      runAllBtn?.addEventListener 'click', ()=>
        @runAllCodeChunks()

    for codeChunk in codeChunks
      setupCodeChunk(codeChunk)

    @codeChunksData = newCodeChunksData # key is codeChunkId, value is {running, outputDiv}

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

  runCodeChunk: (codeChunk=null)->
    codeChunk = @getNearestCodeChunk() if not codeChunk
    return if not codeChunk
    return if codeChunk.classList.contains('running')

    code = codeChunk.getAttribute('data-code')
    dataArgs = codeChunk.getAttribute('data-args')

    options = null
    try
      options = JSON.parse '{'+dataArgs.replace((/([(\w)|(\-)]+)(:)/g), "\"$1\"$2").replace((/'/g), "\"")+'}'
    catch error
      atom.notifications.addError('Invalid options', detail: dataArgs)
      return

    cmd =  options.cmd || codeChunk.getAttribute('data-lang')

    # check id and save outputDiv to @codeChunksData
    idMatch = dataArgs.match(/\s*id\s*:\s*\"([^\"]*)\"/)

    if !idMatch
      id = (new Date().getTime()).toString(36)

      buffer = @editor.buffer
      return if !buffer

      lineNo = parseInt(codeChunk.getAttribute('data-line'))

      line = buffer.lines[lineNo].trimRight()
      line = line.replace(/}$/, (if !dataArgs then '' else ',') + ' id:"' + id + '"}')

      codeChunk.setAttribute('data-args', (if !dataArgs then '' else (dataArgs+', ')) + 'id:"' + id + '"')
      codeChunk.id = 'code_chunk_' + id

      @parseDelay = Date.now() + 500 # prevent renderMarkdown

      buffer.setTextInRange([[lineNo, 0], [lineNo+1, 0]], line + '\n')
    else
      id = idMatch[1]

    codeChunk.classList.add('running')
    if @codeChunksData[id]
      @codeChunksData[id].running = true
    else
      @codeChunksData[id] = {running: true}

    codeChunkAPI.run code, @rootDirectoryPath, cmd, options, (error, data, options)=>
      return if error

      # get new codeChunk
      codeChunk = document.getElementById('code_chunk_' + id)
      return if not codeChunk
      codeChunk.classList.remove('running')

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
      else if options.output == 'none'
        outputDiv.remove()
        outputDiv = null
      else
        if data.length
          preElement = document.createElement 'pre'
          preElement.innerText = data
          outputDiv.appendChild preElement

      if outputDiv
        codeChunk.appendChild outputDiv
        @scrollMap = null

      @codeChunksData[id] = {running: false, outputDiv}

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
    els = @element.getElementsByClassName('mermaid')
    if els.length
      @graphData.mermaid_s = Array.prototype.slice.call(els)

      notProcessedEls = @element.querySelectorAll('.mermaid:not([data-processed])')

      if notProcessedEls.length
        mermaid.init(null, notProcessedEls)

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
    els = @element.getElementsByClassName('wavedrom')
    if els.length
      @graphData.wavedrom_s = Array.prototype.slice.call(els)

      # WaveDrom.RenderWaveForm(0, WaveDrom.eva('a0'), 'a')
      for el in els
        if el.getAttribute('data-processed') != 'true'
          offset = parseInt(el.getAttribute('data-offset'))
          el.id = 'wavedrom'+offset
          text = el.getAttribute('data-original').trim()
          continue if not text.length
          try
            content = JSON.parse(text.replace((/([(\w)|(\-)]+)(:)/g), "\"$1\"$2").replace((/'/g), "\"")) # clean up bad json string.
            WaveDrom.RenderWaveForm(offset, content, 'wavedrom')
            el.setAttribute 'data-processed', 'true'

            @scrollMap = null
          catch error
            el.innerText = 'failed to parse JSON'

      # disable @element onscroll
      @previewScrollDelay = Date.now() + 500

  renderPlantUML: ()->
    els = @element.getElementsByClassName('plantuml')

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
    els = element.getElementsByClassName('viz')

    if els.length
      @graphData.viz_s = Array.prototype.slice.call(els)

      @Viz ?= require('../dependencies/viz/viz.js')
      for el in els
        if el.getAttribute('data-processed') != 'true'
          try
            dotSrc = el.getAttribute('data-original')

            isHasEngine = (dotSrc.indexOf 'engine', 0) >= 0
            options = {engine: 'dot'}
            if isHasEngine
              lineLen = dotSrc.indexOf '\n', 0
              engineLine = (dotSrc.substr 0, lineLen).trim()
              dotSrc = dotSrc.substr lineLen
              options['engine'] = (engineLine.split ":")[1].trim()

            el.innerHTML = @Viz(dotSrc, options) # default svg
            el.setAttribute 'data-processed', true
          catch error
            el.innerHTML = error

  renderMathJax: ()->
    return if @mathRenderingOption != 'MathJax'
    if typeof(MathJax) == 'undefined'
      return loadMathJax document, ()=> @renderMathJax()

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
  resolveFilePath: (filePath, relative=false)->
    if filePath.startsWith('./') or filePath.startsWith('/')
      if relative
        if filePath[0] == '.'
          return filePath
        else
          return path.relative(@rootDirectoryPath, path.resolve(@projectDirectoryPath, '.'+filePath))
      else
        if filePath[0] == '.'
          return 'file:///'+path.resolve(@rootDirectoryPath, filePath)
        else
          return 'file:///'+path.resolve(@projectDirectoryPath, '.'+filePath)
    else
      return filePath

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

  getHTMLContent: ({isForPrint, offline, isSavingToHTML, phantomjsType})->
    isForPrint ?= false
    offline ?= false
    isSavingToHTML ?= false
    phantomjsType ?= false # pdf | png | jpeg | false
    return if not @editor

    useGitHubStyle = atom.config.get('markdown-preview-enhanced.useGitHubStyle')
    useGitHubSyntaxTheme = atom.config.get('markdown-preview-enhanced.useGitHubSyntaxTheme')
    mathRenderingOption = atom.config.get('markdown-preview-enhanced.mathRenderingOption')

    res = @parseMD(@formatStringBeforeParsing(@editor.getText()), {isSavingToHTML, @rootDirectoryPath, @projectDirectoryPath, markdownPreview: this})
    htmlContent = @formatStringAfterParsing(res.html)
    slideConfigs = res.slideConfigs
    yamlConfig = res.yamlConfig || {}

    # as for example black color background doesn't produce nice pdf
    # therefore, I decide to print only github style...
    if isForPrint
      useGitHubStyle = atom.config.get('markdown-preview-enhanced.pdfUseGithub')

    if mathRenderingOption == 'KaTeX'
      if offline
        mathStyle = "<link rel=\"stylesheet\"
              href=\"file:///#{path.resolve(__dirname, '../node_modules/katex/dist/katex.min.css')}\">"
      else
        mathStyle = "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.6.0/katex.min.css\">"
    else if mathRenderingOption == 'MathJax'
      inline = atom.config.get('markdown-preview-enhanced.indicatorForMathRenderingInline')
      block = atom.config.get('markdown-preview-enhanced.indicatorForMathRenderingBlock')
      if offline
        mathStyle = "
        <script type=\"text/x-mathjax-config\">
          MathJax.Hub.Config({
            messageStyle: 'none',
            tex2jax: {inlineMath: #{inline},
                      displayMath: #{block},
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
                      processEscapes: true}
          });
        </script>
        <script type=\"text/javascript\" async src=\"https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML\"></script>
        "
    else
      mathStyle = ''

    # mermaid theme
    mermaidTheme = atom.config.get 'markdown-preview-enhanced.mermaidTheme'
    mermaidThemeStyle = fs.readFileSync(path.resolve(__dirname, '../dependencies/mermaid/'+mermaidTheme))

    # presentation
    if slideConfigs.length
      htmlContent = @parseSlidesForExport(htmlContent, slideConfigs, isSavingToHTML)
      if offline
        presentationScript = "<script src='file:///#{path.resolve(__dirname, '../dependencies/reveal/js/reveal.js')}'></script>"
      else
        presentationScript = "<script src='https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.3.0/js/reveal.min.js'></script>"

      #       <link rel=\"stylesheet\" href='file:///#{path.resolve(__dirname, '../dependencies/reveal/reveal.css')}'>
      presentationStyle = """

      <style>
      #{fs.readFileSync(path.resolve(__dirname, '../dependencies/reveal/reveal.css'))}

      #{if isForPrint then fs.readFileSync(path.resolve(__dirname, '../dependencies/reveal/pdf.css')) else ''}
      </style>
      """
      presentationInitScript = """
      <script>
        Reveal.initialize(#{JSON.stringify(yamlConfig['presentation'])})
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
      #{mermaidThemeStyle}
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

    lastIndexOfSlash = dest.lastIndexOf '/' || 0
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

  saveAsHTML: (dest, offline=true)->
    return if not @editor

    htmlContent = @getHTMLContent isForPrint: false, offline: offline, isSavingToHTML: true

    lastIndexOfSlash = dest.lastIndexOf '/' || 0
    htmlFileName = dest.slice(lastIndexOfSlash + 1)

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
      width = presentationConfig['width'] || 960
      height = presentationConfig['height'] || 700

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

    """
    <div class="preview-slides">
      #{output}
    </div>
    """

  parseSlidesForExport: (html, slideConfigs, isSavingToHTML)->
    slides = html.split '<div class="new-slide"></div>'
    slides = slides.slice(1)
    output = ''

    parseAttrString = (slideConfig)=>
      attrString = ''
      if slideConfig['data-background-image']
        attrString += " data-background-image='#{@resolveFilePath(slideConfig['data-background-image'], isSavingToHTML)}'"

      if slideConfig['data-background-size']
        attrString += " data-background-size='#{slideConfig['data-background-size']}'"

      if slideConfig['data-background-position']
        attrString += " data-background-position='#{slideConfig['data-background-position']}'"

      if slideConfig['data-background-repeat']
        attrString += " data-background-repeat='#{slideConfig['data-background-repeat']}'"

      if slideConfig['data-background-color']
        attrString += " data-background-color='#{slideConfig['data-background-color']}'"

      if slideConfig['data-background-video']
        attrString += " data-background-video='#{@resolveFilePath(slideConfig['data-background-video'], isSavingToHTML)}'"

      if slideConfig['data-background-video-loop']
        attrString += " data-background-video-loop"

      if slideConfig['data-background-video-muted']
        attrString += " data-background-video-muted"

      if slideConfig['data-transition']
        attrString += " data-transition='#{slideConfig['data-transition']}'"

      if slideConfig['data-background-iframe']
        attrString += " data-background-iframe='#{@resolveFilePath(slideConfig['data-background-iframe'], isSavingToHTML)}'"
      attrString

    i = 0
    while i < slides.length
      slide = slides[i]
      slideConfig = slideConfigs[i]
      attrString = parseAttrString(slideConfig)

      if !slideConfig['vertical']
        if i > 0 and slideConfigs[i-1]['vertical'] # end of vertical slides
          output += '</section>'
        output += "<section #{attrString}>#{slide}</section>"
        i += 1
      else # vertical
        if i > 0
          if !slideConfigs[i-1]['vertical'] # start of vertical slides
            output += "<section><section #{attrString}>#{slide}</section>"
          else
            output += "<section #{attrString}>#{slide}</section>"
        else
          output += "<section><section #{attrString}>#{slide}</section>"

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
      return require(configPath) || {}
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
          lastIndexOfSlash = dest.lastIndexOf '/' || 0
          fileName = dest.slice(lastIndexOfSlash + 1)

          atom.notifications.addInfo "File #{fileName} was created", detail: "path: #{dest}"
          if atom.config.get('markdown-preview-enhanced.pdfOpenAutomatically')
            @openFile dest

  ## EBOOK
  generateEbook: (dest)->
    {html, yamlConfig} = @parseMD(@formatStringBeforeParsing(@editor.getText()), {isForEbook: true, @rootDirectoryPath, @projectDirectoryPath, hideFrontMatter:true})
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
          cover = path.resolve(@rootDirectoryPath, cover)
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
          {html} = @parseMD @formatStringBeforeParsing(text), {isForEbook: true, projectDirectoryPath: @projectDirectoryPath, rootDirectoryPath: path.dirname(filePath)}
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
          savePath =  path.resolve(@rootDirectoryPath, savePath)

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

        title = ebookConfig.title || 'no title'

        mathStyle = ''
        if outputHTML.indexOf('class="katex"') > 0
          if path.extname(dest) == '.html' and ebookConfig.html?.cdn
            mathStyle = "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.6.0/katex.min.css\">"
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

    pandocConvert content, this, data

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

  getElement: ->
    @element
