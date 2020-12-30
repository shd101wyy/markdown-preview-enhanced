# PDF

## 概要

PDF ドキュメントを作成するには、ドキュメントのフロントマターで `pdf_document` 出力形式を指定する必要があります。

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: pdf_document
---

```

## 出力先

`path` オプションを指定することでドキュメントの出力先を定義できます。例えば：

```yaml
---
title: "Habits"
output:
  pdf_document:
    path: /Exports/Habits.pdf
---

```

`path` が定義されていない場合、ドキュメントは同じディレクトリの下に生成されます。

## 目次

`toc` オプションを使用して目次を追加し、`toc_depth` オプションを使用して目次に使用する見出しの深さを指定できます。例えば：

```yaml
---
title: "Habits"
output:
  pdf_document:
    toc: true
    toc_depth: 2
---

```

目次の深さが明示的に指定されていない場合、デフォルトで 3 になります（つまり、すべてのレベル 1、2、3 の見出しが目次に含まれます）。

_注意:_ この目次は、**Markdown Preview Enhanced** によって生成される `<!-- toc -->` とは異なります。

`number_sections` オプションを使用して見出し番号を見出しに追加できます：

```yaml
---
title: "Habits"
output:
  pdf_document:
    toc: true
    number_sections: true
---

```

## シンタックス ハイライト

`highlight` オプションはシンタックス ハイライト スタイルを指定します。サポートされているスタイルには、“default”, “tango”, “pygments”, “kate”, “monochrome”, “espresso”, “zenburn”と“haddock”です(シンタックス ハイライトを行わない場合は null を指定します)。

例えば：

```yaml
---
title: "Habits"
output:
  pdf_document:
    highlight: tango
---

```

## LaTeX オプション

PDF ドキュメントの作成に使用される LaTeX テンプレートのパラメータの内いくつかは、トップレベル YAML メタデータを使用して設定できます(これらの設定は、`output` セクションの下に設定せず、`title`、`author`などとともにトップレベルに設定することに注意してください) 。例えば：

```yaml
---
title: "Crop Analysis Q3 2013"
output: pdf_document
fontsize: 11pt
geometry: margin=1in
---

```

使用可能なメタデータ変数は次のとおりです。

| 変数名                         | 説明                                                                                |
| ------------------------------ | ----------------------------------------------------------------------------------- |
| papersize                      | 用紙サイズ。例: `letter`, `A4`                                                      |
| lang                           | 文書の言語コード                                                                    |
| fontsize                       | フォント サイズ (例: 10pt, 11pt, 12pt)                                              |
| documentclass                  | LaTeX ドキュメント クラス (例: jarticle)                                            |
| classoption                    | ドキュメント クラスのオプション (例: oneside); 複数指定可能                         |
| geometry                       | ジオメトリ クラスのオプション (例: margin=1in); 複数指定可能                        |
| linkcolor, urlcolor, citecolor | 内部リンク・外部リンク・引用リンクの文字色 (red, green, magenta, cyan, blue, black) |
| thanks                         | 謝辞脚注の内容                                                                      |

利用可能な変数の詳細については、[こちら](https://pandoc.org/MANUAL.html#variables-for-latex) をご覧ください。

### 引用の LaTeX パッケージ

既定では、引用はすべての出力形式で機能する `pandoc-citeproc` によって処理されます。PDF 出力の場合、`natbib` や `biblatex` などの引用を処理するには LaTeX パッケージを使用する方がよい場合があります。引用に特定の LaTex パッケージを使用するには、オプション `citation_package` を`natbib` または `biblatex` に設定します。たとえば、

```yaml
---
output:
  pdf_document:
    citation_package: natbib
---

```

## 高度なカスタマイズ

### LaTeX エンジン

既定では、PDF ドキュメントは `pdflatex` を使用してレンダリングされます。`latex_engine` オプションを使用して使用する LaTex エンジンを指定できます。利用可能なエンジンは、`pdflatex`、`xelatex`、および `lualatex`です。例えば：

```yaml
---
title: "Habits"
output:
  pdf_document:
    latex_engine: xelatex
---

```

### Include

LaTeX ディレクティブや LaTex コンテンツの追加、または、core pandoc テンプレートを完全に置き換えることにより、PDF 出力のより高度なカスタマイズを行うことができます。ドキュメントヘッダーまたはドキュメント本文の前後にコンテンツを含めるには、次のように `includes`オプションを使用します。

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

### カスタムテンプレート

`template` オプションを使用して pandoc テンプレートを置き換えることもできます：

```yaml
---
title: "Habits"
output:
  pdf_document:
    template: quarterly_report.tex
---

```

テンプレートの詳細については、[pandoc テンプレート](https://pandoc.org/README.html#templates) のドキュメントを参照してください。例として、[デフォルトの LaTeX テンプレート](https://github.com/jgm/pandoc-templates/blob/master/default.latex) を学習することもできます。

### Pandoc の引数

上記の YAML オプションにない pandoc の機能は、カスタム引数 `pandoc_args` を渡すことで使用できます。例えば：

```yaml
---
title: "Habits"
output:
  pdf_document:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## 共有設定

ディレクトリ内の複数のドキュメントで共有する既定の設定値を指定する場合は、ディレクトリ内に `_output.yaml` という名前のファイルを含めることができます。このファイルでは、YAML 区切り文字、または YAML 区切り文字で囲んでいる output オブジェクトは使用されないことに注意してください。例えば：

**\_output.yaml**

```yaml
pdf_document:
  toc: true
  highlight: zenburn
```

`_output.yaml` と同じディレクトリにあるすべてのドキュメントは、その設定値を継承します。ドキュメント内で明示的に定義された設定値は、共有設定ファイルで指定された設定値を上書きします。
