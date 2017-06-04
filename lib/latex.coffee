PDF = null

# callback (error, svg)
toSVG = (texFilePath, callback)->
  engine = atom.config.get('markdown-preview-enhanced.latexEngine')
  task = spawn latexEngine, [texFilePath]

  chunks = []
  task.stdout.on 'data', (chunk)->
    chunks.push(chunk)

  errorChunks = []
  task.stderr.on 'data', (chunk)->
    errorChunks.push(chunk)

  task.on 'close', (chunk)->
    if errorChunks.length
      return callback(Buffer.concat(chunks).toString(), null)
    else
      pdfFilePath = texFilePath.replace(/\.(la)?tex$/, '.pdf')

      PDF ?= require('./pdf')


module.exports = LaTeX = {toSVG}