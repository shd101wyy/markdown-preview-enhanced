Baby = null
path = require 'path'
fs = require 'fs'
request = null
less = null

{protocolsWhiteListRegExp} = require('./protocols-whitelist')

markdownFileExtensions = atom.config.get('markdown-preview-enhanced.fileExtension').split(',').map((x)->x.trim()) or ['.md', '.mmark', '.markdown']


fileExtensionToLanguageMap = {
  'vhd': 'vhdl',
  'erl': 'erlang'
}

# Convert 2D array to markdown table.
# The first row is headings.
_2DArrayToMarkdownTable = (_2DArr)->
  output = "  \n"
  _2DArr.forEach (arr, offset)->
    i = 0
    output += '|'
    while i < arr.length
      output += (arr[i] + '|')
      i += 1
    output += '  \n'
    if offset == 0
      output += '|'
      i = 0
      while i < arr.length
        output += ('---|')
        i += 1
      output += '  \n'

  output += '  '
  output

loadFile = (filePath)->
  new Promise (resolve, reject)->
    if filePath.endsWith('.less') # less file
      less ?= require('less')
      fs.readFile filePath, {encoding: 'utf-8'}, (error, data)->
        if error
          reject(error)
        else
          less.render data, {paths: [path.dirname(filePath)]}, (error, output)->
            if error
              reject(error)
            else
              resolve(output.css or '')
    else if filePath.match(/https?\:\/\//) # online file
      # github
      if filePath.startsWith 'https://github.com/'
        filePath = filePath.replace('https://github.com/', 'https://raw.githubusercontent.com/').replace('/blob/', '/')

      request ?= require 'request'
      request filePath, (error, response, body)->
        if error
          reject(error)
        else
          resolve(body.toString())
    else # local file
      fs.readFile filePath, {encoding: 'utf-8'}, (error, data)->
        if error
          reject(error)
        else
          resolve(data.toString())

###
@param {String} inputString, required
@param {Object} filesCache, optional
@param {String} fileDirectoryPath, required
@param {String} projectDirectoryPath, required
@param {Boolean} useAbsoluteImagePath, optional
@param {Object} editor, optional
return
{
  {String} outputString,
  {Array} heightsDelta : [[start, height, acc, realStart], ...]
          start is the buffer row
          heightsDelta is used to correct scroll sync. please refer to md.coffee
}
###
fileImport = (inputString, {filesCache, fileDirectoryPath, projectDirectoryPath, useAbsoluteImagePath, editor})->
  new Promise (resolve, reject)->
    heightsDelta = []
    acc = 0

    updateHeightsDelta = (str, start)->
      height = (str.match(/\n/g)?.length + 1) or 1
      heightsDelta.push({
        realStart: start,
        start: start + acc - heightsDelta.length,
        height: height,
        acc: acc,
      })

      acc = acc + height

    helper = (i, lineNo=0, outputString="")->
      if i >= inputString.length
        return resolve({outputString, heightsDelta})
      if inputString[i] == '\n'
        return helper i+1, lineNo+1, outputString+'\n'

      end = inputString.indexOf '\n', i
      end = inputString.length if end < 0
      line = inputString.substring i, end

      if importMatch = line.match /^\@import(\s+)\"([^\"]+)\";?/
        whole = importMatch[0]
        filePath = importMatch[2].trim()

        start = lineNo
        if filePath.match(protocolsWhiteListRegExp)
          absoluteFilePath = filePath
        else if filePath.startsWith('/')
          absoluteFilePath = path.resolve(projectDirectoryPath, '.' + filePath)
        else
          absoluteFilePath = path.resolve(fileDirectoryPath, filePath)

        if filesCache?[absoluteFilePath] # already in cache
          updateHeightsDelta(filesCache[absoluteFilePath], start) if editor
          return helper(end+1, lineNo+1, outputString+filesCache[absoluteFilePath]+'\n')

        extname = path.extname(filePath)
        output = ''
        if extname in ['.jpeg', '.jpg', '.gif', '.png', '.apng', '.svg', '.bmp'] # image
          if filePath.match(protocolsWhiteListRegExp)
            imageSrc = filePath
          else if useAbsoluteImagePath
            imageSrc = '/' + path.relative(projectDirectoryPath, absoluteFilePath) + '?' + Math.random()
          else
            imageSrc = path.relative(fileDirectoryPath, absoluteFilePath) + '?' + Math.random()
          output = "![](#{encodeURI(imageSrc)})  "
          filesCache?[absoluteFilePath] = output

          updateHeightsDelta(output, start) if editor
          return helper(end+1, lineNo+1, outputString+output+'\n')
        else
          loadFile(absoluteFilePath).then (fileContent)->
            if extname in markdownFileExtensions # markdown files
              # this return here is necessary
              return fileImport(fileContent, {filesCache, projectDirectoryPath, useAbsoluteImagePath: true, fileDirectoryPath: path.dirname(absoluteFilePath)}).then ({outputString:output})->
                output = '\n' + output + '  '
                filesCache?[absoluteFilePath] = output
                updateHeightsDelta(output, start) if editor
                return helper(end+1, lineNo+1, outputString+output+'\n')
            else if extname == '.html' # html file
              output = '<div>' + fileContent + '</div>  '
              filesCache?[absoluteFilePath] = output
            else if extname == '.csv'  # csv file
              Baby ?= require('babyparse')
              parseResult = Baby.parse(fileContent.trim())
              if parseResult.errors.length
                output = "<pre>#{parseResult.errors[0]}</pre>  "
              else
                # format csv to markdown table
                output = _2DArrayToMarkdownTable(parseResult.data)
                filesCache?[absoluteFilePath] = output
            else if extname in ['.css', '.less'] # css or less file
              output = "<style>#{fileContent}</style>"
              filesCache?[absoluteFilePath] = output
            else if extname in ['.dot'] # graphviz
              output = "```@viz\n#{fileContent}\n```  "
              filesCache?[absoluteFilePath] = output
            else if extname == '.mermaid' # mermaid
              output = "```@mermaid\n#{fileContent}\n```  "
              filesCache?[absoluteFilePath] = output
            else if extname in ['.puml', '.plantuml'] # plantuml
              output = "```@puml\n' @mpe_file_directory_path:#{path.dirname(absoluteFilePath)}\n#{fileContent}\n```  "
              filesCache?[absoluteFilePath] = output
            else if extname in ['.wavedrom']
              output = "```@wavedrom\n#{fileContent}\n```  "
              filesCache?[absoluteFilePath] = output
            else # codeblock
              fileExtension = extname.slice(1, extname.length)
              output = "```#{fileExtensionToLanguageMap[fileExtension] or fileExtension}  \n#{fileContent}\n```  "
              filesCache?[absoluteFilePath] = output

            updateHeightsDelta(output, start) if editor
            return helper(end+1, lineNo+1, outputString+output+'\n')

          .catch (e)-> # failed to load file
            output = "<pre>#{e.toString()}</pre>  "

            updateHeightsDelta(output, start) if editor
            return helper(end+1, lineNo+1, outputString+output+'\n')
      else
        return helper(end+1, lineNo+1, outputString+line+'\n')

    return helper(0, 0, '')

module.exports = { fileImport }