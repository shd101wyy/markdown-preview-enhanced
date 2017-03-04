const path = require('path'),
      fs = require('fs')

// init config.less file
fs.writeFile(path.relative(__dirname, './styles/config.less'), `@import "syntax-variables"; // will be replaced when preview theme is changed`)