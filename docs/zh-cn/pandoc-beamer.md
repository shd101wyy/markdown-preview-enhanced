# Beamer 文档

## 概览

创建 Word 文档，你需要在 markdown 文件中的 front-matter 里声明 `beamer_presentation` 的输出类型：  
你可以用 `#` 以及 `##` 来分隔幻灯片（你还可以通过使用分隔符 (`---`) 来插入新的幻灯片）。
例如，下面是一个简单的例子：

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

---

![picture of spaghetti](images/spaghetti.jpg)

## Going to sleep

- Get in bed
- Count sheep
```

## 输出路径

你可以通过 `path` 来定义文档的输出路径。例如：

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    path: /Exports/Habits.pdf
---

```

如果 `path` 没有被定义，那么文档将会在相同的文件夹下生成。

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

## 语法高亮

`highlight` 选项定义了高亮的样式。支持的样式包括 “default”，“tango”，“pygments”，“kate”，“monochrome”，“espresso”，“zenburn”，以及 “haddock” （设置 null 来禁用语法高亮）：

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

**\_output.yaml**

```yaml
beamer_presentation:
  toc: true
```

All documents located in the same directory as `_output.yaml` will inherit it’s options. Options defined explicitly within documents will override those specified in the shared options file.
