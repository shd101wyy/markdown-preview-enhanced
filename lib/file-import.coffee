Baby = null
path = require 'path'
fs = require 'fs'
request = null
less = null
loophole = null
subjects = require './custom-comment.coffee'

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

loadFile = (filePath, filesCache={})->
  new Promise (resolve, reject)->
    if filesCache[filePath]
      return resolve(filesCache[filePath])

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

createAnchor = (lineNo)->
  "\n\n<p data-line=\"#{lineNo}\" class=\"sync-line\" style=\"margin:0;\"></p>\n\n"

formatClassesAndId = (config)->
  return '' if !config
  id = config.id
  classes = config.class
  return '' if !id and !classes
  output = '{'
  output += ('#' + id + ' ') if id
  output += ('.' + classes.replace(/\s+/g, ' .')  + ' ') if classes
  output += '}'
  output


###
@param {String} inputString, required
@param {Object} filesCache, optional
@param {String} fileDirectoryPath, required
@param {String} projectDirectoryPath, required
@param {Boolean} useAbsoluteImagePath, optional
@param {Boolean} insertAnchors, optional
return
{
  {String} outputString,
}
###
fileImport = (inputString, {filesCache, fileDirectoryPath, projectDirectoryPath, useAbsoluteImagePath, insertAnchors})->
  new Promise (resolve, reject)->
    inblock = false

    helper = (i, lineNo=0, outputString="")->
      if i >= inputString.length
        # console.log outputString
        return resolve({outputString})
      if inputString[i] == '\n'
        return helper i+1, lineNo+1, outputString+'\n'

      end = inputString.indexOf '\n', i
      end = inputString.length if end < 0
      line = inputString.substring i, end

      if insertAnchors
        if inblock
          if line.match(inblock)
            inblock = false
        else if line.match /^(\#|\!\[|```[^`]|@import)/
          outputString += createAnchor(lineNo)
          if line.match(/^```/)
            inblock = /^```\s*$/
        else if subjectMatch = line.match /^\<!--\s+([^\s]+)/
          subject = subjectMatch[1]
          if subjects[subject]
            line = line.replace(subject, "#{subject} lineNo:#{lineNo} ")
            outputString += createAnchor(lineNo)

      if importMatch = line.match /^\@import(\s+)\"([^\"]+)\";?/
        whole = importMatch[0]
        filePath = importMatch[2].trim()

        leftParen = line.indexOf('{')
        config = null
        configStr = ''
        if leftParen > 0
          rightParen = line.lastIndexOf('}')
          if rightParen > 0
            configStr = line.substring(leftParen+1, rightParen)
            try
              loophole ?= require 'loophole'
              loophole.allowUnsafeEval ->
                config = eval("({#{configStr}})")
            catch error
              null

        start = lineNo
        if filePath.match(protocolsWhiteListRegExp)
          absoluteFilePath = filePath
        else if filePath.startsWith('/')
          absoluteFilePath = path.resolve(projectDirectoryPath, '.' + filePath)
        else
          absoluteFilePath = path.resolve(fileDirectoryPath, filePath)

        # if filesCache?[absoluteFilePath] # already in cache
        #  return helper(end+1, lineNo+1, outputString+filesCache[absoluteFilePath]+'\n')

        extname = path.extname(filePath)
        output = ''
        if extname in ['.jpeg', '.jpg', '.gif', '.png', '.apng', '.svg', '.bmp'] # image
          imageSrc = filesCache?[filePath]

          if !imageSrc
            if filePath.match(protocolsWhiteListRegExp)
              imageSrc = filePath
            else if useAbsoluteImagePath
              imageSrc = '/' + path.relative(projectDirectoryPath, absoluteFilePath) + '?' + Math.random()
            else
              imageSrc = path.relative(fileDirectoryPath, absoluteFilePath) + '?' + Math.random()

            # enchodeURI(imageSrc) is wrong. It will cause issue on Windows
            # #414: https://github.com/shd101wyy/markdown-preview-enhanced/issues/414
            imageSrc = imageSrc.replace(/ /g, '%20')
            filesCache?[filePath] = imageSrc

          if config
            if config.width or config.height or config.class or config.id
              output = "<img src=\"#{imageSrc}\" "
              for key of config
                output += " #{key}=\"#{config[key]}\" "
              output += ">"
            else
              output = "!["
              output += config.alt if config.alt
              output += "](#{imageSrc}"
              output += " \"#{config.title}\"" if config.title
              output += ")  "
          else
            output = "![](#{imageSrc})  "
          # filesCache?[absoluteFilePath] = output

          return helper(end+1, lineNo+1, outputString+output+'\n')
        else
          loadFile(absoluteFilePath, filesCache).then (fileContent)->
            filesCache?[absoluteFilePath] = fileContent
            if config?.code_block
              fileExtension = extname.slice(1, extname.length)
              output = "```.#{fileExtensionToLanguageMap[fileExtension] or fileExtension} #{formatClassesAndId(config)}  \n#{fileContent}\n```  "
            else if config?.code_chunk
              fileExtension = extname.slice(1, extname.length)
              output = "```{#{fileExtensionToLanguageMap[fileExtension] or fileExtension} #{configStr}}  \n#{fileContent}\n```  "
              # filesCache?[absoluteFilePath] = output
            else if extname in markdownFileExtensions # markdown files
              # this return here is necessary
              return fileImport(fileContent, {filesCache, projectDirectoryPath, useAbsoluteImagePath: true, fileDirectoryPath: path.dirname(absoluteFilePath)}).then ({outputString:output})->
                output = '\n' + output + '  '
                # filesCache?[absoluteFilePath] = output

                return helper(end+1, lineNo+1, outputString+output+'\n')
            else if extname == '.html' # html file
              output = '<div>' + fileContent + '</div>  '
              # filesCache?[absoluteFilePath] = output
            else if extname == '.csv'  # csv file
              Baby ?= require('babyparse')
              parseResult = Baby.parse(fileContent.trim())
              if parseResult.errors.length
                output = "<pre>#{parseResult.errors[0]}</pre>  "
              else
                # format csv to markdown table
                output = _2DArrayToMarkdownTable(parseResult.data)
                # filesCache?[absoluteFilePath] = output
            else if extname in ['.css', '.less'] # css or less file
              output = "<style>#{fileContent}</style>"
              # filesCache?[absoluteFilePath] = output
            else if extname in ['.dot'] # graphviz
              output = "```@viz\n#{fileContent}\n```  "
              # filesCache?[absoluteFilePath] = output
            else if extname == '.mermaid' # mermaid
              output = "```@mermaid\n#{fileContent}\n```  "
              # filesCache?[absoluteFilePath] = output
            else if extname in ['.puml', '.plantuml'] # plantuml
              output = "```@puml\n' @mpe_file_directory_path:#{path.dirname(absoluteFilePath)}\n#{fileContent}\n```  "
              # filesCache?[absoluteFilePath] = output
            else if extname in ['.wavedrom']
              output = "```@wavedrom\n#{fileContent}\n```  "
              # filesCache?[absoluteFilePath] = output
            else # codeblock
              fileExtension = extname.slice(1, extname.length)
              output = "```.#{fileExtensionToLanguageMap[fileExtension] or fileExtension} #{formatClassesAndId(config)}  \n#{fileContent}\n```  "
              # filesCache?[absoluteFilePath] = output

            return helper(end+1, lineNo+1, outputString+output+'\n')

          .catch (e)-> # failed to load file
            output = "<pre>#{e.toString()}</pre>  "

            return helper(end+1, lineNo+1, outputString+output+'\n')
      else
        return helper(end+1, lineNo+1, outputString+line+'\n')

    return helper(0, 0, '')

module.exports = { fileImport }