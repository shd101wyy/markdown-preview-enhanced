# Chrome (Puppeteer) 導出

## 准備

你需要預先安裝好 [puppeteer](https://github.com/GoogleChrome/puppeteer)。

```bash
npm install -g puppeteer
```

## 使用
右鍵點擊預覽，選擇 `Chrome (Puppeteer)`。

## 設置 Puppeteer
你可以通過 front-matter 來設置 [PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions) 和 [Screenshot](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions) 的文件導出。例如：

````yaml
---
puppeteer:
    landscape: true
    format: "A4"
---
````

## 自定義 CSS
<kbd>cmd-shift-p</kbd> 然後運行 `Markdown Preview Enhanced: Customize Css` 命令打開 `style.less` 文件後，添加並修改以下的代碼：

```less
.markdown-preview.markdown-preview {
    @media print {
        // your code here
    }
}
```
