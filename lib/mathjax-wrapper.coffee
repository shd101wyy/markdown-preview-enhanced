path = require 'path'
fs = require 'fs'

MathJaxConfig = null

# load ~/.atom/markdown-preview-enhanced/mathjax_config.js file
loadMathJaxConfig = ()->
  # mathjax_config.js
  configPath = path.resolve(atom.config.configDirPath, './markdown-preview-enhanced/mathjax_config.js')
  try
    return require(configPath)
  catch error
    if fs.existsSync(configPath)
      return atom.notifications.addError('Failed to load mathjax_config.js', detail: 'there might be errors in your config file')
    fs.writeFileSync configPath, """
/*
  Restarting ATOM is required to take effect after you modify this file.
 */
module.exports = function(inlineMath, displayMath) {
  const processEnvironments = false

  return {
    forPreview: {
      extensions: ['tex2jax.js'],
      jax: ['input/TeX', 'output/HTML-CSS'],
      showMathMenu: false,
      messageStyle: 'none',
      tex2jax: {
        inlineMath: inlineMath,
        displayMath: displayMath,
        processEscapes: true,
        processEnvironments: processEnvironments
      },
      TeX: {
        extensions: ['AMSmath.js', 'AMSsymbols.js', 'noErrors.js', 'noUndefined.js']
      },
      'HTML-CSS': { availableFonts: ['TeX'] },
      skipStartupTypeset: true
    },

    forExport: {
      extensions: ['tex2jax.js'],
      jax: ['input/TeX','output/HTML-CSS'],
      messageStyle: 'none',
      tex2jax: {
        inlineMath: inlineMath,
        displayMath: displayMath,
        processEnvironments: processEnvironments,
        processEscapes: true
      },
      TeX: {
        extensions: ['AMSmath.js', 'AMSsymbols.js', 'noErrors.js', 'noUndefined.js']
      },
      'HTML-CSS': { availableFonts: ['TeX'] }
    }
  }
}
  """

    return require(configPath)

getMathJaxConfigForExport = (cdn=false)->
  config = MathJaxConfig.forExport
  if !cdn
    return config
  else
    # xypic.js
    extensions = config.TeX.extensions or []
    extensions = extensions.map (e)->
      if e == 'xypic.js'
        return 'http://sonoisa.github.io/xyjax_ext/xypic.js'
      else
        return e
    config.TeX.extensions = extensions
    return config

loadMathJax = (document, callback)->
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

      MathJaxConfig ?= loadMathJaxConfig()(inline, block)

      #  config MathJax
      MathJax.Hub.Config(MathJaxConfig.forPreview)

      MathJax.Hub.Configured()
      callback?(MathJaxConfig.forPreview)

    script.type = 'text/javascript'
    script.src = path.resolve(__dirname, '../dependencies/mathjax/MathJax.js?delayStartupUntil=configured')

    document.getElementsByTagName('head')[0].appendChild(script)

  else
    callback?(MathJaxConfig.forPreview)


module.exports = {
  loadMathJaxConfig,
  loadMathJax,
  getMathJaxConfigForExport
}
