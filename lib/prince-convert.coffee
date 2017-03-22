path = require 'path'
{execFile} = require 'child_process'

princeConvert = (src, dest, callback)->
  execFile 'prince', [src, '--javascript', '-o', dest], callback

module.exports = princeConvert