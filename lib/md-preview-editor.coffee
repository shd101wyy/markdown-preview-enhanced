{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, ScrollView}  = require 'atom-space-pen-views'
fs = require 'fs'
temp = require 'temp'
{exec} = require 'child_process'
path = require 'path'
{parseMD} = require './md.js'
{startMDPreview} = require './md-preview.js'
{getMarkdownPreviewCSS} = require './style.js'


## Automatically track and cleanup files at exit
temp.track()

class MarkdownPreviewEditor extends ScrollView
  constructor: (uri)->
    super
    @uri = uri
    @protocal = 'atom-markdown-katex://'
    @emitter = new Emitter
    @disposables = new CompositeDisposable
    @markdownPreview = null # controller defined in md-preview.js
    @handleEvents()

  @content: ->
    @div class: 'markdown-katex-preview-editor'

  attached: ->
    if (@markdownPreview && @markdownPreview.editor)
      @markdownPreview.connectPreviewEditor(this)

  getTitle: ->
    indexOfSlash = @uri.lastIndexOf(if process.platform == 'win32' then '\\' else '/')
    if indexOfSlash >= 0
      @uri.slice indexOfSlash+1
    else
      @uri.slice @protocal.length

  getFileName: ->
    fileName = @uri.slice(@protocal.length, @uri.lastIndexOf(' preview')).trim()
    indexOfSlash = fileName.lastIndexOf(if process.platform == 'win32' then '\\' else '/')
    if indexOfSlash >= 0
      fileName = fileName.slice indexOfSlash+1
    fileName

  getIconName: ->
    "markdown"

  getURI: ->
    @uri

  handleEvents: ->
    atom.commands.add @element,
      'markdown-katex-preview:save-as-pdf': => @saveAsPDF()
      'markdown-katex-preview:save-as-html': => @saveAsHTML(true)
      'markdown-katex-preview:save-as-html-cdn': => @saveAsHTML(false)
      'markdown-katex-preview:open-in-browser': => @openInBrowser()

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
  getHTMLContent: (isForPrint=false, offline=true)->
    return if not @markdownPreview

    textContent = @markdownPreview.textContent
    useGitHubStyle = atom.config.get('atom-markdown-katex.useGitHubStyle')
    useGitHubSyntaxTheme = atom.config.get('atom-markdown-katex.useGitHubSyntaxTheme')
    mathRenderOption = atom.config.get('atom-markdown-katex.mathRenderOption')
    htmlContent = parseMD(@markdownPreview)

    # as for example black color background doesn't produce nice pdf
    # therefore, I decide to print only github style...
    if isForPrint
      useGitHubStyle = atom.config.get('atom-markdown-katex.pdfUseGithub')

    if mathRenderOption == 'KaTeX'
      if offline
        katexStyle = "<link rel=\"stylesheet\"
              href=\"#{path.resolve(__dirname, '../node_modules/katex/dist/katex.min.css')}\">"
      else
        katexStyle = "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.6.0/katex.min.css\">"
    else
      katexStyle = ''

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
      #{katexStyle}
      #{mermaidStyle}
      #{mermaidScript}
    </head>
    <body class=\"markdown-katex-preview\" data-use-github-style=\"#{useGitHubStyle}\" data-use-github-syntax-theme=\"#{useGitHubSyntaxTheme}\">

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
    marginsType = atom.config.get('atom-markdown-katex.marginsType')
    marginsType = if marginsType == 'default margin' then 0 else
                  if marginsType == 'no margin' then 1 else 2


    # get orientation
    landscape = atom.config.get('atom-markdown-katex.orientation') == 'landscape'

    win.webContents.on 'did-finish-load', ()=>
      win.webContents.printToPDF
        pageSize: atom.config.get('atom-markdown-katex.exportPDFPageFormat'),
        landscape: landscape,
        printBackground: atom.config.get('atom-markdown-katex.printBackground'),
        marginsType: marginsType, (err, data)=>
          throw err if err

          dist = path.resolve rootDirectoryPath, pdfName

          fs.writeFile dist, data, (err)=>
            throw err if err

            atom.notifications.addInfo "File #{pdfName} was created in the same directory", detail: "path: #{dist}"

            # open pdf
            if atom.config.get('atom-markdown-katex.pdfOpenAutomatically')
              @openFile dist

  saveAsPDF: ->
    return if not @markdownPreview

    htmlContent = @getHTMLContent true
    temp.open
      prefix: 'atom-markdown-katex',
      suffix: '.html', (err, info)=>
        throw err if err
        fs.write info.fd, htmlContent, (err)=>
          throw err if err
          @printPDF "file://#{info.path}"

  saveAsHTML: (offline=true)->
    return if not @markdownPreview

    htmlContent = @getHTMLContent false, offline
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

    htmlContent = @getHTMLContent false

    temp.open
      prefix: 'atom-markdown-katex',
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
