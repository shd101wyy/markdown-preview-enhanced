path = require('path')

module.exports =
  loadMathJax: (document, callback)->
    if typeof(MathJax) == 'undefined'
      script = document.createElement('script')
      script.addEventListener 'load', ()->
        inline = [['$', '$']]
        block = [['$$', '$$']]

        try
          inline = JSON.parse(atom.config.get('markdown-preview-enhanced.indicatorForMathRenderingInline')).filter (x)->x.length==2
          block = JSON.parse(atom.config.get('markdown-preview-enhanced.indicatorForMathRenderingBlock')).filter (x)->x.length==2
        catch error
          atom.notifications.addError('Failed to parse math delimiters')

        #  config MathJax
        MathJax.Hub.Config({
          extensions: ['tex2jax.js'],
          jax: ['input/TeX', 'output/HTML-CSS'],
          showMathMenu: false,
          messageStyle: 'none',
          tex2jax: {
            inlineMath: inline,
            displayMath: block,
            processEscapes: true,
            processEnvironments: atom.config.get('markdown-preview-enhanced.mathJaxProcessEnvironments'),
            # preview: 'none',
            # skipTags: ["script","noscript","style","textarea"]
          },
          TeX: {
            extensions: ['AMSmath.js', 'AMSsymbols.js', 'noErrors.js', 'noUndefined.js']
          },
          'HTML-CSS': { availableFonts: ['TeX'] },
          skipStartupTypeset: true
        })

        MathJax.Hub.Configured()
        callback?()

      script.type = 'text/javascript'
      script.src = path.resolve(__dirname, '../dependencies/mathjax/MathJax.js?delayStartupUntil=configured')

      document.getElementsByTagName('head')[0].appendChild(script)

    else
      callback?()
