{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, ScrollView}  = require 'atom-space-pen-views'
fs = require 'fs'
temp = require 'temp'
{exec} = require 'child_process'
path = require 'path'
{parseMD} = require './md.js'
{getMarkdownPreviewCSS} = require './style.js'


## Automatically track and cleanup files at exit
temp.track()

class MarkdownPreviewEditor extends ScrollView
  constructor: (uri)->
    super
    @uri = uri
    @protocal = 'markdown-preview-enhanced://'
    @emitter = new Emitter
    @disposables = new CompositeDisposable
    @markdownPreview = null # controller defined in md-preview.js
    @handleEvents()

  @content: ->
    @div class: 'markdown-preview-enhanced-editor'

  attached: ->
    if (@markdownPreview && @markdownPreview.editor)
      @markdownPreview.bindEditor(@markdownPreview.editor)

  getTitle: ->
    @getFileName() + ' preview'

  getFileName: ->
    if @markdownPreview and @markdownPreview.editor
      @markdownPreview.editor.getFileName()
    else
      'unknown'

  getIconName: ->
    "markdown"

  getURI: ->
    @uri

  getGrammar: ->
    {scopeName: 'source.markdown-preview'}

  setTabTitle: (title)->
    tabTitle = $('[data-type="MarkdownPreviewEditor"] div.title')
    if tabTitle.length
      tabTitle[0].innerText = title

  updateTabTitle: ->
    @setTabTitle(@getTitle())

  handleEvents: ->
    atom.commands.add @element,
      'markdown-preview-enhanced:save-as-pdf': => @saveAsPDF()
      'markdown-preview-enhanced:save-as-html': => @saveAsHTML(true)
      'markdown-preview-enhanced:save-as-html-cdn': => @saveAsHTML(false)
      'markdown-preview-enhanced:open-in-browser': => @openInBrowser()

  # open html file in browser or open pdf file in reader ... etc
  openFile: (filePath)->
    if process.platform == 'win32'
      cmd = 'explorer'
    else if process.platform == 'darwin'
      cmd = 'open'
    else
      cmd = 'xdg-open'

    exec "#{cmd} #{filePath}"

  # get html content
  # pass in htmlContent to callback function
  getHTMLContent: (isForPrint=false, offline=true, isSavingToHtml=false)->
    return if not @markdownPreview

    textContent = @markdownPreview.textContent
    useGitHubStyle = atom.config.get('markdown-preview-enhanced.useGitHubStyle')
    useGitHubSyntaxTheme = atom.config.get('markdown-preview-enhanced.useGitHubSyntaxTheme')
    mathRenderingOption = atom.config.get('markdown-preview-enhanced.mathRenderingOption')

    htmlContent = parseMD(@markdownPreview, {isSavingToHtml})

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

    htmlContent = "
  <!DOCTYPE html>
  <html>
    <head>
      <title>#{@getFileName()}</title>
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



  # api doc [printToPDF] function
  # https://github.com/atom/electron/blob/master/docs/api/web-contents.md
  printPDF: (htmlPath)->
    return if not @markdownPreview

    BrowserWindow = require('remote').require('browser-window')
    win = new BrowserWindow show: false
    win.loadUrl htmlPath

    rootDirectoryPath = @markdownPreview.rootDirectoryPath
    fileName = @getFileName()
    pdfName = "#{fileName}.pdf"

    if fileName.lastIndexOf('.') > 0
      pdfName = fileName.slice(0, fileName.lastIndexOf('.')) + '.pdf'


    # get margins type
    marginsType = atom.config.get('markdown-preview-enhanced.marginsType')
    marginsType = if marginsType == 'default margin' then 0 else
                  if marginsType == 'no margin' then 1 else 2


    # get orientation
    landscape = atom.config.get('markdown-preview-enhanced.orientation') == 'landscape'

    win.webContents.on 'did-finish-load', ()=>
      setTimeout(()=>
        win.webContents.printToPDF
          pageSize: atom.config.get('markdown-preview-enhanced.exportPDFPageFormat'),
          landscape: landscape,
          printBackground: atom.config.get('markdown-preview-enhanced.printBackground'),
          marginsType: marginsType, (err, data)=>
            throw err if err

            dist = path.resolve rootDirectoryPath, pdfName

            fs.writeFile dist, data, (err)=>
              throw err if err

              atom.notifications.addInfo "File #{pdfName} was created in the same directory", detail: "path: #{dist}"

              # open pdf
              if atom.config.get('markdown-preview-enhanced.pdfOpenAutomatically')
                @openFile dist
      , 500)

  saveAsPDF: ->
    return if not @markdownPreview

    htmlContent = @getHTMLContent true, true
    temp.open
      prefix: 'markdown-preview-enhanced',
      suffix: '.html', (err, info)=>
        throw err if err
        fs.write info.fd, htmlContent, (err)=>
          throw err if err
          @printPDF "file://#{info.path}"

  saveAsHTML: (offline=true)->
    return if not @markdownPreview

    htmlContent = @getHTMLContent false, offline, true
    rootDirectoryPath = @markdownPreview.rootDirectoryPath
    fileName = @getFileName()
    htmlFileName = "#{fileName}.html"

    if fileName.lastIndexOf('.') > 0
      htmlFileName = fileName.slice(0, fileName.lastIndexOf('.')) + '.html'

    dist = path.resolve rootDirectoryPath, htmlFileName
    fs.writeFile dist, htmlContent, (err)=>
      throw err if err
      atom.notifications.addInfo("File #{htmlFileName} was created in the same directory", detail: "path: #{dist}")

  openInBrowser: ->
    return if not @markdownPreview

    htmlContent = @getHTMLContent false, true, false

    temp.open
      prefix: 'markdown-preview-enhanced',
      suffix: '.html', (err, info)=>
        throw err if err

        fs.write info.fd, htmlContent, (err)=>
          throw err if err
          ## open in browser
          @openFile info.path

  detached: ->
    @emitter.emit 'destroy'

  onDidDestroy: (callback)->
    @emitter.on 'destroy', callback

  destroy: ->
    @detach()
    @disposables.dispose()

module.exports = MarkdownPreviewEditor
