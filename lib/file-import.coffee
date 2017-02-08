Baby = require('babyparse')
path = require 'path'
fs = require 'fs'

markdownFileExtensions = atom.config.get('markdown-preview-enhanced.fileExtension').split(',').map((x)->x.trim()) or ['.md', '.mmark', '.markdown']


_2DArrayToMarkdownTable = (_2DArr)->
  output = "\n  \n"
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

  output += '  \n'
  output

###
return
{
  {String} outputString,
  {Array} heightsDelta : [[start, height], ...]
}
###
fileImport = (inputString, {filesCache, rootDirectoryPath, projectDirectoryPath, useAbsoluteImagePath, editor})->
  heightsDelta = []

  outputString = inputString.replace /(^|\n)\@import(\s+)\"([^\"]+)\"/g, (whole, start, space, filePath, offset)->
    syncLine = ''

    # if editor (atom TextEditor class) is provided
    # prepend syncLine for scroll sync
    if editor
      lineNo = (inputString.slice(0, offset).match(/\n/g)?.length + 1) or 0
      screenRow = editor.screenRowForBufferRow(lineNo)
      syncLine = "<span class='sync-line' data-line='#{screenRow}'></span>  \n"

    if filePath.match(/^(http|https|file)\:\/\//)
      absoluteFilePath = filePath
    else if filePath.startsWith('/')
      absoluteFilePath = path.resolve(projectDirectoryPath, '.' + filePath)
    else
      absoluteFilePath = path.resolve(rootDirectoryPath, filePath)

    if filesCache?[absoluteFilePath] # already in cache
      return syncLine + filesCache[absoluteFilePath]

    extname = path.extname(filePath)
    output = ''
    if extname in ['.jpeg', '.jpg', '.gif', '.png', '.apng', '.svg', '.bmp'] # image
      if filePath.match(/^(http|https|file)\:\/\//)
        output = "\n![](#{filePath})  \n"
      else if useAbsoluteImagePath
        output = "\n![](#{'/' + path.relative(projectDirectoryPath, absoluteFilePath) + '?' + Math.random()})  \n" # TODO: project relative path?
      else
        output = "\n![](#{path.relative(rootDirectoryPath, absoluteFilePath) + '?' + Math.random()})  \n" # TODO: project relative path?

      filesCache?[absoluteFilePath] = output
    else
      try
        fileContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})

        if extname in markdownFileExtensions # markdown files
          output = '\n  \n' + fileImport(fileContent, {filesCache, projectDirectoryPath, useAbsoluteImagePath: true, rootDirectoryPath: path.dirname(absoluteFilePath)}).outputString + '  \n'
          filesCache?[absoluteFilePath] = output
        else if extname == '.html' # html file
          output = '\n  \n<div>' + fileContent + '</div>  \n'
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
          output = "\n```@viz\n#{fileContent}\n```  \n"
          filesCache?[absoluteFilePath] = output
        else if extname == '.mermaid' # mermaid
          output = "\n```@mermaid\n#{fileContent}\n```  \n"
          filesCache?[absoluteFilePath] = output
        else if extname in ['.puml', '.plantuml'] # plantuml
          output = "\n```@puml\n#{fileContent}\n```  \n"
          filesCache?[absoluteFilePath] = output
        # else if extname in ['.wavedrom'] # wavedrom # not supported yet.
        else # codeblock
          output = "\n```#{extname.slice(1, extname.length)}  \n#{fileContent}\n```  \n"
          filesCache?[absoluteFilePath] = output
      catch e # failed to load file
        output = "<pre>#{e.toString()}</pre>"

    return syncLine + output

  return {outputString, heightsDelta}

module.exports = fileImport