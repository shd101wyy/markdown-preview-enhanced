# eBook 导出

Inspired by *GitBook*  
**Markdown Preview Enhanced** 可以导出 ePub，Mobi，PDF 的电子书。  

![Screen Shot 2016-09-08 at 9.42.43 PM](http://ooo.0o0.ooo/2016/09/09/57d221c0a618a.png)

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
一个电子书项目的例子可以查看 [这里](https://github.com/shd101wyy/ebook-example).   

## 开始编写 eBook    
你可以在你的 markdown 文件中添加 `ebook front-matter` 来设置你的电子书。     
```yaml
---
ebook:
  title: My eBook
  authors: shd101wyy
---
```
接着右键点击预览，选择 `Export to Disk`，然后选择 `EBOOK`。  

### Metadata
* **title**  
你的书的标题    
* **authors**  
作者1 & 作者2 & ...  
* **cover**  
http://path-to-image.png  
* **comments**  
关于这本书的描述  
* **publisher**  
发行商是谁？    
* **book-producer**  
制作商是谁？    
* **pubdate**  
发布日期    
* **language**  
语言
* **isbn**  
书的 ISBN
* **tags**  
输的标签。应该用英文 `,` 隔开。  
* **series**  
书的系列。  
* **rating**  
书的评价。应该是 1 到 5 之间的数字。    

例如：  
```yaml
ebook:
  title: My eBook
  author: shd101wyy
  rating: 5  
```

### 感觉和外观    
下面的选项帮助你设置输出的电子书的外观：   
* **asciiize** `[true/false]`   
`default: false`, Transliterate unicode characters to an ASCII representation. Use with care because this will replace unicode characters with ASCII
* **base-font-size** `[number]`   
The base font size in pts. All font sizes in the produced book will be rescaled based on this size. By choosing a larger size you can make the fonts in the output bigger and vice versa. By default, the base font size is chosen based on the output profile you chose.
* **disable-font-rescaling** `[true/false]`     
`default: false` Disable all rescaling of font sizes.
* **line-height** `[number]`  
The line height in pts. Controls spacing between consecutive lines of text. Only applies to elements that do not define their own line height. In most cases, the minimum line height option is more useful. By default no line height manipulation is performed.
* **margin-top** `[number]`  
`default: 72.0` Set the top margin in pts. Default is 72. Setting this to less than zero will cause no margin to be set (the margin setting in the original document will be preserved). Note: 72 pts equals 1 inch
* **margin-right** `[number]`  
`default: 72.0`
* **margin-bottom** `[number]`  
`default: 72.0`
* **margin-left** `[number]`  
`default: 72.0`
* **margin** `[number/array]`  
`default: 72.0`  
You can define **margin top/right/bottom/left** at the same time.  For example:  
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

For example:
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
* **no-default-epub-cover** `[true/false]`  
Normally, if the input file has no cover and you don't specify one, a default cover is generated with the title, authors, etc. This option disables the generation of this cover.
* **no-svg-cover** `[true/false]`  
Do not use SVG for the book cover. Use this option if your EPUB is going to be used on a device that does not support SVG, like the iPhone or the JetBook Lite. Without this option, such devices will display the cover as a blank page.
* **pretty-print** `[true/false]`  
If specified, the output plugin will try to create output that is as human readable as possible. May not have any effect for some output plugins.   


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
* **paper-size**  
The size of the paper. This size will be overridden when a non default output profile is used. Default is letter. Choices are `a0`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `b0`, `b1`, `b2`, `b3`, `b4`, `b5`, `b6`, `legal`, `letter`
* **default-font-size** `[number]`    
The default font size
* **footer-template**  
An HTML template used to generate footers on every page. The strings `_PAGENUM_`, `_TITLE_`, `_AUTHOR_` and `_SECTION_` will be replaced by their current values.
* **header-template**  
An HTML template used to generate headers on every page. The strings `_PAGENUM_`, `_TITLE_`, `_AUTHOR_` and `_SECTION_` will be replaced by their current values.
* **page-numbers** `[true/false]`     
`default: false`  
Add page numbers to the bottom of every page in the generated PDF file. If you specify a footer template, it will take precedence over this option.
* **pretty-print** `[true/false]`  
If specified, the output plugin will try to create output that is as human readable as possible. May not have any effect for some output plugins.


### HTML
导出 `.html` 不依赖于 `ebook-convert`.  
如果你要导出 `.html` 文件，那么所有的本地图片都将会被引用为 `base64` 数据到一个 `html` 文件中。    
要设置 `html` 的输出，添加 `html` 在 `ebook` 之后。     
```yaml
ebook:
  html:
    cdn: true
```
* **cdn**  
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

---

## Demo
`SUMMARY.md` 是一个主文件。他应该拥有一个 目录（TOC）来帮忙组织书的结构：

```markdown
---
ebook:
  title: Markdown Preview Enhanced
  author: shd101wyy
---

# 前言  
这个是前言，但是不是必须的。

# 目录
* [章 1](/chapter1/README.md)
  * [Markdown Preview Enhanced 的介绍](/chapter1/intro.md)
  * [特性](/chapter1/feature.md)
* [章 2](/chapter2/README.md)
  * [已知问题](/chapter2/issues.md)
```

---

如果你要导出一个电子书，打开你的主文件预览，例如上面提到的 `SUMMARY.md`。然后右键点击预览，选择 `Export to Disk`，然后选择 `EBOOK` 选项。接着你就可以导出你的电子书了。  

## 已知问题 & 局限
* 这个特性还在开发中。  
* 所有由 `mermaid`，`PlantUML`，等 生成的 SVG 图像将不会在电子书中工作。只有 `viz` 没问题。
* 只有 **KaTeX** 可以在电子书中使用。   
  生成的电子书中的数学表达式无法在 **iBook** 显示。  
* **PDF** 以及 **Mobi** 导出有些问题。  
* **Code Chunk** 无法在电子书中工作。  