Baby = require('babyparse')
path = require 'path'
fs = require 'fs'

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

  outputString = inputString.replace /(^|\n)\@import(\s+)\"([^\"]+)\"/g, (whole, prefix, spaces, filePath, offset)->
    start = 0
    if editor
      start = (inputString.slice(0, offset + 1).match(/\n/g)?.length) or 0

    if filePath.match(protocolsWhiteListRegExp)
      absoluteFilePath = filePath
    else if filePath.startsWith('/')
      absoluteFilePath = path.resolve(projectDirectoryPath, '.' + filePath)
    else
      absoluteFilePath = path.resolve(fileDirectoryPath, filePath)

    if filesCache?[absoluteFilePath] # already in cache
      updateHeightsDelta(filesCache[absoluteFilePath], start) if editor
      return prefix + filesCache[absoluteFilePath]

    extname = path.extname(filePath)
    output = ''
    if extname in ['.jpeg', '.jpg', '.gif', '.png', '.apng', '.svg', '.bmp'] # image
      if filePath.match(protocolsWhiteListRegExp)
        output = "![](#{filePath})  "
      else if useAbsoluteImagePath
        output = "![](#{'/' + path.relative(projectDirectoryPath, absoluteFilePath) + '?' + Math.random()})  "
      else
        output = "![](#{path.relative(fileDirectoryPath, absoluteFilePath) + '?' + Math.random()})  "

      filesCache?[absoluteFilePath] = output
    else
      try
        fileContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})

        if extname in markdownFileExtensions # markdown files
          output = fileImport(fileContent, {filesCache, projectDirectoryPath, useAbsoluteImagePath: true, fileDirectoryPath: path.dirname(absoluteFilePath)}).outputString + '  '
          filesCache?[absoluteFilePath] = output
        else if extname == '.html' # html file
          output = '<div>' + fileContent + '</div>  '
          filesCache?[absoluteFilePath] = output
        else if extname == '.csv'  # csv file
          parseResult = Baby.parse(fileContent)
          if parseResult.errors.length
            output = "<pre>#{parseResult.errors[0]}</pre>  "
          else
            # format csv to markdown table
            output = _2DArrayToMarkdownTable(parseResult.data)
            filesCache?[absoluteFilePath] = output
        else if extname in ['.dot'] # graphviz
          output = "```@viz\n#{fileContent}\n```  "
          filesCache?[absoluteFilePath] = output
        else if extname == '.mermaid' # mermaid
          output = "```@mermaid\n#{fileContent}\n```  "
          filesCache?[absoluteFilePath] = output
        else if extname in ['.puml', '.plantuml'] # plantuml
          output = "```@puml\n#{fileContent}\n```  "
          filesCache?[absoluteFilePath] = output
        else if extname in ['.wavedrom']
          output = "```@wavedrom\n#{fileContent}\n```  "
          filesCache?[absoluteFilePath] = output
        else # codeblock
          fileExtension = extname.slice(1, extname.length)
          output = "```#{fileExtensionToLanguageMap[fileExtension] or fileExtension}  \n#{fileContent}\n```  "
          filesCache?[absoluteFilePath] = output
      catch e # failed to load file
        output = "#{prefix}<pre>#{e.toString()}</pre>  "

    updateHeightsDelta(output, start) if editor
    return prefix + output

  # console.log(heightsDelta, outputString)
  return {outputString, heightsDelta}

module.exports = fileImport