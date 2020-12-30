# Pandoc

**Markdown Preview Enhanced** は、`RStudio Markdown` と同様に機能する `pandoc document export` 機能をサポートします。
この機能を使用するには、[pandoc](https://pandoc.org/) がインストールされている必要があります。
pandoc のインストール手順は[こちら](https://pandoc.org/installing.html) にあります。
プレビューを右クリックすると、コンテキストメニューに表示され `pandoc document export` 機能を使用できます。

---

## Pandoc パーサー

既定では、**Markdown Preview Enhanced**は [markdown-it](https://github.com/markdown-it/markdown-it) を使用して markdown を解析します。
パッケージ設定から `pandoc` パーサーに設定することもできます。

![Screen Shot 2017-03-07 at 10.05.25 PM](https://i.imgur.com/NdCJBgR.png)

また、フロントマターに書いて、個々のファイルに pandoc 引数を設定することもできます。

```markdown
---
pandoc_args: ["--toc", "--toc-depth=2"]
---
```

フロントマターに `references` または `bibliography` がある場合、`-filter=pandoc-citeproc` が自動的に引数に追加されることに注意してください。

**注意**: この機能はまだ実験段階です。バグや提案を投稿してください。
**既知の問題と制限事項**：

1. `ebook` のエクスポートに問題があります。
2. `Code Chunk` にはバグがある場合があります。

## フロントマター

`pandoc document export` は `front-matter` の記載を必要とします。
`front-matter` の記述方法に関する詳細とチュートリアルは、[ここ](https://jekyllrb.com/docs/frontmatter/) にあります。

## 出力

上記の `Pandoc Parser` を使用してファイルをエクスポートする必要はありません。

現在サポートされている形式は次のとおりです。**今後、さらに多くの形式がサポートされる予定です。**
(一部の例は [RStudio Markdown](https://rmarkdown.rstudio.com/formats.html) から参照されます))
以下のリンクをクリックして、エクスポート出来るドキュメント形式を確認してください。

- [PDF](ja-jp/pandoc-pdf.md)
- [Word](ja-jp/pandoc-word.md)
- [RTF](ja-jp/pandoc-rtf.md)
- [Beamer](ja-jp/pandoc-beamer.md)

独自のカスタムドキュメントを定義することもできます。

- [custom](ja-jp/pandoc-custom.md)

## 保存時に出力する

以下のようにフロントマターを追加します。

```yaml
---
export_on_save:
  pandoc: true
---

```

このように設定すると、markdown ファイルを保存するたびに pandoc が実行されます。

## 別の記事

- [参考文献](ja-jp/pandoc-bibliographies-and-citations.md)

## 注意事項

`mermaid, wavedrom` は `pandoc document export` では機能しません。
[コード チャンク](ja-jp/code-chunk.md) は、`pandoc document export` で使用できない機能があります。
