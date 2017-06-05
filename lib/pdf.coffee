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

# callback(error, svgMarkdown)
toSVGMarkdown = (pdfFilePath, {svgDirectoryPath, markdownDirectoryPath, svgZoom, svgWidth, svgHeight}, callback)->
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
            filePath = path.relative(markdownDirectoryPath, path.resolve(svgDirectoryPath, fileName))

            if svgZoom or svgWidth or svgHeight
              svgMarkdown += "<img src=\"#{filePath}\" #{if svgWidth then "width=\"#{svgWidth}\"" else ""} #{if svgHeight then "height=\"#{svgHeight}\"" else ""} #{if svgZoom then "style=\"zoom:#{svgZoom};\"" else ""}>"
            else
              svgMarkdown += "![](#{filePath}?#{r})\n"

        return callback(null, svgMarkdown)

module.exports = PDF = {toSVGMarkdown}
