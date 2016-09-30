path = require 'path'
fs = require 'fs'
{execFile} = require 'child_process'
matter = require 'gray-matter'
{Directory} = require 'atom'
async = require 'async'
Viz = require '../dependencies/viz/viz.js'
plantumlAPI = require './puml'
codeChunkAPI = require './code-chunk'
{svgAsPngUri} = require '../dependencies/save-svg-as-png/save-svg-as-png.js'

getFileExtension = (documentType)->
  if documentType == 'pdf_document' or documentType == 'beamer_presentation'
    'pdf'
  else if documentType == 'word_document'
    'docx'
  else if documentType == 'rtf_document'
    'rtf'
  else if documentType == 'custom_document'
    '*'
  else
    atom.notifications.addError('Invalid output format', detail: documentType)
    null

# eg: process config inside pdf_document block
processOutputConfig = (config, args)->
  if config['toc']
    args.push '--toc'
  if config['toc_depth']
    args.push('--toc-depth='+config['toc_depth'])

  if config['highlight']
    if config['highlight'] == 'default'
      config['highlight'] = 'pygments'
    args.push('--highlight-style='+config['highlight'])
  if config['highlight'] == null
    args.push('--no-highlight')

  if config['pandoc_args']
    for arg in config['pandoc_args']
      args.push(arg)

  if config['citation_package']
    if config['citation_package'] == 'natbib'
      args.push('--natbib')
    else if config['citation_package'] == 'biblatex'
      args.push('--biblatex')

  if config['number_sections']
    args.push('--number-sections')

  if config['incremental']
    args.push('--incremental')

  if config['slide_level']
    args.push('--slide-level='+config['slide_level'])

  if config['theme']
    args.push('-V', 'theme:'+config['theme'])

  if config['colortheme']
    args.push('-V', 'colortheme:'+config['colortheme'])

  if config['fonttheme']
    args.push('-V', 'fonttheme:'+config['fonttheme'])

  if config['latex_engine']
    args.push('--latex-engine='+config['latex_engine'])

  if config['includes'] and typeof(config['includes']) == 'object'
    includesConfig = config['includes']
    helper = (prefix, data)->
      if typeof(data) == 'string'
        args.push prefix+data
      else if data.constructor == Array
        data.forEach (d)->
          args.push prefix+d
      else
        args.push prefix+data

    # TODO: includesConfig['in_header'] is array
    if includesConfig['in_header']
      helper('--include-in-header=', includesConfig['in_header'])
    if includesConfig['before_body']
      helper('--include-before-body=', includesConfig['before_body'])
    if includesConfig['after_body']
      helper('--include-after-body=', includesConfig['after_body'])

  if config['template']
    args.push('--template=' + config['template'])

loadOutputYAML = (md, config)->
  yamlPath = path.resolve(md.rootDirectoryPath, '_output.yaml')
  try
    yaml = fs.readFileSync yamlPath
  catch error
    return Object.assign({}, config)

  data = matter('---\n'+yaml+'---\n').data
  data = data || {}

  if config['output']
    if typeof(config['output']) == 'string' and data[config['output']]
      format = config['output']
      config['output'] = {}
      config['output'][format] = data[format]
    else
      format = Object.keys(config['output'])[0]
      if data[format]
        config['output'][format] = Object.assign({}, data[format], config['output'][format])

  Object.assign({}, data, config)

