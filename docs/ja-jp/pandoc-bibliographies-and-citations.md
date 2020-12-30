# 参考文献と引用

## 参考文献

### 参考文献の指定

[Pandoc](https://pandoc.org/MANUAL.html#citations) は、さまざまなスタイルで引用・参考文献リストを自動的に生成できます。この機能を使用するには、YAML メタデータセクションの `bibliography` メタデータフィールドを使用して参考文献ファイルを指定する必要があります。例えば：

```yaml
---
title: "Sample Document"
output: pdf_document
bibliography: bibliography.bib
---

```

複数の参考文献ファイルを含める場合は、次のように定義できます。

```yaml
---
bibliography: [bibliography1.bib, bibliography2.bib]
---

```

参考文献ファイルは、次の形式のみ対応します。

| 形式        | 拡張子   |
| ----------- | -------- |
| BibLaTeX    | .bib     |
| BibTeX      | .bibtex  |
| Copac       | .copac   |
| CSL JSON    | .json    |
| CSL YAML    | .yaml    |
| EndNote     | .enl     |
| EndNote XML | .xml     |
| ISI         | .wos     |
| MEDLINE     | .medline |
| MODS        | .mods    |
| RIS         | .ris     |

### インライン参考文献

または、ドキュメントの YAML メタデータで `references` フィールドを使用できます。これには、YAML でエンコードされた参照の配列を含める必要があります。次に例を示します。

```yaml
---
references:
  - id: fenner2012a
    title: One-click science marketing
    author:
      - family: Fenner
        given: Martin
    container-title: Nature Materials
    volume: 11
    URL: "https://dx.doi.org/10.1038/nmat3283"
    DOI: 10.1038/nmat3283
    issue: 4
    publisher: Nature Publishing Group
    page: 261-263
    type: article-journal
    issued:
      year: 2012
      month: 3
---

```

### 参考文献リストの配置

参考文献リストはドキュメントの最後に配置されます。通常、適切なヘッダーでドキュメントを終了する必要があります。

```markdown
last paragraph...

# References
```

参考文献はこのヘッダーの後に挿入されます。

## 引用

### 引用の構文

引用は角括弧の内側に入り、セミコロンで区切られます。各引用には、`@` とデータベースからの引用識別子で構成されるキーが必要であり、オプションで接頭辞、ロケータ、サフィックスを含めることができます。ここではいくつかの例を示します。

```
Blah blah [see @doe99, pp. 33-35; also @smith04, ch. 1].

Blah blah [@doe99, pp. 33-35, 38-39 and *passim*].

Blah blah [@smith04; @doe99].
```

`@` の前のマイナス記号 `(-)` は、引用における著者の言及を抑制します。これは、著者がすでにテキストで言及されている場合に役立ちます。

```
Smith says blah [-@smith04].
```

次のように、本文中の引用を書くこともできます。

```
@smith04 says blah.

@smith04 [p. 33] says blah.
```

### 未使用の参照(notice)

本文で文献を実際に引用せずに参考文献に含めたい場合は、ダミーの `nocite` メタデータフィールドを定義して、そこに引用を配置できます。

```
---
nocite: |
  @item1, @item2
...

@item3
```

この例では、ドキュメントには `item3` の引用のみが含まれますが、参考文献には`item1`、`item2`、および `item3` のエントリが含まれます。

### 引用スタイル

既定では、pandoc は引用と参照に Chicago author-date format を使用します。別のスタイルを使用するには、 `csl` メタデータフィールドで CSL 1.0 スタイルファイルを指定する必要があります。例えば：

```yaml
---
title: "Sample Document"
output: pdf_document
bibliography: bibliography.bib
csl: biomed-central.csl
---

```

CSL スタイルの作成と変更に関する入門書は[こちら](https://citationstyles.org/downloads/primer.html) にあります。 CSL スタイルのリポジトリは[こちら](https://github.com/citation-style-language/styles) にあります。ぱっと見るだけなら、https://zotero.org/styles も参照してください。

### PDF 出力時の引用

既定では、引用は pandoc-citeproc によって生成され、すべての出力形式で機能します。出力が LaTeX/PDF の場合は、LaTeX パッケージ(natbib など)を使用して引用を生成することもできます。詳細については、[PDF ドキュメント](ja-jp/pandoc-pdf.md) を参照してください。
