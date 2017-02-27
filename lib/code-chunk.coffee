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
run = (content, fileDirectoryPath='', cmd, options={}, callback)->
  args = options.args || []
  if (typeof(args) == 'string')
    args = [args]

  savePath = path.resolve(fileDirectoryPath, Math.random().toString(36).substr(2, 9) + '_code_chunk')

  content = content.replace(/\u00A0/g, ' ');

  if cmd.match /(javascript|js)/ # just javascript, not nodejs
    asyncFunctions = []
    if options.require
      requires = options.require
      if typeof(requires) == 'string'
        requires = [requires]

      for requirePath in requires
        requirePath = requirePath.trim()

        helper = (requirePath)->
          if requirePath.match(/^(http|https)\:\/\//)
            asyncFunctions.push (cb)->
              request requirePath, (error, response, body)->
                return cb(error) if error
                return cb(null, {file: requirePath, data: body.toString()})
          else
            requirePath = path.resolve(fileDirectoryPath, requirePath)
            asyncFunctions.push (cb)->
              fs.readFile requirePath, {encoding: 'utf-8'}, (error, data)->
                return cb(error) if error
                return cb(null, {file: requirePath, data: data.toString()})
        helper(requirePath)

    # require files
    return async.series asyncFunctions, (error, results)->
      if error
        return callback(null, error.toString(), options)
      for result in results
        continue if REQUIRE_CACHE[result.file]
        try # TODO: css
          allowUnsafeNewFunction -> allowUnsafeEval ->
            # .css will cause `Refused to load the stylesheet` security error.
            ###
            if result.file.endsWith('.css') and document
              head = document.getElementsByTagName('head')[0]
              link = document.createElement 'link'
              link.setAttribute 'rel', 'stylesheet'
              link.setAttribute 'type', 'text/css'
              link.setAttribute 'href', result.file
              link.id = 'mpe_' + result.file
              head.appendChild link
            else
            ###
            eval(result.data)
            REQUIRE_CACHE[result.file] = true # save to cache
        catch error
          return callback(null, error.toString(), options)

      # run javascript code
      return allowUnsafeNewFunction -> allowUnsafeEval ->
        try
          callback?(null, eval(content), options)
        catch e
          callback?(null, e.toString(), options)


  if cmd.match(/python/) and (options.matplotlib or options.mpl)
    content = """
# -*- coding: utf-8 -*-
# modify default matplotlib pyplot show function
try:
    import matplotlib
    matplotlib.use('Agg') # use Agg backend
    import matplotlib.pyplot as plt
    import sys
    def new_plt_show():
        plt.savefig(sys.stdout, format="svg")
    plt.show = new_plt_show # override old one
except Exception:
    pass

# modify default mpld3 behavior
try:
    import matplotlib.pyplot as plt, mpld3
    import sys
    def new_mpld3_show():
        fig = plt.gcf() # get current figure
        sys.stdout.write(mpld3.fig_to_html(fig))
    mpld3.show = new_mpld3_show # override old one
    mpld3.display = new_mpld3_show
except Exception:
    pass

""" + content
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

    task = spawn cmd, args, {cwd: fileDirectoryPath}
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
    # if key.endsWith('.css') and document
    #  document.getElementById('mpe_' + key)?.remove()

codeChunkAPI = {run, clearCache}
module.exports = codeChunkAPI