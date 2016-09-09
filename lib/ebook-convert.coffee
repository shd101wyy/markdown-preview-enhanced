path = require 'path'
{execFile} = require 'child_process'
{Directory} = require 'atom'
# ebook-convert is requied (calibre), which can be got from https://calibre-ebook.com/download
# xpath http://www.w3schools.com/xsl/xpath_syntax.asp

processMetadata = (config={}, args)->
  title = config.title || 'No Title'
  args.push '--title', title

  if config['authors']
    args.push '--authors', config['authors']

  if config['cover']
    args.push '--cover', config['cover']

  if config['comment']
    args.push '--comments', config['comments']

  if config['publisher']
    args.push '--publisher', config['publisher']

  if config['book-producer']
    args.push '--book-producer', config['book-producer']

  if config['pubdate']
    args.push '--pubdate', config['pubdate']

  if config['language']
    args.push '--language', config['language']

  if config['isbn']
    args.push '--isbn', config['isbn']

  if config['tags']
    args.push '--tags', config['tags']

  if config['series']
    args.push '--series', config['series']

  if config['rating']
    args.push '--rating', config['rating']

processAppearance = (config={}, args)->
  if config['asciiize']
    args.push '--asciiize'

  if config['base-font-size']
    args.push('--base-font-size='+config['base-font-size'])

  if config['disable-font-rescaling']
    args.push('--disable-font-rescaling')

  if config['line-height']
    args.push('--line-height='+config['line-height'])

  if config['margin']
    margin = config['margin']
    marginTop = 72
    marginRight = 72
    marginBottom = 72
    marginLeft = 72
    if margin.constructor == Array
      if margin.length == 1
        marginTop = margin[0]
        marginBottom = margin[0]
        marginLeft = margin[0]
        marginRight = margin[0]
      else if margin.length == 2
        marginTop = margin[0]
        marginBottom = margin[0]
        marginLeft = margin[1]
        marginRight = margin[1]
      else if margin.length == 4
        marginTop = margin[0]
        marginRight = margin[1]
        marginBottom = margin[2]
        marginLeft = margin[3]
    else if typeof(margin) == 'number'
      marginTop = margin
      marginBottom = margin
      marginLeft = margin
      marginRight = margin
    args.push('--margin-top='+marginTop)
    args.push('--margin-bottom='+marginBottom)
    args.push('--margin-left='+marginLeft)
    args.push('--margin-right='+marginRight)
  else
    if config['margin-top']
      args.push('--margin-top='+config['margin-top'])
    if config['margin-right']
      args.push('--margin-right='+config['margin-right'])
    if config['margin-bottom']
      args.push('--margin-bottom='+config['margin-bottom'])
    if config['margin-left']
      args.push('--margin-left='+config['margin-left'])

# Async call
# src: link to .html file
# dest: output path
ebookConvert = (src, dest, config={}, callback)->
  # config
  title = config.title || 'No Title'
  authors = config.authors || null
  publisher = config.publisher || null
  bookProducer = config['book-producer'] || null
  pubdate = config['pubdate'] || null
  isbn = config['isbn'] || null
  cover = config['cover'] || null
  epubTOCAtEnd = config['epub-toc-at-end'] || false
  marginTop = config['margin-top'] || 72
  marginRight = config['margin-right'] || 72
  marginBottom = config['margin-bottom'] || 72
  marginLeft = config['margin-left'] || 72

  args = [  src,
            dest,
            '--level1-toc', '//*[@ebook-toc-level-1]/@heading',
            '--level2-toc', '//*[@ebook-toc-level-2]/@heading',
            '--level3-toc', '//*[@ebook-toc-level-3]/@heading',
            '--no-chapters-in-toc'
          ]

  processMetadata(config, args)
  processAppearance(config, args)


  # arguments
  ebookArgs = config.args || []
  ebookArgs.forEach (arg)->
    args.push(arg)

  # ebook-convert will cause error if directory doesn't exist,
  # therefore I will create directory first.
  directory = new Directory(path.dirname(dest))
  directory.create().then (flag)->
    execFile 'ebook-convert',
              args,
              callback

module.exports = ebookConvert

###
# Example

ebookConvert 'test.html', 'test.epub', {title: 'hehe', authors: 'shd101wyy'}, (error)->
  if error
    console.log error
  else
    console.log 'done'
###
