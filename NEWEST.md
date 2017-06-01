#### v0.12.6  
* [x] Add `WELCOME.md` page.  
* [x] Add `mathjax_config.js` file and `Markdown Preview Enhanced: Open MathJax Config` command. Remove `mathJaxProcessEnvironments` from config schema. However, some `MathJax` extensions doesn't work well.  
* [x] Support multiple previews.  
* [x] `cmd-r` keyboard shortcut to refresh the preview.
* [x] More powerful `@import`, now support importing online files.  
      For exampe: `@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"`.  
* [x] Support TOC ignore headings by appending `{.ignore}` after the heading:  
```markdown
[TOC]
# Heading 1
## Heading 2 {.ignore}
**Heading 2** will be ignored
```

* [x] Modifed scroll sync logic (Might cause issue).