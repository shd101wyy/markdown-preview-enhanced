# 外部 File の Import

![doc-imports](https://cloud.githubusercontent.com/assets/1908863/22716507/f352a4b6-ed5b-11e6-9bac-88837f111de0.gif)

## 使い方

単に

`@import "your_file"`

で OK です。単純ですね :)

`<!-- @import "your_file" -->` でも有効です。

## Refresh ボタン

プレビューの右隅に更新ボタンが追加されました。
クリックすると、ファイルキャッシュがクリアされ、プレビューが更新されます。
画像キャッシュをクリアしたい場合に便利です。[＃144](https://github.com/shd101wyy/markdown-preview-enhanced/issues/144) [＃249](https://github.com/shd101wyy/markdown-preview-enhanced/issues/249)

![screen shot 2017-02-07 at 5 48 52 pm](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## 利用可能な File

- `.jpeg(.jpg), .gif, .png, .apng, .svg, .bmp` ファイルは markdown の画像として扱われます。
- `.csv` ファイルは markdown の Table に変換されます。
- `.mermaid` ファイルは mermaid としてレンダリングされます。
- `.dot` ファイルは viz.js (graphviz) によってレンダリングされます。
- `.plantuml(.puml)` ファイルは PlantUML によってレンダリングされます。
- `.html` ファイルは直接埋め込まれます。
- `.js` ファイルは `<script src="your_js"></script>` として include されます。
- `.less` および `.css` ファイルはスタイルとして include されます。ローカルの `less` ファイルのみが現在サポートされています。`.css` ファイルは `<link rel="stylesheet" href="your_css">` として include されます。
- `.pdf` ファイルは `pdf2svg` によって `svg` ファイルに変換されてから include されます。
- `markdown` ファイルは直接パースされ、埋め込まれます。
- 他のすべてのファイルはコード ブロックとしてレンダリングされます。

## 画像の設定

```markdown
@import "test.png" {width="300px" height="200px" title="my title" alt="my alt"}
```

## オンラインファイルの Import

例:

```markdown
@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"
```

## PDF ファイルの Import

PDF ファイルを Import するには、[pdf2svg](extra.md) がインストールされている必要があります。
Markdown Preview Enhanced は、ローカルとオンラインの両方の PDF ファイルの Import をサポートしています。
ただし、大きな PDF ファイルをインポートすることはお勧めしません。
例:

```markdown
@import "test.pdf"
```

### PDF の設定

- **page_no**
  PDF の `n番目` のページを表示します。 ページ数は 1 から数えます。たとえば、`{page_no=1}` は PDF の最初のページを表示します。
- **page_begin**, **page_end**
  範囲指定。たとえば、`{page_begin=2 page_end=4}`は、2、3、4 ページを表示します。

## 強制的にコード ブロックとしてレンダリングする

```markdown
@import "test.puml" {code_block=true class="line-numbers"}
@import "test.py" {class="line-numbers"}
```

## コード ブロックとして Import

```markdown
@import "test.json" {as="vega-lite"}
```

## 特定の行の Import

```markdown
@import "test.md" {line_begin=2}
@import "test.md" {line_begin=2 line_end=10}
@import "test.md" {line_end=-4}
```

## ファイルをコード チャンクとして Import

```markdown
@import "test.py" {cmd="python3"}
```

[➔ コード チャンク](ja-jp/code-chunk.md)
