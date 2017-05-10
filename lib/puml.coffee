path = require 'path'
{spawn} = require 'child_process'
md5 = require('md5');

plantumlJarPath = path.resolve(__dirname, '../dependencies/plantuml/plantuml.jar')
#
# addJob = (content, fileDirectoryPath='', callback) ->
#   @jobs.push({content, fileDirectoryPath, callback})
#   @executeJob()
#
# executeJob = () ->
#   if @inProgress
#     return
#
#   @inProgress = true
#   try
#     job = @jobs.shift()
#     while job
#       @generateSVG(job.content, job.fileDirectoryPath, job.callback)
#       job = @jobs.shift()
#   finally
#     @inProgress = false


# Async call
generateSVG = (content, fileDirectoryPath='', callback)->
  plantumlAPI.callbacks.push(callback)
  console.log("init callbacks length ->" + plantumlAPI.callbacks.length)
  content = content.trim()
  # ' @mpe_file_directory_path:/fileDirectoryPath
  # fileDirectoryPath

  fileDirectoryPath = content.match(/^'\s@mpe_file_directory_path:(.+)$/m)?[1] or fileDirectoryPath

  if !content.startsWith('@start')
    content = """
@startuml
#{content}
@enduml

    """

  if @task == null
    @task = spawn 'java', [    '-Djava.awt.headless=true',
                            '-Dplantuml.include.path='+fileDirectoryPath
                            '-jar', plantumlJarPath,
                            # '-graphvizdot', 'exe'
                            '-pipe',
                            '-tsvg',
                            '-charset', 'UTF-8']

  @task.stdin.write(content)
  # console.log("write content:" + content)
  data = ""
  @task.stdout.on 'data', (chunk)->
    data = data + chunk.toString()
    if data.endsWith("--></g></svg>")
      #data may contains many diagrams, lets split it
      diagrams = data.split("--></g></svg>")
      for key, diag of diagrams
        if diag.trim() == ""
          continue

        diag = diag + "--></g></svg>"
        #same diagram svg data will be trigger times while the diagram initialize
        #use hash to prevent callbacks error
        hash = md5(diag)
        if plantumlAPI.oldHash != hash
          plantumlAPI.oldHash = hash
          data = ""
          console.debug("oldhash:" + plantumlAPI.oldHash + " new hash:" + hash)
          console.debug("chunks:" + diag)
          console.debug("callbacks.length:" + plantumlAPI.callbacks.length)
          callback = plantumlAPI.callbacks.shift()
          callback?(diag)


# generateSVG('A -> B')
plantumlAPI = {
  oldHash : ""
  callbacks : []
  task: null
  render: generateSVG
}

module.exports = plantumlAPI