processConfigPaths = (config, rootDirectoryPath, projectDirectoryPath)->
  # same as the one in processPaths function
  # TODO: refactor in the future
  resolvePath = (src)->
    if src.startsWith('/')
      return path.relative(rootDirectoryPath, path.resolve(projectDirectoryPath, '.'+src))
    else # ./test.png or test.png
      return src

  helper = (data)->
    if typeof(data) == 'string'
      return resolvePath(data)
    else if data.constructor == Array
      return data.map (d)->resolvePath(d)
    else
      data

  if config['bibliography']
    config['bibliography'] = helper(config['bibliography'])

  if config['csl']
    config['csl'] = helper(config['csl'])

  if config['output'] and typeof(config['output']) == 'object'
    documentFormat = Object.keys(config['output'])[0]
    outputConfig = config['output'][documentFormat]
    if outputConfig['includes']
      if outputConfig['includes']['in_header']
        outputConfig['includes']['in_header'] = helper(outputConfig['includes']['in_header'])
      if outputConfig['includes']['before_body']
        outputConfig['includes']['before_body'] = helper(outputConfig['includes']['before_body'])
      if outputConfig['includes']['after_body']
        outputConfig['includes']['after_body'] = helper(outputConfig['includes']['after_body'])

    if outputConfig['reference_docx']
      outputConfig['reference_docx'] = helper(outputConfig['reference_docx'])

    if outputConfig['template']
      outputConfig['template'] = helper(outputConfig['template'])

# convert mermaid, wavedrom, viz.js from svg to png
processGraphs = (text, rootDirectoryPath, callback)->
  lines = text.split('\n')
  codes = []

  i = 0
  while i < lines.length
    line = lines[i]
    trimmedLine = line.trim()
    if trimmedLine.startsWith('```{') and trimmedLine.endsWith('}')
      numOfSpacesAhead = line.match(/\s*/).length

      j = i + 1
      content = ''
      while j < lines.length
        if lines[j].trim() == '```' and lines[j].match(/\s*/).length == numOfSpacesAhead
          codes.push({start: i, end: j, content: content.trim()})
          i = j
          break
        content += (lines[j]+'\n')
        j += 1
    i += 1

  return processCodes(codes, lines, rootDirectoryPath, callback)

saveSvgAsPng = (svgElement, dest, option={}, cb)->
  return cb(null) if !svgElement or svgElement.tagName.toLowerCase() != 'svg'

  if typeof(option) == 'function' and !cb
    cb = option
    option = {}

  svgAsPngUri svgElement, option, (data)->
    base64Data = data.replace(/^data:image\/png;base64,/, "")
    fs.writeFile dest, base64Data, 'base64', (err)->
      cb(err)



