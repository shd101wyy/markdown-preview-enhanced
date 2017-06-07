# Beamer 文檔
## 概覽

創建 Word 文檔，你需要在 markdown 文件中的 front-matter 裡聲明 `beamer_presentation` 的輸出類型：  
你可以用 `#` 以及 `##` 來分隔幻燈片（你還可以通過使用分隔符 (`---`) 來插入新的幻燈片）。
例如，下面是一個簡單的例子：
```markdown
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: beamer_presentation
---

# In the morning

## Getting up

- Turn off alarm
- Get out of bed

## Breakfast

- Eat eggs
- Drink coffee

# In the evening

## Dinner

- Eat spaghetti
- Drink wine

----

![picture of spaghetti](images/spaghetti.jpg)

## Going to sleep

- Get in bed
- Count sheep
```  

## 輸出路徑
你可以通過 `path` 來定義文檔的輸出路徑。例如：    

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    path: /Exports/Habits.pdf
---
```   
如果 `path` 沒有被定義，那麼文檔將會在相同的文件夾下生成。

## Incremental Bullets
You can render bullets incrementally by adding the `incremental` option:
```yaml
---
output:
  beamer_presentation:
    incremental: true
---
```
If you want to render bullets incrementally for some slides but not others you can use this syntax:
```markdown
> - Eat eggs
> - Drink coffee
```

## Themes
You can specify Beamer themes using the `theme`, `colortheme`, and `fonttheme` options:  
```yaml
---
output:
  beamer_presentation:
    theme: "AnnArbor"
    colortheme: "dolphin"
    fonttheme: "structurebold"
---
```

## Table of Contents
The `toc` option specifies that a table of contents should be included at the beginning of the presentation (only level 1 headers will be included in the table of contents). For example:
```yaml
---
output:
  beamer_presentation:
    toc: true
---
```

## Slide Level
The `slide_level` option defines the heading level that defines individual slides. By default this is the highest header level in the hierarchy that is followed immediately by content, and not another header, somewhere in the document. This default can be overridden by specifying an explicit `slide_level`:
```yaml
---
output:
  beamer_presentation:
    slide_level: 2
---
```

## 語法高亮
`highlight` 選項定義了高亮的樣式。支持的樣式包括 「default」，「tango」，「pygments」，「kate」，「monochrome」，「espresso」，「zenburn」，以及 「haddock」 （設置 null 來禁用語法高亮）：    

例如：  
```yaml
---
title: "Habits"
output:
  beamer_presentation:
    highlight: tango
---
```

## Pandoc Arguments   
If there are pandoc features you want to use that lack equivalents in the YAML options described above you can still use them by passing custom `pandoc_args`. For example:  
```yaml
---
title: "Habits"
output:
  beamer_presentation:
    pandoc_args: [
      "--no-tex-ligatures"
    ]
---
```

## Shared Options
If you want to specify a set of default options to be shared by multiple documents within a directory you can include a file named `_output.yaml` within the directory. Note that no YAML delimeters or enclosing output object are used in this file. For example:    

**_output.yaml**
```yaml
beamer_presentation:
  toc: true
```
All documents located in the same directory as `_output.yaml` will inherit it』s options. Options defined explicitly within documents will override those specified in the shared options file.
