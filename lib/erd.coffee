path = require 'path'
{spawn} = require 'child_process'

## type: bmp, dot, eps, gif, jpg, pdf, plain, png, ps, ps2, svg, tiff
generateERD = (text, format='svg', callback)->
  task = spawn 'erd', [
    '-f', format
  ]

  task.stdin.write(text)
  task.stdin.end()

  chunks = []
  task.stdout.on 'data', (chunk)->
    chunks.push(chunk)

  task.stdout.on 'end', ()->
    data = Buffer.concat(chunks).toString()
    callback?(data)

erdAPI = {
  render: generateERD
}

module.exports = erdAPI