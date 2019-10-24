# Custom 文档

## 概览

**Custom Document** 给予你 `pandoc` 的所有力量。  
创建自定义文档，你需要在 markdown 文件中的 front-matter 里声明 `custom_document` 的输出类型，并且 `path` 项是**必须**被定义的：

下面的是一个展示了类似于 [PDF 文档导出](zh-cn/pandoc-pdf.md) 的例子：

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

下面的是一个展示了类似于 [beamer presentation](zh-cn/pandoc-beamer.md) 的例子：

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

**\_output.yaml**

```yaml
custom_document:
  toc: true
  highlight: zenburn
```

All documents located in the same directory as `_output.yaml` will inherit it’s options. Options defined explicitly within documents will override those specified in the shared options file.
