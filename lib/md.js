'use strict'

/**
 * This file is for parsing Markdown to HTML
 */

let katex = require('katex'), // for katex
    cheerio = require('cheerio'),
    path = require('path'),
    remarkable = require('remarkable'),
    uslug = require('uslug'),
    Highlights = require(path.join(atom.getLoadSettings().resourcePath, 'node_modules/highlights/lib/highlights.js')),
    scopeForLanguageName = require('./extension-helper.js').scopeForLanguageName,
    toc = require('./toc.js'),
    mermaidAPI = require('mermaid/dist/mermaid').mermaidAPI,
    loadMathJax = require('./mathjax-wrapper.js').loadMathJax,
    mathRenderingOption = null

mermaidAPI.initialize({
  startOnLoad: false
})

atom.config.observe('markdown-preview-enhanced.mathRenderingOption', (option)=> {
  if (option === 'None') {
    mathRenderingOption = null
  } else {
    mathRenderingOption = option

    if (mathRenderingOption[0] === 'M') { // MathJax
      loadMathJax(document)
    }
  }
})


let defaults = {
  html:         true,        // Enable HTML tags in source
  xhtmlOut:     false,        // Use '/' to close single tags (<br />)
  breaks:       true,        // Convert '\n' in paragraphs into <br>
  langPrefix:   'language-',  // CSS language prefix for fenced blocks
  linkify:      true,         // autoconvert URL-like texts to links
  linkTarget:   '',           // set target to open link in
  typographer:  true,         // Enable smartypants and other sweet transforms
}

let md = new remarkable(defaults)

// inline MATH rule
// $...$
// $$...$$
md.inline.ruler.before('autolink', 'math', function(state, silent) {
  if (!mathRenderingOption) return false
  if (state.src[state.pos] !== '$') return false

  let content = null
  let tag = '$'
  if (state.src.startsWith('$$', state.pos)) {
    tag = '$$'
  }

  let end = -1
  for (let i = state.pos + tag.length; i < state.src.length; i++) {
    if (state.src[i] === '\\') {
      i++
    } else if (state.src.startsWith(tag, i)) {
      end = i
      break
    }
  }

  if (end >= 0) {
    content = state.src.slice(state.pos + tag.length, end)
  } else {
    return false
  }

  if (content && !silent) {
    state.push({
      type: 'math',
      content: content,
      tag: tag
    })
    state.pos += (content.length + 2 * tag.length)
    return true
  }
  return false
})

md.renderer.rules.math = function(tokens, idx) {
  let content = tokens[idx].content,
      tag = tokens[idx].tag

  if (!content) return

  if (mathRenderingOption === 'KaTeX') {
    try {
      return  katex.renderToString(content, {
                displayMode: (tag === '$' ? false : true)
              })
    } catch (e) {
      return '<span style="color: #ee7f49; font-weight: 500;">{ parse error: ' + content + ' }</span>'
    }
  } else if (mathRenderingOption === 'MathJax') {
    return tag + content + tag
  }
}

// enable footnotes
md.block.ruler.enable([
  'footnote'
])

// custom-comment
md.block.ruler.before('code', 'custom-comment', function(state, start, end, silent) {
  let pos = state.bMarks[start] + state.tShift[start],
      max = state.eMarks[start]
  if (pos >= max) return false
  if (state.src.startsWith('<!--', pos)) {
    let end = state.src.indexOf('-->', pos + 4)
    if (end >= 0) {
      let content = state.src.slice(pos + 4, end).trim()
      state.tokens.push({
        type: 'custom',
        content: content,
        line: state.line
      })
      state.line = start + 1
      return true
    } else {
      return false
    }
  }
})

// Settings
atom.config.observe('markdown-preview-enhanced.breakOnSingleNewline', (breakOnSingleNewline)=> {
  md.set({breaks: breakOnSingleNewline})
})


//
// Inject line numbers for sync scroll. Notes:
//
// - We track only headings and paragraphs on first level. That's enougth.
// - Footnotes content causes jumps. Level limit filter it automatically.
//
// YIYI : 这里我不仅仅 map 了 level 0
md.renderer.rules.paragraph_open = function (tokens, idx) {
  let lineNo = null
  if (tokens[idx].lines /*&& tokens[idx].level === 0*/) {
    lineNo = tokens[idx].lines[0]
    return '<p class="line" data-line="' + lineNo + '">'
  }
  return '<p>'
}

