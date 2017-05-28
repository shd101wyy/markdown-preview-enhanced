path = require 'path'
{spawn} = require 'child_process'

plantumlJarPath = path.resolve(__dirname, '../dependencies/plantuml/plantuml.jar')

CALLBACKS = []
CHUNKS = []
TASKS = {} # key is fileDirectoryPath
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

  if !TASKS[fileDirectoryPath] # init `plantuml.jar` task
    TASKS[fileDirectoryPath] = spawn 'java', [  '-Djava.awt.headless=true',
                              '-Dplantuml.include.path='+fileDirectoryPath
                              '-jar', plantumlJarPath,
                              # '-graphvizdot', 'exe'
                              '-pipe',
                              '-tsvg',
                              '-charset', 'UTF-8']

    # only `on 'data'` once
    TASKS[fileDirectoryPath].stdout.on 'data', (chunk)->
      CHUNKS.push(chunk)
      data = Buffer.concat(CHUNKS).toString().trim() # `trim()` here is necessary.
      if data.endsWith('</svg>')
        CHUNKS = [] # clear CHUNKS

        diagrams = data.split('</svg>')
        diagrams.forEach (diagram, i)->
          if diagram.length
            CALLBACKS.shift()?(diagram + '</svg>')

    ###
    TASKS[fileDirectoryPath].stdout.on 'end', ()->
      data = Buffer.concat(chunks).toString()
      callback?(data)
    ###

  CALLBACKS.push(callback) # save callback to CALLBACKS queue
  TASKS[fileDirectoryPath].stdin.write(content + "\n")
  # TASKS[fileDirectoryPath].stdin.end()


# generateSVG('A -> B')
plantumlAPI = {
  render: generateSVG,
}

module.exports = plantumlAPI