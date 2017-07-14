# Extend Markdown Parser

Run `Markdown Preview Enhanced: Extend Parser` command.  
Then edit the `parser.js` file.  

> `parser.js` file is located at `~/.mume/parser.js`   


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

For example, if you want to prepend `😀` to every headers, then just edit `onWillParseMarkdown` like this:  

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
