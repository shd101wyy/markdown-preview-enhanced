path = require 'path'
{execFile} = require 'child_process'

pandocConvert = (src, dest, callback)->
  args = [  src,
            dest  ]
  execFile 'pandoc',
            args,
            callback

module.exports = pandocConvert
