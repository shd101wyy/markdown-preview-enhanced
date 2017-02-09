###
CACHE, key is @editor.getFilePath()
used to store rendered cache.

{
  html: @element.innerHTML
  codeChunksData: @codeChunksData
  graphData: @graphData
  presentationMode: @presentationMode
  slideConfigs: @slideConfigs
  filesCache: @filesCache
}
###
CACHE = {}
module.exports = CACHE