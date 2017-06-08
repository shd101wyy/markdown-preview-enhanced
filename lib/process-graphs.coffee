path = require 'path'
fs = require 'fs'
{Directory} = require 'atom'
{execFile} = require 'child_process'
async = require 'async'
Viz = null
plantumlAPI = require './puml'
codeChunkAPI = require './code-chunk'
{svgAsPngUri} = require '../dependencies/save-svg-as-png/save-svg-as-png.js'
{allowUnsafeEval, allowUnsafeNewFunction} = require 'loophole'

# convert mermaid, wavedrom, viz.js from svg to png
# used for markdown-convert and pandoc-convert
# callback: function(text, imagePaths=[]){ ... }
processGraphs = (text, {fileDirectoryPath, projectDirectoryPath, imageDirectoryPath, imageFilePrefix, useAbsoluteImagePath, forPandoc}, callback)->
  lines = text.split('\n')
  codes = []

  i = 0
  while i < lines.length
    line = lines[i]
    trimmedLine = line.trim()
    if trimmedLine.match(/^```\{(.+)\}$/) or
       trimmedLine.match(/^```(mermaid|wavedrom|viz|plantuml|puml|dot)$/)
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
    else if forPandoc and match = trimmedLine.match(/^```(.+?)\{(.+?)\}$/) # remove {...} after lang
      lines[i] = line.replace(match[0], "```#{match[1]}")

    i += 1

  return processCodes(codes, lines, {fileDirectoryPath, projectDirectoryPath, imageDirectoryPath, imageFilePrefix, useAbsoluteImagePath}, callback)

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
processCodes = (codes, lines, {fileDirectoryPath, projectDirectoryPath, imageDirectoryPath, imageFilePrefix, useAbsoluteImagePath}, callback)->
  asyncFunctions = []

  imageFilePrefix = (Math.random().toString(36).substr(2, 9) + '_') if !imageFilePrefix
  imageFilePrefix = imageFilePrefix.replace(/[\/&]/g, '_ss_')
  imageFilePrefix = encodeURIComponent(imageFilePrefix)
  imgCount = 0

  wavedromIdPrefix = 'wavedrom_' + (Math.random().toString(36).substr(2, 9) + '_')
  wavedromOffset = 100

  codeChunksArr = [] # array of {id, options, code}

  for codeData in codes
    {start, end, content} = codeData
    def = lines[start].trim().slice(3)

    if match = def.match(/^(mermaid|wavedrom|viz|plantuml|puml|dot)/)  # builtin graph
      graphType = match[1]

      if graphType == 'mermaid'
        helper = (start, end, content)->
          (cb)->
            mermaid.parseError = (err, hash)->
              atom.notifications.addError 'mermaid error', detail: err

            if mermaidAPI.parse(content)
              div = document.createElement('div')
              # div.style.display = 'none' # will cause font issue.
              div.classList.add('mermaid')
              div.textContent = content
              document.body.appendChild(div)

              mermaid.init null, div, ()->
                svgElement = div.getElementsByTagName('svg')[0]
                svgElement.classList.add('mermaid')

                dest = path.resolve(imageDirectoryPath, imageFilePrefix + imgCount + '.png')
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
            options = {}

            # check engine
            content = content.trim().replace /^engine(\s)*[:=]([^\n]+)/, (a, b, c)->
              options.engine = c.trim() if c?.trim() in ['circo', 'dot', 'fdp', 'neato', 'osage', 'twopi']
              return ''

            Viz ?= require '../dependencies/viz/viz.js'
            div.innerHTML = Viz(content, options)

            dest = path.resolve(imageDirectoryPath, imageFilePrefix + imgCount + '.png')
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
        null
        ###
        helper = (start, end, content)->
          (cb)->
            div = document.createElement('div')
            div.id = wavedromIdPrefix + wavedromOffset
            div.style.display = 'none'

            # check engine
            content = content.trim()

            allowUnsafeEval ->
              try
                document.body.appendChild(div)
                WaveDrom.RenderWaveForm(wavedromOffset, eval("(#{content})"), wavedromIdPrefix)
                wavedromOffset += 1

                dest = path.resolve(imageDirectoryPath, imageFilePrefix + imgCount + '.png')
                imgCount += 1

                svgElement = div.children[0]
                width = svgElement.getBBox().width
                height = svgElement.getBBox().height

                console.log('rendered WaveDrom')
                window.svgElement = svgElement

                saveSvgAsPng svgElement, dest, {width, height}, (error)->
                  document.body.removeChild(div)
                  cb(null, {dest, start, end, content, type: 'graph'})
              catch error
                console.log('failed to render wavedrom')
                document.body.removeChild(div)
                cb(null, null)

        asyncFunc = helper(start, end, content)
        asyncFunctions.push asyncFunc
        ###
      else # plantuml
        helper = (start, end, content)->
          (cb)->
            div = document.createElement('div')
            plantumlAPI.render content, fileDirectoryPath, (outputHTML)->
              div.innerHTML = outputHTML

              dest = path.resolve(imageDirectoryPath, imageFilePrefix + imgCount + '.png')
              imgCount += 1

              svgElement = div.children[0]
              width = svgElement.getBBox().width
              height = svgElement.getBBox().height

              saveSvgAsPng svgElement, dest, {width, height}, (error)->
                cb(null, {dest, start, end, content, type: 'graph'})

        asyncFunc = helper(start, end, content)
        asyncFunctions.push asyncFunc
    else # code chunk
      helper = (start, end, content)->
        (cb)->
          def = lines[start].trim().slice(3)
          match = def.match(/^\{\s*(\"[^\"]*\"|[^\s]*|[^}]*)(.*)}$/)
          return cb(null, null) if !match

          lang = match[1].trim()
          lang = lang.slice(1, lang.length-1).trim() if lang[0] == '"'
          dataArgs = match[2].trim()

          options = null
          try
            allowUnsafeEval ->
              options = eval("({#{dataArgs}})")
            # options = JSON.parse '{'+dataArgs.replace((/([(\w)|(\-)]+)(:)/g), "\"$1\"$2").replace((/'/g), "\"")+'}'
          catch error
            atom.notifications.addError('Invalid options', detail: dataArgs)
            return cb(null, null)

          id = options.id

          codeChunksArr.push {id, code: content, options}

          # check continue
          currentCodeChunk = codeChunksArr[codeChunksArr.length - 1]
          while currentCodeChunk?.options.continue
            last = null
            if currentCodeChunk.options.continue == true
              offset = 0
              while offset < codeChunksArr.length - 1
                if codeChunksArr[offset + 1] == currentCodeChunk
                  last = codeChunksArr[offset]
                  break
                offset += 1
            else # continue with id
              for c in codeChunksArr
                if c.id == currentCodeChunk.options.continue
                  last = c
                  break

            if last
              content = last.code + '\n' + content
              options = Object.assign({}, last.options, options)
            else # error
              break

            currentCodeChunk = last

          cmd = options.cmd or lang

          if cmd.match(/(la)tex/)
            options.latex_svg_dir = imageDirectoryPath

          codeChunkAPI.run content, fileDirectoryPath, cmd, options, (error, data, options)->
            outputType = options.output || 'text'
            return cb(null, {start, end, content, lang, type: 'code-chunk', hide: options.hide, data: ''}) if !data

            if outputType == 'text'
              # Chinese character will cause problem in pandoc
              cb(null, {start, end, content, lang, type: 'code_chunk', hide: options.hide, data: "```\n#{data.trim()}\n```\n"})
            else if outputType == 'none'
              cb(null, {start, end, content, lang, type: 'code_chunk', hide: options.hide})
            else if outputType == 'html'
              div = document.createElement('div')
              div.innerHTML = data
              if div.children[0]?.tagName.toLowerCase() == 'svg'
                dest = path.resolve(imageDirectoryPath, imageFilePrefix + imgCount + '.png')
                imgCount += 1

                svgElement = div.children[0]
                width = svgElement.getBBox().width
                height = svgElement.getBBox().height
                saveSvgAsPng svgElement, dest, {width, height}, (error)->
                  cb(null, {start, end, content, lang, type: 'code_chunk', hide: options.hide, dest})
              else
                # html will not be working with pandoc.
                cb(null, {start, end, content, lang, type: 'code_chunk', hide: options.hide, data})
            else if outputType == 'markdown'
              cb(null, {start, end, content, lang, type: 'code_chunk', hide: options.hide, data})
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
        if useAbsoluteImagePath
          imgMd = "![](#{'/' + path.relative(projectDirectoryPath, dest) + '?' + Math.random()})  "
        else
          imgMd = "![](#{path.relative(fileDirectoryPath, dest) + '?' + Math.random()})  "
        imagePaths.push dest

        lines[start] = imgMd

        i = start + 1
        while i <= end
          lines[i] = null # filter out later.
          i += 1
      else # code chunk
        {hide, data, dest, lang} = d
        if hide
          i = start
          while i <= end
            lines[i] = null
            i += 1
          lines[end] = ''
        else # replace ```{python} to ```python
          line = lines[start]
          i = line.indexOf('```')
          lines[start] = line.slice(0, i+3) + lang

        if dest
          imagePaths.push dest
          if useAbsoluteImagePath
            imgMd = "![](#{'/' + path.relative(projectDirectoryPath, dest) + '?' + Math.random()})  "
          else
            imgMd = "![](#{path.relative(fileDirectoryPath, dest) + '?' + Math.random()})  "
          lines[end] += ('\n' + imgMd)

        if data
          lines[end] += ('\n' + data)

    lines = lines.filter (line)-> line!=null
              .join('\n')
    callback lines, imagePaths


module.exports = processGraphs