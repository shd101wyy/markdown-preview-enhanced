katex = require 'katex'
cheerio = require 'cheerio'
path = require 'path'
fs = require 'fs'
remarkable = require 'remarkable'
uslug = require 'uslug'
Highlights = require(path.join(atom.getLoadSettings().resourcePath, 'node_modules/highlights/lib/highlights.js'))
{File} = require 'atom'
matter = require('gray-matter')
async = null

{mermaidAPI} = require('../dependencies/mermaid/mermaid.min.js')
toc = require('./toc')
{scopeForLanguageName} = require './extension-helper'
customSubjects = require './custom-comment'
{fileImport} = require('./file-import.coffee')
{protocolsWhiteListRegExp} = require('./protocols-whitelist')
{pandocRender} = require('./pandoc-convert')

mathRenderingOption = atom.config.get('markdown-preview-enhanced.mathRenderingOption')
mathRenderingIndicator = inline: [['$', '$']], block: [['$$', '$$']]
enableWikiLinkSyntax = atom.config.get('markdown-preview-enhanced.enableWikiLinkSyntax')
wikiLinkFileExtension = atom.config.get('markdown-preview-enhanced.wikiLinkFileExtension')
frontMatterRenderingOption = atom.config.get('markdown-preview-enhanced.frontMatterRenderingOption')
globalMathTypesettingData = {}
useStandardCodeFencingForGraphs = atom.config.get('markdown-preview-enhanced.useStandardCodeFencingForGraphs')
usePandocParser = atom.config.get('markdown-preview-enhanced.usePandocParser')

TAGS_TO_REPLACE = {
    '&': '&amp;',
    '<': '&lt;',
    '>': '&gt;',
    '"': '&quot;',
    '\'': '&#x27;',
    '\/', '&#x2F;',
    '\\', '&#x5C;',
}

TAGS_TO_REPLACE_REVERSE = {
    '&amp;': '&',
    '&lt;': '<',
    '&gt;': '>',
    '&quot;': '"',
    '&apos;': '\'',
    '&#x27;': '\'',
    '&#x2F;': '\/',
    '&#x5C;': '\\',
}

