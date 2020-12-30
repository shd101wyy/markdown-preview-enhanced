# Word 文書

## 概要

Word 文書を作成するには、文書のフロントマターで`word_document` 出力形式を指定する必要があります。

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: word_document
---

```

## 出力先

`path` オプションを指定することでドキュメントの出力先を定義できます。例えば：

```yaml
---
title: "Habits"
output:
  word_document:
    path: /Exports/Habits.docx
---

```

`path` が定義されていない場合、ドキュメントは同じディレクトリの下に生成されます。

## シンタックス ハイライト

`highlight` オプションはシンタックス ハイライト スタイルを指定します。サポートされているスタイルには、“default”, “tango”, “pygments”, “kate”, “monochrome”, “espresso”, “zenburn”と“haddock”です(シンタックス ハイライトを行わない場合は null を指定します)。

例えば：

```yaml
---
title: "Habits"
output:
  word_document:
    highlight: "tango"
---

```

## スタイルリファレンス

指定されたファイルを、docx ファイルを生成する際のスタイルリファレンスとして使用します。最良の結果を得るには、リファレンス docx は pandoc を使用して作成された docx ファイルを修正したファイルである必要があります。リファレンス docx の内容は無視されますが、スタイルシートとドキュメントプロパティ(マージン、ページサイズ、ヘッダー、フッターを含む)が出力される docx で使用されます。コマンドラインでリファレンス docx が指定されていない場合、pandoc はユーザーデータディレクトリ(--data-dir を参照)でファイル `reference.docx` を探します。これも見つからない場合は、既定値のスタイルが使用されます。

```yaml
---
title: "Habits"
output:
  word_document:
    reference_docx: mystyles.docx
---

```

## Pandoc の引数

上記の YAML オプションにない pandoc の機能は、カスタム引数 `pandoc_args` を渡すことで使用できます。例えば：

```yaml
---
title: "Habits"
output:
  word_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## 共有設定

ディレクトリ内の複数のドキュメントで共有する既定の設定値を指定する場合は、ディレクトリ内に `_output.yaml` という名前のファイルを含めることができます。このファイルでは、YAML 区切り文字、または YAML 区切り文字で囲んでいる output オブジェクトは使用されないことに注意してください。例えば：

**\_output.yaml**

```yaml
word_document:
  highlight: zenburn
```

`_output.yaml` と同じディレクトリにあるすべてのドキュメントは、その設定値を継承します。ドキュメント内で明示的に定義された設定値は、共有設定ファイルで指定された設定値を上書きします。
