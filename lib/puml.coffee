path = require 'path'
{spawn} = require 'child_process'

plantumlJarPath = path.resolve(__dirname, '../dependencies/plantuml/plantuml.jar')

addJob = (content, fileDirectoryPath='', callback) ->
  @jobs.push({content, fileDirectoryPath, callback})

executeJob = () ->
  for d, i in @jobs
    generateSVG(d[0], d[1], d[2])

# Async call
generateSVG = (content, fileDirectoryPath='', callback)->

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
  @task.stdin.write("\n")
  #@task.stdin.end()

  chunks = []
  @task.stdout.on 'data', (chunk)->
    chunks.push(chunk)

  @task.stdout.on 'end', ()->
    data = Buffer.concat(chunks).toString()
    callback?(data)

# generateSVG('A -> B')
plantumlAPI = {
  task: null
  jobs : []
  render: addJob
}

module.exports = plantumlAPI
