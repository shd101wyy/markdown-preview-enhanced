{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, View, TextEditorView}  = require 'atom-space-pen-views'
path = require 'path'

class ExporterView extends View
  subscriptions: new CompositeDisposable

  initialize: ()->

    @markdownPreview = null

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
        @div class: 'document-type document-phantomjs', "PHANTOMJS"
        @div class: 'document-type document-ebook', 'EBOOK'

      @label class: 'save-as-label', 'Save as'
      @subview 'fileNameInput', new TextEditorView(mini: true, placeholderText: 'enter filename here')

      @div class: 'html-div', =>
        @label 'CDN (network required)'
        @input class: 'cdn-checkbox', type: 'checkbox'

      @div class: 'pdf-div', =>
        @div class: 'splitter'
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

      @div class: 'phantomjs-div', =>
        @div class: 'splitter'
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
        @a class: 'header-footer-config', 'click me to config header and footer'
        @br()
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
    @initPhantomJSPageEvent()
    @initEBookPageEvent()

    $('.export-btn', @element).click ()=>
      dist = @fileNameInput.getText().trim()
      if !@markdownPreview or !dist.length
        atom.notifications.addError('Failed to export document')
        return

      @hidePanel()
      if $('.document-pdf', @element).hasClass('selected') # pdf
        atom.notifications.addInfo('Your document is being prepared', detail: ':)')
        @markdownPreview.saveAsPDF dist
      else if $('.document-html', @element).hasClass('selected') # html
        isCDN = $('.cdn-checkbox', @element)[0].checked
        @markdownPreview.saveAsHTML dist, !isCDN
      else if $('.document-phantomjs', @element).hasClass('selected') # phantomjs
        atom.notifications.addInfo('Your document is being prepared', detail: ':)')
        @markdownPreview.phantomJSExport dist
      else if $('.document-ebook', @element).hasClass('selected') # ebook
        @markdownPreview.generateEbook dist

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

      filePath = @markdownPreview.editor.getPath()
      filePath = filePath.slice(0, filePath.length-3) + '.html'
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

      filePath = @markdownPreview.editor.getPath()
      filePath = filePath.slice(0, filePath.length-3) + '.pdf'
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

      filePath = @markdownPreview.editor.getPath()
      filePath = filePath.slice(0, filePath.length-3) + '.' + atom.config.get('markdown-preview-enhanced.phantomJSExportFileType').toLowerCase()
      @fileNameInput.setText(filePath)
      @marginInput.setText(atom.config.get('markdown-preview-enhanced.phantomJSMargin'))

      $('.phantomjs-div .file-type-select', @element).val atom.config.get('markdown-preview-enhanced.phantomJSExportFileType')

      $('.phantomjs-div .format-select', @element).val atom.config.get('markdown-preview-enhanced.exportPDFPageFormat')

      $('.phantomjs-div .orientation-select', @element).val atom.config.get('markdown-preview-enhanced.orientation')

      $('.phantomjs-div .pdf-auto-open-checkbox', @element)[0].checked = atom.config.get('markdown-preview-enhanced.pdfOpenAutomatically')

    ## select
    $('.phantomjs-div .file-type-select', @element).on 'change', (e)=>
      atom.config.set('markdown-preview-enhanced.phantomJSExportFileType', e.target.value)

      filePath = @markdownPreview.editor.getPath()
      filePath = filePath.slice(0, filePath.length-3) + '.' + atom.config.get('markdown-preview-enhanced.phantomJSExportFileType').toLowerCase()
      @fileNameInput.setText(filePath)

    $('.phantomjs-div .format-select', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.exportPDFPageFormat', this.value)

    $('.phantomjs-div .orientation-select', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.orientation', this.value)

    ## input
    @marginInput.model.onDidStopChanging (e)=>
      atom.config.set('markdown-preview-enhanced.phantomJSMargin', @marginInput.getText())

    ## checkbox
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

      filePath = @markdownPreview.editor.getPath()
      filePath = filePath.slice(0, filePath.length-3) + '.' + $('.ebook-div .ebook-format-select', @element)[0].value
      @fileNameInput.setText(filePath)
      @fileNameInput.focus()

      $('.html-div', @element).hide()
      $('.pdf-div', @element).hide()
      $('.phantomjs-div', @element).hide()
      $('.ebook-div', @element).show()

    ## select
    $('.ebook-div .ebook-format-select', @element).on 'change', (e)=>
      filePath = @markdownPreview.editor.getPath()
      filePath = filePath.slice(0, filePath.length-3) + '.' + e.target.value
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

    @fileNameInput.focus()
    $('.selected', @element).click()

module.exports = ExporterView
