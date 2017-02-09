# referred from markdown-preview-view.coffee in the official Markdown Preview
getTextEditorStyles = ()->
  textEditorStyles = document.createElement("atom-styles")
  textEditorStyles.initialize(atom.styles)
  textEditorStyles.setAttribute("context", "atom-text-editor")
  document.body.appendChild(textEditorStyles)

  # Extract style elements content
  style = Array.prototype.slice.apply(textEditorStyles.childNodes).map((styleElement) -> styleElement.innerText)

  # delete element
  textEditorStyles.parentNode.removeChild(textEditorStyles)

  return style

# get array of styles that has 'atom-text-editor' or ':host'
getReplacedTextEditorStyles = ()->
  styles = getTextEditorStyles()
  output = []

  for i in [0...styles.length]
    if styles[i].indexOf('atom-text-editor') >= 0
      output.push(styles[i]
                    .replace(/atom-text-editor/g, '.markdown-preview-enhanced pre')
                    .replace(/:host/g, '.markdown-preview-enhanced .host')
                    .replace(/\.syntax\-\-/g, '.mpe-syntax--'))

  return output.join('\n')


getMarkdownPreviewCSS = ()->
  markdownPreviewRules = []
  ruleRegExp = /\.markdown-preview-enhanced/
  cssUrlRefExp = /url\(atom:\/\/markdown-preview-enhanced\/assets\/(.*)\)/

  for stylesheet in document.styleSheets
    if stylesheet.rules.length
      for rule in stylesheet.rules
        # We only need `.markdown-preview-enhanced` css
        if rule.cssText.match(ruleRegExp)
          markdownPreviewRules.push(rule.cssText)

  return markdownPreviewRules
          .concat(if atom.config.get('markdown-preview-enhanced.useGitHubSyntaxTheme') then [] else getTextEditorStyles())
          .join('\n')
          .replace(/atom-text-editor/g, 'pre.editor-colors')
          .replace(/:host/g, '.host') # Remove shadow-dom :host selector causing problem on FF
          .replace(/\.syntax\-\-/g, '.mpe-syntax--')

module.exports = {
  getTextEditorStyles
  getMarkdownPreviewCSS
  getReplacedTextEditorStyles
}
