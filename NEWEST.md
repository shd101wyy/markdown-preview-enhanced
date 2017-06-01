#### v0.12.6  
* [x] Add `WELCOME.md` page.  
* [x] Add `mathjax_config.js` file and `Markdown Preview Enhanced: Open MathJax Config` command. Remove `mathJaxProcessEnvironments` from config schema. However, some `MathJax` extensions doesn't work well.  
* [x] Support multiple previews.  
* [x] `cmd-r` keyboard shortcut to refresh the preview.
* [x] More powerful `@import`:
  1. Support importing online files.  
    For exampe: `@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"`.  
  2. Support configuring images  
  ```markdown
  @import "test.png" {width:"300px", height:"200px", title: "my title", alt: "my alt"}
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

* [x] Support TOC ignore headings by appending `{.ignore}` after the heading:  
```markdown
[TOC]
# Heading 1
## Heading 2 {.ignore}
**Heading 2** will be ignored
```

* [x] Modifed scroll sync logic (Might cause issue).
* [x] Fix image `@import` issue on Windows [#414](https://github.com/shd101wyy/markdown-preview-enhanced/issues/414).  