// modified version from https://github.com/marcbachmann/node-html-pdf/blob/master/lib/scripts/pdf_a4_portrait.js

/* global phantom */
var system = require('system')
var webpage = require('webpage')

// Error handler
function exit (error) {
  var message
  if (typeof error === 'string') message = error
  if (error) system.stderr.write('html-pdf: ' + (message || 'Unknown Error ' + error) + '\n')
  phantom.exit(error ? 1 : 0)
}

// Build stack to print
function buildStack (msg, trace) {
  var msgStack = [msg]
  if (trace && trace.length) {
    msgStack.push('Stack:')
    trace.forEach(function (t) {
      msgStack.push('  at ' + t.file || t.sourceURL + ': ' + t.line + ' (in function ' + t.function + ')')
    })
  }
  return msgStack.join('\n')
}

phantom.onError = function (msg, trace) {
  exit(buildStack('Script - ' + msg, trace))
}

// Load configurations from stdin
var json = JSON.parse(system.stdin.readLine())
if (!json.html || !json.html.trim()) exit('Did not receive any html')

var options = json.options
var page = webpage.create()

if (options.httpHeaders) page.customHeaders = options.httpHeaders
if (options.viewportSize) page.viewportSize = options.viewportSize
if (options.zoomFactor) page.zoomFactor = options.zoomFactor
if (options.base) page.setContent(json.html, options.base)
else page.setContent(json.html, null)

page.onError = function (msg, trace) {
  exit(buildStack('Evaluation - ' + msg, trace))
}

// Force cleanup after 2 minutes
// Add 2 seconds to make sure master process triggers kill
// before to the phantom process
var timeout = (options.timeout || 120000) + 2000
setTimeout(function () {
  exit('Force timeout')
}, timeout)

// Completely load page & end process
// ----------------------------------
page.onLoadFinished = function (status) {
  // The paperSize object must be set at once
  page.paperSize = definePaperSize(getContent(page), options)

  // Output to parent process
  var fileOptions = {
    type: options.type || 'pdf',
    quality: options.quality || 75
  }

  var filename = options.filename || (options.directory || '/tmp') + '/html-pdf-' + system.pid + '.' + fileOptions.type

  // I added code below
  var interval, allDone

  allDone = page.evaluate(function () {
    if (window.MathJax) {
      MathJax.Hub.Register.StartupHook('End', function () {
        window.allDone = true
      })

      return false
    } else {
      return true
    }
  })

  if (allDone) {
    page.render(filename, fileOptions)
    system.stdout.write(JSON.stringify({filename: filename}))

    exit(null)
    return
  }

  interval = setInterval(function () {
    allDone = page.evaluate(function () {
      return window.allDone
    })

    if (allDone) {
      clearInterval(interval)

      setTimeout(function() {
        page.render(filename, fileOptions)
        system.stdout.write(JSON.stringify({filename: filename}))

        exit(null)
      }, 2000)
    }
  }, 100)
}

// Returns a hash of HTML content
// ------------------------------
function getContent (page) {
  return page.evaluate(function () {
    function getElements (doc, wildcard) {
      var wildcardMatcher = new RegExp(wildcard + '(.*)')
      var hasElements = false
      var elements = {}
      var $elements = document.querySelectorAll("[id*='" + wildcard + "']")

      var $elem, match, i
      var len = $elements.length
      for (i = 0; i < len; i++) {
        $elem = $elements[i]
        match = $elem.attributes.id.value.match(wildcardMatcher)
        if (match) {
          hasElements = true
          elements[match[1]] = $elem.outerHTML
          $elem.parentNode.removeChild($elem)
        }
      }

      if (hasElements) return elements
    }

    function getElement (doc, id) {
      var $elem = doc.getElementById(id)
      if ($elem) {
        var html = $elem.outerHTML
        $elem.parentNode.removeChild($elem)
        return html
      }
    }

    var styles = document.querySelectorAll('link,style')
    styles = Array.prototype.reduce.call(styles, function (string, node) {
      return string + (node.outerHTML || '')
    }, '')

    // Wildcard headers e.g. <div id="pageHeader-first"> or <div id="pageHeader-0">
    var header = getElements(document, 'pageHeader-')
    var footer = getElements(document, 'pageFooter-')

    // Default header and footer e.g. <div id="pageHeader">
    var h = getElement(document, 'pageHeader')
    var f = getElement(document, 'pageFooter')

    if (h) {
      header = header || {}
      header.default = h
    }

    if (f) {
      footer = footer || {}
      footer.default = f
    }

    var body
    var $body = document.getElementById('pageContent')
    if ($body) body = $body.outerHTML
    else body = document.body.outerHTML

    return {
      styles: styles,
      header: header,
      body: body,
      footer: footer
    }
  })
}

// Creates page section
// --------------------
function createSection (section, content, options) {
  options = options[section] || {}
  var c = content[section] || {}
  var o = options.contents
  if (typeof o !== 'object') o = {default: o}

  return {
    height: options.height,
    contents: phantom.callback(function (pageNum, numPages) {
      var html = o[pageNum] || c[pageNum]
      if (pageNum === 1 && !html) html = o.first || c.first
      if (pageNum === numPages && !html) html = o.last || c.last
      return (html || o.default || c.default || '')
        .replace(/{{page}}/g, pageNum)
        .replace(/{{pages}}/g, numPages) + content.styles
    })
  }
}

// Creates paper with specified options
// ------------------------------------
function definePaperOrientation (options) {
  var paper = {border: options.border || '0'}

  if (options.height && options.width) {
    paper.width = options.width
    paper.height = options.height
  } else {
    paper.format = options.format || 'A4'
    paper.orientation = options.orientation || 'portrait'
  }

  return paper
}

// Creates paper with generated footer & header
// --------------------------------------------
function definePaperSize (content, options) {
  var paper = definePaperOrientation(options)

  if (options.header || content.header) {
    paper.header = createSection('header', content, options)
  }

  if (options.footer || content.footer) {
    paper.footer = createSection('footer', content, options)
  }

  if (paper.header && paper.header.height === undefined) paper.header.height = '46mm'
  if (paper.footer && paper.footer.height === undefined) paper.footer.height = '28mm'

  return paper
}
