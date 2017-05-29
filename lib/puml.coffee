path = require 'path'
{spawn} = require 'child_process'

plantumlJarPath = path.resolve(__dirname, '../dependencies/plantuml/plantuml.jar')

class PlantUMLTask
  constructor: (fileDirectoryPath)->
    @fileDirectoryPath = fileDirectoryPath
    @chunks = ''
    @callbacks = []
    @task = null

    @startTask()

  startTask: ->
    @task = spawn 'java', [  '-Djava.awt.headless=true',
                              '-Dplantuml.include.path='+@fileDirectoryPath
                              '-jar', plantumlJarPath,
                              # '-graphvizdot', 'exe'
                              '-pipe',
                              '-tsvg',
                              '-charset', 'UTF-8']

    @task.stdout.on 'data', (chunk)=>
      data = chunk.toString().trimRight() # `trimRight()` here is necessary.
      if data.endsWith('</svg>')
        data = @chunks + data
        @chunks = '' # clear CHUNKS

        diagrams = data.split('</svg>')
        diagrams.forEach (diagram, i)=>
          if diagram.length
            @callbacks.shift()?(diagram + '</svg>')
      else
        @chunks += data

  generateSVG: (content, cb)->
    @callbacks.push cb
    @task.stdin.write(content + '\n')

TASKS = {} # key is fileDirectoryPath, value is PlantUMLTask
# Async call
render = (content, fileDirectoryPath='', callback)->
  content = content.trim()
  # ' @mpe_file_directory_path:/fileDirectoryPath
  # fileDirectoryPath

  fileDirectoryPath = content.match(/^'\s@mpe_file_directory_path:(.+)$/m)?[1] or fileDirectoryPath


  if !(content.match(/^\@start/m))
    content = """@startuml
#{content}
@enduml"""

  if !TASKS[fileDirectoryPath] # init `plantuml.jar` task
    TASKS[fileDirectoryPath] = new PlantUMLTask(fileDirectoryPath)

  TASKS[fileDirectoryPath].generateSVG content, callback



plantumlAPI = {
  render,
}

module.exports = plantumlAPI