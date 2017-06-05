path = require 'path'
fs = require 'fs'
{Directory} = require 'atom'
processGraphs = require './process-graphs'
encrypt = require './encrypt'
CACHE = require './cache'
{fileImport} = require './file-import'
{protocolsWhiteListRegExp} = require './protocols-whitelist'

# TODO: refactor this file
# it has common functions as pandoc-convert.coffee

processMath = (text)->
  line = text.replace(/\\\$/g, '#slash_dollarsign#')

  inline = JSON.parse(atom.config.get('markdown-preview-enhanced.indicatorForMathRenderingInline'))
  block = JSON.parse(atom.config.get('markdown-preview-enhanced.indicatorForMathRenderingBlock'))

  inlineBegin = '(?:' + inline.map (x)-> x[0]
                      .join('|')
                      .replace(/\\/g, '\\\\')
                      .replace(/([\(\)\[\]\$])/g, '\\$1') + ')'
  inlineEnd = '(?:' + inline.map (x)-> x[1]
                      .join('|')
                      .replace(/\\/g, '\\\\')
                      .replace(/([\(\)\[\]\$])/g, '\\$1') + ')'
  blockBegin = '(?:' + block.map (x)-> x[0]
                      .join('|')
                      .replace(/\\/g, '\\\\')
                      .replace(/([\(\)\[\]\$])/g, '\\$1') + ')'
  blockEnd = '(?:' + block.map (x)-> x[1]
                      .join('|')
                      .replace(/\\/g, '\\\\')
                      .replace(/([\(\)\[\]\$])/g, '\\$1') + ')'

  # display
  line = line.replace new RegExp("(```(?:[\\s\\S]+?)```\\s*(?:\\n|$))|(?:#{blockBegin}([\\s\\S]+?)#{blockEnd})", 'g'), ($0, $1, $2)->
    return $1 if $1
    math = $2
    math = math.replace(/\n/g, '').replace(/\#slash\_dollarsign\#/g, '\\\$')
    math = escape(math)
    "<p align=\"center\"><img src=\"https://latex.codecogs.com/gif.latex?#{math.trim()}\"/></p>"

  # inline
  line = line.replace new RegExp("(```(?:[\\s\\S]+?)```\\s*(?:\\n|$))|(?:#{inlineBegin}([\\s\\S]+?)#{inlineEnd})", 'g'), ($0, $1, $2)->
    return $1 if $1
    math = $2
    math = math.replace(/\n/g, '').replace(/\#slash\_dollarsign\#/g, '\\\$')
    math = escape(math)
    "<img src=\"https://latex.codecogs.com/gif.latex?#{math.trim()}\"/>"

  line = line.replace(/\#slash\_dollarsign\#/g, '\\\$')
  return line

# convert relative path to project path
processPaths = (text, fileDirectoryPath, projectDirectoryPath, useAbsoluteImagePath)->
  match = null
  offset = 0
  output = ''

  resolvePath = (src)->
    if src.match(protocolsWhiteListRegExp)
      return src

    if useAbsoluteImagePath
      if src.startsWith('/')
        return src
      else # ./test.png or test.png
        return '/' + path.relative(projectDirectoryPath, path.resolve(fileDirectoryPath, src))
    else
      if src.startsWith('/')
        return path.relative(fileDirectoryPath, path.resolve(projectDirectoryPath, '.'+src))
      else # ./test.png or test.png
        return src

  inBlock = false
  lines = text.split('\n')
  lines = lines.map (line)->
    if line.match(/^\s*```/)
      inBlock = !inBlock
      line
    else if inBlock
      line
    else
      # replace path in ![](...) and []()
      r = /(\!?\[.*?]\()([^\)|^'|^"]*)(.*?\))/gi
      line = line.replace r, (whole, a, b, c)->
        if b[0] == '<'
          b = b.slice(1, b.length-1)
          a + '<' + resolvePath(b.trim()) + '> ' + c
        else
          a + resolvePath(b.trim()) + ' ' + c

      # replace path in tag
      r = /(<[img|a|iframe].*?[src|href]=['"])(.+?)(['"].*?>)/gi
      line = line.replace r, (whole, a, b, c)->
        a + resolvePath(b) + c
      line

  lines.join('\n')

markdownConvert = (text, {projectDirectoryPath, fileDirectoryPath}, config={})->
  if !config.path
    return atom.notifications.addError('{path} has to be specified')

  if !config.image_dir
    return atom.notifications.addError('{image_dir} has to be specified')

  # dest
  if config.path[0] == '/'
    outputFilePath = path.resolve(projectDirectoryPath, '.' + config.path)
  else
    outputFilePath = path.resolve(fileDirectoryPath, config.path)

  # TODO: create imageFolder
  if config['image_dir'][0] == '/'
    imageDirectoryPath = path.resolve(projectDirectoryPath, '.' + config['image_dir'])
  else
    imageDirectoryPath = path.resolve(fileDirectoryPath, config['image_dir'])

  delete(CACHE[outputFilePath])

  useAbsoluteImagePath = config.absolute_image_path

  # import external files
  fileImport(text, {fileDirectoryPath, projectDirectoryPath, useAbsoluteImagePath, imageDirectoryPath}).then ({outputString:text})->
    # change link path to project '/' path
    # this is actually differnet from pandoc-convert.coffee
    text = processPaths text, fileDirectoryPath, projectDirectoryPath, useAbsoluteImagePath

    text = processMath text

    atom.notifications.addInfo('Your document is being prepared', detail: ':)')

    imageDir = new Directory(imageDirectoryPath)
    imageDir.create().then (flag)->

      # mermaid / viz / wavedrom graph
      processGraphs text, {fileDirectoryPath, projectDirectoryPath, imageDirectoryPath, imageFilePrefix: encrypt(outputFilePath), useAbsoluteImagePath}, (text, imagePaths=[])->
        fs.writeFile outputFilePath, text, (err)->
          return atom.notifications.addError('failed to generate markdown') if err
          atom.notifications.addInfo("File #{path.basename(outputFilePath)} was created", detail: "path: #{outputFilePath}")


module.exports = markdownConvert