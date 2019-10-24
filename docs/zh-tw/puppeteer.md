# Chrome (Puppeteer) 導出

## 准備

你需要預先安裝好 [Chrome 瀏覽器](https://www.google.com/chrome/)。

> 這裡有一個叫做 `chromePath`的插件設置允許你自定義 chrome 的運行路徑。默認條件下你無需修改它。MPE 插件會自動尋找 chrome 的運行路徑。

## 使用

右鍵點擊預覽，選擇 `Chrome (Puppeteer)`。

## 設置 Puppeteer

你可以通過 front-matter 來設置 [PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions) 和 [Screenshot](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions) 的文件導出。例如：

```yaml
---
puppeteer:
  landscape: true
  format: "A4"
  timeout: 3000 # <= 特殊設置，意味著等待（waitFor） 3000 毫秒
---

```

## 保存時自動導出

```yaml
---
export_on_save:
    puppeteer: true # 保存文件時導出 PDF
    puppeteer: ["pdf", "png"] #保存文件時導出 PDF 和 PNG
    puppeteer: ["png"] # 保存文件時導出 PNG
---
```

## 自定義 CSS

<kbd>cmd-shift-p</kbd> 然後運行 `Markdown Preview Enhanced: Customize Css` 命令打開 `style.less` 文件後，添加並修改以下的代碼：

```less
.markdown-preview.markdown-preview {
  @media print {
    // your code here
  }
}
```
