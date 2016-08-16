{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, ScrollView}  = require 'atom-space-pen-views'
{MediumEditor} = require 'medium-editor'

module.exports =
class MarsView extends ScrollView
  constructor: (uri) ->
    super

    @uri = uri

    @zeroWidthCharacter = '\u200b' # zero-width character
    @nbsp = String.fromCharCode(160)
    window.mars = this

    @editor = new MediumEditor @element,
                               toolbar: false,
                               placeholder:
                                 text: 'Write markdown here',
                                 hideOnClick: true

    @element.setAttribute 'data-use-github-style', ''
    @bindEvents()

  @content: ->
    @div class: 'markdown-preview-enhanced native-key-bindings mars'

  getTitle: ->
    'Mars'

  getURI: ->
    @uri

  # Tear down any state and detach
  destroy: ->
    @element.remove()
    @editor.destroy()
    @editor = null

  getElement: ->
    @element

  bindEvents: ->
    @editor.subscribe('editableInput', @handleInput.bind(this))

  handleInput: (event, editable)->
    currentSelectedElement = @editor.getSelectedParentElement()
    textContent = currentSelectedElement.textContent

    headingTest = textContent.match(/^#+\s/i)
    if headingTest && headingTest[0].length - 1 <= 6
      # @editor.selectElement(currentSelectedElement)
      # @editor.pasteHTML('<h1> haha </h1>')
      heading = 'h' + (headingTest[0].length - 1)
      currentSelectedElement.classList.add('heading-hint')
      currentSelectedElement.setAttribute('data-heading', heading)
    else
      # remove all unnecessary classes and attributes
      currentSelectedElement.classList.remove('heading-hint')
      currentSelectedElement.removeAttribute('data-heading')

      if currentSelectedElement.previousElementSibling?.hasAttribute('data-heading')
        headingElement = currentSelectedElement.previousElementSibling
        tag = headingElement.getAttribute('data-heading')
        headingHTML = headingElement.innerHTML
        headingHTML = headingHTML.slice(headingHTML.indexOf(' ') + 1)

        @editor.selectElement(headingElement)
        @editor.pasteHTML("<#{tag}>#{headingHTML}</#{tag}>")

        @editor.selectElement(currentSelectedElement)
