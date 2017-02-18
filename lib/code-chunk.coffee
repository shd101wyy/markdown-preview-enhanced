path = require 'path'
fs = require 'fs'
{spawn} = require 'child_process'
{allowUnsafeEval} = require 'loophole'

#
#
#
run = (content, rootDirectoryPath='', cmd, options={}, callback)->
  args = options.args || []
  if (typeof(args) == 'string')
    args = [args]

  savePath = path.resolve(rootDirectoryPath, Math.random().toString(36).substr(2, 9) + '_code_chunk')

  content = content.replace(/\u00A0/g, ' ');

  if cmd.match /(javascript|js)/ # just javascript, not nodejs
    # replace `require('./file.js')` with `require('absolute_path/file.js')`
    content = content.replace /require\((\s*)(('([^']+)')|("([^"]+)"))(\s*)\)/g, (whole, g1, g2, g3, g4, g5, g6, g7)->
      filePath = g4 or g6 or ''
      if filePath.startsWith('.')
        filePath = path.resolve(rootDirectoryPath, filePath)
      return "require('#{filePath}')"

    return allowUnsafeEval ->
      try
        callback?(null, eval(content), options)
      catch e
        callback?(null, e.toString(), options)

  if cmd.match(/python/) and options.matplotlib
    content = """
import matplotlib
matplotlib.use('Svg') # use Svg backend

""" + content + """

import matplotlib.pyplot as plt
import sys
plt.savefig(sys.stdout)
"""
    options.output = 'html' # change to html so that svg can be rendered


  fs.writeFile savePath, content, (err)->
    if (err)
      callback?(true)
      return

    # check macros
    findInputFileMacro = false
    args = args.map (arg)->
      if arg == '{input_file}'
        findInputFileMacro = true
        savePath
      else
        arg

    if !findInputFileMacro and !options.stdin
      args.push savePath

    task = spawn cmd, args, {cwd: rootDirectoryPath}
    if options.stdin # pass content as stdin
      task.stdin.write(content)
    task.stdin.end()

    chunks = []
    task.stdout.on 'data', (chunk)->
      chunks.push(chunk)

    task.stderr.on 'data', (chunk)->
      chunks.push(chunk)

    task.on 'close', ()->
      fs.unlink(savePath)

      data = Buffer.concat(chunks).toString()
      callback?(null, data, options)

codeChunkAPI = {run}
module.exports = codeChunkAPI