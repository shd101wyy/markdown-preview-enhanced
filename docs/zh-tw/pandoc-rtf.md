# RTF 文檔
## 概覽
創建 RTF 文檔，你需要在 markdown 文件中的 front-matter 裡聲明 `rtf_document` 的輸出類型：    
```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: rtf_document
---
```

## 輸出路徑
你可以通過 `path` 來定義文檔的輸出路徑。例如：    

```yaml
---
title: "Habits"
output:
  rtf_document:
    path: /Exports/Habits.rtf
---
```   
如果 `path` 沒有被定義，那麼 RTF 將會在相同的文件夾下生成。  

## Table of Contents
你可以通過 `toc` 選項來添加目錄，以及 `toc_depth` 來控制目錄的等級。例如：  
```yaml
---
title: "Habits"
output:
  rtf_document:
    toc: true
    toc_depth: 2
---
```
如果 `toc_depth` 沒有被定義，那麼默認 3 將會被使用。（意味著等級 1，2，已經 3 的標題將會被列舉在目錄中）。  

*注意：* 這個 TOC 和用 **Markdown Preview Enhanced** `<!-- toc -->` 生成的是不同的。  

## Pandoc Arguments   
If there are pandoc features you want to use that lack equivalents in the YAML options described above you can still use them by passing custom `pandoc_args`. For example:  
```yaml
---
title: "Habits"
output:
  rtf_document:
    pandoc_args: [
      "--csl", "/var/csl/acs-nano.csl"
    ]
---
```

## Shared Options
If you want to specify a set of default options to be shared by multiple documents within a directory you can include a file named `_output.yaml` within the directory. Note that no YAML delimeters or enclosing output object are used in this file. For example:    

**_output.yaml**
```yaml
rtf_document:
  toc: true
```
All documents located in the same directory as `_output.yaml` will inherit it』s options. Options defined explicitly within documents will override those specified in the shared options file.
