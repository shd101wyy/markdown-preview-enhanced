# PDF 导出

> 我们推荐使用 [Chrome (Puppeteer) 来导出 PDF](./puppeteer.md)。

## 使用

右键点击预览，然后选择 `Open in Browser`。  
从浏览器中打印为 PDF。

![screen shot 2017-07-14 at 1 46 39 am](https://user-images.githubusercontent.com/1908863/28201366-536dbc0a-6836-11e7-866f-db9a5d12de16.png)

## 自定义 CSS

<kbd>cmd-shift-p</kbd> 然后运行 `Markdown Preview Enhanced: Customize Css` 命令打开 `style.less` 文件后，添加并修改以下的代码：

```less
.markdown-preview.markdown-preview {
  @media print {
    // your code here
  }
}
```

---

你也可以通过 [puppeteer](zh-cn/puppeteer.md) 或者 [prince.md](zh-cn/prince.md) 来生成 PDF 文件。
