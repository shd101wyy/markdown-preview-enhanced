# RTF 文档

## 概览

创建 RTF 文档，你需要在 markdown 文件中的 front-matter 里声明 `rtf_document` 的输出类型：

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: rtf_document
---

```

## 输出路径

你可以通过 `path` 来定义文档的输出路径。例如：

```yaml
---
title: "Habits"
output:
  rtf_document:
    path: /Exports/Habits.rtf
---

```

如果 `path` 没有被定义，那么 RTF 将会在相同的文件夹下生成。

## Table of Contents

你可以通过 `toc` 选项来添加目录，以及 `toc_depth` 来控制目录的等级。例如：

```yaml
---
title: "Habits"
output:
  rtf_document:
    toc: true
    toc_depth: 2
---

```

如果 `toc_depth` 没有被定义，那么默认 3 将会被使用。（意味着等级 1，2，已经 3 的标题将会被列举在目录中）。

_注意：_ 这个 TOC 和用 **Markdown Preview Enhanced** `<!-- toc -->` 生成的是不同的。

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

**\_output.yaml**

```yaml
rtf_document:
  toc: true
```

All documents located in the same directory as `_output.yaml` will inherit it’s options. Options defined explicitly within documents will override those specified in the shared options file.
