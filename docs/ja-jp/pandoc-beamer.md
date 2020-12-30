# Beamer プレゼンテーション

## 概要

**Markdown Preview Enhanced** から Beamer プレゼンテーションを作成するには、ドキュメントのフロントマターで `beamer_presentation` 出力形式を指定します。
`#` および `##` 見出しタグを使用して、セクションに分割されたスライドショーを作成できます(水平線(`----`)を使用して、ヘッダーなしで新しいスライドを作成することもできます。)
たとえば、次は簡単なスライドショーです:

```markdown
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: beamer_presentation
---

# 午前

## 起きる

- アラームをオフにする
- ベッドから出る

## Breakfast

## 朝ごはん

- 卵を食べる
- コーヒーを飲む

# 午後

## 晩ごはん

- スパゲッティを食べる
- ワインを飲む

---

![スパゲッティの写真](images/spaghetti.jpg)

## 寝る

- 横になる
- 羊を数える
```

## 出力先

`path` オプションを指定することでドキュメントの出力先を定義できます。例えば：

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    path: /Exports/Habits.pdf
---

```

`path` が定義されていない場合、ドキュメントは同じディレクトリの下に生成されます。

## 箇条書き番号のインクリメント

`incremental` オプションを追加することで、箇条書きの番号をインクリメントしてレンダリングできます：

```yaml
---
output:
  beamer_presentation:
    incremental: true
---

```

一部のスライドで箇条書き番号のインクリメント レンダリングをしたい場合は、次の構文を使用できます。

```markdown
> - Eat eggs
> - Drink coffee
```

## テーマ

`theme`、`colortheme`、および `fonttheme` オプションを使用して Beamer テーマを指定できます。

```yaml
---
output:
  beamer_presentation:
    theme: "AnnArbor"
    colortheme: "dolphin"
    fonttheme: "structurebold"
---

```

## 目次

`toc` オプションは、目次をプレゼンテーションの最初に含めるように指定します（目次にはレベル 1 ヘッダーのみが含まれます）。例えば：

```yaml
---
output:
  beamer_presentation:
    toc: true
---

```

## スライドレベル

`slide_level` オプションは個々のスライドを定義する見出しレベルを定義します。デフォルトでは、これは階層内で最も高いヘッダーレベルであり、直後にコンテンツが続きます。ドキュメント内の別のヘッダーではありません。このデフォルトは、 `slide_level` を明示的に指定することでオーバーライドできます。

```yaml
---
output:
  beamer_presentation:
    slide_level: 2
---

```

## シンタックス ハイライト

`highlight` オプションはシンタックス ハイライト スタイルを指定します。サポートされているスタイルには、“default”, “tango”, “pygments”, “kate”, “monochrome”, “espresso”, “zenburn”と“haddock”です(シンタックス ハイライトを行わない場合は null を指定します)。

例えば：

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    highlight: tango
---

```

## Pandoc の引数

上記の YAML オプションにない pandoc の機能は、カスタム引数 `pandoc_args` を渡すことで使用できます。例えば：

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## 共有設定

ディレクトリ内の複数のドキュメントで共有する既定の設定値を指定する場合は、ディレクトリ内に `_output.yaml` という名前のファイルを含めることができます。このファイルでは、YAML 区切り文字、または YAML 区切り文字で囲んでいる output オブジェクトは使用されないことに注意してください。例えば：

**\_output.yaml**

```yaml
beamer_presentation:
  toc: true
```

`_output.yaml` と同じディレクトリにあるすべてのドキュメントは、その設定値を継承します。ドキュメント内で明示的に定義された設定値は、共有設定ファイルで指定された設定値を上書きします。
