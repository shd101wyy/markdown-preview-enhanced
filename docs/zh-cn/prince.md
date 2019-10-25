# Prince PDF 导出

**Markdown Preview Enhanced** 支持 [prince](https://www.princexml.com/) pdf 文档导出。

## 安装

你需要事先安装好 [prince](https://www.princexml.com/)。  
对于 `macOS`，打开 terminal 终端然后运行一下命令：

```sh
brew install Caskroom/cask/prince
```

## 使用

右键点击预览，然后选择 `PDF (prince)`。

![screen shot 2017-07-14 at 1 44 23 am](https://user-images.githubusercontent.com/1908863/28201287-fb5ea8d0-6835-11e7-9bdb-2afb458ee5cc.png)

## 自定义 CSS

<kbd>cmd-shift-p</kbd> 然后运行 `Markdown Preview Enhanced: Customize Css` 命令，添加以下的代码：

```less
.markdown-preview.markdown-preview {
  &.prince {
    // 你的 prince css
  }
}
```

例如，改变纸张大小到 `A4 landscape`:

```less
.markdown-preview.markdown-preview {
  &.prince {
    @page {
      size: A4 landscape;
    }
  }
}
```

更多信息请查看 [prince 用户指南](https://www.princexml.com/doc/)。  
特别是 [page 样式](https://www.princexml.com/doc/paged/#page-styles)。

## 保存时自动导出

添加 front-matter 如下：

```yaml
---
export_on_save:
  prince: true
---

```

这样每次当你保存你的 markdown 文件时，Prince 将会自动运行生成 PDF 文件。

## 已知问题

- `KaTeX` 和 `MathJax` 无法工作。