// task list
md.renderer.rules.list_item_open = function(tokens, idx) {
  if (tokens[idx + 2]) {
    let children = tokens[idx + 2].children
    if (!children || !children[0].content) return '<li>'
    let line = children[0].content
    if (line.startsWith('[ ] ') || line.startsWith('[x] ') || line.startsWith('[X] ')) {
      children[0].content = line.slice(3)
      let checked = !(line[1] === ' ')
      let checkBox = `<input type="checkbox" class="task-list-item-checkbox" ${checked? 'checked':''}>`
      let level = children[0].level
      children = [{content: checkBox, type: 'htmltag', level}, ...children]

      tokens[idx + 2].children = children
      return '<li class="task-list-item">'
    }
    return '<li>'
  }
  return '<li>'
}

// Build offsets for each line (lines can be wrapped)
// That's a bit dirty to process each line everytime, but ok for demo.
// Optimizations are required only for big texts.
function buildScrollMap(markdownPreview) {
  var i, offset, nonEmptyList, pos, a, b, lineHeightMap, linesCount, acc, _scrollMap

  let editor = markdownPreview.editor
  let markdownHtmlView = markdownPreview.htmlView
  let lines = editor.getBuffer().getLines()

  // offset = $('.result-html').scrollTop() - $('.result-html').offset().top;
  _scrollMap = []
  nonEmptyList = []
  lineHeightMap = []

  acc = 0;
  lines.forEach(function(str, n) {
    lineHeightMap.push(editor.screenRowForBufferRow(n))
  })
  linesCount = editor.getScreenLineCount()

  for (let i = 0; i < linesCount; i++) { _scrollMap.push(-1); }

  nonEmptyList.push(0)
  _scrollMap[0] = 0

  // 把有标记 data-line 的 element 的 offsetTop 记录到 _scrollMap
  let lineElements = markdownHtmlView.getElementsByClassName('line')

  for (let i = 0; i < lineElements.length; i++) {
    let el = lineElements[i],
        t = el.getAttribute('data-line')
    if (!t) {
      continue
    }
    t = lineHeightMap[parseInt(t)] // get screen buffer row
    if (t !== 0) { nonEmptyList.push(t) }

    let offsetTop = 0
    while (el != markdownHtmlView) {
      offsetTop += el.offsetTop
      el = el.offsetParent
    }

    _scrollMap[t] = Math.round(offsetTop)
  }

  nonEmptyList.push(linesCount)
  _scrollMap.push(markdownHtmlView.scrollHeight)

  pos = 0
  for (i = 1; i < linesCount; i++) {
    if (_scrollMap[i] !== -1) {
      pos++
      continue
    }

    a = nonEmptyList[pos]
    b = nonEmptyList[pos + 1]
    _scrollMap[i] = Math.round((_scrollMap[b] * (i - a) + _scrollMap[a] * (b - i)) / (b - a))
  }

  return _scrollMap  // scrollMap's length == screenLineCount
}

// resolve image path and pre code block...
function resolveImagePathAndCodeBlock(html, directoryPath) {
  if (!directoryPath) return

  let $ = cheerio.load(html)
  $('img').each(function(i, imgElement) {
    let img = $(imgElement)
    let src = img.attr('src')
    if (src &&
      (!(src.startsWith('http://') ||
        src.startsWith('https://') ||
        src.startsWith('atom://')  ||
        src.startsWith('file://'))) &&
      (src.startsWith('./') ||
        src.startsWith('../') ||
        src[0] !== '/')) {
      img.attr('src', path.resolve(directoryPath,  src))
    }
  })

  function renderCodeBlock(preElement, text, lang) {
    let highlighter = new Highlights({registry: atom.grammars}),
        html = highlighter.highlightSync({
          fileContents: text,
          scopeName: scopeForLanguageName(lang),
        })

    let highlightedBlock = $(html)

    highlightedBlock.removeClass('editor').addClass('lang-' + lang)

    $(preElement).replaceWith(highlightedBlock)
  }

  $('pre').each(function(i, preElement) {
    let codeBlock = $(preElement).children().first()
    let lang = 'text'
    if (codeBlock.attr('class')) {
      lang = codeBlock.attr('class').replace(/^language-/, '') || 'text'
    }

    if (lang === 'mermaid') {

      mermaid.parseError = function(err, hash) {
        renderCodeBlock(preElement, err, 'text')
      }

      if (mermaidAPI.parse(codeBlock.text().trim())) {
        $(preElement).replaceWith(`<div class="mermaid"> ${codeBlock.text()} </div>`)
      }
    } else {
      renderCodeBlock(preElement, codeBlock.text(), lang)
    }
  })

  return $.html()
}

