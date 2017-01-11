path = require 'path'
fs = require 'fs'
{Directory} = require 'atom'
{execFile} = require 'child_process'
async = require 'async'
Viz = require '../dependencies/viz/viz.js'
plantumlAPI = require './puml'
codeChunkAPI = require './code-chunk'
{svgAsPngUri} = require '../dependencies/save-svg-as-png/save-svg-as-png.js'

# TODO: refactor this file
# it has common functions as pandoc-wrapper.coffee

# convert mermaid, wavedrom, viz.js from svg to png
processGraphs = (text, {rootDirectoryPath, projectDirectoryPath, imageDirectoryPath, outputFilePath}, callback)->
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

  return processCodes(codes, lines, {rootDirectoryPath, projectDirectoryPath, imageDirectoryPath, outputFilePath}, callback)

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
processCodes = (codes, lines, {rootDirectoryPath, projectDirectoryPath, imageDirectoryPath, outputFilePath}, callback)->
  asyncFunctions = []

  imgFilePrefix = outputFilePath.replace(/\//g, '&')
  imgCount = 0

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

                dest = path.resolve(imageDirectoryPath, imgFilePrefix + imgCount + '.png')
                imgCount += 1

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

            dest = path.resolve(imageDirectoryPath, imgFilePrefix + imgCount + '.png')
            imgCount += 1

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

              dest = path.resolve(imageDirectoryPath, imgFilePrefix + imgCount + '.png')
              imgCount += 1

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

          cmd = options.cmd if options.cmd

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
                dest = path.resolve(imageDirectoryPath, imgFilePrefix + imgCount + '.png')
                imgCount += 1

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
        imgMd = "![](#{'/' + path.relative(projectDirectoryPath, dest) + '?' + Math.random()})"
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

processMath = (text)->
  text = text.replace(/\\\$/g, '#slash_dollarsign#')

  # display
  text = text.replace /\$\$([\s\S]+?)\$\$/g, ($0, $1)->
    $1 = $1.replace(/\n/g, '').replace(/\#slash\_dollarsign\#/g, '\\\$')
    $1 = escape($1)
    "<p align=\"center\"><img src=\"http://api.gmath.guru/cgi-bin/gmath?#{$1.trim()}\"/></p>"

  # inline
  r = /\$([\s\S]+?)\$/g
  text = text.replace /\$([\s\S]+?)\$/g, ($0, $1)->
    $1 = $1.replace(/\n/g, '').replace(/\#slash\_dollarsign\#/g, '\\\$')
    $1 = escape($1)
    "<img src=\"http://api.gmath.guru/cgi-bin/gmath?#{$1.trim()}\"/>"

  text = text.replace(/\#slash\_dollarsign\#/g, '\\\$')
  text

# convert relative path to project path
processPaths = (text, rootDirectoryPath, projectDirectoryPath)->
  match = null
  offset = 0
  output = ''

  resolvePath = (src)->
    if src.startsWith('/')
      return src
    else # ./test.png or test.png
      return '/' + path.relative(projectDirectoryPath, path.resolve(rootDirectoryPath, src))

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

markdownConvert = (text, {projectDirectoryPath, rootDirectoryPath}, config={})->
  if !config.path
    return atom.notifications.addError('{path} has to be specified')

  if !config.image_dir
    return atom.notifications.addError('{image_dir} has to be specified')

  # dest
  if config.path[0] == '/'
    outputFilePath = path.resolve(projectDirectoryPath, '.' + config.path)
  else
    outputFilePath = path.resolve(rootDirectoryPath, config.path)

  # change link path to project '/' path
  # this is actually differnet from pandoc-wrapper.coffee
  text = processPaths text, rootDirectoryPath, projectDirectoryPath

  text = processMath text

  # TODO: create imageFolder
  if config['image_dir'][0] == '/'
    imageDirectoryPath = path.resolve(projectDirectoryPath, '.' + config['image_dir'])
  else
    imageDirectoryPath = path.resolve(rootDirectoryPath, config['image_dir'])

  atom.notifications.addInfo('Your document is being prepared', detail: ':)')

  imageDir = new Directory(imageDirectoryPath)
  imageDir.create().then (flag)->

    # mermaid / viz / wavedrom graph
    processGraphs text, {rootDirectoryPath, projectDirectoryPath, imageDirectoryPath, outputFilePath}, (text, imagePaths=[])->
      fs.writeFile outputFilePath, text, (err)->
        return atom.notifications.addError('failed to generate markdown') if err
        atom.notifications.addInfo("File #{path.basename(outputFilePath)} was created", detail: "path: #{outputFilePath}")


module.exports = markdownConvert