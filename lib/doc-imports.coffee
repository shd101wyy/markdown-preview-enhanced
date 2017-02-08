Baby = require('babyparse')
path = require 'path'
fs = require 'fs'

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

  output += '  \n'
  output

docImports = (inputString, {filesCache, rootDirectoryPath, projectDirectoryPath, useAbsoluteImagePath})->
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
    if extname in ['.jpeg', '.gif', '.png', '.apng', '.svg', '.bmp'] # image
      if filePath.match(/^(http|https|file)\:\/\//)
        output = "![](#{filePath})"
      else if useAbsoluteImagePath
        output = "![](#{'/' + path.relative(projectDirectoryPath, absoluteFilePath) + '?' + Math.random()})" # TODO: project relative path?
      else
        output = "![](#{path.relative(rootDirectoryPath, absoluteFilePath) + '?' + Math.random()})" # TODO: project relative path?

      filesCache?[absoluteFilePath] = output

    else if extname in ['.md', '.markdown', '.mmark', '.rmd'] # TODO: use config markdown-preview-enhanced.fileExtension
      try
        fileContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})
        output = '  \n' + docImports(fileContent, {filesCache, projectDirectoryPath, useAbsoluteImagePath: true, rootDirectoryPath: path.dirname(absoluteFilePath)}) + '  \n'
        filesCache?[absoluteFilePath] = output
      catch e
        output = "<pre>#{e.toString()}</pre>"
    else if extname == '.html'
      try
        fileContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})
        output = '<div>' + fileContent + '</div>'
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
    else # codeblock
      try
        fileContent = fs.readFileSync(absoluteFilePath, {encoding: 'utf-8'})
        output = """
```#{extname.slice(1, extname.length)}
#{fileContent}
```
"""
        filesCache?[absoluteFilePath] = output
      catch e
        output = "<pre>#{e.toString()}</pre>"

    return output

module.exports = docImports