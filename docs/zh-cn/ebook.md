# eBook 导出

Inspired by _GitBook_  
**Markdown Preview Enhanced** 可以导出 ePub，Mobi，PDF 的电子书。

![Screen Shot 2016-09-08 at 9.42.43 PM](https://ooo.0o0.ooo/2016/09/09/57d221c0a618a.png)

要导出电子书，你需要事先安装好 `ebook-convert`。

## 安装 ebook-convert

**macOS**  
下载 [Calibre](https://calibre-ebook.com/download)。  
在将 `calibre.app` 添加到你的 Applications 添加一个 symbolic link 到 `ebook-convert` 工具：

```shell
$ sudo ln -s ~/Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin
```

**Windows**  
下载并安装 [Calibre Application](https://calibre-ebook.com/download)。  
添加 `ebook-convert` 到你的系统路径。

## eBook 例子

一个电子书项目的例子可以查看 [这里](https://github.com/shd101wyy/ebook-example)。

## 开始编写 eBook

你可以在你的 markdown 文件中添加 `ebook front-matter` 来设置你的电子书。

```yaml
---
ebook:
  theme: github-light.css
  title: My eBook
  authors: shd101wyy
---

```

---

## Demo

`SUMMARY.md` 是一个**主文件**。他应该拥有一个 目录（TOC）来帮忙组织书的结构：

```markdown
---
ebook:
  theme: github-light.css
  title: Markdown Preview Enhanced
  author: shd101wyy
---

# 前言

这个是前言，但是不是必须的。

# 目录

- [章 1](/chapter1/README.md)
  - [Markdown Preview Enhanced 的介绍](/chapter1/intro.md)
  - [特性](/chapter1/feature.md)
- [章 2](/chapter2/README.md)
  - [已知问题](/chapter2/issues.md)
```

一般来讲，最后一个列表会被视为目录（TOC）。

---

如果你要导出一个电子书，打开你的主文件预览，例如上面提到的 `SUMMARY.md`。然后右键点击预览，选择 `Export to Disk`，然后选择 `EBOOK` 选项。接着你就可以导出你的电子书了。

### Metadata

- **theme**
  电子书的渲染主题。默认是使用预览的主题。主题列表可以在[这个文档](https://github.com/shd101wyy/mume/#markdown-engine-configuration)中的 `previewTheme` 部分找到。
- **title**  
  你的书的标题
- **authors**  
  作者 1 & 作者 2 & ...
- **cover**  
  https://path-to-image.png
- **comments**  
  关于这本书的描述
- **publisher**  
  发行商是谁？
- **book-producer**  
  制作商是谁？
- **pubdate**  
  发布日期
- **language**  
  语言
- **isbn**  
  书的 ISBN
- **tags**  
  输的标签。应该用英文 `,` 隔开。
- **series**  
  书的系列。
- **rating**  
  书的评价。应该是 1 到 5 之间的数字。
- **include_toc**  
  `默认：true` 是否包含主文件中所写的目录（TOC）。

例如：

```yaml
ebook:
  title: My eBook
  author: shd101wyy
  rating: 5
```

### 感觉和外观

下面的选项帮助你设置输出的电子书的外观：

- **asciiize** `[true/false]`  
  `默认：false`, 是否将 unicode 字符转化为 ASCII 。请小心使用这一选项因为这将会将 unicode 字符转化为 ASCII。
- **base-font-size** `[number]`  
  基本字体大小，单位 pts。所有的字体大小将会根据这个基本字体大小进行缩放。选择大的字体意味着你输出的内容的字体会更大。默认下，基本字体大小和你的 profile 设置中的相同。
- **disable-font-rescaling** `[true/false]`  
  `默认：false` 禁掉所有字体的缩放。
- **line-height** `[number]`  
  行间距，单位 pts。用于控制行与行之间的空隙大小。这个选项仅仅作用于没有定义自己行间距的元素。在普遍情况下，小的行间距是最有用的。默认下，没有行间距的操作。
- **margin-top** `[number]`  
  `默认：72.0` Set the top margin in pts. Default is 72. Setting this to less than zero will cause no margin to be set (the margin setting in the original document will be preserved). Note: 72 pts equals 1 inch
- **margin-right** `[number]`  
  `默认：72.0`
- **margin-bottom** `[number]`  
  `默认：72.0`
- **margin-left** `[number]`  
  `默认：72.0`
- **margin** `[number/array]`  
  `默认：72.0`  
  你也可以同时定义 **margin top/right/bottom/left**。例如：

```yaml
ebook:
  margin: 5 # margin-top = margin-right = margin-bottom = margin-left = 5
```

```yaml
ebook:
  margin: [4, 8] # margin-top = margin-bottom = 4, margin-left = margin-right = 8
```

```yaml
ebook:
  margin: [1, 2, 3, 4] # margin-top=1, margin-right=2, margin-bottom=3, margin-left=4
```

例如：

```yaml
ebook:
  title: My eBook
  base-font-size: 8
  margin: 72
```

## 输出类型

目前你可以输出以下类型的电子书：  
`ePub`, `mobi`, `pdf`, `html`。

### ePub

要设置 `ePub` 的输出，添加 `epub` 在 `ebook` 之后。

```yaml
---
ebook:
  epub:
    no-default-epub-cover: true
    pretty-print: true
---

```

可进行的设置如下：

- **no-default-epub-cover** `[true/false]`  
  通常情况下，如果你没有提供书籍的封面 `(cover)`，那么我们会自动为你生成一个包含书名，作者名等的封面。禁用这个选项将会禁止自动生成封面。
- **no-svg-cover** `[true/false]`  
  不使用 SVG 作为书籍封面。启用这个选项如果你的 EPUB 将会被用于不支持 SVG 的设备，例如 iPhone 或者 JetBook Lite。没有这个选项，上述的设备将会显示空白页。
- **pretty-print** `[true/false]`  
  如果启用了这个选项，那么输出插件将会尽可能的生成人类可读的文档。可能对其他一些插件没作用。

### PDF

要设置 `ePub` 的输出，添加 `pdf` 在 `ebook` 之后。

```yaml
ebook:
  pdf:
    paper-size: letter
    default-font-size: 12
    header-template: "<span> Written by shd101wyy _PAGENUM_ </span>"
```

可进行的设置如下：

- **paper-size**  
  纸张的大小。这个选项将会覆盖掉默认 profile 中的大小。默认是 letter。可选的选项有：`a0`，`a1`，`a2`，`a3`，`a4`，`a5`，`a6`，`b0`，`b1`，`b2`，`b3`，`b4`，`b5`，`b6`，`legal`，`letter`
- **default-font-size** `[number]`  
  默认字体大小
- **footer-template**  
  为每个页面的 footer 的模版。字符串 `_PAGENUM_`，`_TITLE_`，`_AUTHOR_` 已经 `_SECTION_` 将会被相应的值替代。
- **header-template**  
  为每个页面的 header 的模版。字符串 `_PAGENUM_`，`_TITLE_`，`_AUTHOR_` 已经 `_SECTION_` 将会被相应的值替代。
- **page-numbers** `[true/false]`  
  `默认：false`  
  添加页码到每一页的底部。如果你定义了 `footer-template`，那么 `footer-template` 会先被处理。
- **pretty-print** `[true/false]`  
  如果启用了这个选项，那么输出插件将会尽可能的生成人类可读的文档。可能对其他一些插件没作用。

### HTML

导出 `.html` 不依赖于 `ebook-convert`.  
如果你要导出 `.html` 文件，那么所有的本地图片都将会被引用为 `base64` 数据到一个 `html` 文件中。  
要设置 `html` 的输出，添加 `html` 在 `ebook` 之后。

```yaml
ebook:
  html:
    cdn: true
```

- **cdn**  
  是否从 `cdn.js` 读取 css 和 javascript 文件。

## ebook-convert 参数

如果这里有 `ebook-convert` 的一些你想要使用的特性，但是上面没有提到，你依旧可以在 `args` 中使用它们。  
例如：

```yaml
---
ebook:
  title: My eBook
  args: ["--embed-all-fonts", "--embed-font-family"]
---

```

你可以在 [ebook-convert 手册](https://manual.calibre-ebook.com/generated/en/ebook-convert.html) 中找到一系列的参数。

## 保存时自动导出

Add the front-matter like below:

```yaml
---
export_on_save:
  ebook: true
  // or
  ebook: "epub"
  ebook: "pdf"
  ebook: "mobi"
  ebook: "html"
  ebook: ["pdf", ...]
---
```

这样当你保存你的 markdown 文件时，电子书将会被自动导出。

## 已知问题 & 局限

- 这个特性还在开发中。
- 所有由 `mermaid`，`PlantUML`，等 生成的 SVG 图像将不会在电子书中工作。只有 `viz` 没问题。
- 只有 **KaTeX** 可以在电子书中使用。  
  生成的电子书中的数学表达式无法在 **iBook** 显示。
- **PDF** 以及 **Mobi** 导出有些问题。
- **Code Chunk** 无法在电子书中工作。
