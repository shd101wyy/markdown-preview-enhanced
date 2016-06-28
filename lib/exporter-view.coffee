{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, View, TextEditorView}  = require 'atom-space-pen-views'

class ExporterView extends View
  initialize: ()->

    @markdownPreview = null

    atom.commands.add @element,
      'core:cancel': => @hidePanel()

    @bindEvents()

  @content: ->
    @div class: 'exporter-view', =>
      @h4 'Export to disk'
      @div class: 'document-type-div clearfix', =>
        @div class: 'document-type document-html selected', "HTML"
        @div class: 'document-type document-pdf', "PDF"

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
        @label 'Print Background'
        @input type: 'checkbox', class: 'print-background-checkbox'
        @br()
        @label 'Github Style'
        @input type: 'checkbox', class: 'github-style-checkbox'
        @br()
        @label 'Open PDF after generation'
        @input type: 'checkbox', class: 'pdf-auto-open-checkbox'
        # @div 'splitter'
        # @label 'header'
        # @label 'image quality'
        # @input type: 'text', class: 'image-quality-input'

      @div class: 'button-group', =>
        @div class: 'close-btn btn', 'close'
        @div class: 'export-btn btn', 'export'

  bindEvents: ->
    $('.close-btn', @element).click ()=> @hidePanel()

    @initHTMLPageEvent()
    @initPDFPageEvent()

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

  initHTMLPageEvent: ->
    $('.document-html', @element).on 'click', (e)=>
      $el = $(e.target)
      if !$el.hasClass('selected')
        $('.selected', @elemnet).removeClass('selected')
        $el.addClass('selected')

      $('.pdf-div', @element).hide()
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

      $('.html-div', @element).hide()
      $('.pdf-div', @element).show()

      filePath = @markdownPreview.editor.getPath()
      filePath = filePath.slice(0, filePath.length-3) + '.pdf'
      @fileNameInput.setText(filePath)

    ## select
    $('.format-select', @element).value = atom.config.get('markdown-preview-enhanced.exportPDFPageFormat')
    $('.format-select', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.exportPDFPageFormat', this.value)

    $('.orientation-select', @element).value =
    atom.config.get('markdown-preview-enhanced.orientation')
    $('.orientation-select', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.orientation', this.value)

    $('.margin-select', @element).value = atom.config.get('markdown-preview-enhanced.marginsType')
    $('.margin-select', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.marginsType', this.value)

    ## checkbox
    $('.print-background-checkbox', @element)[0].checked = atom.config.get('markdown-preview-enhanced.printBackground')
    $('.print-background-checkbox', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.printBackground', e.target.checked)

    $('.github-style-checkbox', @element)[0].checked = atom.config.get('markdown-preview-enhanced.pdfUseGithub')
    $('.github-style-checkbox', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.pdfUseGithub', e.target.checked)

    $('.pdf-auto-open-checkbox', @element)[0].checked = atom.config.get('markdown-preview-enhanced.pdfOpenAutomatically')
    $('.pdf-auto-open-checkbox', @element).on 'change', (e)->
      atom.config.set('markdown-preview-enhanced.pdfOpenAutomatically', e.target.checked)


  hidePanel: ->
    return unless @panel.isVisible()
    @panel.hide()

  display: (markdownPreview)->
    @markdownPreview = markdownPreview

    @panel ?= atom.workspace.addModalPanel(item: this, visible: false)
    @panel.show()

    @fileNameInput.focus()
    $('.selected', @lement).click()

# documentExporter = new ExporterView()
module.exports = ExporterView
