# TODO: finish this file
# This is an experimental file
# Not ready for use yet.
###

---
phantomjs:
  path: ./test.pdf
  format: A3, A4, A5, Legal, Letter, Tabloid
  orientation: portrait or landscape
  margin: number or array

  header:
    height: "45mm",
    contents: '<div style="text-align: center;">Author: Marc Bachmann</div>'

  footer:
    height: 28mm,
    contents:
      first: 'Cover page',
      2: 'Second page' // Any page number is working. 1-based index
      default: '<span style="color: #444;">{{page}}</span>/<span>{{pages}}</span>', // fallback value
      last: 'Last Page'
---
###

###
phantomsJSConvert = (text, config={}, projectDirectoryPath, fileDirectoryPath)->
  if !config.path
    return atom.notifications.addError('phantomjs output path not provided')

  # dest
  if config.path[0] == '/'
    outputFilePath = path.resolve(projectDirectoryPath, '.' + config.path)
  else
    outputFilePath = path.resolve(fileDirectoryPath, config.path)

  useAbsoluteImagePath = false

  TODO: convert to markdown
  TODO: convert to html
  TODO: call phantomjs 

###



