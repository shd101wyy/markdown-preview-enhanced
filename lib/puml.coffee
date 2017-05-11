path = require 'path'
{spawn} = require 'child_process'
md5 = require('md5');

plantumlJarPath = path.resolve(__dirname, '../dependencies/plantuml/plantuml.jar')

# Async call
generateSVG = (content, fileDirectoryPath='', callback)->

  content = content.trim()
  fileDirectoryPath = content.match(/^'\s@mpe_file_directory_path:(.+)$/m)?[1] or fileDirectoryPath

  #the string have to put this way for make md5 hash right
  if !content.startsWith('@start')
    content = """@startuml
#{content}
@enduml"""

  content = content.replace(/\r/g, "")

  hash = md5(content)

  # the cache not work , still dont know why
  # if plantumlAPI.callbacks[hash]?
  #   console.log("content cached!!")
  #   callback?(plantumlAPI.callbacks[hash].result)
  #   return

  plantumlAPI.callbacks[hash] = {cb:callback, content: content, result: null}

  #keep call size tiny
  if Object.keys(plantumlAPI.callbacks).length > 20
    # console.log("callbacks too large, shifting:" + plantumlAPI.callbacks.length + " hash:" + Object.keys(plantumlAPI.callbacks)[0]);
    delete plantumlAPI.callbacks[Object.keys(plantumlAPI.callbacks)[0]]

  if @task == null
    @task = spawn 'java', [    '-Djava.awt.headless=true',
                            '-Dplantuml.include.path='+fileDirectoryPath
                            '-jar', plantumlJarPath,
                            # '-graphvizdot', 'exe'
                            '-pipe',
                            '-tsvg',
                            '-charset', 'UTF-8']

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
          #use hash to prevent callbacks error, but it still not work very well
          data = ""
          uml = diag.match(/@startuml(.|\n|\r)*@enduml/);
          if(uml != null)
            #walk around of plantuml bug sometimes "-->" will become "- ->"
            hash = md5(uml[0].replace(/\r/g, "").replace(/- -/g, "--"))
            plantumlAPI.callbacks[hash]?.result = diag
            plantumlAPI.callbacks[hash]?.cb(diag)


  @task.stdin.write(content)
  @task.stdin.write("\n")

# generateSVG('A -> B')
plantumlAPI = {
  callbacks : []
  render: generateSVG
  task: null
}

module.exports = plantumlAPI
