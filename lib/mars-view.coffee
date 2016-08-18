{Emitter, CompositeDisposable} = require 'atom'
{$, $$$, ScrollView}  = require 'atom-space-pen-views'
# {MediumEditor} = require 'medium-editor'

module.exports =
class MarsView extends ScrollView
  constructor: (uri) ->
    super

    @uri = uri

    @zeroWidthCharacter = '\u200b' # zero-width character
    @nbsp = String.fromCharCode(160)
    window.mars = this

    ###
    @editor = new MediumEditor @element,
                               toolbar: false,
                               placeholder:
                                 text: 'Write markdown here',
                                 hideOnClick: true
    ###

    @element.setAttribute 'data-use-github-style', ''
    @element.setAttribute('contenteditable', true)

    # TODO: History stack

    @bindEvents()

  @content: ->
    @div class: 'markdown-preview-enhanced native-key-bindings mars', =>
      @p =>
        @br()

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

  setCursor: (element, atStart=false)->
    selection = document.getSelection()
    newRange = document.createRange()
    newRange.selectNodeContents element
    newRange.collapse atStart
    selection.removeAllRanges()
    selection.addRange newRange

  selectElement: (element)->
    selection = document.getSelection()
    range = document.createRange()
    range.selectNodeContents element
    selection.removeAllRanges()
    selection.addRange range

  getSelectedParentElement: ()->
    selection = document.getSelection()
    node = selection.anchorNode
    element = if node.nodeType == 3 then node.parentNode else node
    element

  bindEvents: ->
    @element.addEventListener 'input', @handleInput.bind(this)
    @element.addEventListener 'keydown', @handleKeydown.bind(this)
    # @editor.subscribe('editableInput', @handleInput.bind(this))

  handleInput: (event)->
    currentSelectedElement = @getSelectedParentElement()
    textContent = currentSelectedElement.textContent

    # console.log(currentSelectedElement)

    if !@element.innerHTML.length
      p = document.createElement('p')
      p.innerHTML = '<br>'

      @element.appendChild(p)
      @setCursor p
    else if (headingTest = textContent.match(/^#+\s/i)) and
            headingTest && headingTest[0].length - 1 <= 6
      heading = 'h' + (headingTest[0].length - 1)
      currentSelectedElement.classList.add('heading')
      currentSelectedElement.setAttribute('data-heading', heading)
    else if (blockquoteTest = textContent.match(/^>\s/i)) && blockquoteTest
      blockquote = document.createElement('blockquote')
      p = document.createElement('p')
      p.innerHTML = '<br>'
      blockquote.appendChild(p)

      currentSelectedElement.parentElement.replaceChild(blockquote, currentSelectedElement)
      @setCursor(p)
    else
      # remove all unnecessary classes and attributes
      currentSelectedElement.classList.remove('heading')
      currentSelectedElement.removeAttribute('data-heading')

      @formatHeadings()

  handleKeydown: (event)->
    code = event.which
    # console.log(code)

    if code == 13 # enter
      currentSelectedElement = @getSelectedParentElement()
      if currentSelectedElement.parentElement?.tagName == 'BLOCKQUOTE' and currentSelectedElement.textContent.length == 0
        event.preventDefault()

        p = document.createElement('p')
        p.innerHTML = '<br>'

        currentSelectedElement.parentElement.insertAdjacentElement 'afterend', p

        currentSelectedElement.remove()
        @setCursor p

  formatHeadings: ()->
    headings = document.getElementsByClassName('heading')
    for headingElement in headings
      tag = headingElement.getAttribute('data-heading')
      headingHTML = headingElement.innerHTML
      headingHTML = headingHTML.slice(headingHTML.indexOf(' ') + 1)

      newHeadingElement = document.createElement(tag)
      newHeadingElement.innerHTML = headingHTML

      headingElement.parentElement?.replaceChild(newHeadingElement, headingElement)

  ###
  handleInput: (event, editable)->
    console.log(event)
    currentSelectedElement = @editor.getSelectedParentElement()
    textContent = currentSelectedElement.textContent

    headingTest = textContent.match(/^#+\s/i)
    if headingTest && headingTest[0].length - 1 <= 6
      # @editor.selectElement(currentSelectedElement)
      # @editor.pasteHTML('<h1> haha </h1>')
      heading = 'h' + (headingTest[0].length - 1)
      currentSelectedElement.classList.add('heading')
      currentSelectedElement.setAttribute('data-heading', heading)
    else if (blockquoteTest = textContent.match(/^>\s/i)) && blockquoteTest
      @editor.selectElement(currentSelectedElement)
      @editor.execAction('formatBlock', {value: 'blockquote'})
    else
      # remove all unnecessary classes and attributes
      currentSelectedElement.classList.remove('heading')
      # currentSelectedElement.classList.remove('blockquote')

      currentSelectedElement.removeAttribute('data-heading')

      if currentSelectedElement.previousElementSibling?.hasAttribute('data-heading')
        headingElement = currentSelectedElement.previousElementSibling
        tag = headingElement.getAttribute('data-heading')
        headingHTML = headingElement.innerHTML
        headingHTML = headingHTML.slice(headingHTML.indexOf(' ') + 1)

        @editor.selectElement(headingElement)
        @editor.pasteHTML("<#{tag}>#{headingHTML}</#{tag}>")

        @editor.selectElement(currentSelectedElement)
      else if currentSelectedElement.classList.contains('blockquote') && currentSelectedElement.previousElementSibling?.textContent.length == 0
        currentSelectedElement.previousElementSibling.remove('blockquote')
        currentSelectedElement.classList.remove('blockquote')
  ###
