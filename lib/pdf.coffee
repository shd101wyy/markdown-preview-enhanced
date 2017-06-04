# `pdf2svg` is requied to be installed.
# http://www.cityinthesky.co.uk/opensource/pdf2svg/
#
path = require 'path'
fs = require 'fs'
{spawn} = require 'child_process'
async_ = null
temp = null
SVG_DIRECTORY_PATH = null
md5 = null


# callback(error, cb)
# cb(error, {svg, svgFiles})
helper = (pdfFilePath, fileDirectoryPath, callback)->
  svgFilePrefix = (Math.random().toString(36).substr(2, 9) + '_')

  task = spawn 'pdf2svg', [pdfFilePath, path.resolve(fileDirectoryPath, svgFilePrefix+'%d.svg'), 'all']

  chunks = []
  task.stdout.on 'data', (chunk)->
    chunks.push(chunk)

  errorChunks = []
  task.stderr.on 'data', (chunk)->
    errorChunks.push(chunk)

  task.on 'close', (chunk)->
    if errorChunks.length
      return callback(Buffer.concat(errorChunks).toString(), null)
    else
      fs.readdir fileDirectoryPath, (error, items)->
        if error
          return callback(error, null)

        async_ ?= require('async')
        asyncFuncs = []

        items.forEach (fileName)->
          if match = fileName.match(new RegExp("^#{svgFilePrefix}(\\d+)\.svg"))
            offset = parseInt(match[1]) - 1

            filePath = path.resolve(fileDirectoryPath, fileName)

            asyncFuncs.push (cb)->
              fs.readFile filePath, {encoding: 'utf-8'}, (error, data)->
                if error
                  cb(true)
                else
                  cb(null, {offset, data, filePath})

        async_.parallel asyncFuncs, (error, results)->
          return callback(error, null) if error
          results = results.sort (a, b)-> a.offset - b.offset
          svg = ''
          svgFiles = []
          results.forEach ({data, filePath})->
            svg += data
            svgFiles.push(filePath)
          return callback(null, {svg, svgFiles})

# callback(error, svgMarkdown)
toSVGMarkdown = (pdfFilePath, {svgDirectoryPath, markdownDirectoryPath}, callback)->
  if !svgDirectoryPath
    temp ?= require('temp').track()
    SVG_DIRECTORY_PATH ?= temp.mkdirSync('mpe_pdf')
    svgDirectoryPath = SVG_DIRECTORY_PATH

  md5 ?= require 'md5'
  svgFilePrefix = md5(pdfFilePath)+'_'

  task = spawn 'pdf2svg', [pdfFilePath, path.resolve(svgDirectoryPath, svgFilePrefix+'%d.svg'), 'all']

  chunks = []
  task.stdout.on 'data', (chunk)->
    chunks.push(chunk)

  errorChunks = []
  task.stderr.on 'data', (chunk)->
    errorChunks.push(chunk)

  task.on 'error', (error)->
    errorChunks.push(Buffer.from(error.toString(), 'utf-8'))

  task.on 'close', ()->
    if errorChunks.length
      return callback(Buffer.concat(errorChunks).toString(), null)
    else
      fs.readdir svgDirectoryPath, (error, items)->
        if error
          return callback(error, null)

        svgMarkdown = ''
        r = Math.random()
        items.forEach (fileName)->
          if match = fileName.match(new RegExp("^#{svgFilePrefix}(\\d+)\.svg"))
            # offset = parseInt(match[1]) - 1
            filePath = path.relative(markdownDirectoryPath, path.resolve(svgDirectoryPath, fileName))
            svgMarkdown += "![](#{filePath}?#{r})\n"

        return callback(null, svgMarkdown)

# callback(error, svg)
toSVG = (pdfFilePath, fileDirectoryPath="", callback)->
  helper pdfFilePath, fileDirectoryPath, (error, data)->
    return callback(error, '') if error

    {svg, svgFiles} = data
    svgFiles.forEach (filePath)-> # remove svg files
      fs.unlink(filePath)

    return callback(null, svg)

# callback(error, svgFiles)
toSVGFiles = ()->
  helper pdfFilePath, fileDirectoryPath, (error, data)->
    return callback(error, '') if error
    {svgFiles} = data
    return callback(null, svgFiles)

module.exports = PDF = {toSVG, toSVGFiles, toSVGMarkdown}
