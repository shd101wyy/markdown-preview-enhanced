path = require 'path'
fs = require 'fs'
{execFile} = require 'child_process'
matter = require 'gray-matter'
{Directory} = require 'atom'
async = require 'async'
Viz = require '../dependencies/viz/viz.js'
codeChunkAPI = require './code-chunk'
{svgAsPngUri} = require '../dependencies/save-svg-as-png/save-svg-as-png.js'
processGraphs = require './process-graphs'
{fileImport} = require './file-import'

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

loadOutputYAML = (fileDirectoryPath, config)->
  yamlPath = path.resolve(fileDirectoryPath, '_output.yaml')
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

processConfigPaths = (config, fileDirectoryPath, projectDirectoryPath)->
  # same as the one in processPaths function
  # TODO: refactor in the future
  resolvePath = (src)->
    if src.startsWith('/')
      return path.relative(fileDirectoryPath, path.resolve(projectDirectoryPath, '.'+src))
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

processPaths = (text, fileDirectoryPath, projectDirectoryPath)->
  match = null
  offset = 0
  output = ''

  resolvePath = (src)->
    if src.startsWith('/')
      return path.relative(fileDirectoryPath, path.resolve(projectDirectoryPath, '.'+src))
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

# callback(error, html)
pandocRender = (text='', {args, projectDirectoryPath, fileDirectoryPath}, callback)->
  args = args or []
  args = ['-f', atom.config.get('markdown-preview-enhanced.pandocMarkdownFlavor'), # -tex_math_dollars doesn't work properly
          '-t', 'html',
          '--mathjax']
          .concat(args).filter((arg)->arg.length)

  ###
  convert code chunk
  ```{python id:"haha"}
  to
  ```{.python data-code-chunk"{id: haha}"}
  ###

  outputString = ""
  lines = text.split('\n')
  i = 0
  inCodeBlock = false
  while i < lines.length
    line = lines[i]

    if codeChunkMatch = line.match /^\`\`\`\{(\w+)\s*(.*)\}\s*/ # code chunk
      lang = codeChunkMatch[1].trim()
      dataArgs = codeChunkMatch[2].trim().replace(/('|")/g, '\\$1') # escape
      dataCodeChunk = "{#{lang} #{dataArgs}}"

      outputString += "```{.r data-code-chunk=\"#{dataCodeChunk}\"}\n"
      inCodeBlock = true
      i += 1
      continue

    if codeBlockMatch = line.match(/^\`\`\`([^\s]+)\s+\{(.+?)\}/)
      lang = codeBlockMatch[1]
      dataArgs = codeBlockMatch[2].trim().replace(/('|")/g, '\\$1') # escape
      dataCodeBlock = "#{lang} \{#{dataArgs}\}"

      outputString += "```{.r data-code-block=\"#{dataCodeBlock}\"}\n"
      inCodeBlock = true
      i += 1
      continue

    if line.startsWith '```'
      inCodeBlock = not inCodeBlock

    if line.match(/^\[toc\]/i) and !inCodeBlock
      line = '[MPETOC]'

    outputString += line + '\n'
    i += 1

  # console.log(outputString)

  # change working directory
  cwd = process.cwd()
  process.chdir(fileDirectoryPath)

  pandocPath = atom.config.get('markdown-preview-enhanced.pandocPath')
  program = execFile pandocPath, args, (error, stdout, stderr)->
    process.chdir(cwd)
    return callback(error or stderr, stdout)
  program.stdin.end(outputString)

###
@param {String} text: markdown string
@param {Object} all properties are required!
  @param {String} fileDirectoryPath
  @param {String} projectDirectoryPath
  @param {String} sourceFilePath
callback(err, outputFilePath)
###
pandocConvert = (text, {fileDirectoryPath, projectDirectoryPath, sourceFilePath, deleteImages}, config={}, callback=null)->
  deleteImages = deleteImages or true
  config = loadOutputYAML fileDirectoryPath, config
  args = ['-f', atom.config.get('markdown-preview-enhanced.pandocMarkdownFlavor').replace(/\-raw\_tex/, '')]

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
      outputFilePath = path.resolve(projectDirectoryPath, '.'+outputFilePath)
    else
      outputFilePath = path.resolve(fileDirectoryPath, outputFilePath)

    if documentFormat != 'custom_document' and path.extname(outputFilePath) != '.' + extension
      return atom.notifications.addError('Invalid extension for ' + documentFormat, detail: 'required .' + extension + ', but ' + path.extname(outputFilePath) + ' was provided.')

    args.push '-o', outputFilePath
  else
    outputFilePath = sourceFilePath
    outputFilePath = outputFilePath.slice(0, outputFilePath.length - path.extname(outputFilePath).length) + '.' + extension
    args.push '-o', outputFilePath

  # NOTE: 0.12.4 No need to resolve paths.
  # #409: https://github.com/shd101wyy/markdown-preview-enhanced/issues/409
  # resolve paths in front-matter(yaml)
  # processConfigPaths config, fileDirectoryPath, projectDirectoryPath

  if outputConfig
    processOutputConfig outputConfig, args

  # add front-matter(yaml) to text
  text = matter.stringify(text, config)

  # import external files
  fileImport(text, {fileDirectoryPath, projectDirectoryPath, useAbsoluteImagePath: false}).then ({outputString: text})->
    # change link path to relative path
    text = processPaths text, fileDirectoryPath, projectDirectoryPath

    # change working directory
    cwd = process.cwd()
    process.chdir(fileDirectoryPath)

    # citation
    if config['bibliography'] or config['references']
      args.push('--filter', 'pandoc-citeproc')

    atom.notifications.addInfo('Your document is being prepared', detail: ':)')

    # mermaid / viz / wavedrom graph
    processGraphs text, {fileDirectoryPath, projectDirectoryPath, imageDirectoryPath: fileDirectoryPath}, (text, imagePaths=[])->
      # console.log args.join(' ')
      #
      # pandoc will cause error if directory doesn't exist,
      # therefore I will create directory first.
      directory = new Directory(path.dirname(outputFilePath))
      directory.create().then (flag)->
        pandocPath = atom.config.get('markdown-preview-enhanced.pandocPath')
        program = execFile pandocPath, args, (err)->
          if deleteImages
            # remove images
            imagePaths.forEach (p)->
              fs.unlink(p)

          process.chdir(cwd) # change cwd back
          return callback(err, outputFilePath) if callback
        program.stdin.end(text)

module.exports = {
  pandocConvert,
  pandocRender
}