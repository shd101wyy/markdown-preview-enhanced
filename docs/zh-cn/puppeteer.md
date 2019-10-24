# Chrome (Puppeteer) 导出

## 准备

你需要预先安装好 [Chrome 浏览器](https://www.google.com/chrome/)。

> 这里有一个叫做 `chromePath`的插件设置允许你自定义 chrome 的运行路径。默认条件下你无需修改它。MPE 插件会自动寻找 chrome 的运行路径。

## 使用

右键点击预览，选择 `Chrome (Puppeteer)`。

## 设置 Puppeteer

你可以通过 front-matter 来设置 [PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions) 和 [Screenshot](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions) 的文件导出。例如：

```yaml
---
puppeteer:
  landscape: true
  format: "A4"
  timeout: 3000 # <= 特殊设置，意味着等待（waitFor） 3000 毫秒
---

```

## 保存时自动导出

```yaml
---
export_on_save:
    puppeteer: true # 保存文件时导出 PDF
    puppeteer: ["pdf", "png"] #保存文件时导出 PDF 和 PNG
    puppeteer: ["png"] # 保存文件时导出 PNG
---
```

## 自定义 CSS

<kbd>cmd-shift-p</kbd> 然后运行 `Markdown Preview Enhanced: Customize Css` 命令打开 `style.less` 文件后，添加并修改以下的代码：

```less
.markdown-preview.markdown-preview {
  @media print {
    // your code here
  }
}
```
