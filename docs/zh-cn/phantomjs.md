# PhantomJS 导出  

**PhantomJS** 支持 `pdf`，`jpeg`，以及 `png` 文件的导出。  

在使用这个特性之前，请确保你已经安装好了 `phantomjs`。

* Windows
请查看 [PhantomJS](http://phantomjs.org/) 官网。
* macOS
`brew install phantomjs`

## 使用
右键点击预览，然后点击 `PhantomJS`。     
选择你想要导出的文件类型。  

![screen shot 2017-07-14 at 1 37 38 am](https://user-images.githubusercontent.com/1908863/28201098-0e5fe3be-6835-11e7-8db6-75fe7e5c35c7.png)

## 设置
### 全局设置
你可以通过 `Markdown Preview Enhanced: Open PhantomJS Config` 命令，来打开并修改 `phantomjs_config.js` 文件。  

> `phantomjs_config.js` 文件位于 `~/.mume/phantomjs_config.js`

`phantomjs_config.js` 应该如下：    


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

### 单一文件设置  
你可以编写 front-matter  来对设置 phantomjs：  

```yaml
---
phantomjs:
  orientation: landscape
---
```

查看 [node-html-pdf](https://github.com/marcbachmann/node-html-pdf#options) 了解更多信息。   

## 自定义 CSS
<kbd>cmd-shift-p</kbd> 然后运行 `Markdown Preview Enhanced: Customize Css` 命令打开 `style.less` 文件后，添加并修改以下的代码：    
```less
.markdown-preview.markdown-preview {
  // custom phantomjs png/jpeg export style
  &.phantomjs-image {
    // 你的代码
  }

  //custom phantomjs pdf export style
  &.phantomjs-pdf {
    // 你的代码
  }
}
```

## 保存时自动导出
添加 front-matter 如下：  
```yaml
---
export_on_save:
  phantomjs: true
  // or
  phantomjs: "pdf"
  phantomjs: "jpeg"
  phantomjs: "png"
  phantomjs: ["pdf", "png", ...]
---
```
这样每次当你保存你的 markdown 文件时，PhantomJS  将会自动运行。
