# eBook の作成

_GitBook_ に触発されました。  
**Markdown Preview Enhanced** はコンテンツを ebook(ePub, Mobi, PDF) として出力できます。

![Screen Shot 2016-09-08 at 9.42.43 PM](https://ooo.0o0.ooo/2016/09/09/57d221c0a618a.png)

ebook を生成するには、`ebook-convert` をインストールする必要があります。

## ebook-convert のインストール

**macOS**  
[Calibre Application](https://calibre-ebook.com/download) をダウンロードしてください。`calibre.app` をアプリケーションフォルダーに移動したら、`ebook-convert` ツールへのシンボリックリンクを作成します。

```shell
$ sudo ln -s ~/Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin
```

**Windows**  
[Calibre アプリケーション](https://calibre-ebook.com/download) をダウンロードしてインストールします。
`$PATH` に `ebook-convert` を追加します。

## eBook の例

eBook サンプルプロジェクトは [こちら](https://github.com/shd101wyy/ebook-example) にあります。

## eBook の書き方

markdown ファイルに `ebook front-matter` を追加するだけで、ebook の設定を構成できます。

```yaml
---
ebook:
  theme: github-light.css
  title: My eBook
  authors: shd101wyy
---

```

---

## デモ

`SUMMARY.md` はサンプルエントリファイルです。本をまとめる目次がついています。

```markdown
---
ebook:
  theme: github-light.css
  title: Markdown Preview Enhanced
  author: shd101wyy
---

# Preface

This is the preface, but not necessary.

# Table of Contents

- [Chapter 1](/chapter1/README.md)
  - [Introduction of Markdown Preview Enhanced](/chapter1/intro.md)
  - [Features](/chapter1/feature.md)
- [Chapter 2](/chapter2/README.md)
  - [Known issues](/chapter2/issues.md)
```

markdown ファイルの最後のリストは目次と見なされます。

リンクのタイトルは章のタイトルとして使用され、リンクのターゲットはその章のファイルへのパスです。

---

ebook をエクスポートするには、プレビューを開いた状態で `SUMMARY.md` を開きます。次に、プレビューを右クリックし、`Export to Disk` を選択して、`EBOOK` オプションを選択します。ebook がエクスポートされます。

### メタデータ

- **theme**
  eBook に使用するテーマ。既定ではプレビューテーマを使用します。利用可能なテーマのリストは、[このドキュメント](https://github.com/shd101wyy/mume/#markdown-engine-configuration) の `previewTheme` セクションにあります。
- **title**  
  ebook のタイトル
- **authors**  
  著者 1 & 著者 2 & ...
- **cover**  
  https://path-to-image.png
- **comments**  
  ebook の説明
- **publisher**  
  ebook の出版者
- **book-producer**  
  ebook のプロデューサー
- **pubdate**  
  ebook の発行日
- **language**  
  ebook の言語
- **isbn**  
  ebook の ISBN
- **tags**  
  ebook のタグを設定します。コンマ区切りのリストでなければなりません。
- **series**  
  この ebook が属するシリーズを設定します。
- **rating**  
  レーティングを設定します。 1 と 5 の間の数でなければなりません。
- **include_toc**  
  `既定値：true` エントリファイルに書き込んだ目次を含めるかどうか。

例:

```yaml
ebook:
  title: My eBook
  author: shd101wyy
  rating: 5
```

### 見た目

次のオプションは、出力の見た目の制御に役立ちます。

- **asciiize** `[true/false]`  
  `既定値：false`、Unicode 文字を ASCII 表現に変換します。これは Unicode 文字を ASCII に置き換えるため、注意して使用してください
- **base-font-size** `[number]`  
  基本フォントサイズをポイント単位で設定します。作成された ebook のすべてのフォントサイズは、このサイズに基づいて再スケーリングされます。大きいサイズを選択して出力のフォントを大きくしたり、その逆を行うこともできます。既定では、ベースフォントサイズは、選択した出力プロファイルに基づいて選択されます。
- **disable-font-rescaling** `[true/false]`  
  `既定値：false` フォントサイズのすべての再スケーリングを無効にします。
- **line-height** `[number]`  
  ポイント単位で行の高さを設定します。テキストの連続する行間の間隔を制御します。独自の行の高さを定義しない要素にのみ適用されます。ほとんどの場合、最小行高さオプションの方が便利です。デフォルトでは、行の高さの操作は実行されません。
- **margin-top** `[number]`  
  `既定値：72.0` 上マージンをポイント単位で設定します。これをゼロ未満に設定すると、マージンは設定されません(元のドキュメントのマージン設定は保持されます)。注:72 ポイントは 1 インチに相当します
- **margin-right** `[number]`  
  `既定値: 72.0`
- **margin-bottom** `[number]`  
  `既定値: 72.0`
- **margin-left** `[number]`  
  `既定値: 72.0`
- **margin** `[number/array]`  
  `既定値: 72.0`  
  **マージンの上下左右** を同時に定義できます。例：

```yaml
ebook:
  margin: 5 # margin-top = margin-right = margin-bottom = margin-left = 5
```

```yaml
ebook:
  margin: [4, 8] # margin-top = margin-bottom = 4, margin-left = margin-right = 8
```

```yaml
ebook:
  margin: [1, 2, 3, 4] # margin-top=1, margin-right=2, margin-bottom=3, margin-left=4
```

例:

```yaml
ebook:
  title: My eBook
  base-font-size: 8
  margin: 72
```

## 出力フォーマット

現在のところ、ebook を `ePub`, `mobi`, `pdf`, `html` の形式で出力できます。

### ePub

`ePub` 出力を設定するには、`ebook` の後に `epub` を追加します。

```yaml
---
ebook:
  epub:
    no-default-epub-cover: true
    pretty-print: true
---

```

次のオプションが使用できます。

- **no-default-epub-cover** `[true/false]`  
  通常、入力ファイルに表紙がなく、指定しない場合、既定の表紙がタイトル、著者などとともに生成されます。このオプションは、この表紙の生成を無効にします。
- **no-svg-cover** `[true/false]`  
  表紙に SVG を使用しない。 iPhone や JetBook Lite など、SVG をサポートしていないデバイスで EPUB を使用する場合は、このオプションを使用します。このオプションがないと、このようなデバイスは表紙を空白ページとして表示します。
- **pretty-print** `[true/false]`  
  指定されている場合、出力プラグインは、可能な限り人間が読める形式の出力を作成しようとします。一部の出力プラグインには効果がない場合があります。

### PDF

`pdf` 出力を設定するには、`ebook` の後に `pdf` を追加します。

```yaml
ebook:
  pdf:
    paper-size: letter
    default-font-size: 12
    header-template: "<span> Written by shd101wyy _PAGENUM_ </span>"
```

次のオプションが使用できます。

- **paper-size**  
  用紙サイズ。このサイズは、既定以外の出力プロファイルが使用されると上書きされます。既定値は Letter サイズです。`a0`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `b0`, `b1`, `b2`, `b3`, `b4`, `b5`, `b6`, `legal`, `letter` が利用できます。
- **default-font-size** `[number]`  
  既定のフォントサイズ
- **footer-template**  
  各ページにフッターを生成するために使用される HTML テンプレート。文字列 `_PAGENUM_`, `_TITLE _`, `_AUTHOR_`, `_SECTION_` は、現在の値に置き換えられます。
- **header-template**  
  各ページでヘッダーを生成するために使用される HTML テンプレート。文字列 `_PAGENUM_`, `_TITLE _`, `_AUTHOR_`, `_SECTION_` は、現在の値に置き換えられます。
- **page-numbers** `[true/false]`  
  `既定値: false`  
  生成された PDF ファイルの全ページの下部にページ番号を追加します。フッターテンプレートを指定すると、このオプションよりも優先されます。
- **pretty-print** `[true/false]`  
  指定されている場合、出力プラグインは、可能な限り人間が読める形式の出力を作成しようとします。一部の出力プラグインには効果がない場合があります。

### HTML

`.html` のエクスポートは `ebook-convert` に依存しません。
`.html` ファイルをエクスポートする場合、すべてのローカル画像は単一の `html` ファイル内に `base64` データとして含まれます。
`html` 出力を設定するには、`ebook` の後に `html` を追加します。

```yaml
ebook:
  html:
    cdn: true
```

- **cdn**  
  `cdn.js` から css および javascript ファイルをロードします。このオプションは、`.html` ファイルをエクスポートする場合にのみ使用されます。

## ebook-convert の引数

上記の YAML オプションに相当するものがない `ebook-convert` 機能がある場合、カスタムの `args` を渡すことで使用できます。例：

```yaml
---
ebook:
  title: My eBook
  args: ["--embed-all-fonts", "--embed-font-family"]
---

```

引数の一覧は [ebook-convert manual](https://manual.calibre-ebook.com/generated/en/ebook-convert.html) にあります。

## 保存時に出力する

以下のように front-matter を追加します。

```yaml
---
export_on_save:
  ebook: true
  // or
  ebook: "epub"
  ebook: "pdf"
  ebook: "mobi"
  ebook: "html"
  ebook: ["pdf", ...]
---
```

このように設定すると、markdown ファイルを保存するたびに ebook が生成されます。

## 既知の問題と制限

- ebook の出力はまだ開発中です。
- `mermaid`, `PlantUML` などによって生成されるすべての SVG グラフは、出力された ebook では機能しません。 `viz` のみが機能します。
- **KaTeX** のみが数式の記述に使用できます。
  また、生成された ebook ファイルは、**iBook** で数式が正しくレンダリングされません。
- **PDF** および **Mobi** の出力にはバグがあります。
- **コード チャンク** は ebook の出力では機能しません。
