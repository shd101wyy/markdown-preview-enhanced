# 扩展 Markdown Parser

运行 `Markdown Preview Enhanced: Extend Parser` 命令。    
然后 `parser.js` 文件。    

> `parser.js` 文件位于 `~/.mume/parser.js`   


```javascript
module.exports = {
  onWillParseMarkdown: function(markdown) {
    return new Promise((resolve, reject)=> {
      return resolve(markdown)
    })
  },
  onDidParseMarkdown: function(html) {
    return new Promise((resolve, reject)=> {
      return resolve(html)
    })
  }
}
```

例如，你想在每个标题前添加 `😀` ，那么你需要编辑 `onWillParseMarkdown` 如下：  

```javascript
module.exports = {
  onWillParseMarkdown: function(markdown) {
    return new Promise((resolve, reject)=> {
      markdown = markdown.replace(/#+\s+/gm, ($0)=> $0+'😀 ')
      return resolve(markdown)
    })
  }
}
```



![screen shot 2017-07-14 at 1 04 19 am](https://user-images.githubusercontent.com/1908863/28200243-78e1a10a-6830-11e7-836b-2defc528ee07.png)
