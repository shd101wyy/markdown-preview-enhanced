# PDF 文檔
## 概覽
創建 PDF 文檔，你需要在 markdown 文件中的 front-matter 裡聲明 `pdf_document` 的輸出類型：   
```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: pdf_document
---
```

## 輸出路徑
你可以通過 `path` 來定義文檔的輸出路徑。例如：    

```yaml
---
title: "Habits"
output:
  pdf_document:
    path: /Exports/Habits.pdf
---
```   
如果 `path` 沒有被定義，那麼 PDF 將會在相同的文件夾下生成。  

## 目錄
你可以通過 `toc` 選項來添加目錄，以及 `toc_depth` 來控制目錄的等級。例如：  
```yaml
---
title: "Habits"
output:
  pdf_document:
    toc: true
    toc_depth: 2
---
```
如果 `toc_depth` 沒有被定義，那麼默認 3 將會被使用。（意味著等級 1，2，已經 3 的標題將會被列舉在目錄中）。  

*注意：* 這個 TOC 和用 **Markdown Preview Enhanced** `<!-- toc -->` 生成的是不同的。  

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

## 語法高亮
`highlight` 選項定義了高亮的樣式。支持的樣式包括 「default」，「tango」，「pygments」，「kate」，「monochrome」，「espresso」，「zenburn」，以及 「haddock」 （設置 null 來禁用語法高亮）：    

例如：  
```yaml
---
title: "Habits"
output:
  pdf_document:
    highlight: tango
---
```
## LaTeX 選項  
你可以用 YAML metadata 來定義你的 LaTeX 模版（注意這些選項不是出現在 `output` 部分下的，但是出現在最上層）。例如
```yaml
---
title: "Crop Analysis Q3 2013"
output: pdf_document
fontsize: 11pt
geometry: margin=1in
---
```
支持的 metadata 變量包括：  

| 變量  | 描述  |
|---|---|
| papersize | 紙張大小，e.g. `letter`, `A4` |
| lang  | Document language code |
| fontsize | 字體大小 (e.g. 10pt, 11pt, 12pt) |
| documentclass | LaTeX document class (e.g. article) |
| classoption | Option for documentclass (e.g. oneside); may be repeated |
| geometry | Options for geometry class (e.g. margin=1in); may be repeated |
| linkcolor, urlcolor, citecolor	|Color for internal, external, and citation links (red, green, magenta, cyan, blue, black) |
| thanks | specifies contents of acknowledgments footnote after document title. |  

更多的可用變量請查看 [這裡](http://pandoc.org/MANUAL.html#variables-for-latex).

### LaTeX Packages for Citations
By default, citations are processed through `pandoc-citeproc`, which works for all output formats. For PDF output, sometimes it is better to use LaTeX packages to process citations, such as `natbib` or `biblatex`. To use one of these packages, just set the option `citation_package` to be `natbib` or `biblatex`, e.g.  
```yaml
---
output:
  pdf_document:
    citation_package: natbib
---
```

## 高級自定義
### LaTeX Engine   
默認情況下 PDF 文檔由 `pdflatex` 生成。你可以用 `latex_engine` 選項來定義你想用的引擎。支持的引擎有 `pdflatex`，`xelatex`，以及 `lualatex`。例如：  
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

### 自定義模版
你可以替代 pandoc 的基礎模版通過 `template` 選項：
```yaml
---
title: "Habits"
output:
  pdf_document:
    template: quarterly_report.tex
---
```
請參考 [pandoc 模版](http://pandoc.org/README.html#templates) 文檔了解更多關於模版的信息。你還可以學習 [default LaTeX template](https://github.com/jgm/pandoc-templates/blob/master/default.latex) 作為一個例子。  

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

**_output.yaml**
```yaml
pdf_document:
  toc: true
  highlight: zenburn
```
All documents located in the same directory as `_output.yaml` will inherit it』s options. Options defined explicitly within documents will override those specified in the shared options file.
