'use strict'
let path = require('path')

module.exports = {
  loadMathJax: function(document) {
    if (typeof(MathJax) === 'undefined' || !MathJax ) {
      let script = document.createElement('script')

      script.addEventListener('load', function() {

        let inline = [['$', '$']],
            block = [['$$', '$$']]

        try {
          inline = JSON.parse(atom.config.get('markdown-preview-enhanced.indicatorForMathRenderingInline')).filter(x=>x.length === 2)
          block = JSON.parse(atom.config.get('markdown-preview-enhanced.indicatorForMathRenderingBlock')).filter(x=>x.length===2)
        } catch (e) {
          atom.notifications.addError('Failed to parse math delimiters')
        }

        // config MathJax
        MathJax.Hub.Config({
          extensions: ['tex2jax.js'],
          jax: ['input/TeX', 'output/HTML-CSS'],
          showMathMenu: false,
          messageStyle: 'none',
          tex2jax: {
            inlineMath: inline,
            displayMath: block,
            processEscapes: true,
            processEnvironments: true,
            preview: 'none',
            // skipTags: ["script","noscript","style","textarea"]
          },
          TeX: {
            extensions: ['AMSmath.js', 'AMSsymbols.js', 'noErrors.js', 'noUndefined.js']
          },
          'HTML-CSS': { availableFonts: ['TeX'] },
          skipStartupTypeset: true
        })

        MathJax.Hub.Configured()
      })

      script.type = 'text/javascript'
      script.src = path.resolve(__dirname, '../mathjax/MathJax.js?delayStartupUntil=configured')

      document.getElementsByTagName('head')[0].appendChild(script)

    }
  }
}
