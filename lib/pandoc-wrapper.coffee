path = require 'path'
fs = require 'fs'
{execFile} = require 'child_process'
matter = require('gray-matter')
# temp = require 'temp'

getFileExtension = (documentType)->
  if documentType == 'pdf_document'
    'pdf'
  else if documentType == 'word_document'
    'docx'
  else if documentType == 'html_document'
    'html'
  else if documentType == 'rtf_document'
    'rtf'
  else
    atom.notifications.addError('Invalid output format', detail: documentType)
    null

processOutputConfig = (config, args)->
  if config['toc']
    args.push '--toc'
  if config['toc_depth']
    args.push('--toc-depth='+config['toc_depth'])
  if config['highlight']
    args.push('--highlight-style='+config['highlight'])
  if config['pandoc_args']
    for arg in config['pandoc_args']
      args.push(arg)

loadOutputYAML = (md, config)->
  yamlPath = path.resolve(path.dirname(md.editor.getPath()), '_output.yaml')
  yaml = fs.readFileSync yamlPath
  data = matter('---\n'+yaml+'---\n').data
  data = data || {}

  if config['output']
    if typeof(config['output']) == 'string' && data[config['output']]
      format = config['output']
      config['output'] = {}
      config['output'][format] = data[format]
    else
      format = Object.keys(config['output'])[0]
      if data[format]
        config['output'][format] = Object.assign({}, data[format], config['output'][format])

  Object.assign({}, data, config)

###
title
author
date
path: ./
output:
###
pandocConvert = (text, md, config={})->
  config = loadOutputYAML md, config
  text = matter.stringify(text, config)
  args = []

  console.log config

  extension = null
  outputConfig = null
  if config['output']
    if typeof(config['output']) == 'string'
      extension = getFileExtension(config['output'])
    else
      documentFormat = Object.keys(config['output'])[0]
      extension = getFileExtension(documentFormat)
      outputConfig = config['output'][documentFormat]
  else
    atom.notifications.addError('Output format needs to be specified')
  return if not extension

  if outputConfig
    processOutputConfig outputConfig, args

  # src/dist
  if config['path']
    # TODO: check extension
    outputFilePath = config['path']
    args.push '-o', outputFilePath
  else
    outputFilePath = md.editor.getPath()
    outputFilePath = outputFilePath.slice(0, outputFilePath.length - path.extname(outputFilePath).length) + '.' + extension
    args.push '-o', outputFilePath
  # args.push(md.editor.getPath())

  console.log args.join(' ')

  program = execFile 'pandoc', args
  program.stdin.end(text)

  program.on 'exit', ()->
    atom.notifications.addInfo "File #{path.basename(outputFilePath)} was created", detail: "path: #{outputFilePath}"

  program.on 'error', (err)->
    throw err
  ###
  , (error)->
    throw error if error
    atom.notifications.addInfo "File #{path.basename(outputFilePath)} was created", detail: "path: #{outputFilePath}"
  ###
module.exports = pandocConvert
