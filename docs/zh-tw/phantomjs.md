# PhantomJS 導出  

**PhantomJS** 支持 `pdf`，`jpeg`，以及 `png` 文件的導出。  

在使用這個特性之前，請確保你已經安裝好了 `phantomjs`。

* Windows
請查看 [PhantomJS](http://phantomjs.org/) 官網。
* macOS
`brew install phantomjs`

## 使用
右鍵點擊預覽，然後點擊 `PhantomJS`。     
選擇你想要導出的文件類型。  

![screen shot 2017-07-14 at 1 37 38 am](https://user-images.githubusercontent.com/1908863/28201098-0e5fe3be-6835-11e7-8db6-75fe7e5c35c7.png)

## 設置
### 全局設置
你可以通過 `Markdown Preview Enhanced: Open PhantomJS Config` 命令，來打開並修改 `phantomjs_config.js` 文件。  

> `phantomjs_config.js` 文件位於 `~/.mume/phantomjs_config.js`

`phantomjs_config.js` 應該如下：    


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

### 單一文件設置  
你可以編寫 front-matter  來對設置 phantomjs：  

```yaml
---
phantomjs:
  orientation: landscape
---
```

查看 [node-html-pdf](https://github.com/marcbachmann/node-html-pdf#options) 了解更多信息。   

## 自定義 CSS
<kbd>cmd-shift-p</kbd> 然後運行 `Markdown Preview Enhanced: Customize Css` 命令打開 `style.less` 文件後，添加並修改以下的代碼：    
```less
.markdown-preview.markdown-preview {
  // custom phantomjs png/jpeg export style
  &.phantomjs-image {
    // 你的代碼
  }

  //custom phantomjs pdf export style
  &.phantomjs-pdf {
    // 你的代碼
  }
}
```

## 保存時自動導出
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
這樣每次當你保存你的 markdown 文件時，PhantomJS  將會自動運行。
