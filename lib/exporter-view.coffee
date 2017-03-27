{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, View, TextEditorView}  = require 'atom-space-pen-views'
path = require 'path'

class ExporterView extends View
  subscriptions: new CompositeDisposable

  initialize: ()->

    @markdownPreview = null
    @documentExportPath = null

    @subscriptions.add atom.commands.add @element,
      'core:cancel': => @hidePanel()

    @bindEvents()

  destroy: ->
    @subscriptions.dispose()
    @panel?.destroy()
    @panel = null

  @content: ->
    @div class: 'exporter-view', =>
      @h4 'Export to disk'
      @div class: 'document-type-div clearfix', =>
        @div class: 'document-type document-html selected', "HTML"
        @div class: 'document-type document-pdf', "PDF"
        @div class: 'document-type document-prince', 'PRINCE (PDF)'
        @div class: 'document-type document-phantomjs', "PHANTOMJS"
        @div class: 'document-type document-ebook', 'EBOOK'

      @label class: 'save-as-label', 'Save as'
      @subview 'fileNameInput', new TextEditorView(mini: true, placeholderText: 'enter filename here')
      @label class: 'copy-label', 'Export document to ./ folder'
      @div class: 'splitter'

      @div class: 'html-div', =>
        @input class: 'cdn-checkbox', type: 'checkbox'
        @label 'Use CDN hosted resources'
        @br()
        @input class: 'relative-image-path-checkbox', type: 'checkbox'
        @label 'Use relative image path'
        @br()
        @input class: 'embed-local-images-checkbox', type: 'checkbox'
        @label 'Embed local images'

      @div class: 'pdf-div', =>
        @label 'Format'
        @select class: 'format-select', =>
          @option 'A3'
          @option 'A4'
          @option 'A5'
          @option 'Legal'
          @option 'Letter'
          @option 'Tabloid'
        @br()
        @label 'Orientation'
        @select class: 'orientation-select', =>
          @option 'portrait'
          @option 'landscape'
        @br()
        @label 'Margin'
        @select class: 'margin-select', =>
          @option 'default margin'
          @option 'no margin'
          @option 'minimum margin'
        @br()
        @label 'Print background'
        @input type: 'checkbox', class: 'print-background-checkbox'
        @br()
        @label 'Github style'
        @input type: 'checkbox', class: 'github-style-checkbox'
        @br()
        @label 'Open PDF after generation'
        @input type: 'checkbox', class: 'pdf-auto-open-checkbox'
        # @div 'splitter'
        # @label 'header'
        # @label 'image quality'
        # @input type: 'text', class: 'image-quality-input'
      @div class: 'prince-div', =>
        @label 'Github style'
        @input type: 'checkbox', class: 'github-style-checkbox'
        @br()
        @label 'Open PDF after generation'
        @input type: 'checkbox', class: 'pdf-auto-open-checkbox'

      @div class: 'phantomjs-div', =>
        @label 'File Type'
        @select class: 'file-type-select', =>
          @option 'pdf'
          @option 'png'
          @option 'jpeg'
        @br()
        @label 'Format'
        @select class: 'format-select', =>
          @option 'A3'
          @option 'A4'
          @option 'A5'
          @option 'Legal'
          @option 'Letter'
          @option 'Tabloid'
        @br()
        @label 'Orientation'
        @select class: 'orientation-select', =>
          @option 'portrait'
          @option 'landscape'
        @br()
        @label 'Margin'
        @subview 'marginInput', new TextEditorView(mini: true, placeholderText: '1cm')
        @br()
        @a class: 'header-footer-config', 'click me to open header and footer config'
        @br()
        @br()
        @label 'Github style'
        @input type: 'checkbox', class: 'github-style-checkbox'
        @br()
        @label 'Open PDF after generation'
        @input type: 'checkbox', class: 'pdf-auto-open-checkbox'

      @div class: 'ebook-div', =>
        @select class: 'ebook-format-select', =>
          @option 'epub'
          @option 'mobi'
          @option 'pdf'
          @option 'html'

      @div class: 'button-group', =>
        @div class: 'close-btn btn', 'close'
        @div class: 'export-btn btn', 'export'

  bindEvents: ->
    $('.close-btn', @element).click ()=> @hidePanel()

    @initHTMLPageEvent()
    @initPDFPageEvent()
    @initPrincePageEvent()
    @initPhantomJSPageEvent()
    @initEBookPageEvent()

    $('.export-btn', @element).click ()=>
      dest = @fileNameInput.getText().trim()
      if !@markdownPreview or !dest.length
        atom.notifications.addError('Failed to export document')
        return

      @hidePanel()
      if $('.document-pdf', @element).hasClass('selected') # pdf
        atom.notifications.addInfo('Your document is being prepared', detail: ':)')
        @markdownPreview.saveAsPDF dest
      else if $('.document-html', @element).hasClass('selected') # html
        isCDN = $('.cdn-checkbox', @element)[0].checked
        relativeImagePath = $('.relative-image-path-checkbox', @element)[0].checked
        embedLocalImages = $('.embed-local-images-checkbox', @element)[0].checked
        @markdownPreview.saveAsHTML dest, !isCDN, relativeImagePath, embedLocalImages
      else if $('.document-phantomjs', @element).hasClass('selected') # phantomjs
        atom.notifications.addInfo('Your document is being prepared', detail: ':)')
        @markdownPreview.phantomJSExport dest
      else if $('.document-ebook', @element).hasClass('selected') # ebook
        @markdownPreview.generateEbook dest
      else if $('.document-prince', @element).hasClass('selected') # prince
        @markdownPreview.princeExport dest

  initHTMLPageEvent: ->
    $('.document-html', @element).on 'click', (e)=>
      $el = $(e.target)
      if !$el.hasClass('selected')
        $('.selected', @elemnet).removeClass('selected')
        $el.addClass('selected')

        @fileNameInput.focus()

      $('.pdf-div', @element).hide()
      $('.phantomjs-div', @element).hide()
      $('.ebook-div', @element).hide()
      $('.html-div', @element).show()
      $('.prince-div', @element).hide()

      filePath = path.resolve(@documentExportPath, @markdownPreview.editor.getFileName())
      filePath = filePath.slice(0, filePath.length-path.extname(filePath).length) + '.html'
      @fileNameInput.setText(filePath)

  initPDFPageEvent: ->
    $('.document-pdf', @element).on 'click', (e)=>
      $el = $(e.target)
      if !$el.hasClass('selected')
        $('.selected', @elemnet).removeClass('selected')
        $el.addClass('selected')

        @fileNameInput.focus()

      $('.html-div', @element).hide()
      $('.phantomjs-div', @element).hide()
      $('.ebook-div', @element).hide()
      $('.pdf-div', @element).show()
      $('.prince-div', @element).hide()

      filePath = path.resolve(@documentExportPath, @markdownPreview.editor.getFileName())
      filePath = filePath.slice(0, filePath.length-path.extname(filePath).length) + '.pdf'
      @fileNameInput.setText(filePath)

      $('.pdf-div .format-select', @element).val atom.config.get('markdown-preview-enhanced.exportPDFPageFormat')

      $('.pdf-div .orientation-select', @element).val atom.config.get('markdown-preview-enhanced.orientation')

      $('.pdf-div .margin-select', @element).val atom.config.get('markdown-preview-enhanced.marginsType')

      $('.pdf-div .print-background-checkbox', @element)[0].checked = atom.config.get('markdown-preview-enhanced.printBackground')

      $('.pdf-div .github-style-checkbox', @element)[0].checked =   atom.config.get('markdown-preview-enhanced.pdfUseGithub')

      $('.pdf-div .pdf-auto-open-checkbox', @element)[0].checked = atom.config.get('markdown-preview-enhanced.pdfOpenAutomatically')

    ## select
    $('.pdf-div .format-select', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.exportPDFPageFormat', this.value)

    $('.pdf-div .orientation-select', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.orientation', this.value)

    $('.pdf-div .margin-select', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.marginsType', this.value)

    ## checkbox
    $('.pdf-div .print-background-checkbox', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.printBackground', e.target.checked)

    $('.pdf-div .github-style-checkbox', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.pdfUseGithub', e.target.checked)

    $('.pdf-div .pdf-auto-open-checkbox', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.pdfOpenAutomatically', e.target.checked)

  initPrincePageEvent: ->
    $('.document-prince', @element).on 'click', (e)=>
      $el = $(e.target)
      if !$el.hasClass('selected')
        $('.selected', @element).removeClass('selected')
        $el.addClass('selected')

        @fileNameInput.focus()

      $('.html-div', @element).hide()
      $('.pdf-div', @element).hide()
      $('.ebook-div', @element).hide()
      $('.phantomjs-div', @element).hide()
      $('.prince-div', @element).show()

      filePath = path.resolve(@documentExportPath, @markdownPreview.editor.getFileName())
      filePath = filePath.slice(0, filePath.length-path.extname(filePath).length) + '.pdf'
      @fileNameInput.setText(filePath)

      $('.prince-div .github-style-checkbox', @element)[0].checked =   atom.config.get('markdown-preview-enhanced.pdfUseGithub')

      $('.prince-div .pdf-auto-open-checkbox', @element)[0].checked = atom.config.get('markdown-preview-enhanced.pdfOpenAutomatically')

    $('.prince-div .github-style-checkbox', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.pdfUseGithub', e.target.checked)

    $('.prince-div .pdf-auto-open-checkbox', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.pdfOpenAutomatically', e.target.checked)

  initPhantomJSPageEvent: ->
    $('.document-phantomjs', @element).on 'click', (e)=>
      $el = $(e.target)
      if !$el.hasClass('selected')
        $('.selected', @element).removeClass('selected')
        $el.addClass('selected')

        @fileNameInput.focus()

      $('.html-div', @element).hide()
      $('.pdf-div', @element).hide()
      $('.ebook-div', @element).hide()
      $('.phantomjs-div', @element).show()
      $('.prince-div', @element).hide()

      filePath = path.resolve(@documentExportPath, @markdownPreview.editor.getFileName())
      extension = atom.config.get('markdown-preview-enhanced.phantomJSExportFileType')
      filePath = filePath.slice(0, filePath.length-path.extname(filePath).length) + '.' + extension
      @fileNameInput.setText(filePath)
      @marginInput.setText(atom.config.get('markdown-preview-enhanced.phantomJSMargin'))

      $('.phantomjs-div .file-type-select', @element).val extension

      $('.phantomjs-div .format-select', @element).val atom.config.get('markdown-preview-enhanced.exportPDFPageFormat')

      $('.phantomjs-div .orientation-select', @element).val atom.config.get('markdown-preview-enhanced.orientation')

      $('.phantomjs-div .github-style-checkbox', @element)[0].checked =   atom.config.get('markdown-preview-enhanced.pdfUseGithub')

      $('.phantomjs-div .pdf-auto-open-checkbox', @element)[0].checked = atom.config.get('markdown-preview-enhanced.pdfOpenAutomatically')

    ## select
    $('.phantomjs-div .file-type-select', @element).on 'change', (e)=>
      extension = e.target.value
      atom.config.set('markdown-preview-enhanced.phantomJSExportFileType', extension)

      filePath = path.resolve(@documentExportPath, @markdownPreview.editor.getFileName())
      filePath = filePath.slice(0, filePath.length-path.extname(filePath).length) + '.' + extension
      @fileNameInput.setText(filePath)

    $('.phantomjs-div .format-select', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.exportPDFPageFormat', this.value)

    $('.phantomjs-div .orientation-select', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.orientation', this.value)

    ## input
    @marginInput.model.onDidStopChanging (e)=>
      atom.config.set('markdown-preview-enhanced.phantomJSMargin', @marginInput.getText())

    ## checkbox
    $('.phantomjs-div .github-style-checkbox', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.pdfUseGithub', e.target.checked)

    $('.phantomjs-div .pdf-auto-open-checkbox', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.pdfOpenAutomatically', e.target.checked)

    ## config
    config = $('.header-footer-config', @element)
    config.on 'click', ()=>
      @hidePanel()
      atom.workspace.open(path.resolve(atom.config.configDirPath, './markdown-preview-enhanced/phantomjs_header_footer_config.js'), {split: 'left'})

  initEBookPageEvent: ->
    $('.document-ebook', @element).on 'click', (e)=>
      $el = $(e.target)
      if !$el.hasClass('selected')
        $('.selected', @elemnet).removeClass('selected')
        $el.addClass('selected')

      filePath = path.resolve(@documentExportPath, @markdownPreview.editor.getFileName())
      filePath = filePath.slice(0, filePath.length-path.extname(filePath).length) + '.' + $('.ebook-div .ebook-format-select', @element)[0].value
      @fileNameInput.setText(filePath)
      @fileNameInput.focus()

      $('.html-div', @element).hide()
      $('.pdf-div', @element).hide()
      $('.phantomjs-div', @element).hide()
      $('.ebook-div', @element).show()
      $('.prince-div', @element).hide()

    ## select
    $('.ebook-div .ebook-format-select', @element).on 'change', (e)=>
      filePath = path.resolve(@documentExportPath, @markdownPreview.editor.getFileName())
      filePath = filePath.slice(0, filePath.length-path.extname(filePath).length) + '.' + e.target.value
      @fileNameInput.setText(filePath)

  hidePanel: ->
    return unless @panel?.isVisible()
    @panel.hide()

  display: (markdownPreview)->
    @markdownPreview = markdownPreview

    if !@markdownPreview.editor
      return


    @panel ?= atom.workspace.addModalPanel(item: this, visible: false)
    @panel.show()

    copyLabel = $('.copy-label', @element)
    @documentExportPath = atom.config.get 'markdown-preview-enhanced.documentExportPath'
    copyLabel.html "<i>Export document to <a>#{@documentExportPath}</a> folder</i>"
    copyLabel.find('a').on 'click', ()=>
      try
        atom.workspace.open('atom://config/packages/markdown-preview-enhanced', {split: 'right'})
        @hidePanel()
      catch e
        @hidePanel()
    if @documentExportPath.startsWith('/')
      @documentExportPath = path.resolve(markdownPreview.projectDirectoryPath, '.'+@documentExportPath)
    else
      @documentExportPath = path.resolve(markdownPreview.fileDirectoryPath, @documentExportPath)

    @fileNameInput.focus()
    $('.selected', @element).click()

module.exports = ExporterView