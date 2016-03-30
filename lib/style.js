'use strict'
// referred from markdown-preview-view.coffee in the official Markdown Preview
function getTextEditorStyles() {
  let textEditorStyles = document.createElement("atom-styles")
  textEditorStyles.initialize(atom.styles)
  textEditorStyles.setAttribute("context", "atom-text-editor")
  document.body.appendChild(textEditorStyles)

  // Extract style elements content
  let style = Array.prototype.slice.apply(textEditorStyles.childNodes).map((styleElement) => styleElement.innerText)

  // delete element
  textEditorStyles.parentNode.removeChild(textEditorStyles)

  return style
}

function getMarkdownPreviewCSS() {
  let markdownPreviewRules = [],
      ruleRegExp = /\.markdown-katex-preview/,
      cssUrlRefExp = /url\(atom:\/\/markdown-katex-preview\/assets\/(.*)\)/

  for (let i = 0; i < document.styleSheets.length; i++) {
    let stylesheet = document.styleSheets[i]
    if (stylesheet.rules.length) {
      for (let j = 0; j < stylesheet.rules.length; j++) {
        let rule = stylesheet.rules[j]

        // We only need `.markdown-katex-preview` css
        if (rule.cssText.match(ruleRegExp)) {
          markdownPreviewRules.push(rule.cssText)
        }
      }
    }
  }

  return markdownPreviewRules
          .concat(getTextEditorStyles())
          .join('\n')
          .replace(/atom-text-editor/g, 'pre.editor-colors')
          .replace(/:host/g, '.host') // Remove shadow-dom :host selector causing problem on FF
}

module.exports = {
  getTextEditorStyles,
  getMarkdownPreviewCSS
}
