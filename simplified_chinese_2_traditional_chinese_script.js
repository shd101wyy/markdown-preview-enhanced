const chineseConv = require('chinese-conv'),
      fs = require('fs'),
      path = require('path')

/*

  This script is used to convert the simplified Chinese *.md files inside /docs/zh-cn folder to Tranditional Chinese for /docs/zh-tw

  To run this script:
    node simplified_chinese_2_traditional_chinese_script.js

 */

const ignoreFiles = ['installation.md']

zhTWDir = path.resolve(__dirname, './docs/zh-tw')
zhCNDir = path.resolve(__dirname, './docs/zh-cn')
/*
// delete all markdown files inside /docs/zh-tw
fs.readdir(zhTWDir, (error, items)=> {
  if (error)
    return console.log(error)

  items.forEach((fileName)=> {
    for (let i = 0; i < ignoreFiles.length; i++) {
      if (ignoreFiles[i] === fileName)
        return
    }

    fs.unlink(path.resolve(zhTWDir, fileName))
  })
})
*/

// translate
fs.readdir(zhCNDir, (error, items)=> {
  if (error)
    return console.log(error)

  items.forEach((fileName)=> {
    for (let i = 0; i < ignoreFiles.length; i++) {
      if (ignoreFiles[i] === fileName)
        return
    }

    const filePath = path.resolve(zhCNDir, fileName)
    fs.readFile(filePath, {encoding:'utf-8'}, (error, data)=>{
      if (error)
        return console.log(error)

      let text = chineseConv.tify(data).replace(/\]\(\s*zh\-cn\//g, '](zh-tw/')

      fs.writeFile(path.resolve(zhTWDir, fileName), text, {encoding:'utf-8'}, (error)=> {
        if (error)
          return console.log(error)
      })
    })
  })
})
