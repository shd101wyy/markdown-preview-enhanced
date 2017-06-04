# sm.ms api
request = require 'request'
fs = require 'fs'
path = require 'path'

smAPI = {}
smAPI.uploadFile = (filePath, callback)->
  headers = {
    authority: 'sm.ms',
    'user-agent': 'markdown-preview-enhanced'

  }
  request.post url:'https://sm.ms/api/upload', formData: {smfile: fs.createReadStream(filePath)}, headers:headers, (err, httpResponse, body)->
    try
      body = JSON.parse body
      if err
        callback 'Failed to upload image'
      else if body.code == 'error'
        callback body.msg, null
      else
        callback null, body.data.url
    catch error
      callback 'Failed to connect to sm.ms host', null


###
# example of how to use this API
smAPI.uploadFile '/Users/wangyiyi/Desktop/test.html', (err, url)->
  if err
    console.log err
  else
    console.log url
###

module.exports = smAPI
