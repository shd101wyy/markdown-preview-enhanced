Markdown Preview Enhanced
===
测试 Beta 版本    
[![](https://img.shields.io/github/tag/shd101wyy/markdown-preview-enhanced.svg)](https://github.com/shd101wyy/markdown-preview-enhanced/releases) ![](https://img.shields.io/apm/dm/markdown-preview-enhanced.svg)  [![](https://img.shields.io/github/stars/shd101wyy/markdown-preview-enhanced.svg?style=social&label=Star)](https://github.com/shd101wyy/markdown-preview-enhanced)   

[English Doc](../README.md)   

`0.9.0` 版本以后，**Markdown Preview Enhanced** 支持编译 markdown 到 markdown 文件。更多相关信息请查看[文档](markdown.md)。

如果你发现了 bug，遇到问题，或者想要开发者添加新的功能，请在 [这里](https://github.com/shd101wyy/markdown-preview-enhanced/issues) 留言。

（以下 TOC 由该插件命令 `Markdown Preview Enhanced: Create Toc` 生成）
<!-- toc orderedList:0 -->

* [Markdown Preview Enhanced](#markdown-preview-enhanced)
	* [支持特性](#支持特性)
	* [该插件如何工作](#该插件如何工作)
	* [使用](#使用)
	* [预览菜单](#预览菜单)
	* [额外支持](#额外支持)
	* [开发者](#开发者)
	* [感谢](#感谢)
	* [TODO](#todo)

<!-- tocstop -->
---

![intro](https://cloud.githubusercontent.com/assets/1908863/19796387/a00df0f6-9ca9-11e6-86e9-1d74e195748f.gif)  

## 支持特性
- **编辑与预览滑动同步**  
- **[Code Chunks (beta)](./code-chunk.md)**
- **[pandoc](./advanced-export.md)**
- **[ebook](./ebook.md)**  
- **[Presentation Writer](https://rawgit.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.html)**
- **[支持扩展](#开发者)**
- 数学编辑支持     
你可以选择 [MathJax](https://github.com/mathjax/MathJax) 或者 [KaTeX](https://github.com/Khan/KaTeX) 来渲染数学表达式      
- 导出 **PDF**, **PNG**, and **JPEG** 文件  
- 导出 **HTML** （完美支持移动端设备）  
- 编译成 **Markdown** 文件
- 自定义 Markdown Preview 样式（css）  
- [TOC](./toc.md) 自动生成 **(beta)**  
- Flowchart / Sequence 等各种图
- Task List 任务列表 *(Github Flavored)*  
- 图片助手
- [Footnotes](https://github.com/shd101wyy/markdown-preview-enhanced/issues/35)  
- [Front Matter](https://github.com/shd101wyy/markdown-preview-enhanced/issues/100)
- 以及更多特性...

## 该插件如何工作
- [remarkable](https://github.com/jonschlinkert/remarkable) 转换 markdown 到 html
- [KaTeX](https://github.com/Khan/KaTeX) 或者 [MathJax](https://github.com/mathjax/MathJax) 来渲染数学表达式。 ([KaTeX 支持的 functions/symbols](https://github.com/Khan/KaTeX/wiki/Function-Support-in-KaTeX))
  - `$...$` 里的内容将被正常渲染。  
  - `$$...$$` 里的内容将用 displayMode 渲染。   
  - 你可以在 [settings panel](#settings-panel) 中设置你想要的渲染引擎。   
		**MathJax** 支持更多的符号，但是比 **KaTeX** 渲染速度更慢。   
  - 想要支持数学表达式的高亮，请考虑安装 [language-gfm-enhanced](https://atom.io/packages/language-gfm-enhanced) 插件。
  - <img src="https://cloud.githubusercontent.com/assets/1908863/14398210/0e408954-fda8-11e5-9eb4-562d7c0ca431.gif">
- [mermaid](https://github.com/knsv/mermaid) 来渲染 flowchart 和 sequence diagram  
	- 代码块 `{mermaid}` 里的内容将被 [mermaid](https://github.com/knsv/mermaid) 渲染。  
	- 查看 [mermaid 文档](http://knsv.github.io/mermaid/#flowcharts-basic-syntax) 来了解如何画图。   
	- ![mermaid](http://i.imgur.com/rwIPIA8.gif)
- [PlantUML](http://plantuml.com/) 来渲染图形。 (**Java** 是必须的依赖)  
	- 你可以安装 [Graphviz](http://www.graphviz.org/) （非必需） 来生成其他种类的图形。  
	- 代码块 `{puml}` 或者 `{plantuml}` 里的内容将被 [PlantUML](http://plantuml.com/) 渲染。  
- [WaveDrom](http://wavedrom.com/) 来渲染 digital timing diagram.  
	- 代码块 `{wavedrom}` 里的内容将被 [wavedrom](https://github.com/drom/wavedrom) 渲染。
- [Viz.js](https://github.com/mdaines/viz.js) 来渲染 [dot language](https://en.wikipedia.org/wiki/DOT_(graph_description_language)) 图形.  
	- 代码块 `{viz}` 里的内容将被 [Viz.js](https://github.com/mdaines/viz.js) 渲染。
    - 在代码块第一行，可以通过`engine:[engine_name]`形式选择渲染引擎。比如:`engine:dot`。支持 `circo`, `dot`, `neato`, `osage`, or `twopi` 引擎。 `dot` 是默认引擎.    
    - ![viz](https://cloud.githubusercontent.com/assets/1908863/22486898/f3b71a8a-e7d0-11e6-9f69-88e30baa3a9a.gif)
- [reveal.js](https://github.com/hakimel/reveal.js) 来渲染漂亮的 presentations.
	- [点击这里](https://rawgit.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.html) 查看相关介绍。

## 使用
使用此插件, 请在 Atom 中按 <kbd>cmd + shift + p</kbd> 调出 <strong> Command Palette </strong>。然后选择以下的命令：
- <strong>Markdown Preview Enhanced: Toggle</strong>
  - 开关预览。   
	你也可以用快捷键 <kbd>ctrl+shift+m</kbd> 来开关预览.（为了防止快捷键冲突，请禁用默认的 [markdown preview](https://atom.io/packages/markdown-preview) 插件）
- <strong>Markdown Preview Enhanced: Toggle Zen Mode </strong>  
	- 开关清净式写作模式。  
- <strong>Markdown Preview Enhanced: Customize CSS</strong>
  - 编辑预览的样式。 你可以在 `style.less` 文件中的 `markdown-preview-enhanced-custom` 部分编辑样式。  
  - 如果你在 `style.less` 文件中没有看到 `markdown-preview-enhanced-custom` 部分，请先运行 `Markdown Preview Enhanced: Customize CSS` 指令。
- <strong>Markdown Preview Enhanced: Create Toc </strong>
  - 生成 TOC （预览需要被事先开启）[文档在这里](./toc.md)。   
- <strong>Markdown Preview Enhanced: Toggle Scroll Sync </strong>
  - 开关编辑和预览的滑动同步.
- <strong>Markdown Preview Enhanced: Toggle Break On Single Newline </strong>
- <strong>Markdown Preview Enhanced: Insert New Slide </strong>  
- <strong>Markdown Preview Enhanced: Insert Table </strong>
- <strong>Markdown Preview Enhanced: Insert Page Break </strong>
- <strong> Markdown Preview Enhanced: Config Mermaid</strong>
  - 编辑 `mermaid` 初始化设置。
- <strong> Markdown Preview Enhanced: Config Header Footer</strong>
  - 编辑导出 **PDF** 的 header 和 footer 设置。
- <strong>Markdown Preview Enhanced: Image Helper</strong>  
	- Image Helper 图片助手支持快速插入图片链接，拷贝本地图片，和上传图片（powered by [imgur](http://imgur.com/) and [sm.ms](https://sm.ms/)）。       
	（如果 **imgur** 被墙了， 请使用 **sm.ms** ）    
	- 快捷键 <kbd>ctrl+shift+i</kbd>    
	-  ![image_helper](https://cloud.githubusercontent.com/assets/1908863/15414603/c40b6556-1e6e-11e6-956c-090b5996ec87.gif)  

## 预览菜单
**在 预览 右键点击唤起菜单**

![contextmenu](http://i.imgur.com/hOxseAS.gif)

- <strong> Open in Browser </strong>
  - 在浏览器中打开。
- **Export to Disk**
	- 导出 **HTML**, **PDF**, **PNG**, **JPEG**, **ePub** 等文件。
- **Pandoc Document Export**
	- [文档](./advanced-export.md)
- **Save as Markdown**
	- [文档](./markdown.md)

## 额外支持
* **Code Chunks 运行内嵌代码** [文档](./code-chunk.md)。
* **EBook 电子书**  
	更多关于如何创建 电子书 请参阅 [这里](./ebook.md)。
* **Presentation Writer**  
	更多关于如何创建 Presentation 请参阅 [这里](https://rawgit.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.html)。
* **Task List 任务列表**    
	本插件支持 *Github Flavored* task list.  
	更多信息可在 [这里](https://github.com/blog/1375-task-lists-in-gfm-issues-pulls-comments) 查看。
* **Smart Navigation 智能跳转**    
	你可以很快的切换到其他的 markdown 文件通过在预览中点击它的链接。  
* **Preview Auto Open 自动打开预览**  
	当你打开一个 markdown 文件时，自动打开预览。  
  你可以在 settings panel 中禁用此功能。

## 开发者
手动安装指南可以在 [这里](./DEVELOPER.md) 找到。   
扩展该插件也十分简单，更多信息请点击 [这里](./extension.md)。

## 感谢  
感谢所有支持这个插件的人们！    

## TODO
[CHANGELOG](../CHANGELOG.md)
- [ ] fix bugs
- [ ] modify css to make preview look nice
- [x] ePub output
- [x] support more image upload methods other than imgur (as imgur is blocked in some countries)
- [x] image paste [#30](https://github.com/shd101wyy/markdown-preview-enhanced/issues/30)
- [ ] pdf book generation [#56](https://github.com/shd101wyy/markdown-preview-enhanced/issues/56)
- [x] header and footer for pdf [57](https://github.com/shd101wyy/markdown-preview-enhanced/issues/57)

谢谢你使用并支持此插件 ;)

> University of Illinois/NCSA Open Source License
