path = require 'path'
fs = require 'fs'
{spawn} = require 'child_process'

# TODO: known extensions. eg: node -> .js
run = (content, rootDirectoryPath='', cmd, options={}, callback)->
  args = options.args || []
  if (typeof(args) == 'string')
    args = [args]

  savePath = path.resolve(rootDirectoryPath, Math.random().toString(36).substr(2, 9) + '_code_chunk')

  content = content.replace(/\u00A0/g, ' ');

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