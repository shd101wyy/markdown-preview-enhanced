# Pandoc

**Markdown Preview Enhanced** 支持类似于 `RStudio Markdown` 的 `pandoc 文档导出`特性。  
要使用这一特性，你需要安装好 [pandoc](https://pandoc.org/)。  
Pandoc 的安装说明可以参考 [这里](https://pandoc.org/installing.html)。  
你可以通过右键点击预览，然后在菜单中点击 `Pandoc` 使用 `pandoc document export`。

---

## Pandoc Parser

默认情况下， **Markdown Preview Enhanced** 使用 [markdown-it](https://github.com/markdown-it/markdown-it) 来转换 markdown。  
你也可以在插件设置中设置使用 `Pandoc Parser` 来转换 markdown。

![Screen Shot 2017-03-07 at 10.05.25 PM](https://i.imgur.com/NdCJBgR.png)

你还可以为单独的文件设置 pandoc 的参数通过编写 front-matter：

```markdown
---
pandoc_args: ["--toc", "--toc-depth=2"]
---
```

请注意，如果在你的 front-matter 中写有 `references` 或者 `bibliography`，那么 `--filter=pandoc-citeproc` 将会被自动添加 。

**请注意**：这一特性依旧是实验性质的。请随意发表你的看法以及建议。  
**已知的问题 & 局限**:

1. `ebook` 导出有问题。
2. `Code Chunk` 有时候有问题。

## Front-Matter

`pandoc document export` 要求编写 `front-matter`。  
如果你想了解更多的关于如何编写 `front-matter` 的信息，请查看 [这里](https://jekyllrb.com/docs/frontmatter/)。

## 文档导出

你不是必须使用我上面提到的 `Pandoc Parser` 才可以使用 Pandoc 导出文件。

以下的文件类型是支持的，**更多的文件类型可能会在未来添加。**  
（一些例子引用于 [RStudio Markdown](https://rmarkdown.rstudio.com/formats.html)）  
点击以下的链接查看如何导出相应的文件类型。

- [PDF](zh-cn/pandoc-pdf.md)
- [Word](zh-cn/pandoc-word.md)
- [RTF](zh-cn/pandoc-rtf.md)
- [Beamer](zh-cn/pandoc-beamer.md)

你还可以创建你自己的自定义文档：

- [custom](zh-cn/pandoc-custom.md)

## 保存时自动导出

添加 front-matter 如下：

```yaml
---
export_on_save:
  pandoc: true
---

```

这样每次当你保存你的 markdown 文件时，pandoc 将会自动运行。

## 文章

- [Bibliographies and Citations](zh-cn/pandoc-bibliographies-and-citations.md)

## 注意

`mermaid，wavedrom` 将无法在 `pandoc document export` 中工作。  
[code chunk](code-chunk.md) 部分工作于 `pandoc document export`。
