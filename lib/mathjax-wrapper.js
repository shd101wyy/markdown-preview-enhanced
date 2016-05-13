'use strict'
let path = require('path')

module.exports = {
  loadMathJax: function(document) {
    if (typeof(MathJax) === 'undefined' || !MathJax ) {
      let script = document.createElement('script')

      script.addEventListener('load', function() {

        // config MathJax
        MathJax.Hub.Config({
          extensions: ['tex2jax.js'],
          jax: ['input/TeX', 'output/HTML-CSS'],
          showMathMenu: false,
          messageStyle: 'none',
          tex2jax: {
            inlineMath: [['$','$']],
            displayMath: [['$$','$$']],
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
