###
CACHE, key is @editor.getFilePath()
used to store rendered cache.

{
  html: @previewElement.innerHTML
  codeChunksData: @codeChunksData
  graphData: @graphData
  presentationMode: @presentationMode
  tocConfigs: @tocConfigs
  slideConfigs: @slideConfigs
  filesCache: @filesCache
}
###
CACHE = {}
module.exports = CACHE