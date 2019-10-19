# Word 文档

## 概览

创建 Word 文档，你需要在 markdown 文件中的 front-matter 里声明 `word_document` 的输出类型：

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: word_document
---

```

## 输出路径

你可以通过 `path` 来定义文档的输出路径。例如：

```yaml
---
title: "Habits"
output:
  word_document:
    path: /Exports/Habits.docx
---

```

如果 `path` 没有被定义，那么 Word 将会在相同的文件夹下生成。

## Syntax Highlighting

你可以使用 `highlight` 选项来控制语法高亮的主题。例如：

```yaml
---
title: "Habits"
output:
  word_document:
    highlight: "tango"
---

```

## Style Reference

Use the specified file as a style reference in producing a docx file. For best results, the reference docx should be a modified version of a docx file produced using pandoc. The contents of the reference docx are ignored, but its stylesheets and document properties (including margins, page size, header, and footer) are used in the new docx. If no reference docx is specified on the command line, pandoc will look for a file `reference.docx` in the user data directory (see --data-dir). If this is not found either, sensible defaults will be used.

```yaml
---
title: "Habits"
output:
  word_document:
    reference_docx: mystyles.docx
---

```

## Pandoc Arguments

If there are pandoc features you want to use that lack equivalents in the YAML options described above you can still use them by passing custom `pandoc_args`. For example:

```yaml
---
title: "Habits"
output:
  word_document:
    pandoc_args: [
      "--csl", "/var/csl/acs-nano.csl"
    ]
---
```

## Shared Options

If you want to specify a set of default options to be shared by multiple documents within a directory you can include a file named `_output.yaml` within the directory. Note that no YAML delimeters or enclosing output object are used in this file. For example:

**\_output.yaml**

```yaml
word_document:
  highlight: zenburn
```

All documents located in the same directory as `_output.yaml` will inherit it’s options. Options defined explicitly within documents will override those specified in the shared options file.
