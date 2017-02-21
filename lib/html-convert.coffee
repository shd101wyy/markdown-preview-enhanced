# TODO: finish this file
###
html:
  path: ./test.html
  cdn: true
  absolute_image_path: true
  image_dir:
###

###
htmlConvert = (text, config={}, projectDirectoryPath, fileDirectoryPath)->
  if !config.path
    return atom.notifications.addError('html output path not provided')

  if !config.image_dir
    return atom.notifications.addError('{image_dir} has to be specified')

  # dest
  if config.path[0] == '/'
    outputFilePath = path.resolve(projectDirectoryPath, '.' + config.path)
  else
    outputFilePath = path.resolve(fileDirectoryPath, config.path)

  useAbsoluteImagePath = config.absolute_image_path

  TODO: presentation html?
###