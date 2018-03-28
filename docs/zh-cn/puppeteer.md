# Chrome (Puppeteer) 导出

## 准备

你需要预先安装好 [puppeteer](https://github.com/GoogleChrome/puppeteer)。

```bash
npm install -g puppeteer
```

## 使用
右键点击预览，选择 `Chrome (Puppeteer)`。

## 自定义 CSS
<kbd>cmd-shift-p</kbd> 然后运行 `Markdown Preview Enhanced: Customize Css` 命令打开 `style.less` 文件后，添加并修改以下的代码：

```less
.markdown-preview.markdown-preview {
    @media print {
        // your code here
    }
}
```
