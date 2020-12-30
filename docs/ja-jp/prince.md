# Prince PDF 出力

**Markdown Preview Enhanced** は、[prince](https://www.princexml.com/) pdf 出力をサポートしています。

## インストール

[prince](https://www.princexml.com/) をインストールする必要があります。
`macOS` の場合は、ターミナルを開いて次のコマンドを実行します。

```sh
brew install Caskroom/cask/prince
```

## 使い方

プレビューを右クリックして、`PDF (prince)` を選択します。

![screen shot 2017-07-14 at 1 44 23 am](https://user-images.githubusercontent.com/1908863/28201287-fb5ea8d0-6835-11e7-9bdb-2afb458ee5cc.png)

## CSS のカスタマイズ

<kbd>cmd-shift-p</kbd> 次に、`Markdown Preview Enhanced：Customize Css` コマンドを実行して `style.less` ファイルを開き、次の行を追加して変更します。

```less
.markdown-preview.markdown-preview {
  &.prince {
    // your prince css here
  }
}
```

たとえば、ページサイズを「A4 横」に変更するには：

```less
.markdown-preview.markdown-preview {
  &.prince {
    @page {
      size: A4 landscape;
    }
  }
}
```

詳細については、[prince ユーザーガイド](https://www.princexml.com/doc/) をご覧ください。
特に [ページスタイル](https://www.princexml.com/doc/paged/#page-styles)。

## 保存時に出力する

以下のようにフロントマターを追加します。

```yaml
---
export_on_save:
  prince: true
---

```

このように設定すると、markdown ファイルを保存するたびに PDF が生成されます。

## 既知の問題

- `KaTeX` と `MathJax` が動作しません。
