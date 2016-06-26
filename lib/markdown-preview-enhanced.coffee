MarkdownPreviewEnhancedView = require './markdown-preview-enhanced-view'
{CompositeDisposable} = require 'atom'
path = require 'path'

{getReplacedTextEditorStyles} = require './style'

module.exports = MarkdownPreviewEnhanced =
  view: null,
  katexStyle: null,

  activate: (state) ->
    console.log 'actvate markdown-preview-enhanced', state
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # set opener
    atom.workspace.addOpener (uri)=>
      if (uri.startsWith('markdown-preview-enhanced://'))
        return @view

    @view = new MarkdownPreviewEnhancedView(state, 'markdown-preview-enhanced://preview')

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'markdown-preview-enhanced:toggle': => @toggle()

  deactivate: ->
    @subscriptions.dispose()
    @view.destroy()

    console.log 'deactivate markdown-preview-enhanced'

  serialize: ->
    # console.log 'package serialize'
    state: @view.serialize()

  toggle: ->
    if @view.editor
      @view.destroy()
    else
      ## check if it is valid markdown file
      editor = atom.workspace.getActiveTextEditor()

      if @checkValidMarkdownFile(editor)
        @appendGlobalStyle()
        @view.bindEditor editor

  checkValidMarkdownFile: (editor)->
    if !editor or !editor.getFileName()
      atom.notifications.addError('Markdown file should be saved first.')
      return false

    fileName = editor.getFileName().trim()
    if !fileName.endsWith('.md')
      atom.notifications.addError('Invalid Markdown file: ' + fileName + '. The file extension should be .md' )
      return false

    buffer = editor.buffer
    if !buffer
      atom.notifications.addError('Invalid Markdown file: ' + fileName)
      return false

    return true

  appendGlobalStyle: ()->
    if not @katexStyle
      @katexStyle = document.createElement 'link'
      @katexStyle.rel = 'stylesheet'
      @katexStyle.href = path.resolve(__dirname, '../node_modules/katex/dist/katex.min.css')
      document.getElementsByTagName('head')[0].appendChild(@katexStyle)

      textEditorStyle = document.createElement('style')
      textEditorStyle.innerHTML = getReplacedTextEditorStyles()
      textEditorStyle.setAttribute('for', 'markdown-preview-enhanced')

      head = document.getElementsByTagName('head')[0]
      atomStyles = document.getElementsByTagName('atom-styles')[0]
      head.insertBefore(textEditorStyle, atomStyles)
