# RTF 文書

## 概要

R Markdown から RTF 文書を作成するには、ドキュメントのフロントマターで `rtf_document` 出力形式を指定します。

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: rtf_document
---

```

## 出力先

`path` オプションを指定することでドキュメントの出力先を定義できます。例えば：

```yaml
---
title: "Habits"
output:
  rtf_document:
    path: /Exports/Habits.rtf
---

```

`path` が定義されていない場合、ドキュメントは同じディレクトリの下に生成されます。

## 目次

`toc` オプションを使用して目次を追加し、`toc_depth` オプションを使用して目次に使用する見出しの深さを指定できます。例えば：

```yaml
---
title: "Habits"
output:
  rtf_document:
    toc: true
    toc_depth: 2
---

```

目次の深さが明示的に指定されていない場合、デフォルトで 3 になります（つまり、すべてのレベル 1、2、3 の見出しが目次に含まれます）。

_注意:_ この目次は、**Markdown Preview Enhanced** によって生成される `<!-- toc -->` とは異なります。

### Pandoc の引数

上記の YAML オプションにない pandoc の機能は、カスタム引数 `pandoc_args` を渡すことで使用できます。例えば：

```yaml
---
title: "Habits"
output:
  rtf_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## 共有設定

ディレクトリ内の複数のドキュメントで共有する既定の設定値を指定する場合は、ディレクトリ内に `_output.yaml` という名前のファイルを含めることができます。このファイルでは、YAML 区切り文字、または YAML 区切り文字で囲んでいる output オブジェクトは使用されないことに注意してください。例えば：

**\_output.yaml**

```yaml
rtf_document:
  toc: true
```

`_output.yaml` と同じディレクトリにあるすべてのドキュメントは、その設定値を継承します。ドキュメント内で明示的に定義された設定値は、共有設定ファイルで指定された設定値を上書きします。
