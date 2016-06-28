plantuml = require 'node-plantuml'

generateSVG = (content, callback)->
  content = """
  @startuml
  #{content}
  @enduml
  """
  gen = plantuml.generate(content, {format: 'svg', charset: 'UTF-8'})

  chunks = []
  gen.out.on 'data', (chunk)->
    chunks.push(chunk)
  gen.out.on 'end', ()->
    data = Buffer.concat(chunks).toString()
    callback(data)

# generateSVG('A -> B')
plantumlAPI = {
  render: generateSVG
}

module.exports = plantumlAPI
