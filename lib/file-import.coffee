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

fileImport = (inputString, {filesCache, rootDirectoryPath, projectDirectoryPath, useAbsoluteImagePath})->
  inputString = inputString.replace /(^|\n)\@import(\s+)\"([^\"]+)\"/g, (whole, _g1, _g2, filePath, offset)->

    if filePath.match(/^(http|https|file)\:\/\//)
      absoluteFilePath = filePath
    else if filePath.startsWith('/')
      absoluteFilePath = path.resolve(projectDirectoryPath, '.' + filePath)
    else
      absoluteFilePath = path.resolve(rootDirectoryPath, filePath)

    if filesCache?[absoluteFilePath] # already in cache
      return filesCache[absoluteFilePath]

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

    else if extname in markdownFileExtensions
      try
        fileContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})
        output = '\n  \n' + fileImport(fileContent, {filesCache, projectDirectoryPath, useAbsoluteImagePath: true, rootDirectoryPath: path.dirname(absoluteFilePath)}) + '  \n'
        filesCache?[absoluteFilePath] = output
      catch e
        output = "<pre>#{e.toString()}</pre>"
    else if extname == '.html'
      try
        fileContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})
        output = '\n  \n<div>' + fileContent + '</div>  \n'
        filesCache?[absoluteFilePath] = output
      catch error
        output = "<pre>#{e.toString()}</pre>"

    else if extname in ['.csv']
      try
        csvContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})
        parseResult = Baby.parse(csvContent)
        if parseResult.errors.length
          output = "<pre>#{parseResult.errors[0]}</pre>"
        else
          # format csv to markdown table
          output = _2DArrayToMarkdownTable(parseResult.data)
          filesCache?[absoluteFilePath] = output
      catch e
        output = "<pre>#{e.toString()}</pre>"
    else if extname in ['.dot']  # graph viz
      try
        fileContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})
        output = "\n```@viz\n#{fileContent}\n```  \n"
        filesCache?[absoluteFilePath] = output
      catch e
        output = "<pre>#{e.toString()}</pre>"
    else if extname in ['.mermaid'] # mermaid
      try
        fileContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})
        output = "\n```@mermaid\n#{fileContent}\n```  \n"
        filesCache?[absoluteFilePath] = output
      catch e
        output = "<pre>#{e.toString()}</pre>"
    else if extname in ['.puml', '.plantuml'] # plantuml
      try
        fileContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})
        output = "\n```@puml\n#{fileContent}\n```  \n"
        filesCache?[absoluteFilePath] = output
      catch e
        output = "<pre>#{e.toString()}</pre>"
    # else if extname in ['.wavedrom'] # wavedrom # not supported yet.
    else # codeblock
      try
        fileContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})
        output = "\n```#{extname.slice(1, extname.length)}  \n#{fileContent}\n```  \n"
        filesCache?[absoluteFilePath] = output
      catch e
        output = "<pre>#{e.toString()}</pre>"

    return output

  return inputString

module.exports = fileImport