path = require 'path'
{spawn} = require 'child_process'

plantumlJarPath = path.resolve(__dirname, '../dependencies/plantuml/plantuml.jar')

CALLBACKS = []
CHUNKS = []
# Async call
generateSVG = (content, fileDirectoryPath='', callback)->
  content = content.trim()
  # ' @mpe_file_directory_path:/fileDirectoryPath
  # fileDirectoryPath

  fileDirectoryPath = content.match(/^'\s@mpe_file_directory_path:(.+)$/m)?[1] or fileDirectoryPath

  if !(content.match(/^\@start/m))
    content = """
@startuml
#{content}
@enduml
    """

  if !@task # init `plantuml.jar` task
    @task = spawn 'java', [  '-Djava.awt.headless=true',
                              '-Dplantuml.include.path='+fileDirectoryPath
                              '-jar', plantumlJarPath,
                              # '-graphvizdot', 'exe'
                              '-pipe',
                              '-tsvg',
                              '-charset', 'UTF-8']

    # only `on 'data'` once
    @task.stdout.on 'data', (chunk)->
      CHUNKS.push(chunk)
      data = Buffer.concat(CHUNKS).toString()
      if data.endsWith('--></g></svg>')
        CHUNKS = [] # clear CHUNKS
        CALLBACKS.shift()?(data)

  ###
  @task.stdout.on 'end', ()->
    data = Buffer.concat(chunks).toString()
    callback?(data)
  ###

  CALLBACKS.push(callback) # save callback to CALLBACKS queue
  @task.stdin.write(content + "\n")
  # @task.stdin.end()


# generateSVG('A -> B')
plantumlAPI = {
  render: generateSVG,
  task: null
}

module.exports = plantumlAPI
