# PDF 導出

> 我們推薦使用 [Chrome (Puppeteer) 來導出 PDF](./puppeteer.md)。

## 使用

右鍵點擊預覽，然後選擇 `Open in Browser`。  
從瀏覽器中打印為 PDF。

![screen shot 2017-07-14 at 1 46 39 am](https://user-images.githubusercontent.com/1908863/28201366-536dbc0a-6836-11e7-866f-db9a5d12de16.png)

## 自定義 CSS

<kbd>cmd-shift-p</kbd> 然後運行 `Markdown Preview Enhanced: Customize Css` 命令打開 `style.less` 文件後，添加並修改以下的代碼：

```less
.markdown-preview.markdown-preview {
  @media print {
    // your code here
  }
}
```

---

你也可以通過 [puppeteer](zh-tw/puppeteer.md) 或者 [prince.md](zh-tw/prince.md) 來生成 PDF 文件。
