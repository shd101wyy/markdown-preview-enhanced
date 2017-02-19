path = require 'path'
fs = require 'fs'
{spawn} = require 'child_process'
{allowUnsafeEval, allowUnsafeNewFunction} = require 'loophole'

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
    if options.require
      requires = options.require
      if typeof(requires) == 'string'
        requires = [requires]

      requiresStr = ""
      for requirePath in requires
        requirePath = path.resolve(rootDirectoryPath, requirePath)
        # TODO: css
        # TODO: http://

        requiresStr += fs.readFileSync(requirePath, {encoding: 'utf-8'}) + '\n'

      content = requiresStr + '\n' + content


    return allowUnsafeNewFunction -> allowUnsafeEval ->
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