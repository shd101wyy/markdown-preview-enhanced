@import "https://i.ytimg.com/vi/YgjzquvzTXU/maxresdefault.jpg" {width: 400, style: "position:relative; left: 50%; transform: translateX(-50%);"}

#### v0.12.7  & v0.12.8 
* [x] Quick fix Welcome page issue. So the Welcome page will only open when this package is updated [#428](https://github.com/shd101wyy/markdown-preview-enhanced/issues/428).    

#### v0.12.6  

* [x] Add `WELCOME.md` page and `Markdown Preview Enhanced: Open Welcome Page` command. The `WELCOME.md` will display the changes and updates of this package.   
* [x] Add `mathjax_config.js` file and `Markdown Preview Enhanced: Open MathJax Config` command. Remove `mathJaxProcessEnvironments` from config schema. However, some `MathJax` extensions don't work well.  
* [x] Support multiple previews. You can uncheck the `Open only one preview` in package settings to enable multiple previews so that each markdown source will have a preview.  
![Screen Shot 2017-06-01 at 5.06.41 PM](http://i.imgur.com/gNEh6aK.png)

* [x] `cmd-r` keyboard shortcut in preview to refresh the preview.
* [x] More powerful `@import`:
  1. Support importing online files.  
    For exampe: `@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"`.  
  2. Support configuring images  
  ```markdown
  @import "test.png" {width:"300px", height:"200px", title: "my title", alt: "my alt"}
  ```
  For example the image on the most top of this document:  
  ```markdown
  @import "https://i.ytimg.com/vi/YgjzquvzTXU/maxresdefault.jpg" {width: 400, style: "position:relative; left: 50%; transform: translateX(-50%);"}
  ```

  3. Force to render Code Block  
  ```markdown
  @import "test.puml" {code_block:true, class:"lineNo"}
  @import "test.py" {class:"lineNo"}
  ```

  4. Code Chunk
  ```markdown
  @import "test.py" {code_chunk:true, cmd: "python3", id: "you_have_to_declare_id_here"}
  ```

* [x] Support TOC to ignore headings by appending `{.ignore}` after the heading:  
```markdown
[TOC]
# Heading 1
## Heading 2 {.ignore}
**Heading 2** will be ignored
```

* [x] Support showing line numbers for Code Block and Code Chunk by adding `lineNo` class.  

      ```javascript {.lineNo}
      function add(x, y) {
        return x + y
      }
      ```

      ```{python class:"lineNo", id:"chj3etqcm9"}
      def add(x, y):
          return x + y;
      ```

```javascript {.lineNo}
function add(x, y) {
  return x + y
}
```

```{python class:"lineNo", id:"chj3etqcm9"}
def add(x, y):
    return x + y;
```

* [x] Modifed scroll sync logic (Might cause issue).
* [x] Support `Markdown Preview Enhanced: Sync Preview` and `Markdown Preview Enhanced: Sync Source` [#424](https://github.com/shd101wyy/markdown-preview-enhanced/issues/424).  
      Keyboard shortcut <kbd>ctrl-shift-s</kbd>. Please message me if you have any other good options for keyboard shortcut.         
      However, this works differently from the one in [markdown-preview-plus](https://github.com/atom-community/markdown-preview-plus) and misses the `flash` behavior in **mpp**.     
* [x] Fix image `@import` issue on Windows [#414](https://github.com/shd101wyy/markdown-preview-enhanced/issues/414).  
* [x] Fix one PlantUML rendering [issue](https://github.com/shd101wyy/markdown-preview-enhanced/commit/4b9f7df66af18a96905b60eb845463771fdd034a).    

---  

I will start building a website for the documentation of this package, thanks :)  
