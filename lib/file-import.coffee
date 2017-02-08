Baby = require('babyparse')
path = require 'path'
fs = require 'fs'

markdownFileExtensions = atom.config.get('markdown-preview-enhanced.fileExtension').split(',').map((x)->x.trim()) or ['.md', '.mmark', '.markdown']


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
return
{
  {String} outputString,
  {Array} heightsDelta : [[start, height], ...]
          start is the buffer row
}
###
fileImport = (inputString, {filesCache, rootDirectoryPath, projectDirectoryPath, useAbsoluteImagePath, editor})->
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
    #syncLine = ''

    # if editor (atom TextEditor class) is provided
    # prepend syncLine for scroll sync
    #if editor
    #  lineNo = (inputString.slice(0, offset).match(/\n/g)?.length + 1) or 0
    #  screenRow = editor.screenRowForBufferRow(lineNo)
    #  syncLine = "<span class='sync-line' data-line='#{screenRow}'></span>  \n"
    start = 0
    if editor
      start = (inputString.slice(0, offset + 1).match(/\n/g)?.length) or 0

    if filePath.match(/^(http|https|file)\:\/\//)
      absoluteFilePath = filePath
    else if filePath.startsWith('/')
      absoluteFilePath = path.resolve(projectDirectoryPath, '.' + filePath)
    else
      absoluteFilePath = path.resolve(rootDirectoryPath, filePath)

    if filesCache?[absoluteFilePath] # already in cache
      updateHeightsDelta(filesCache[absoluteFilePath], start) if editor
      return prefix + filesCache[absoluteFilePath]

    extname = path.extname(filePath)
    output = ''
    if extname in ['.jpeg', '.jpg', '.gif', '.png', '.apng', '.svg', '.bmp'] # image
      if filePath.match(/^(http|https|file)\:\/\//)
        output = "![](#{filePath})  "
      else if useAbsoluteImagePath
        output = "![](#{'/' + path.relative(projectDirectoryPath, absoluteFilePath) + '?' + Math.random()})  "
      else
        output = "![](#{path.relative(rootDirectoryPath, absoluteFilePath) + '?' + Math.random()})  "

      filesCache?[absoluteFilePath] = output
    else
      try
        fileContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})

        if extname in markdownFileExtensions # markdown files
          output = fileImport(fileContent, {filesCache, projectDirectoryPath, useAbsoluteImagePath: true, rootDirectoryPath: path.dirname(absoluteFilePath)}).outputString + '  '
          filesCache?[absoluteFilePath] = output
        else if extname == '.html' # html file
          output = '<div>' + fileContent + '</div>  '
          filesCache?[absoluteFilePath] = output
        else if extname == '.csv'  # csv file
          parseResult = Baby.parse(fileContent)
          if parseResult.errors.length
            output = "<pre>#{parseResult.errors[0]}</pre>"
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
        # else if extname in ['.wavedrom'] # wavedrom # not supported yet.
        else # codeblock
          output = "```#{extname.slice(1, extname.length)}  \n#{fileContent}\n```  "
          filesCache?[absoluteFilePath] = output
      catch e # failed to load file
        output = "#{prefix}<pre>#{e.toString()}</pre>  "

    updateHeightsDelta(output, start) if editor
    return prefix + output

  # console.log(heightsDelta, outputString)
  return {outputString, heightsDelta}

module.exports = fileImport