path = require 'path'
{execFile} = require 'child_process'
# ebook-convert is requied (calibre), which can be got from https://calibre-ebook.com/download
# xpath http://www.w3schools.com/xsl/xpath_syntax.asp

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

  if title
    args.push '--title'
    args.push title

  if authors
    args.push '--authors'
    args.push authors

  if publisher
    args.push '--publisher'
    args.push publisher

  if bookProducer
    args.push '--book-producer'
    args.push bookProducer

  if pubdate
    args.push '--pubdate'
    args.push pubdate

  if isbn
    args.push '--isbn'
    args.push isbn

  if cover
    args.push '--cover'
    args.push cover

  if epubTOCAtEnd
    args.push '--epub-toc-at-end'

  if marginTop
    args.push '--margin-top'
    args.push marginTop

  if marginRight
    args.push '--margin-right'
    args.push marginRight

  if marginBottom
    args.push '--margin-bottom'
    args.push marginBottom

  if marginLeft
    args.push '--margin-left'
    args.push marginLeft

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