// parse markdown content to html
function parseMD(markdownPreview) {
  let editor = markdownPreview.editor
  let rootDirectoryPath = markdownPreview.rootDirectoryPath

  let inputString = markdownPreview.textContent
  let headings = []

  // toc
  let tocNeedUpdate = false
  let tocTable = {} // eliminate repeated slug
  let tocEnabled = false
  let tocStartLine = -1
  let tocEndLine = -1

  // overwrite remark heading parse function
  md.renderer.rules.heading_open = (tokens, idx)=> {
    let line = null,
        id = null

    if (tokens[idx + 1] && tokens[idx + 1].content) {
      id = uslug(tokens[idx + 1].content)
      if (tocTable[id] >= 0) {
        tocTable[id] += 1
        id = id + '-' + tocTable[id]
      } else {
        tocTable[id] = 0
      }
      if (!tocNeedUpdate) {
        headings.push({content: tokens[idx + 1].content, level: tokens[idx].hLevel})
      }
    }

    if (tokens[idx].lines /*&& tokens[idx].level === 0*/) {
      line = tokens[idx].lines[0]
      return `<h${tokens[idx].hLevel} class="line" data-line="${line}" ${id ? `id="${id}"` : ''}>`
    }
    return `<h${tokens[idx].hLevel} ${id ? `id="${id}"` : ''}>`
  }

  // <!-- content -->
  md.renderer.rules.custom = (tokens, idx)=> {
    let content = tokens[idx].content

    if (content === 'pagebreak' || content === 'newpage') {
      return '<div class="pagebreak"> </div>'
    } else if (content === 'toc') {
      tocEnabled = true
      if (tocStartLine === -1) {
        tocStartLine = tokens[idx].line
      } else {
        throw 'Only one toc is supported'
      }
    } else if (content === 'tocstop') {
      if (tocEndLine === -1) {
        tocEndLine = tokens[idx].line
      } else {
        throw "Only on toc is supported"
      }
    }
    return ''
  }


  let html = md.render(inputString)

  // check toc update
  if (tocEnabled) {
    let oldHeadingsLength = markdownPreview.headings.length
    let newHeadingsLength = headings.length
    if (tocStartLine >= 0 && tocEndLine === -1) {
      tocNeedUpdate = true
    } else if (markdownPreview.headings === headings) {
      tocNeedUpdate = false
    } else if (oldHeadingsLength !== newHeadingsLength) {
      tocNeedUpdate = true
    } else {
      for (let i = 0; i < headings.length; i++) {
        if (markdownPreview.headings[i].content !== headings[i].content) {
          tocNeedUpdate = true
          break
        }
      }
    }

    if (tocNeedUpdate && editor) {
      let tocObject = toc(headings)
      let buffer = editor.buffer
      if (buffer) {
        if (tocEndLine === -1) {
          tocEndLine = tocStartLine + 1
          buffer.insert([tocStartLine+1, 0], '<!-- tocstop -->\n')
        }

        markdownPreview.parseDelay = Date.now() + 500 // prevent render again
        markdownPreview.editorScrollDelay = Date.now() + 500
        markdownPreview.previewScrollDelay = Date.now() + 500

        buffer.setTextInRange([[tocStartLine+1, 0], [tocEndLine, 0]], '\n\n\n')
        buffer.insert([tocStartLine+2, 0], tocObject.content)

        // parse markdown content again
        tocTable = {}
        tocEnabled = false
        tocStartLine = -1
        tocEndLine = -1

        markdownPreview.textContent = editor.getText()
        html = md.render(editor.getText())
      }
    }
  }

  markdownPreview.headings = headings

  return resolveImagePathAndCodeBlock(html, rootDirectoryPath)
}

module.exports = {
  parseMD,
  buildScrollMap
}
