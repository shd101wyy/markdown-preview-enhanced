# EBook generation (beta)

<!-- toc orderedList:0 -->

* [EBook generation (beta)](#ebook-generation-beta)
	* [Installing ebook-convert](#installing-ebook-convert)
	* [EBook Example](#ebook-example)
	* [Start writing EBook](#start-writing-ebook)
		* [Metadata](#metadata)
		* [Feel and Look](#feel-and-look)
	* [Output Formats](#output-formats)
		* [ePub](#epub)
		* [PDF](#pdf)
		* [HTML](#html)
	* [ebook-convert Arguments](#ebook-convert-arguments)
	* [Demo](#demo)
	* [Known Issues & Limitations](#known-issues-limitations)

<!-- tocstop -->

Inspired by *GitBook*  
**Markdown Preview Enhanced** can output content as ebook (ePub, Mobi, PDF).   

![Screen Shot 2016-09-08 at 9.42.43 PM](http://ooo.0o0.ooo/2016/09/09/57d221c0a618a.png)

To generate ebook, you need to have `ebook-convert` installed.  

## Installing ebook-convert
**OS X**  
Download the [Calibre Application](https://calibre-ebook.com/download). After moving the calibre.app to your Applications folder create a symbolic link to the ebook-convert tool:
```shell
$ sudo ln -s ~/Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin
```
**Windows**  
Download and Install the [Calibre Application](https://calibre-ebook.com/download).  
Add `ebook-convert` to your system path.

## EBook Example
An EBook example project can be found [here](https://github.com/shd101wyy/ebook-example).   

## Start writing EBook    
You can set up a ebook configuration by simply adding `ebook front-matter` into your markdown file.   
```yaml
---
ebook:
  title: My EBook
  authors: shd101wyy
---
```
Next right click at the preview, choose `Export to Disk`, then choose `EBOOK`.

### Metadata
* **title**  
title of your book  
* **authors**  
author1 & author2 & ...  
* **cover**  
http://path-to-image.png  
* **comments**  
Set the ebook description
* **publisher**  
who is the publisher?  
* **book-producer**  
who is the book producer  
* **pubdate**  
publish date  
* **language**  
Set the language
* **isbn**  
ISBN of the book  
* **tags**  
Set the tags for the book. Should be a comma separated list.
* **series**  
Set the series this ebook belongs to.
* **rating**  
Set the rating. Should be a number between 1 and 5.

For example:   
```yaml
ebook:
  title: My EBook
  author: shd101wyy
  rating: 5  
```

### Feel and Look  
The following options are provided to help control the look and feel of the output
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
  title: My EBook
  base-font-size: 8
  margin: 72
```
## Output Formats
Right now you can output ebook in format of `ePub`, `mobi`, `pdf`, `html`.  

### ePub
To configure `ePub` output, simply add `epub` after `ebook`.   
```yaml
---
ebook:
  epub:
    no-default-epub-cover: true
    pretty-print: true
---
```
the following options are provided:   
* **no-default-epub-cover** `[true/false]`  
Normally, if the input file has no cover and you don't specify one, a default cover is generated with the title, authors, etc. This option disables the generation of this cover.
* **no-svg-cover** `[true/false]`  
Do not use SVG for the book cover. Use this option if your EPUB is going to be used on a device that does not support SVG, like the iPhone or the JetBook Lite. Without this option, such devices will display the cover as a blank page.
* **pretty-print** `[true/false]`  
If specified, the output plugin will try to create output that is as human readable as possible. May not have any effect for some output plugins.   


### PDF  
To configure `pdf` output, simply add `pdf` after `ebook`.   
```yaml
ebook:
  pdf:
    paper-size: letter
    default-font-size: 12
    header-template: "<span> Written by shd101wyy _PAGENUM_ </span>"
```
the following options are provided:  
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
Exporting `.html` doesn't depend on `ebook-convert`.  
If you are exporting `.html` file, then all local images will be included as `base64` data inside a single `html` file.  
To configure `html` output, simply add `html` after `ebook`.
```yaml
ebook:
  html:
    cdn: true
```
* **cdn**  
Load css and javascript files from `cdn.js`. This option is only used when exporting `.html` file.  

## ebook-convert Arguments
If there are `ebook-convert` features you want to use that lack equivalents in the YAML options described above you can still use them by passing custom `args`. For example:  
```yaml
---
ebook:
  title: My EBook
  args: ["--embed-all-fonts", "--embed-font-family"]
---
```  
You can find a list of arguments in [ebook-convert manual](https://manual.calibre-ebook.com/generated/en/ebook-convert.html).

---

## Demo
`Summary.md` is a sample entry file. It should also have a TOC to help organize the book:  
```markdown
---
ebook:
  title: Markdown Preview Enhanced
  author: shd101wyy
---

# Preface  
This is the preface, but not necessary.

# Table of Contents
* [Chapter 1](/chapter1/README.md)
  * [Introduction of Markdown Preview Enhanced](/chapter1/intro.md)
  * [Features](/chapter1/feature.md)
* [Chapter 2](/chapter2/README.md)
  * [Known issues](/chapter2/issues.md)
```

The link's title is used as the chapter's title, and the link's target is a path to that chapter's file.  

---

To export ebook, open the `SUMMARY.md` with the preview opened. Then right click at the preview, choose `Export to Disk`, then choose `EBOOK` option. You can then export your ebook.

## Known Issues & Limitations
* EBook generation is still under development.
* All SVG graph generated by `mermaid`, `PlantUML`, etc will not work in the ebook generated. Only `viz` works.   
* Only **KaTeX** can be used for Math Typesetting.   
  And the generated ebook file doesn't render math expression properly in **iBook**.
* **PDF** and **Mobi** generation is buggy.
* **Code Chunk** doesn't work with Ebook generation.