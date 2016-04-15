'use strict'

/**
 * This file is for parsing Markdown to HTML
 */

let katex = require("katex"), // for katex
    // highlightjs = require("highlight.js"), // for highlight
    cheerio = require("cheerio"),
    path = require('path'),
    remarkable = require('remarkable'),
    uslug = require('uslug'),
    // Highlights = require('highlights'),
    Highlights = require(path.join(atom.getLoadSettings().resourcePath, 'node_modules/highlights/lib/highlights.js')),
    scopeForLanguageName = require('./extension-helper.js').scopeForLanguageName,
    toc = require('markdown-toc')

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

// Settings
atom.config.observe('atom-markdown-katex.breakOnSingleNewline', (breakOnSingleNewline)=> {
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
  let line = null
  if (tokens[idx].lines /*&& tokens[idx].level === 0*/) {
    line = tokens[idx].lines[0]
    return '<p class="line" data-line="' + line + '">'
  }
  return '<p>'
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
  let lineElements = markdownHtmlView.querySelectorAll ('.line')
  for (let i = 0; i < lineElements.length; i++) {
    let el = lineElements[i],
        t = el.getAttribute('data-line')
    if (t === '') { return; }
    t = lineHeightMap[Number(t)] // get screen buffer row
    if (t !== 0) { nonEmptyList.push(t) }
    _scrollMap[t] = Math.round(el.offsetTop)
  }

  nonEmptyList.push(linesCount)
  _scrollMap[linesCount] = markdownHtmlView.scrollHeight;

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

// replace string within $...$ or $$...$$ with rendered string
function parseKatex(inputString, mathExpressions) {
  let outputString = "",
      mathExpCount = 0
  // return end
  function findEnd(start, tag) {
    let end = -1
    let j
    for (let i = start; i < inputString.length; i++) {
      if (inputString[i] === "\\") {
        i += 1
        continue;
      }
      let match = true
      for (j = 0; j < tag.length; j++) {
        if (i + j >= inputString.length || inputString[i + j] !== tag[j]) {
          match = false;
          break
        }
      }
      if (match) {
        return i
      }
    }
    return end
  }

  for (let i = 0; i < inputString.length; i++) {
    if (inputString[i] === "\\") {
      // fix dollar sign bug
      // eg  \$12 + \$13   should be rendered as $12 + $13
      if (i + 1 < inputString.length && inputString[i + 1] === '$') {
        outputString += '$'
        i += 1
      } else if (inputString.slice(i + 1, i + 8) === 'newpage') {
        outputString += '<div class="newpage"></div>'
        i += 8
      } else {
        outputString += inputString[i];
        if (i + 1 < inputString.length) {
          i += 1;
          outputString += inputString[i]
        }
      }
    } else if (inputString[i] === '$') {
      let tag = (i + 1 < inputString.length && inputString[i + 1] === '$') ? '$$' : '$'
      let start = i + tag.length
      let end = findEnd(start, tag)
      if (end !== -1) {
        try {
          mathExpressions.push(katex.renderToString(inputString.slice(start, end), {
            displayMode: (tag === '$' ? false : true)
          }))
          outputString += '$me' + mathExpCount + '$'
          mathExpCount += 1
        } catch (e) {
          outputString += '<span style="color: #ee7f49; font-weight: 500;">{ parse error: ' + inputString.slice(start, end) + ' }</span>'
        }
        i = end + tag.length - 1
      } else {
        outputString += tag + inputString.slice(start, inputString.length)
        break
      }
    } else if (inputString.startsWith('```', i)) {
      let end = inputString.indexOf('```', i+3)
      outputString += inputString.slice(i, end === -1 ? inputString.length : end + 3)
      if (end === -1) return outputString
      i = end + 2
    } else {
      outputString += inputString[i]
    }
  }
  return outputString
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

  $('pre').each(function(i, preElement) {
    let codeBlock = $(preElement).children().first()
    let lang = 'text'
    if (codeBlock.attr('class')) {
      lang = codeBlock.attr('class').replace(/^language-/, '') || 'text'
    }

    let highlighter = new Highlights({registry: atom.grammars}),
        html = highlighter.highlightSync({
          fileContents: codeBlock.text(),
          scopeName: scopeForLanguageName(lang),
        })

    let highlightedBlock = $(html)

    highlightedBlock.removeClass('editor').addClass('lang-' + lang)

    $(preElement).replaceWith(highlightedBlock)
  })

  return $.html()
}

function replaceMathExpression(html, mathExpressions) {
  for (let i = 0; i < mathExpressions.length; i++) {
    html = html.replace('$me' + i + '$', mathExpressions[i])
  }
  return html
}

// parse markdown content to html
function parseMD(markdownPreview) {
  let editor = markdownPreview.editor
  let rootDirectoryPath = markdownPreview.rootDirectoryPath

  let inputString = markdownPreview.textContent
  let headings = []
  let tocNeedUpdate = false

  // replace math expression
  let useKaTeX = atom.config.get('atom-markdown-katex.useKaTeX')
  let mathExpressions = []
  let replaced = useKaTeX ? parseKatex(inputString, mathExpressions) : inputString
  let tocTable = {} // eliminate repeated slug

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
        headings.push(tokens[idx + 1].content)
      }
    }

    if (tokens[idx].lines /*&& tokens[idx].level === 0*/) {
      line = tokens[idx].lines[0]
      return `<h${tokens[idx].hLevel} class="line" data-line="${line}" ${id ? `id="${id}"` : ''}>`
    }
    return `<h${tokens[idx].hLevel} ${id ? `id="${id}"` : ''}>`
  }

  let html = md.render(replaced)

  // check toc update
  let oldHeadingsLength = markdownPreview.headings.length
  let newHeadingsLength = headings.length
  if (oldHeadingsLength !== newHeadingsLength) {
    markdownPreview.headings = headings
    tocNeedUpdate = true
  } else {
    for (let i = 0; i < headings.length; i++) {
      if (markdownPreview.headings[i] !== headings[i]) {
        markdownPreview.headings = headings
        tocNeedUpdate = true
        break
      }
    }
  }

  if (tocNeedUpdate && inputString.indexOf('<!-- toc -->\n\n') >= 0) {
    // console.log('toc update')
    let cursorPos = editor.getCursorScreenPosition()

    let newReplaced = toc.insert(replaced, {slugify: uslug})

    tocTable = {} // reset tocTable before md
    html = md.render(newReplaced)
    markdownPreview.editor.setText(newReplaced)

    markdownPreview.parseDelay = Date.now() + 500 // prevent render again
    markdownPreview.editorScrollDelay = Date.now() + 500
    markdownPreview.previewScrollDelay = Date.now() + 500

    // set cursor position
    if (newHeadingsLength > oldHeadingsLength) {
      editor.setCursorScreenPosition([cursorPos.row + 1, cursorPos.column])
    } else if (newHeadingsLength < oldHeadingsLength) {
      editor.setCursorScreenPosition([cursorPos.row - 1, cursorPos.column])
    } else {
      editor.setCursorScreenPosition([cursorPos.row, cursorPos.column])
    }
  }

  /*
  console.log(headingNum + ' ' + editor.headingNum)

  let oldHeadingNum = editor.headingNum
  editor.headingNum = headingNum

  // update TOC
  if (headingNum !== oldHeadingNum) {
    let newReplaced = toc.insert(replaced)
    if (newReplaced.length !== replaced.length) {
      let cursorPos = editor.getCursorScreenPosition()
      editor.setText(newReplaced)

      if (newReplaced.length > replaced.length) {
        //editor.setCursorScreenPosition([cursorPos.row + 1, cursorPos.column])
      } else {
        //editor.setCursorScreenPosition([cursorPos.row - 1, cursorPos.column])
      }
    }
    html = md.render(newReplaced)
  }
  */

  // replace math expression back
  html = useKaTeX ? replaceMathExpression(html, mathExpressions) : html

  return resolveImagePathAndCodeBlock(html, rootDirectoryPath)
}

module.exports = {
  parseMD,
  buildScrollMap
}
