{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, ScrollView}  = require 'atom-space-pen-views'
path = require 'path'
fs = require 'fs'
temp = require 'temp'
{exec} = require 'child_process'

{parseMD, buildScrollMap} = require './md'
{getMarkdownPreviewCSS} = require './style'
plantumlAPI = require './puml'


module.exports =
class MarkdownPreviewEnhancedView extends ScrollView
  constructor: (state=null, uri)->
    super

    @state = state
    @uri = uri
    @protocal = 'markdown-preview-enhanced://'
    @editor = null

    @headings = []
    @scrollMap = null
    @rootDirectoryPath = null
    @textContent = ''
    @projectDirectoryPath = null

    @disposables = null

    @liveUpdate = true
    @scrollSync = true
    @mathRenderingOption = null

    @parseDelay = Date.now()
    @editorScrollDelay = Date.now()
    @previewScrollDelay = Date.now()

    @documentExporter = null # binded in markdown-preview-enhanced.coffee startMD function

    # when resize the window, clear the editor
    @resizeEvent = ()=>
      @scrollMap = null
    window.addEventListener 'resize', @resizeEvent

    # right click event
    atom.commands.add @element,
      'markdown-preview-enhanced:open-in-browser': => @openInBrowser()
      'markdown-preview-enhanced:export-to-disk': => @exportToDisk()

  @content: ->
    @div class: 'markdown-preview-enhanced', =>
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
                split: 'right', activatePane: false, searchAllPanes: true
          .then (e)=>
            @editor = editor
            @initEvents()

    else
      @editor = editor
      @element.innerHTML = '<p style="font-size: 24px;"> loading preview... </p>'
      @initEvents()

  initEvents: ->
    @updateTabTitle()

    @headings = []
    @scrollMap = null
    @rootDirectoryPath = @editor.getDirectoryPath()
    @textContent = @editor.getText()
    @projectDirectoryPath = @getProjectDirectoryPath()

    if @disposables # remove all binded events
      @disposables.dispose()
    @disposables = new CompositeDisposable()

    @initEditorEvent()
    @initViewEvent()
    @initSettingsEvents()


  initEditorEvent: ->
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

    @disposables.add @editor.onDidChangeScrollTop ()=>
      if !@scrollSync or !@element or !@liveUpdate
        return
      if Date.now() < @editorScrollDelay
        return

      editorElement = @editor.getElement()
      editorHeight = editorElement.getHeight()

      firstVisibleScreenRow = @editor.getFirstVisibleScreenRow()
      lastVisibleScreenRow = firstVisibleScreenRow + Math.floor(editorHeight / @editor.getLineHeightInPixels())

      lineNo = Math.floor((firstVisibleScreenRow + lastVisibleScreenRow) / 2)

      if !@scrollMap
        @scrollMap = buildScrollMap(this)

      # disable markdownHtmlView onscroll
      @previewScrollDelay = Date.now() + 500

      @element.scrollTop = @scrollMap[lineNo] - editorHeight / 2

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

      if event.oldScreenPosition.row != event.newScreenPosition.row or event.oldScreenPosition.column == 0
        lineNo = event.newScreenPosition.row
        if lineNo == 0
          @element.scrollTop = 0
          return
        else if lineNo == @editor.getScreenLineCount() - 1 # last row
          @element.scrollTop = @element.offsetHeight - 16
          return

        @scrollSyncToLineNo(lineNo)

  initViewEvent: ->
    @element.onscroll = ()=>
      if !@editor or !@scrollSync or !@liveUpdate
        return
      if Date.now() < @previewScrollDelay
        return

      top = @element.scrollTop + @element.offsetHeight / 2

      # try to find corresponding screen buffer row
      if !@scrollMap
        @scrollMap = buildScrollMap(this)

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

      if (screenRow >= 0)
        @editor.setScrollTop(screenRow * @editor.getLineHeightInPixels() - @element.offsetHeight / 2)

        # track currnet time to disable onDidChangeScrollTop
        @editorScrollDelay = Date.now() + 500

  initSettingsEvents: ->
    # settings changed
    # github style?
    @disposables.add atom.config.observe 'markdown-preview-enhanced.useGitHubStyle',
      (useGitHubStyle) =>
        @element.setAttribute('data-use-github-style', if useGitHubStyle then 'true' else 'false')

    # github syntax theme
    @disposables.add atom.config.observe 'markdown-preview-enhanced.useGitHubSyntaxTheme',
      (useGitHubSyntaxTheme)=>
        @element.setAttribute('data-use-github-syntax-theme', if useGitHubSyntaxTheme then 'true' else 'false')

    # break line?
    @disposables.add atom.config.observe 'markdown-preview-enhanced.breakOnSingleNewline',
      (breakOnSingleNewline)=>
        @renderMarkdown()

    # liveUpdate?
    @disposables.add atom.config.observe 'markdown-preview-enhanced.liveUpdate',
      (flag) => @liveUpdate = flag

    # scroll sync?
    @disposables.add atom.config.observe 'markdown-preview-enhanced.scrollSync',
      (flag) => @scrollSync = flag

    # math?
    @disposables.add atom.config.observe 'markdown-preview-enhanced.mathRenderingOption',
      (option) =>
        @mathRenderingOption = option
        @renderMarkdown()

  scrollSyncToLineNo: (lineNo)->
    if !@scrollMap
      @scrollMap = buildScrollMap(this)

    editorElement = @editor.getElement()

    firstVisibleScreenRow = @editor.getFirstVisibleScreenRow()
    posRatio = (lineNo - firstVisibleScreenRow) / (editorElement.getHeight() / @editor.getLineHeightInPixels())
    scrollTop = @scrollMap[lineNo] - (if posRatio > 1 then 1 else posRatio) * editorElement.getHeight()

    @element.scrollTop = scrollTop

  updateMarkdown: ->
    @editorScrollDelay = Date.now() + 500
    @previewScrollDelay = Date.now() + 500

    @renderMarkdown()

  renderMarkdown: ->
    if Date.now() < @parseDelay or !@editor or !@element
      return
    @parseDelay = Date.now() + 200

    textContent = @editor.getText()
    html = parseMD(this)

    @element.innerHTML = html
    @bindEvents()

  bindEvents: ->
    @bindTagAClickEvent()
    @initTaskList()
    @renderMermaid()
    @renderPlantUML()
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
          if href and href.endsWith('.md')
            mdFilePath = path.resolve(@rootDirectoryPath, href)
            if href[0] == '/'
              mdFilePath = path.resolve(@projectDirectoryPath, '.' + href)

            atom.workspace.open mdFilePath,
              split: 'left',
              searchAllPanes: true

    for a in as
      href = a.getAttribute('href')
      analyzeHref(href)

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
      mermaid.init()

      # disable @element onscroll
      @previewScrollDelay = Date.now() + 500

  renderPlantUML: ()->
    els = @element.getElementsByClassName('plantuml')
    helper = (el, text)->
      plantumlAPI.render text, (outputHTML)->
        graph = document.createElement 'div'
        graph.classList.add('plantuml')
        graph.setAttribute 'data-original', text
        graph.innerHTML = outputHTML
        el?.parentElement?.replaceChild graph, el

    for el in els
      if el.tagName == 'PRE'
        helper(el, el.innerText)
        el.innerHTML = 'rendering graph...\n' + el.innerHTML

  renderMathJax: ()->
    if @mathRenderingOption != 'MathJax' or typeof(MathJax) == 'undefined'
      return

    els = @element.getElementsByClassName('mathjax-exps')
    helper = (el, text)->
      MathJax.Hub.Queue  ['Typeset', MathJax.Hub, el], ()->
        if el?.children.length
          el?.setAttribute 'data-original', text

    for el in els
      if !el.children.length
        helper(el, el.innerText.trim())


  ## Utilities
  openInBrowser: ()->
    return if not @editor

    htmlContent = @getHTMLContent offline: true

    temp.open
      prefix: 'markdown-preview-enhanced',
      suffix: '.html', (err, info)=>
        throw err if err

        fs.write info.fd, htmlContent, (err)=>
          throw err if err
          ## open in browser
          @openFile info.path

  exportToDisk: ()->
    @documentExporter.display(this)

  # open html file in browser or open pdf file in reader ... etc
  openFile: (filePath)->
    if process.platform == 'win32'
      cmd = 'explorer'
    else if process.platform == 'darwin'
      cmd = 'open'
    else
      cmd = 'xdg-open'

    exec "#{cmd} #{filePath}"

  getHTMLContent: ({isForPrint, offline, isSavingToHTML})->
    isForPrint ?= false
    offline ?= false
    isSavingToHTML ?= false
    return if not @editor

    textContent = @editor.getText()
    useGitHubStyle = atom.config.get('markdown-preview-enhanced.useGitHubStyle')
    useGitHubSyntaxTheme = atom.config.get('markdown-preview-enhanced.useGitHubSyntaxTheme')
    mathRenderingOption = atom.config.get('markdown-preview-enhanced.mathRenderingOption')

    htmlContent = parseMD(this, {isSavingToHTML, isForPreview: false})

    # as for example black color background doesn't produce nice pdf
    # therefore, I decide to print only github style...
    if isForPrint
      useGitHubStyle = atom.config.get('markdown-preview-enhanced.pdfUseGithub')

    if mathRenderingOption == 'KaTeX'
      if offline
        mathStyle = "<link rel=\"stylesheet\"
              href=\"#{path.resolve(__dirname, '../node_modules/katex/dist/katex.min.css')}\">"
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
        <script type=\"text/javascript\" async src=\"#{path.resolve(__dirname, '../mathjax/MathJax.js?config=TeX-AMS_CHTML')}\"></script>
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

    if offline
      mermaidStyle = "<link rel=\"stylesheet\" href=\"#{path.resolve(__dirname, '../node_modules/mermaid/dist/mermaid.css')}\">"
      mermaidScript = "<script src=\"#{path.resolve(__dirname, '../node_modules/mermaid/dist/mermaid.min.js')}\"></script>"
    else
      mermaidStyle = "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/mermaid/0.5.8/mermaid.min.css\">"
      mermaidScript = "<script src=\"https://cdnjs.cloudflare.com/ajax/libs/mermaid/0.5.8/mermaid.min.js\"></script>"

    title = @getFileName()
    title = title.slice(0, title.length - 3) # remove '.md'
    htmlContent = "
  <!DOCTYPE html>
  <html>
    <head>
      <title>#{title}</title>
      <meta charset=\"utf-8\">
      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
      <style> #{getMarkdownPreviewCSS()} </style>
      #{mathStyle}
      #{mermaidStyle}
      #{mermaidScript}
    </head>
    <body class=\"markdown-preview-enhanced\" data-use-github-style=\"#{useGitHubStyle}\" data-use-github-syntax-theme=\"#{useGitHubSyntaxTheme}\">

    #{htmlContent}

    </body>
  </html>
    "

  # We don't need to use this function...
  # Returns an object that can be retrieved when package is activated
  serialize: ->
    null

  # Tear down any state and detach
  destroy: ->
    @element.remove()
    @editor = null
    if @disposables
      @disposables.dispose()
      @disposables = null

  getElement: ->
    @element
