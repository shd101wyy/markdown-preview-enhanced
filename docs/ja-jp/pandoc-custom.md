# カスタム文書

## 概要

**カスタムドキュメント** を使用すると、`pandoc` の機能を最大限に活用できます。
カスタム文書を作成するには、ドキュメントのフロントマターで `custom_document` 出力形式を指定する必要があります。**また、** `path` **を定義する必要があります**。

以下のコード例は、[PDF](ja-jp/pandoc-pdf.md) と同様に動作します。

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

以下のコード例は、[Beamer](ja-jp/pandoc-beamer.md) と同様に動作します。

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

## Pandoc の引数

上記の YAML オプションにない pandoc の機能は、カスタム引数 `pandoc_args` を渡すことで使用できます。例えば：

```yaml
---
title: "Habits"
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["--no-tex-ligatures"]
---

```

## 共有設定

ディレクトリ内の複数のドキュメントで共有する既定の設定値を指定する場合は、ディレクトリ内に `_output.yaml` という名前のファイルを含めることができます。このファイルでは、YAML 区切り文字、または YAML 区切り文字で囲んでいる output オブジェクトは使用されないことに注意してください。例えば：

**\_output.yaml**

```yaml
custom_document:
  toc: true
  highlight: zenburn
```

`_output.yaml` と同じディレクトリにあるすべてのドキュメントは、その設定値を継承します。ドキュメント内で明示的に定義された設定値は、共有設定ファイルで指定された設定値を上書きします。
