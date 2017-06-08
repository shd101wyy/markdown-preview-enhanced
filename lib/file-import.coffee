Baby = null
path = require 'path'
fs = require 'fs'
{allowUnsafeEval, allowUnsafeNewFunction} = require 'loophole'
request = require 'request'
less = null
loophole = null
temp = null
DOWNLOADS_TEMP_FOLDER = null
md5 = null

{protocolsWhiteListRegExp} = require('./protocols-whitelist')
subjects = require './custom-comment.coffee'
PDF = null

markdownFileExtensions = atom.config.get('markdown-preview-enhanced.fileExtension').split(',').map((x)->x.trim()) or ['.md', '.mmark', '.markdown']


fileExtensionToLanguageMap = {
  'vhd': 'vhdl',
  'erl': 'erlang',
  'dot': 'dot',
  'gv': 'dot',
  'viz': 'dot',
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
downloadFileIfNecessary(url)
.then (localFilePath)->
  ...
.catch (error)->
  ...
###
downloadFileIfNecessary = (filePath)->
  new Promise (resolve, reject)->
    if !filePath.match(/^https?\:\/\//)
      return resolve(filePath)

    temp ?= require('temp').track()
    md5 ?= require('md5')

    DOWNLOADS_TEMP_FOLDER = temp.mkdirSync('mpe_downloads')
    request.get {url: filePath, encoding: 'binary'}, (error, response, body)->
      if error
        return reject(error)
      else
        localFilePath = path.resolve(DOWNLOADS_TEMP_FOLDER, md5(filePath)) + path.extname(filePath)
        fs.writeFile localFilePath, body, 'binary', (error)->
          if error
            return reject error
          else
            return resolve localFilePath


###
eval JavaScript code in window (not node.js)
###
requiresJavaScriptFiles = (requirePath, forPreview)->
  new Promise (resolve, reject)->
    evalScript = (jsCode)->
      return allowUnsafeNewFunction -> allowUnsafeEval ->
        eval(jsCode) if forPreview
        return resolve(jsCode)

    if requirePath.match(/^(http|https)\:\/\//)
      request requirePath, (error, response, body)->
        return reject(error.toString()) if error
        return evalScript(body.toString())
    else
      fs.readFile requirePath, {encoding: 'utf-8'}, (error, data)->
        return reject(error.toString()) if error
        return evalScript(data.toString())

loadFile = (filePath, {imageDirectoryPath, fileDirectoryPath, forPreview}, filesCache={})->
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
    else if filePath.endsWith('.pdf') # pdf file
      downloadFileIfNecessary(filePath)
      .then (localFilePath)->
        PDF ?= require('./pdf')
        PDF.toSVGMarkdown localFilePath, {svgDirectoryPath: imageDirectoryPath, markdownDirectoryPath: fileDirectoryPath}, (error, svgMarkdown)->
          if error
            return reject error
          else
            return resolve(svgMarkdown)
    else if filePath.endsWith('.js') # javascript file
      requiresJavaScriptFiles(filePath, forPreview).then (jsCode)->
        return resolve(jsCode)
      .catch (e)->
        return resolve(e)
      # .catch (error)->
      #  return reject(error)
    else if filePath.match(/^https?\:\/\//) # online file
      # github
      if filePath.startsWith 'https://github.com/'
        filePath = filePath.replace('https://github.com/', 'https://raw.githubusercontent.com/').replace('/blob/', '/')

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
  classes = config.class or 'code-block'
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
@param {Boolean} forPreview, optional
return
{
  {String} outputString,
}
###
fileImport = (inputString, {filesCache, fileDirectoryPath, projectDirectoryPath, useAbsoluteImagePath, imageDirectoryPath, forPreview})->
  new Promise (resolve, reject)->
    inBlock = false # inside code block

    helper = (i, lineNo=0, outputString="")->
      if i >= inputString.length
        # console.log outputString
        return resolve({outputString})
      if inputString[i] == '\n'
        return helper i+1, lineNo+1, outputString+'\n'

      end = inputString.indexOf '\n', i
      end = inputString.length if end < 0
      line = inputString.substring i, end

      if line.match(/^\s*```/)
        inBlock = !inBlock
        return helper(end+1, lineNo+1, outputString+line+'\n')

      if inBlock
        return helper(end+1, lineNo+1, outputString+line+'\n')

      if forPreview # insert anchors for scroll sync
        if line.match /^(\#|\!\[|```[^`]|@import)/
          outputString += createAnchor(lineNo)
        else if subjectMatch = line.match /^\<!--\s+([^\s]+)/
          subject = subjectMatch[1]
          if subjects[subject]
            line = line.replace(subject, "#{subject} lineNo:#{lineNo} ")
            outputString += createAnchor(lineNo)

      if importMatch = line.match /^(\s*)\@import(\s+)\"([^\"]+)\";?/
        outputString += importMatch[1]
        filePath = importMatch[3].trim()

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
          loadFile(absoluteFilePath, {imageDirectoryPath, fileDirectoryPath, forPreview}, filesCache).then (fileContent)->
            filesCache?[absoluteFilePath] = fileContent
            if config?.code_block
              fileExtension = extname.slice(1, extname.length)
              output = "```#{fileExtensionToLanguageMap[fileExtension] or fileExtension} #{formatClassesAndId(config)}  \n#{fileContent}\n```  "
            else if config?.code_chunk
              if !config.id
                md5 ?= require 'md5'
                config.id = md5(absoluteFilePath)
                configStr = JSON.stringify(config).slice(1, -1)

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
            else if extname == '.pdf'
              if config?.page_no # only disply the nth page. 1-indexed
                pages = fileContent.split('\n')
                pageNo = parseInt(config.page_no) - 1
                pageNo = 0 if pageNo < 0
                output = pages[pageNo] or ''
              else if config?.page_begin or config?.page_end
                pages = fileContent.split('\n')
                pageBegin = parseInt(config.page_begin) - 1 or 0
                pageEnd = config.page_end or pages.length - 1
                pageBegin = 0 if pageBegin < 0
                output = pages.slice(pageBegin, pageEnd).join('\n') or ''
              else
                output = fileContent
            else if extname in ['.dot', '.gv', '.viz'] # graphviz
              output = "```dot\n#{fileContent}\n```  "
              # filesCache?[absoluteFilePath] = output
            else if extname == '.mermaid' # mermaid
              output = "```mermaid\n#{fileContent}\n```  "
              # filesCache?[absoluteFilePath] = output
            else if extname in ['.puml', '.plantuml'] # plantuml
              output = "```puml\n' @mpe_file_directory_path:#{path.dirname(absoluteFilePath)}\n#{fileContent}\n```  "
              # filesCache?[absoluteFilePath] = output
            else if extname in ['.wavedrom']
              output = "```wavedrom\n#{fileContent}\n```  "
              # filesCache?[absoluteFilePath] = output
            else if extname == '.js'
              if forPreview
                output = '' # js code is evaluated and there is no need to display the code.
              else
                if filePath.match(/^https?\:\/\//)
                  output = "<script src=\"#{filePath}\"></script>"
                else
                  output = "<script>#{fileContent}</script>"
            else # codeblock
              fileExtension = extname.slice(1, extname.length)
              output = "```#{fileExtensionToLanguageMap[fileExtension] or fileExtension} #{formatClassesAndId(config)}  \n#{fileContent}\n```  "
              # filesCache?[absoluteFilePath] = output

            return helper(end+1, lineNo+1, outputString+output+'\n')

          .catch (e)-> # failed to load file
            output = "<pre>#{e.toString()}</pre>  "

            return helper(end+1, lineNo+1, outputString+output+'\n')
      else
        return helper(end+1, lineNo+1, outputString+line+'\n')

    return helper(0, 0, '')

module.exports = { fileImport }