# {start, end, content}
processCodes = (codes, lines, rootDirectoryPath, callback)->
  asyncFunctions = []

  for codeData in codes
    {start, end, content} = codeData
    def = lines[start].trim().slice(3)

    match = def.match(/^{(mermaid|wavedrom|viz|plantuml|puml)}$/)

    if match  # builtin graph
      graphType = match[1]

      if graphType == 'mermaid'
        helper = (start, end, content)->
          (cb)->
            mermaid.parseError = (err, hash)->
              atom.notifications.addError 'mermaid error', detail: err

            if mermaidAPI.parse(content)
              div = document.createElement('div')
              div.classList.add('mermaid')
              div.textContent = content
              document.body.appendChild(div)

              mermaid.init null, div, ()->
                svgElement = div.getElementsByTagName('svg')[0]

                dest = path.resolve(rootDirectoryPath, (Math.random().toString(36).substr(2, 9)) + '_mermaid.png')

                saveSvgAsPng svgElement, dest, {}, (error)->
                  document.body.removeChild(div)
                  cb(null, {dest, start, end, content, type: 'graph'})
            else
              cb(null, null)

        asyncFunc = helper(start, end, content)
        asyncFunctions.push asyncFunc

      else if graphType == 'viz'
        helper = (start, end, content)->
          (cb)->
            div = document.createElement('div')
            div.innerHTML = Viz(content)

            dest = path.resolve(rootDirectoryPath, (Math.random().toString(36).substr(2, 9)) + '_viz.png')

            svgElement = div.children[0]
            width = svgElement.getBBox().width
            height = svgElement.getBBox().height

            saveSvgAsPng svgElement, dest, {width, height}, (error)->
              cb(null, {dest, start, end, content, type: 'graph'})


        asyncFunc = helper(start, end, content)
        asyncFunctions.push asyncFunc

      else if graphType == 'wavedrom'
        # not supported

      else # plantuml
        helper = (start, end, content)->
          (cb)->
            div = document.createElement('div')
            plantumlAPI.render content, (outputHTML)->
              div.innerHTML = outputHTML

              dest = path.resolve(rootDirectoryPath, (Math.random().toString(36).substr(2, 9)) + '_puml.png')

              svgElement = div.children[0]
              width = svgElement.getBBox().width
              height = svgElement.getBBox().height

              saveSvgAsPng svgElement, dest, {width, height}, (error)->
                cb(null, {dest, start, end, content, type: 'graph'})

        asyncFunc = helper(start, end, content)
        asyncFunctions.push asyncFunc
    else # code chunk
         # TODO: support this in the future
      helper = (start, end, content)->
        (cb)->
          def = lines[start].trim().slice(3)
          match = def.match(/^\{\s*(\"[^\"]*\"|[^\s]*|[^}]*)(.*)}$/)

          cmd = match[1].trim()
          cmd = cmd.slice(1, cmd.length-1).trim() if cmd[0] == '"'
          dataArgs = match[2].trim()

          options = null
          try
            options = JSON.parse '{'+dataArgs.replace((/([(\w)|(\-)]+)(:)/g), "\"$1\"$2").replace((/'/g), "\"")+'}'
          catch error
            atom.notifications.addError('Invalid options', detail: dataArgs)
            return

          codeChunkAPI.run content, rootDirectoryPath, cmd, options, (error, data, options)->
            outputType = options.output || 'text'

            if outputType == 'text'
              cb(null, {start, end, content, type: 'code_chunk', hide: options.hide, data, cmd})
            else if outputType == 'none'
              cb(null, {start, end, content, type: 'code_chunk', hide: options.hide, cmd})
            else if outputType == 'html'
              div = document.createElement('div')
              div.innerHTML = data
              if div.children[0].tagName.toLowerCase() == 'svg'
                dest = path.resolve(rootDirectoryPath, (Math.random().toString(36).substr(2, 9)) + '_cc.png')

                svgElement = div.children[0]
                width = svgElement.getBBox().width
                height = svgElement.getBBox().height
                saveSvgAsPng svgElement, dest, {width, height}, (error)->
                  cb(null, {start, end, content, type: 'code_chunk', hide: options.hide, dest, cmd})
              else
                cb(null, {start, end, content, type: 'code_chunk', hide: options.hide, data, cmd})
            else
              cb(null, null)

      asyncFunc = helper(start, end, content)
      asyncFunctions.push asyncFunc

  async.parallel asyncFunctions, (error, dataArray)->
    # TODO: deal with error in the future.
    #
    imagePaths = []

    for d in dataArray
      continue if !d
      {start, end, type} = d
      if type == 'graph'
        {dest} = d
        imgMd = "![](#{path.relative(rootDirectoryPath, dest)})"
        imagePaths.push dest

        lines[start] = imgMd

        i = start + 1
        while i <= end
          lines[i] = null # filter out later.
          i += 1
      else # code chunk
        {hide, data, dest, cmd} = d
        if hide
          i = start
          while i <= end
            lines[i] = null
            i += 1
          lines[end] = ''
        else # replace ```{python} to ```python
          line = lines[start]
          i = line.indexOf('```')
          lines[start] = line.slice(0, i+3) + cmd

        if dest
          imagePaths.push dest
          imgMd = "![](#{path.relative(rootDirectoryPath, dest)})"
          lines[end] += ('\n' + imgMd)

        if data
          lines[end] += ('\n' + data)

    lines = lines.filter (line)-> line!=null
              .join('\n')
    callback lines, imagePaths

processPaths = (text, rootDirectoryPath, projectDirectoryPath)->
  match = null
  offset = 0
  output = ''

  resolvePath = (src)->
    if src.startsWith('/')
      return path.relative(rootDirectoryPath, path.resolve(projectDirectoryPath, '.'+src))
    else # ./test.png or test.png
      return src

  # replace path in ![](...) and []()
  r = /(\!?\[.*?]\()([^\)|^'|^"]*)(.*?\))/gi
  text = text.replace r, (whole, a, b, c)->
    if b[0] == '<'
      b = b.slice(1, b.length-1)
      a + '<' + resolvePath(b.trim()) + '> ' + c
    else
      a + resolvePath(b.trim()) + ' ' + c

  # replace path in tag
  r = /(<[img|a|iframe].*?[src|href]=['"])(.+?)(['"].*?>)/gi
  text = text.replace r, (whole, a, b, c)->
    a + resolvePath(b) + c

  text
###
title
author
date
path: ./
output:
###
pandocConvert = (text, md, config={})->
  config = loadOutputYAML md, config
  args = []

  extension = null
  outputConfig = null
  documentFormat = null
  if config['output']
    if typeof(config['output']) == 'string'
      documentFormat = config['output']
      extension = getFileExtension(documentFormat)
    else
      documentFormat = Object.keys(config['output'])[0]
      extension = getFileExtension(documentFormat)
      outputConfig = config['output'][documentFormat]
  else
    atom.notifications.addError('Output format needs to be specified')
  return if not extension

  # custom_document requires path to be defined
  if documentFormat == 'custom_document' and (!outputConfig || !outputConfig['path'])
    return atom.notifications.addError('custom_document requires path to be defined')

  if documentFormat == 'beamer_presentation'
    args.push('-t', 'beamer')

  # dest
  if outputConfig and outputConfig['path']
    outputFilePath = outputConfig['path']
    if outputFilePath.startsWith('/')
      outputFilePath = path.resolve(md.projectDirectoryPath, '.'+outputFilePath)
    else
      outputFilePath = path.resolve(md.rootDirectoryPath, outputFilePath)

    if documentFormat != 'custom_document' and path.extname(outputFilePath) != '.' + extension
      return atom.notifications.addError('Invalid extension for ' + documentFormat, detail: 'required .' + extension + ', but ' + path.extname(outputFilePath) + ' was provided.')

    args.push '-o', outputFilePath
  else
    outputFilePath = md.editor.getPath()
    outputFilePath = outputFilePath.slice(0, outputFilePath.length - path.extname(outputFilePath).length) + '.' + extension
    args.push '-o', outputFilePath

  # resolve paths in front-matter(yaml)
  processConfigPaths config, md.rootDirectoryPath, md.projectDirectoryPath

  if outputConfig
    processOutputConfig outputConfig, args

  # add front-matter(yaml) to text
  text = matter.stringify(text, config)

  # change link path to relative path
  text = processPaths text, md.rootDirectoryPath, md.projectDirectoryPath

  # change working directory
  cwd = process.cwd()
  process.chdir(md.rootDirectoryPath)

  # citation
  if config['bibliography'] or config['references']
    args.push('--filter', 'pandoc-citeproc')

  atom.notifications.addInfo('Your document is being prepared', detail: ':)')

  # mermaid / viz / wavedrom graph
  processGraphs text, md.rootDirectoryPath, (text, imagePaths=[])->
    # console.log args.join(' ')
    #
    # pandoc will cause error if directory doesn't exist,
    # therefore I will create directory first.
    directory = new Directory(path.dirname(outputFilePath))
    directory.create().then (flag)->
      program = execFile 'pandoc', args, (err)->
        # remove images
        imagePaths.forEach (p)->
          fs.unlink(p)

        process.chdir(cwd) # change cwd back
        if err
          atom.notifications.addError 'pandoc error', detail: err
          return
        atom.notifications.addInfo "File #{path.basename(outputFilePath)} was created", detail: "path: #{outputFilePath}"
      program.stdin.end(text)

module.exports = pandocConvert
