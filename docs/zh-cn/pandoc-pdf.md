# PDF 文档

## 概览

创建 PDF 文档，你需要在 markdown 文件中的 front-matter 里声明 `pdf_document` 的输出类型：

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: pdf_document
---

```

## 输出路径

你可以通过 `path` 来定义文档的输出路径。例如：

```yaml
---
title: "Habits"
output:
  pdf_document:
    path: /Exports/Habits.pdf
---

```

如果 `path` 没有被定义，那么 PDF 将会在相同的文件夹下生成。

## 目录

你可以通过 `toc` 选项来添加目录，以及 `toc_depth` 来控制目录的等级。例如：

```yaml
---
title: "Habits"
output:
  pdf_document:
    toc: true
    toc_depth: 2
---

```

如果 `toc_depth` 没有被定义，那么默认 3 将会被使用。（意味着等级 1，2，已经 3 的标题将会被列举在目录中）。

_注意：_ 这个 TOC 和用 **Markdown Preview Enhanced** `<!-- toc -->` 生成的是不同的。

You can add section numbering to headers using the `number_sections` option:

```yaml
---
title: "Habits"
output:
  pdf_document:
    toc: true
    number_sections: true
---

```

## 语法高亮

`highlight` 选项定义了高亮的样式。支持的样式包括 “default”，“tango”，“pygments”，“kate”，“monochrome”，“espresso”，“zenburn”，以及 “haddock” （设置 null 来禁用语法高亮）：

例如：

```yaml
---
title: "Habits"
output:
  pdf_document:
    highlight: tango
---

```

## LaTeX 选项

你可以用 YAML metadata 来定义你的 LaTeX 模版（注意这些选项不是出现在 `output` 部分下的，但是出现在最上层）。例如

```yaml
---
title: "Crop Analysis Q3 2013"
output: pdf_document
fontsize: 11pt
geometry: margin=1in
---

```

支持的 metadata 变量包括：

| 变量                           | 描述                                                                                      |
| ------------------------------ | ----------------------------------------------------------------------------------------- |
| papersize                      | 纸张大小，e.g. `letter`, `A4`                                                             |
| lang                           | Document language code                                                                    |
| fontsize                       | 字体大小 (e.g. 10pt, 11pt, 12pt)                                                          |
| documentclass                  | LaTeX document class (e.g. article)                                                       |
| classoption                    | Option for documentclass (e.g. oneside); may be repeated                                  |
| geometry                       | Options for geometry class (e.g. margin=1in); may be repeated                             |
| linkcolor, urlcolor, citecolor | Color for internal, external, and citation links (red, green, magenta, cyan, blue, black) |
| thanks                         | specifies contents of acknowledgments footnote after document title.                      |

更多的可用变量请查看 [这里](https://pandoc.org/MANUAL.html#variables-for-latex).

### LaTeX Packages for Citations

By default, citations are processed through `pandoc-citeproc`, which works for all output formats. For PDF output, sometimes it is better to use LaTeX packages to process citations, such as `natbib` or `biblatex`. To use one of these packages, just set the option `citation_package` to be `natbib` or `biblatex`, e.g.

```yaml
---
output:
  pdf_document:
    citation_package: natbib
---

```

## 高级自定义

### LaTeX Engine

默认情况下 PDF 文档由 `pdflatex` 生成。你可以用 `latex_engine` 选项来定义你想用的引擎。支持的引擎有 `pdflatex`，`xelatex`，以及 `lualatex`。例如：

```yaml
---
title: "Habits"
output:
  pdf_document:
    latex_engine: xelatex
---

```

### Include

You can do more advanced customization of PDF output by including additional LaTeX directives and/or content or by replacing the core pandoc template entirely. To include content in the document header or before/after the document body you use the `includes` option as follows:

```yaml
---
title: "Habits"
output:
  pdf_document:
    includes:
      in_header: header.tex
      before_body: doc_prefix.tex
      after_body: doc_suffix.tex
---

```

### 自定义模版

你可以替代 pandoc 的基础模版通过 `template` 选项：

```yaml
---
title: "Habits"
output:
  pdf_document:
    template: quarterly_report.tex
---

```

请参考 [pandoc 模版](https://pandoc.org/README.html#templates) 文档了解更多关于模版的信息。你还可以学习 [default LaTeX template](https://github.com/jgm/pandoc-templates/blob/master/default.latex) 作为一个例子。

### Pandoc Arguments

If there are pandoc features you want to use that lack equivalents in the YAML options described above you can still use them by passing custom `pandoc_args`. For example:

```yaml
---
title: "Habits"
output:
  pdf_document:
    pandoc_args: [
      "--no-tex-ligatures"
    ]
---
```

## Shared Options

If you want to specify a set of default options to be shared by multiple documents within a directory you can include a file named `_output.yaml` within the directory. Note that no YAML delimeters or enclosing output object are used in this file. For example:

**\_output.yaml**

```yaml
pdf_document:
  toc: true
  highlight: zenburn
```

All documents located in the same directory as `_output.yaml` will inherit it’s options. Options defined explicitly within documents will override those specified in the shared options file.