highlighter = null
String.prototype.escape = ()->
  this.replace /[&<>"'\/\\]/g, (tag)-> TAGS_TO_REPLACE[tag] or tag

String.prototype.unescape = ()->
  this.replace /\&(amp|lt|gt|quot|apos|\#x27|\#x2F|\#x5C)\;/g, (whole)-> TAGS_TO_REPLACE_REVERSE[whole] or whole

####################################################
## Mermaid
##################################################
loadMermaidConfig = ()->
  # mermaid_config.js
  configPath = path.resolve(atom.config.configDirPath, './markdown-preview-enhanced/mermaid_config.js')
  try
    return require(configPath)
  catch error
    mermaidConfigFile = new File(configPath)
    mermaidConfigFile.create().then (flag)->
      if !flag # already exists
        atom.notifications.addError('Failed to load mermaid_config.js', detail: 'there might be errors in your config file')
        return

      mermaidConfigFile.write """
'use strict'
// config mermaid init call
// http://knsv.github.io/mermaid/#configuration
//
// you can edit the 'config' variable below
// everytime you changed this file, you may need to restart atom.
let config = {
  startOnLoad: false
}

module.exports = config || {startOnLoad: false}
"""
    return {startOnLoad: false}

mermaidAPI.initialize(loadMermaidConfig())

#################################################
## Math
#################################################
atom.config.observe 'markdown-preview-enhanced.mathRenderingOption',
  (option)->
    if option == 'None'
      mathRenderingOption = null
    else
      mathRenderingOption = option

atom.config.observe 'markdown-preview-enhanced.indicatorForMathRenderingInline',
  (indicatorStr)->
    try
      indicators = JSON.parse(indicatorStr).filter (x)->x.length == 2
      mathRenderingIndicator.inline = indicators
    catch error
      console.log error

atom.config.observe 'markdown-preview-enhanced.indicatorForMathRenderingBlock',
  (indicatorStr)->
    try
      indicators = JSON.parse(indicatorStr).filter (x)->x.length == 2
      mathRenderingIndicator.block = indicators
    catch error
      console.log error

atom.config.observe 'markdown-preview-enhanced.enableWikiLinkSyntax',
  (flag)->
    enableWikiLinkSyntax = flag

atom.config.observe 'markdown-preview-enhanced.wikiLinkFileExtension', (extension)->
  wikiLinkFileExtension = extension

atom.config.observe 'markdown-preview-enhanced.frontMatterRenderingOption',
  (flag)->
    frontMatterRenderingOption = flag

atom.config.observe 'markdown-preview-enhanced.useStandardCodeFencingForGraphs', (flag)->
  useStandardCodeFencingForGraphs = flag

atom.config.observe 'markdown-preview-enhanced.usePandocParser', (flag)->
  usePandocParser = flag

#################################################
## Remarkable
#################################################
defaults =
  html:         true,        # Enable HTML tags in source
  xhtmlOut:     false,       # Use '/' to close single tags (<br />)
  breaks:       true,        # Convert '\n' in paragraphs into <br>
  langPrefix:   'language-', # CSS language prefix for fenced blocks
  linkify:      true,        # autoconvert URL-like texts to links
  linkTarget:   '',          # set target to open link in
  typographer:  true,        # Enable smartypants and other sweet transforms

md = new remarkable('full', defaults)

atom.config.observe 'markdown-preview-enhanced.breakOnSingleNewline',
  (breakOnSingleNewline)->
    md.set({breaks: breakOnSingleNewline})

atom.config.observe 'markdown-preview-enhanced.enableTypographer', (enableTypographer)->
  md.set({typographer: enableTypographer})


# inline MATH rule
# $...$
# $$...$$
md.inline.ruler.before 'escape', 'math',
  (state, silent)->
    if !mathRenderingOption
      return false

    openTag = null
    closeTag = null
    displayMode = true
    inline = mathRenderingIndicator.inline
    block = mathRenderingIndicator.block

    for b in block
      if state.src.startsWith(b[0], state.pos)
        openTag = b[0]
        closeTag = b[1]
        displayMode = true
        break

    if !openTag
      for i in inline
        if state.src.startsWith(i[0], state.pos)
          openTag = i[0]
          closeTag = i[1]
          displayMode = false
          break

    if !openTag
      return false

    content = null
    end = -1

    i = state.pos + openTag.length
    while i < state.src.length
      if state.src.startsWith(closeTag, i)
        end = i
        break
      else if state.src[i] == '\\'
        i += 1
      i += 1

    if end >= 0
      content = state.src.slice(state.pos + openTag.length, end)
    else
      return false

    if content and !silent
      state.push
        type: 'math'
        content: content.trim(),
        openTag: openTag
        closeTag: closeTag
        displayMode: displayMode

      state.pos += (content.length + openTag.length + closeTag.length)
      return true
    else
      return false

parseMath = ({content, openTag, closeTag, displayMode})->
  return if !content
  if mathRenderingOption == 'KaTeX'
    if globalMathTypesettingData.isForPreview
      displayModeAttr = if displayMode then 'display-mode' else ''
      if !globalMathTypesettingData.katex_s.length
        return "<span class='katex-exps' #{displayModeAttr}>#{content.escape()}</span>"
      else
        element = globalMathTypesettingData.katex_s.splice(0, 1)[0]
        if element.getAttribute('data-original') == content and element.hasAttribute('display-mode') == displayMode
          return "<span class='katex-exps' data-original=\"#{content}\" data-processed #{displayModeAttr}>#{element.innerHTML}</span>"
        else
          return "<span class='katex-exps' #{displayModeAttr}>#{content.escape()}</span>"

    else # not for preview
      try
        return katex.renderToString content, {displayMode}
      catch error
        return "<span style=\"color: #ee7f49; font-weight: 500;\">#{error}</span>"

  else if mathRenderingOption == 'MathJax'
    text = (openTag + content + closeTag).replace(/\n/g, '')
    tag = if displayMode then 'div' else 'span'

    # if it's for preview
    # we need to save the math expression data to 'data-original' attribute
    # then we compared it with text to see whether the math expression is modified or not.
    if globalMathTypesettingData.isForPreview
      if !globalMathTypesettingData.mathjax_s.length
        return "<#{tag} class=\"mathjax-exps\">#{text.escape()}</#{tag}>"
      else
        element = globalMathTypesettingData.mathjax_s.splice(0, 1)[0]
        if element.getAttribute('data-original') == text and element.tagName.toLowerCase() == tag and element.hasAttribute('data-processed')  # math expression not changed
          return "<#{tag} class=\"mathjax-exps\" data-original=\"#{text}\" data-processed>#{element.innerHTML}</#{tag}>"
        else
          return "<#{tag} class=\"mathjax-exps\">#{text.escape()}</#{tag}>"
    else
      ## this doesn't work
      # element = globalMathTypesettingData.mathjax_s.splice(0, 1)[0]
      # return "<div class=\"mathjax-exps\"> #{element.innerHTML} </div>"
      return text.escape()

md.renderer.rules.math = (tokens, idx)->
  return parseMath(tokens[idx] or {})

# inline [[]] rule
# [[...]]
md.inline.ruler.before 'autolink', 'wikilink',
  (state, silent)->
    if !enableWikiLinkSyntax or !state.src.startsWith('[[', state.pos)
      return false
    content = null
    tag = ']]'
    end = -1

    i = state.pos + tag.length
    while i < state.src.length
      if state.src[i] == '\\'
        i+=1
      else if state.src.startsWith(tag, i)
        end = i
        break
      i+=1

    if end >= 0 # found ]]
      content = state.src.slice(state.pos + tag.length, end)
    else
      return false

    if content and !silent
      state.push
        type: 'wikilink'
        content: content
      state.pos += content.length + 2 * tag.length
      return true
    else
      return false

md.renderer.rules.wikilink = (tokens, idx)->
  {content} = tokens[idx]
  if !content
    return

  splits = content.split('|')
  linkText = splits[0].trim()
  wikiLink = if splits.length == 2 then "#{splits[1].trim()}#{wikiLinkFileExtension}" else "#{linkText.replace(/\s/g, '')}#{wikiLinkFileExtension}"

  return "<a href=\"#{wikiLink}\">#{linkText}</a>"

# custom comment
md.block.ruler.before 'code', 'custom-comment',
  (state, start, end, silent)->
    pos = state.bMarks[start] + state.tShift[start]
    max = state.eMarks[start]
    src = state.src

    if pos >= max
       return false
    if src.startsWith('<!--', pos)
      end = src.indexOf('-->', pos + 4)
      if (end >= 0)
        content = src.slice(pos + 4, end).trim()

        match = content.match(/(\s|\n)/) # find ' ' or '\n'
        if !match
          firstIndexOfSpace = content.length
        else
          firstIndexOfSpace = match.index

        subject = content.slice(0, firstIndexOfSpace)

        if !customSubjects[subject] # check if it is a valid subject
          # it's not a valid subject, therefore escape it
          state.line = start + 1 + (src.slice(pos + 4, end).match(/\n/g)||[]).length
          return true

        rest = content.slice(firstIndexOfSpace+1).trim()

        match = rest.match(/(?:[^\s\n:"']+|"[^"]*"|'[^']*')+/g) # split by space and \newline and : (not in single and double quotezz)

        if match and match.length % 2 == 0
          option = {}
          i = 0
          while i < match.length
            key = match[i]
            value = match[i+1]
            try
              option[key] = JSON.parse(value)
            catch e
              null # do nothing
            i += 2
        else
          option = {}

        state.tokens.push
          type: 'custom'
          subject: subject
          option: option

        state.line = start + 1 + (src.slice(pos + 4, end).match(/\n/g)||[]).length
        return true
      else
        return false
    else if src[pos] == '[' and src.slice(pos, max).match(/^\[toc\]\s*$/i) # [TOC]
      state.tokens.push
        type: 'custom'
        subject: 'toc-bracket'
        option: {}
      state.line = start + 1
      return true
    else
      return false

# task list
md.renderer.rules.list_item_open = (tokens, idx)->
  if tokens[idx + 2]
    children = tokens[idx + 2].children
    if !children or !children[0]?.content
      return '<li>'
    line = children[0].content
    if line.startsWith('[ ] ') or line.startsWith('[x] ') or line.startsWith('[X] ')
      children[0].content = line.slice(3)
      checked = !(line[1] == ' ')
      checkBox = "<input type=\"checkbox\" class=\"task-list-item-checkbox\" #{if checked then 'checked' else ''}>"
      level = children[0].level
      # children = [{content: checkBox, type: 'htmltag', level}, ...children]
      children = [{content: checkBox, type: 'htmltag', level}].concat(children)

      tokens[idx + 2].children = children
      return '<li class="task-list-item">'
    return '<li>'
  else
    return '<li>'

# code fences
# modified to support code chunk
# check https://github.com/jonschlinkert/remarkable/blob/875554aedb84c9dd190de8d0b86c65d2572eadd5/lib/rules.js
md.renderer.rules.fence = (tokens, idx, options, env, instance)->
  token = tokens[idx]
  langClass = ''
  langPrefix = options.langPrefix
  langName = token.params.escape()

  if token.params
    langClass = ' class="' + langPrefix + langName + '" ';

  # get code content
  content = token.content.escape()

  # copied from getBreak function.
  break_ = '\n'
  if idx < tokens.length && tokens[idx].type == 'list_item_close'
    break_ = ''

  if langName == 'math'
    openTag = mathRenderingIndicator.block[0][0] or '$$'
    closeTag = mathRenderingIndicator.block[0][1] or '$$'
    mathHtml = parseMath({openTag, closeTag, content: content.unescape(), displayMode: true})
    return "<p>#{mathHtml}</p>"

  return '<pre><code' + langClass + '>' + content + '</code></pre>' + break_

# Build offsets for each line (lines can be wrapped)
# That's a bit dirty to process each line everytime, but ok for demo.
# Optimizations are required only for big texts.
buildScrollMap = (markdownPreview)->
  editor = markdownPreview.editor
  markdownHtmlView = markdownPreview.getElement()
  lines = editor.getBuffer().getLines()

  _scrollMap = []
  nonEmptyList = []

  acc = 0

  linesCount = editor.getScreenLineCount()

  for i in [0...linesCount]
    _scrollMap.push(-1)

  nonEmptyList.push(0)
  _scrollMap[0] = 0

  # 把有标记 data-line 的 element 的 offsetTop 记录到 _scrollMap
  # write down the offsetTop of element that has 'data-line' property to _scrollMap
  lineElements = markdownHtmlView.getElementsByClassName('sync-line')

  for i in [0...lineElements.length]
    el = lineElements[i]
    t = el.getAttribute('data-line')
    continue if !t

    t = editor.screenRowForBufferRow(parseInt(t)) # get screen buffer row

    continue if !t

    # this is for ignoring footnote scroll match
    if t < nonEmptyList[nonEmptyList.length - 1]
      el.removeAttribute('data-line')
    else
      nonEmptyList.push(t)

      offsetTop = 0
      while el and el != markdownHtmlView
        offsetTop += el.offsetTop
        el = el.offsetParent

      _scrollMap[t] = Math.round(offsetTop)

  nonEmptyList.push(linesCount)
  _scrollMap.push(markdownHtmlView.scrollHeight)

  pos = 0
  for i in [1...linesCount]
    if _scrollMap[i] != -1
      pos++
      continue

    a = nonEmptyList[pos]
    b = nonEmptyList[pos + 1]
    _scrollMap[i] = Math.round((_scrollMap[b] * (i - a) + _scrollMap[a] * (b - i)) / (b - a))

  return _scrollMap  # scrollMap's length == screenLineCount

# Add lineno-#num class to set width of line number
addLineNumber = (highlightedBlock)->
  totoalLineNo = highlightedBlock[0].children.length #.children().length()
  if totoalLineNo < 100
    highlightedBlock.addClass('lineNo lineno-100')
  else if totoalLineNo < 1000
    highlightedBlock.addClass('lineNo lineno-1000')
  else if totoalLineNo < 10000
    highlightedBlock.addClass('lineNo lineno-10000')
  else
    highlightedBlock.addClass('lineNo lineno-100000')

# graphType = 'mermaid' | 'plantuml' | 'wavedrom'
checkGraph = (graphType, graphArray=[], preElement, text, option, $, offset=-1)->
  if option.isForPreview
    $preElement = $(preElement)
    if !graphArray.length
      $el = $("<div class=\"#{graphType} mpe-graph\" data-offset=\"#{offset}\">#{text}</div>")
      $el.attr 'data-original', text

      $preElement.replaceWith $el
    else
      element = graphArray.splice(0, 1)[0] # get the first element
      if element.getAttribute('data-original') == text and element.getAttribute('data-processed') == 'true' # graph not changed
        $el = $("<div class=\"#{graphType} mpe-graph\" data-processed=\"true\" data-offset=\"#{offset}\">#{element.innerHTML}</div>")
        $el.attr 'data-original', text

        $preElement.replaceWith $el
      else if graphType == 'plantuml' # prevent plantuml flickering
        $el = $("<div class=\"plantuml mpe-graph initialized\" data-offset=\"#{offset}\">#{element.innerHTML}</div>")
        $el.attr 'data-original', text

        $preElement.replaceWith $el
      else
        $el = $("<div class=\"#{graphType} mpe-graph\" data-offset=\"#{offset}\">#{text}</div>")
        $el.attr('data-original', text)

        $preElement.replaceWith $el
  else if option.isForEbook
    ### doesn't work...
    if graphType == 'viz'
      Viz = require('../dependencies/viz/viz.js')
      $el = $("<div></div>")
      $el.html(Viz(text))
      $(preElement).replaceWith $el
    else
      $(preElement).replaceWith "<pre>Graph is not supported in EBook</pre>"
    ###
    $el = $("<div class=\"#{graphType} mpe-graph\" #{if graphType in ['wavedrom', 'mermaid'] then "data-offset=\"#{offset}\"" else ''}>Graph is not supported in EBook</div>")
    $el.attr 'data-original', text

    $(preElement).replaceWith $el
  else
    element = graphArray.splice(0, 1)[0]
    if element
      $(preElement).replaceWith "<div class=\"#{graphType} mpe-graph\">#{element.innerHTML}</div>"
    else
      $(preElement).replaceWith "<pre>please wait till preview finishes rendering graph </pre>"

# eg '#gege .class1 haha="yoo"' given a element <div></div>
# return <div id="gege" class="class1" haha="yoo"></div>
addClassesAndIdAndAttrs = ($el, parameters)->
  if match = (parameters + ' ').match(/([\#.](\S+?)\s)|((\S+?)\s*=\s*(\"(.+?)\"|\'(.+?)\'|\[[^\]]*\]|\{[\}]*\}|(\S+)))/g)
    match.forEach (param)->
      param = param.trim()
      if param[0] == '#'
        $el.attr('id', param.slice(1))
      else if param[0] == '.'
        $el.addClass(param.slice(1))
      else
        offset = param.indexOf('=')
        id = param.substring(0, offset).trim().toLowerCase()
        val = param.substring(offset+1).trim()
        if val[0] in ['"', "'"]
          val = val.substring(1, val.length - 1)
        if id == 'class'
          $el.addClass(val)
        else
          $el.attr(id, val)

# eg '#gege .class1' given a element <div></div>
# return <div id="gege" class="class1" haha="yoo"></div>
addClassesAndId = ($el, parameters)->
  if match = (parameters + ' ').match(/([\#.](\S+?)\s)/g)
    match.forEach (param)->
      param = param.trim()
      if param[0] == '#'
        $el.attr('id', param.slice(1))
      else if param[0] == '.'
        $el.addClass(param.slice(1))

# resolve image path and pre code block...
# check parseMD function, 'option' is the same as the option in paseMD.
resolveImagePathAndCodeBlock = (html, graphData={}, codeChunksData={},  option={})->
  {fileDirectoryPath, projectDirectoryPath} = option

  if !fileDirectoryPath
    return

  $ = cheerio.load(html)
  wavedromOffset = 0
  mermaidOffset = 0

  $('img, a').each (i, imgElement)->
    srcTag = 'src'
    if imgElement.name == 'a'
      srcTag = 'href'

    img = $(imgElement)
    src = img.attr(srcTag)

    if src and
      (!(src.match(protocolsWhiteListRegExp) or
        src.startsWith('data:image/') or
        src[0] == '#' or
        src[0] == '/'))
      if !option.useRelativeImagePath
        img.attr(srcTag, 'file:///'+path.resolve(fileDirectoryPath,  src))

    else if (src and src[0] == '/')  # absolute path
      if option.useRelativeImagePath
        img.attr(srcTag, path.relative(fileDirectoryPath, path.resolve(projectDirectoryPath, '.' + src)))
      else
        img.attr(srcTag, 'file:///'+path.resolve(projectDirectoryPath, '.' + src))

  renderCodeBlock = (preElement, text, parameters)->
    highlighter ?= new Highlights({registry: atom.grammars, scopePrefix: 'mpe-syntax--'})
    if match = parameters.match(/\s*([^\s]+)\s+\{(.+?)\}/)
      lang = match[1]
      parameters = match[2]
    else
      lang = parameters
      parameters = ''

    if lang[0] == '.'
      lang = lang.substring(1)

    html = highlighter.highlightSync
            fileContents: text,
            scopeName: scopeForLanguageName(lang)

    highlightedBlock = $(html)
    highlightedBlock.removeClass('editor').addClass('lang-' + lang)

    if parameters
      addClassesAndId(highlightedBlock, parameters)
      if highlightedBlock.hasClass('lineNo')
        addLineNumber(highlightedBlock)

    $(preElement).replaceWith(highlightedBlock)

  # parse eg:
  # {node args:["-v"], output:"html"}
  renderCodeChunk = (preElement, text, parameters, codeChunksData={})->
    if match = parameters.match(/^\{([^\s]+)\s+(.+?)\}$/)
      lang = match[1]
      parameters = match[2]
    else
      lang = parameters.substring(0, parameters.length).trim()
      parameters = ''

    return if !lang

    highlightedBlock = ''
    buttonGroup = ''
    statusDiv = '<div class="status">running...</div>'

    $el = $("<div class=\"code-chunk\"></div>")
    $el.attr 'data-lang': lang, 'data-code': text, 'data-args': parameters, 'data-root-directory-path': fileDirectoryPath

    # addClassesAndIdAndAttrs($el, parameters)
    if classMatch = parameters.match(/\s*class\s*:\s*\"([^\"]*)\"/)
      $el.addClass classMatch[1]
    if idMatch = parameters.match(/\s*id\s*:\s*\"([^\"]*)\"/)
      $el.attr 'id', idMatch[1]

    if not /\s*hide\s*:\s*true/.test(parameters)
      highlighter ?= new Highlights({registry: atom.grammars, scopePrefix: 'mpe-syntax--'})
      html = highlighter.highlightSync
              fileContents: text,
              scopeName: scopeForLanguageName(lang)

      highlightedBlock = $(html)
      highlightedBlock.removeClass('editor').addClass('lang-' + lang)

      if $el.hasClass('lineNo')
        addLineNumber(highlightedBlock)

      buttonGroup = '<div class="btn-group"><div class="run-btn btn"><span>▶︎</span></div><div class=\"run-all-btn btn\">all</div></div>'

    $el.append(highlightedBlock)
    $el.append(buttonGroup)
    $el.append(statusDiv)
    $(preElement).replaceWith $el

  $('pre').each (i, preElement)->
    if preElement.children[0]?.name == 'code'
      codeBlock = $(preElement).children().first()
      lang = 'text'
      if codeBlock.attr('class')
        lang = codeBlock.attr('class').replace(/^language-/, '') or 'text'
      text = codeBlock.text()

    else
      lang = 'text'
      if preElement.children[0]
        text = preElement.children[0].data
      else
        text = ''

    if useStandardCodeFencingForGraphs
      mermaidRegExp = /^\@?mermaid/
      plantumlRegExp = /^\@?(plantuml|puml)/
      wavedromRegExp = /^\@?wavedrom/
      vizRegExp = /^\@?(viz|dot)/
    else # only works with @ appended at front
      mermaidRegExp = /^\@mermaid/
      plantumlRegExp = /^\@(plantuml|puml)/
      wavedromRegExp = /^\@wavedrom/
      vizRegExp = /^\@(viz|dot)/


    if lang.match mermaidRegExp
      mermaid.parseError = (err, hash)->
        renderCodeBlock(preElement, err, 'text')

      element = graphData.mermaid_s?[0]
      # prevent mermaidAPI.parse if content not changed
      if (element && element.getAttribute('data-processed') == 'true' && element.getAttribute('data-original') == text) or mermaidAPI.parse(text.trim())
        checkGraph 'mermaid', graphData.mermaid_s, preElement, text, option, $, mermaidOffset

        mermaidOffset += 1

    else if lang.match plantumlRegExp
      checkGraph 'plantuml', graphData.plantuml_s, preElement, text, option, $

    else if lang.match wavedromRegExp
      checkGraph 'wavedrom', graphData.wavedrom_s, preElement, text, option, $, wavedromOffset
      wavedromOffset += 1
    else if lang.match vizRegExp
      checkGraph 'viz', graphData.viz_s, preElement, text, option, $
    else if lang[0] == '{' && lang[lang.length-1] == '}'
      renderCodeChunk(preElement, text, lang, codeChunksData)
    else
      renderCodeBlock(preElement, text, lang)

  return $.html()

###
# process input string, skip front-matter

if display table
  return {
    content: rest of input string after skipping front matter (but with '\n' included)
    table: string of <table>...</table> generated from data
  }
else
  return {
    content: replace ---\n with ```yaml
    table: '',
  }
###
processFrontMatter = (inputString, hideFrontMatter=false)->
  toTable = (arg)->
    if arg instanceof Array
      tbody = "<tbody><tr>"
      for item in arg
        tbody += "<td>#{toTable(item)}</td>"
      tbody += "</tr></tbody>"

      "<table>#{tbody}</table>"
    else if typeof(arg) == 'object'
      thead = "<thead><tr>"
      tbody = "<tbody><tr>"
      for key of arg
        thead += "<th>#{key}</th>"
        tbody += "<td>#{toTable(arg[key])}</td>"
      thead += "</tr></thead>"
      tbody += "</tr></tbody>"

      "<table>#{thead}#{tbody}</table>"
    else
      arg

  # https://regexper.com/
  r = /^-{3}[\n\r]([\w|\W]+?)[\n\r]-{3}[\n\r]/

  match = r.exec(inputString)

  if match
    yamlStr = match[0]
    data = matter(yamlStr).data

    if usePandocParser # use pandoc parser, so don't change inputString
      return {content: inputString, table: '', data}
    else if hideFrontMatter or frontMatterRenderingOption[0] == 'n' # hide
      content = '\n'.repeat(yamlStr.match(/\n/g)?.length or 0) + inputString.slice(yamlStr.length)
      return {content, table: '', data}
    else if frontMatterRenderingOption[0] == 't' # table
      content = '\n'.repeat(yamlStr.match(/\n/g)?.length or 0) + inputString.slice(yamlStr.length)

      # to table
      if typeof(data) == 'object'
        table = toTable(data)
      else
        table = "<pre>Failed to parse YAML.</pre>"

      return {content, table, data}
    else # if frontMatterRenderingOption[0] == 'c' # code block
      content = '```yaml\n' + match[1] + '\n```\n' + inputString.slice(yamlStr.length)

      return {content, table: '', data}

  {content: inputString, table: ''}

###
update editor toc
return true if toc is updated
###
updateTOC = (markdownPreview, tocConfigs)->
  return false if !markdownPreview or tocConfigs.tocStartLine_s.length != tocConfigs.tocEndLine_s.length

  equal = (arr1, arr2)->
    return false if arr1.length != arr2.length
    i = 0
    while i < arr1.length
      if arr1[i] != arr2[i]
        return false
      i += 1
    return true

  tocNeedUpdate = false
  if !markdownPreview.tocConfigs
    tocNeedUpdate = true
  else if !equal(markdownPreview.tocConfigs.tocOrdered_s, tocConfigs.tocOrdered_s) or !equal(markdownPreview.tocConfigs.tocDepthFrom_s, tocConfigs.tocDepthFrom_s) or !equal(markdownPreview.tocConfigs.tocDepthTo_s, tocConfigs.tocDepthTo_s)
    tocNeedUpdate = true
  else
    headings = tocConfigs.headings
    headings2 = markdownPreview.tocConfigs.headings
    if headings.length != headings2.length
      tocNeedUpdate = true
    else
      for i in [0...headings.length]
        if headings[i].content != headings2[i].content or headings[i].level != headings2[i].level
          tocNeedUpdate = true
          break

  if tocNeedUpdate
    editor = markdownPreview.editor
    buffer = editor.buffer
    tab = editor.getTabText() or '\t'

    headings = tocConfigs.headings
    tocOrdered_s = tocConfigs.tocOrdered_s
    tocDepthFrom_s = tocConfigs.tocDepthFrom_s
    tocDepthTo_s = tocConfigs.tocDepthTo_s
    tocStartLine_s = tocConfigs.tocStartLine_s
    tocEndLine_s = tocConfigs.tocEndLine_s

    if buffer
      i = 0
      delta = 0
      while i < tocOrdered_s.length
        tocOrdered = tocOrdered_s[i]
        tocDepthFrom = tocDepthFrom_s[i]
        tocDepthTo = tocDepthTo_s[i]
        tocStartLine = tocStartLine_s[i] + delta
        tocEndLine = tocEndLine_s[i] + delta

        tocObject = toc(headings, {ordered: tocOrdered, depthFrom: tocDepthFrom, depthTo: tocDepthTo, tab})

        buffer.setTextInRange([[tocStartLine+1, 0], [tocEndLine, 0]], '\n\n\n')
        buffer.insert([tocStartLine+2, 0], tocObject.content)

        delta += (tocStartLine + tocObject.array.length + 3 - tocEndLine)

        markdownPreview.parseDelay = Date.now() + 500 # prevent render again
        markdownPreview.editorScrollDelay = Date.now() + 500
        markdownPreview.previewScrollDelay = Date.now() + 500

        i += 1

  markdownPreview.tocConfigs = tocConfigs
  return tocNeedUpdate

###
[TOC] for pandoc parser
###
createTOC = ($, tab)->
  $ = cheerio.load($) if (typeof($) == 'string')
  tocHTML = null

  getTOCHtml = ()->
    headings = $('h1, h2, h3, h4, h5, h6')
    tokens = []
    headings.each (i, elem)->
      $heading = $(this)
      if $heading.attr('id')
        tokens.push({content: $heading.html(), id: $heading.attr('id'), level: parseInt($heading[0].name.slice(1))})
    tocObject = toc(tokens, {ordered: false, depthFrom: 1, depthTo: 6, tab: tab or '\t'})
    return md.render(tocObject.content)

  $('p').each (i, elem)->
    $p = $(this)
    if $p.text() == '[MPETOC]'
      tocHTML ?= getTOCHtml()
      $p.replaceWith(tocHTML)

  return $

###
analyze slideConfigs for pandoc
###
analyzeSlideConfigs = (text)->
  slideConfigs = []
  outputString = text.replace /(^|\n)\<\!\-\-\s+slide\s+([\w\W]*?)\-\-\>/g, (whole, prefix, args, offset)->
    match = args.match(/(?:[^\s\n:"']+|"[^"]*"|'[^']*')+/g) # split by space and \newline and : (not in single and double quotezz)

    # skip <!-- slide --> within code block
    # eg:
    # ```html
    # <!-- slide -->
    # ```
    str = text.slice(0, offset)
    n = str.match(/^\`\`\`/gm)?.length or 0
    return whole if n % 2 != 0

    if match and match.length % 2 == 0
      option = {}
      i = 0
      while i < match.length
        key = match[i]
        value = match[i+1]
        try
          option[key] = JSON.parse(value)
        catch e
          null # do nothing
        i += 2
    else
      option = {}

    if prefix == '\n'
      line = str.match(/^/gm).length
    else
      line = 0

    slideConfigs.push option
    return '<span class="new-slide"></span>  \n'

  return {slideConfigs, outputString}



###
# parse markdown content to html

inputString:         string, required
option = {
  useRelativeImagePath:       bool, optional
  isForPreview:         bool, optional
  isForEbook:           bool, optional
  hideFrontMatter:      bool, optional
  markdownPreview:      MarkdownPreviewEnhancedView, optional

  fileDirectoryPath:    string, required
                        the directory path of the markdown file.
  projectDirectoryPath: string, required
}
callback(data)
###
parseMD = (inputString, option={}, callback)->
  {markdownPreview} = option

  # toc
  tocTable = {} # eliminate repeated slug
  tocEnabled = false
  tocBracketEnabled = false
  tocConfigs = {
    headings: [],
    tocStartLine_s: [],
    tocEndLine_s: [],
    tocOrdered_s: [],
    tocDepthFrom_s: [],
    tocDepthTo_s: []
  }

  # slide
  slideConfigs = []

  # yaml
  yamlConfig = null

  # we won't render the graph that hasn't changed
  graphData = null
  codeChunksData = null
  if markdownPreview
    if markdownPreview.graphData
      graphData = {}
      for key of markdownPreview.graphData
        graphData[key] = markdownPreview.graphData[key].slice(0) # fix issue 177... as the array will be `splice` in the future, so need to create new array here
    codeChunksData = markdownPreview.codeChunksData

  # set globalMathTypesettingData
  # so that we won't render the math expression that hasn't changed
  globalMathTypesettingData = {}
  if markdownPreview
    globalMathTypesettingData.isForPreview = option.isForPreview
    if mathRenderingOption == 'KaTeX'
      globalMathTypesettingData.katex_s = Array.prototype.slice.call markdownPreview.getElement().getElementsByClassName('katex-exps')
    else if mathRenderingOption == 'MathJax'
      globalMathTypesettingData.mathjax_s = Array.prototype.slice.call markdownPreview.getElement().getElementsByClassName('mathjax-exps')

  # check front-matter
  {table:frontMatterTable, content:inputString, data:yamlConfig} = processFrontMatter(inputString, option.hideFrontMatter)
  yamlConfig = yamlConfig or {}

  # check document imports
  fileImport(inputString, {filesCache: markdownPreview?.filesCache, fileDirectoryPath: option.fileDirectoryPath, projectDirectoryPath: option.projectDirectoryPath, insertAnchors: option.isForPreview}).then ({outputString:inputString})->
    # check slideConfigs
    if usePandocParser
      {slideConfigs, outputString:inputString} = analyzeSlideConfigs(inputString)

    # overwrite remark heading parse function
    md.renderer.rules.heading_open = (tokens, idx)=>
      line = null
      id = null

      if tokens[idx + 1] and tokens[idx + 1].content
        id = ""
        classes = ""
        ignore = false
        heading = tokens[idx + 1].content

        # check {.class1 .class2 #id1}
        if optMatch = heading.match(/[^\\]\{(.+?)\}/)
          heading = heading.replace(optMatch[0], '')
          tokens[idx + 1].content = heading
          tokens[idx + 1].children[0].content = heading

          opt = optMatch[1]
          if classMatch = opt.match(/\.[^\s]+/g)
            classes = classMatch.map (cl)->
              if cl == '.ignore'
                ignore = true
              cl.slice(1)
            classes = classes.join(' ')

          if idMatch = opt.match(/\#[^\s]+/g)
            id = idMatch[idMatch.length - 1].slice(1)

        id = uslug(heading) if !id
        if (tocTable[id] >= 0)
          tocTable[id] += 1
          id = id + '-' + tocTable[id]
        else
          tocTable[id] = 0

        if !ignore
          tocConfigs.headings.push({content: heading, level: tokens[idx].hLevel})

      id = "id=#{id}" if id
      classes = "class=#{classes}" if classes
      return "<h#{tokens[idx].hLevel} #{id} #{classes}>"

    # <!-- subject options... -->
    md.renderer.rules.custom = (tokens, idx)=>
      subject = tokens[idx].subject

      if subject == 'pagebreak' or subject == 'newpage'
        return '<div class="pagebreak"> </div>'
      else if subject == 'toc'
        tocEnabled = true

        opt = tokens[idx].option
        tocConfigs.tocStartLine_s.push opt.lineNo
        if opt.orderedList and opt.orderedList != 0
          tocConfigs.tocOrdered_s.push true
        else
          tocConfigs.tocOrdered_s.push false

        tocConfigs.tocDepthFrom_s.push opt.depthFrom || 1
        tocConfigs.tocDepthTo_s.push opt.depthTo || 6

      else if (subject == 'tocstop')
        tocConfigs.tocEndLine_s.push tokens[idx].option.lineNo

      else if (subject == 'toc-bracket') # [toc]
        tocBracketEnabled = true
        return '\n[MPETOC]\n'

      else if subject == 'slide'
        opt = tokens[idx].option
        slideConfigs.push(opt)
        return '<span class="new-slide"></span>'
      return ''

    finalize = (html)->
      if markdownPreview and tocEnabled and updateTOC(markdownPreview, tocConfigs)
        return parseMD(markdownPreview.editor.getText(), option, callback)
      else
        markdownPreview?.tocConfigs = tocConfigs

      if tocBracketEnabled # [TOC]
        tocObject = toc(tocConfigs.headings, {ordered: false, depthFrom: 1, depthTo: 6, tab: markdownPreview?.editor?.getTabText() or '\t'})
        tocHtml = md.render(tocObject.content)
        html = html.replace /^\s*\[MPETOC\]\s*/gm, tocHtml

      html = resolveImagePathAndCodeBlock(html, graphData, codeChunksData, option)
      return callback({html: frontMatterTable+html, slideConfigs, yamlConfig})

    if usePandocParser # pandoc parser
      args = yamlConfig.pandoc_args or []
      args = [] if not (args instanceof Array)
      if yamlConfig.bibliography or yamlConfig.references
        args.push('--filter', 'pandoc-citeproc')

      args = atom.config.get('markdown-preview-enhanced.pandocArguments').split(',').map((x)-> x.trim()).concat(args)

      return pandocRender inputString, {args, projectDirectoryPath: option.projectDirectoryPath, fileDirectoryPath: option.fileDirectoryPath}, (error, html)->
        html = "<pre>#{error}</pre>" if error
        # console.log(html)
        # format blocks
        $ = cheerio.load(html)
        $('pre').each (i, preElement)->
          # code block
          if preElement.children[0]?.name == 'code'
            $preElement = $(preElement)
            codeBlock = $(preElement).children().first()
            classes = (codeBlock.attr('class')?.split(' ') or []).filter (x)-> x != 'sourceCode'
            lang = classes[0]

            # graphs
            if $preElement.attr('class')?.match(/(mermaid|viz|dot|puml|plantuml|wavedrom)/)
              lang = $preElement.attr('class')
            codeBlock.attr('class', 'language-' + lang)

            # check code chunk
            if dataCodeChunk = $preElement.parent()?.attr('data-code-chunk')
              codeBlock.attr('class', 'language-' + dataCodeChunk.unescape())
            # check code block
            if dataCodeBlock = $preElement.parent()?.attr('data-code-block')
              codeBlock.attr('class', 'language-' + dataCodeBlock.unescape())

        $ = createTOC($, markdownPreview?.editor?.getTabText())

        return finalize($.html())
    else # remarkable parser
      # parse markdown
      html = md.render(inputString)
      # console.log(html)
      return finalize(html)

module.exports = {
  parseMD,
  buildScrollMap,
  processFrontMatter,
  md
}
