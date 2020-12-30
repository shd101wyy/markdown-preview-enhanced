# Chrome (Puppeteer) 出力

## インストール

[Chrome ブラウザ](https://www.google.com/chrome/) がインストールされている必要があります。

> chrome の実行可能ファイルへのパスを指定できる `chromePath` という名前の拡張機能の設定があります。通常、変更する必要はありません。 Markdown Preview Enhanced は自動的にパスを探します。

## 使い方

プレビューを右クリックして、`Chrome (Puppeteer)` を選択します。

## Puppeteer の設定

[PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions) と [Screenshot](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions) の出力設定をフロントマター内に書けます。例えば：

```yaml
---
puppeteer:
  landscape: true
  format: "A4"
  timeout: 3000 # <= Special config, which means waitFor 3000 ms
---

```

## 保存時に出力する

```yaml
---
export_on_save:
    puppeteer: true # export PDF on save
    puppeteer: ["pdf", "png"] # export PDF and PNG files on save
    puppeteer: ["png"] # export PNG file on save
---
```

## CSS のカスタマイズ

<kbd>cmd-shift-p</kbd> 次に、`Markdown Preview Enhanced：Customize Css` コマンドを実行して `style.less` ファイルを開き、次の行を追加して変更します。

```less
.markdown-preview.markdown-preview {
  @media print {
    // your code here
  }
}
```
