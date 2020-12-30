# PDF 出力

> [Chrome(Puppeteer) を使用した PDF 出力](ja-jp/puppeteer.md) を使用することをお勧めします。

## 使い方

プレビューを右クリックして、`Open in Browser` を選択します。
ブラウザから PDF として印刷します。

![screen shot 2017-07-14 at 1 46 39 am](https://user-images.githubusercontent.com/1908863/28201366-536dbc0a-6836-11e7-866f-db9a5d12de16.png)

## CSS のカスタマイズ

<kbd>cmd-shift-p</kbd> 次に、`Markdown Preview Enhanced：Customize Css` コマンドを実行して `style.less` ファイルを開き、次の行を追加して変更します。

```less
.markdown-preview.markdown-preview {
  @media print {
    // your code here
  }
}
```

---

[puppeteer](ja-jp/puppeteer.md) または[prince](ja-jp/prince.md) で PDF ファイルを生成することもできます。
