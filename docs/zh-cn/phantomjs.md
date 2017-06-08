# PhantomJS 导出  

**PhantomJS** 支持 `pdf`，`jpeg`，以及 `png` 文件的导出。  

## 使用
右键点击预览，然后选择 `Export to Disk`。    
点击 `PHANTOMJS` 标签。     
点击 `export` 按钮。    

![screen shot 2017-06-06 at 4 46 33 pm](https://user-images.githubusercontent.com/1908863/26853700-a85dba6a-4ad8-11e7-9d42-78b1e4249e83.png)

## Header 和 footer 设置
你可以通过 `Markdown Preview Enhanced: Open Header Footer Config` 命令，来打开并修改 `phantomjs_header_footer_config.js` 文件。  

`phantomjs_header_footer_config.js` 应该如下：    


```javascript
'use strict'
/*
configure header and footer (and other options)
more information can be found here:
    https://github.com/marcbachmann/node-html-pdf
Attention: this config will override your config in exporter panel.

eg:

  let config = {
    "header": {
      "height": "45mm",
      "contents": '<div style="text-align: center;">Author: Marc Bachmann</div>'
    },
    "footer": {
      "height": "28mm",
      "contents": '<span style="color: #444;">{{page}}</span>/<span>{{pages}}</span>'
    }
  }
*/
// you can edit the 'config' variable below
let config = {
}

module.exports = config || {}
```

