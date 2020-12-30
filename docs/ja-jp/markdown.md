# Save as Markdown

**Markdown Preview Enhanced** は **GitHub Flavored Markdown** へのコンパイルをサポートします。出力された markdown ファイルにはすべてのグラフ(png 画像として)、コードチャンク(結果を非表示にして含める)、数学タイプセット(画像として表示)が含まれ、GitHub で公開できます。

## 使い方

プレビューを右クリックして、`Save as Markdown` を選択します。

## 設定

フロントマターで画像ディレクトリと出力パスを設定できます。

```yaml
---
markdown:
  image_dir: /assets
  path: output.md
  ignore_from_front_matter: true
  absolute_image_path: false
---

```

**image_dir** `省略可能`
生成された画像を保存する場所を指定します。たとえば、`/ assets` はすべての画像がプロジェクトフォルダーの下の `assets` ディレクトリに保存されることを意味します。 **image_dir** が指定されていない場合、パッケージ設定の `Image folder path` が使用されます。既定値は `/assets` です。

**path** `省略可能`  
markdown ファイルを出力する場所を指定します。 **path** が指定されていない場合、 `filename_.md` が出力先として使用されます。

**ignore_from_front_matter** `省略可能`  
`false` に設定すると、`markdown` フィールドがフロントマターに含まれます。

**absolute_image_path** `省略可能`  
画像パスに絶対パスと相対パスのどちらを使用するかを指定します。

## 保存時に出力する

以下のようにフロントマターを追加します:

```yaml
---
export_on_save:
  markdown: true
---

```

このように設定すると、markdown ソースファイルを保存するたびに、markdown ファイルが生成されます。

## 既知の問題点

- `WaveDrom` はまだ動作しません。
- 数学の組版表示が正しくない場合があります。
- `latex` コードチャンクはまだ機能しません。
