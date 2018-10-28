# Chrome (Puppeteer) 导出

## 准备

你需要预先安装好 [puppeteer](https://github.com/GoogleChrome/puppeteer)。

```bash
npm install -g puppeteer
```

## 使用
右键点击预览，选择 `Chrome (Puppeteer)`。

## 设置 Puppeteer
你可以通过 front-matter 来设置 [PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions) 和 [Screenshot](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions) 的文件导出。例如：

````yaml
---
puppeteer:
    landscape: true
    format: "A4"
---
````

## 自定义 CSS
<kbd>cmd-shift-p</kbd> 然后运行 `Markdown Preview Enhanced: Customize Css` 命令打开 `style.less` 文件后，添加并修改以下的代码：

```less
.markdown-preview.markdown-preview {
    @media print {
        // your code here
    }
}
```
