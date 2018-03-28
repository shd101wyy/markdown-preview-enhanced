# Custom 文檔
## 概覽
**Custom Document** 給予你 `pandoc` 的所有力量。  
創建自定義文檔，你需要在 markdown 文件中的 front-matter 裡聲明 `custom_document` 的輸出類型，並且 `path` 項是**必須**被定義的：   

下面的是一個展示了類似於 [PDF 文檔導出](zh-tw/pandoc-pdf.md) 的例子：

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output:
  custom_document:
    path: /Exports/test.pdf
    toc: true
---
```

下面的是一個展示了類似於 [beamer presentation](zh-tw/pandoc-beamer.md) 的例子：
```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["-t", "beamer"]
---
```

## Pandoc Arguments   
If there are pandoc features you want to use that lack equivalents in the YAML options described above you can still use them by passing custom `pandoc_args`. For example:  
```yaml
---
title: "Habits"
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: [
      "--no-tex-ligatures"
    ]
---
```

## Shared Options
If you want to specify a set of default options to be shared by multiple documents within a directory you can include a file named `_output.yaml` within the directory. Note that no YAML delimeters or enclosing output object are used in this file. For example:    

**_output.yaml**
```yaml
custom_document:
  toc: true
  highlight: zenburn
```
All documents located in the same directory as `_output.yaml` will inherit it』s options. Options defined explicitly within documents will override those specified in the shared options file.
