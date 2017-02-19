path = require 'path'
fs = require 'fs'
{spawn} = require 'child_process'
{allowUnsafeEval, allowUnsafeNewFunction} = require 'loophole'
request = require('request')
async = require('async')

REQUIRE_CACHE = {}

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
    asyncFunctions = []
    if options.require
      requires = options.require
      if typeof(requires) == 'string'
        requires = [requires]

      for requirePath in requires
        # TODO: css
        # TODO: http://
        if requirePath.match(/^(http|https)\:\/\//)
          asyncFunctions.push (cb)->
            request requirePath, (error, response, body)->
              return cb(error) if error
              return cb(null, {file: requirePath, data: body.toString()})
        else
          requirePath = path.resolve(rootDirectoryPath, requirePath)
          asyncFunctions.push (cb)->
            fs.readFile requirePath, {encoding: 'utf-8'}, (error, data)->
              return cb(error) if error
              return cb(null, {file: requirePath, data: data.toString()})

    # require files
    return async.series asyncFunctions, (error, results)->
      if error
        return callback(null, error.toString(), options)

      for result in results
        continue if REQUIRE_CACHE[result.file]
        try # TODO: css
          allowUnsafeNewFunction -> allowUnsafeEval ->
            eval(result.data)
            REQUIRE_CACHE[result.file] = result.data # save to cache
        catch error
          return callback(null, error.toString(), options)

      # run javascript code
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


clearCache = ()->
  for key of REQUIRE_CACHE
    REQUIRE_CACHE[key] = false

codeChunkAPI = {run, clearCache}
module.exports = codeChunkAPI