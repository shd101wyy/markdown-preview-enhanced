Markdown Preview Enhanced
===
测试 Beta 版本    
[![](https://img.shields.io/github/tag/shd101wyy/markdown-preview-enhanced.svg)](https://github.com/shd101wyy/markdown-preview-enhanced/releases) ![](https://img.shields.io/apm/dm/markdown-preview-enhanced.svg)  [![](https://img.shields.io/github/stars/shd101wyy/markdown-preview-enhanced.svg?style=social&label=Star)](https://github.com/shd101wyy/markdown-preview-enhanced)   

[English Doc](../README.md)    
[Wiki](https://github.com/shd101wyy/markdown-preview-enhanced/wiki) (尚未完成)  

---

`0.10.9` 支持 [prince](https://www.princexml.com) pdf 文件导出。  
具体信息请参考[该文档](./prince.md)。  

---

推荐安装 [language-gfm-enhanced](https://atom.io/packages/language-gfm-enhanced) 来更好地与 markdown-preview-enhanced 协同工作.  

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
	* [疑难解答](#疑难解答)
	* [鸣谢](#鸣谢)
	* [Changelog](#changelog)
	* [感谢](#感谢)

<!-- tocstop -->
---

![intro](https://cloud.githubusercontent.com/assets/1908863/22763072/32f09e80-ee28-11e6-9d42-c3953f5749a1.gif)

## 支持特性
- **编辑与预览滑动同步**  
- **[导入外部文件](doc-imports.md)**
- **[Code Chunks (beta)](./code-chunk.md)**
- **[pandoc](./pandoc.md)**
- **[prince](./prince.md)**  
- **[ebook](./ebook.md)**  
- **[Presentation Writer](https://rawgit.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.html)**
- **[支持扩展](#开发者)**
- 数学编辑支持     
你可以选择 [MathJax](https://github.com/mathjax/MathJax) 或者 [KaTeX](https://github.com/Khan/KaTeX) 来渲染数学表达式      
- 导出 **PDF**, **PNG**, and **JPEG** 文件  
- 导出 **HTML** （完美支持移动端设备）  
- [编译成 Markdown 文件](markdown.md)
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
  - `$...$` 或者 `\(...\)` 里的内容将被正常渲染。  
  - `$$...$$` 或者 `\[...\]` 和 代码块<code>\`\`\`math</code> 里的内容将用 displayMode 渲染。   
  - 你可以在 [settings panel](#settings-panel) 中设置你想要的渲染引擎。   
		**MathJax** 支持更多的符号，但是比 **KaTeX** 渲染速度更慢。   
  - 想要支持数学表达式的高亮，请考虑安装 [language-gfm-enhanced](https://atom.io/packages/language-gfm-enhanced) 插件。
  - <img src="https://cloud.githubusercontent.com/assets/1908863/14398210/0e408954-fda8-11e5-9eb4-562d7c0ca431.gif">
- [mermaid](https://github.com/knsv/mermaid) 来渲染 flowchart 和 sequence diagram  
	- 代码块 `mermaid` （或者 `@mermaid`） 里的内容将被 [mermaid](https://github.com/knsv/mermaid) 渲染。  
	- 查看 [mermaid 文档](http://knsv.github.io/mermaid/#flowcharts-basic-syntax) 来了解如何画图。   
	- ![mermaid](https://cloud.githubusercontent.com/assets/1908863/23383956/5c8cb37e-fd0e-11e6-8a22-f3946841bbbd.gif)
- [PlantUML](http://plantuml.com/) 来渲染图形。 (**Java** 是必须的依赖)  
	- 你可以安装 [Graphviz](http://www.graphviz.org/) （非必需） 来生成其他种类的图形。  
	- 代码块 `puml` 或者 `plantuml`（或者 `@puml` 或者 `@plantuml`）里的内容将被 [PlantUML](http://plantuml.com/) 渲染。  
- [WaveDrom](http://wavedrom.com/) 来渲染 digital timing diagram.  
	- 代码块 `wavedrom` （或者 `@wavedrom`）里的内容将被 [wavedrom](https://github.com/drom/wavedrom) 渲染。
- [Viz.js](https://github.com/mdaines/viz.js) 来渲染 [dot language](https://en.wikipedia.org/wiki/DOT_(graph_description_language)) 图形.  
	- 代码块 `viz`（或者 `@viz`）里的内容将被 [Viz.js](https://github.com/mdaines/viz.js) 渲染。
    - 在代码块第一行，可以通过`engine:[engine_name]`形式选择渲染引擎。比如:`engine:dot`。支持 `circo`, `dot`, `neato`, `osage`, or `twopi` 引擎。 `dot` 是默认引擎.    
- [reveal.js](https://github.com/hakimel/reveal.js) 来渲染漂亮的 presentations.
	- [点击这里](https://rawgit.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.html) 查看相关介绍。

## 使用
使用此插件, 请在 Atom 中按 <kbd>cmd + shift + p</kbd> 调出 <strong> Command Palette </strong>。然后选择以下的命令：
- <strong>Markdown Preview Enhanced: Toggle</strong>
  - 开关预览。   
	你也可以用快捷键 <kbd>ctrl+shift+m</kbd> 来开关预览.（为了防止快捷键冲突，请禁用默认的 [markdown preview](https://atom.io/packages/markdown-preview) 插件）
- <strong>Markdown Preview Enhanced: Toggle Zen Mode </strong>  
	- 开关清净式写作模式。  
- <strong>Markdown Preview Enhanced: Customize Css</strong>
  - 编辑预览的样式。 你可以在 `style.less` 文件中的 `markdown-preview-enhanced-custom` 部分编辑样式。  
  - [教程文章](https://github.com/shd101wyy/markdown-preview-enhanced/wiki/Customize-CSS)。
- <strong>Markdown Preview Enhanced: Create Toc </strong>
  - 生成 TOC （预览需要被事先开启）[文档在这里](./toc.md)。   
- <strong>Markdown Preview Enhanced: Toggle Scroll Sync </strong>
  - 开关编辑和预览的滑动同步.
- <strong>Markdown Preview Enhanced: Toggle Live Update </strong>
	- 开关预览实时更新。
	- 如果关闭了实时更新，那么预览将只会在文件保存的时候更新。
- <strong>Markdown Preview Enhanced: Toggle Break On Single Newline </strong>
- <strong>Markdown Preview Enhanced: Insert New Slide </strong>  
- <strong>Markdown Preview Enhanced: Insert Table </strong>
- <strong>Markdown Preview Enhanced: Insert Page Break </strong>
- <strong> Markdown Preview Enhanced: Open Mermaid Config</strong>
  - 编辑 `mermaid` 初始化设置。
- <strong> Markdown Preview Enhanced: Open Header Footer Config</strong>
  - 编辑导出 **PDF** 的 header 和 footer 设置。
- <strong> Markdown Preview Enhanced: Open Mathjax Config </strong>
	- 编辑 `MathJax` 初始化设置。
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
	- [文档](./pandoc.md)
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

## 疑难解答
1. **在国内（中国大陆）安装不了怎么办？**  
由于该插件的依赖之一 [phantomjs](https://github.com/Medium/phantomjs) 需要翻墙才可以安装。所以我推荐以下两种方式解决此问题：
	1. 本地提前安装好 phantomjs。 Mac 用户可以直接 terminal 运行 `brew install phantomjs` 安装。然后再尝试安装此插件。
	2. 安装 `cnpm`。具体请查看 [@Niefee](https://github.com/shd101wyy/markdown-preview-enhanced/issues/231#issuecomment-280912665) 的回答。
2. **在 atom 的插件市场中找不到这个插件啊？**  
请搜索全称 `markdown-preview-enhanced`。[#269](https://github.com/shd101wyy/markdown-preview-enhanced/issues/269)。
3. **我导出了一个 html 文件，想把它放到我的服务器上。但是数学符号等不能正确显示，该怎么办？**  
请确定导出 html 文件的时候，`Use CDN hosted resources` 这一选项勾上了。  
4. **我导出了一个 presentation 的 html 文件，想把它放到我的服务器上，但是无法正确显示？**  
请参考上一个问题。
5. **我想用黑色的预览主题，该怎么做？**  
如果你想要你的预览和你的 atom 编辑器风格颜色一致，你可以到该插件的设置中，更改 `Preview Theme` 项。 [#281](https://github.com/shd101wyy/markdown-preview-enhanced/issues/281)   
还有一种方法是运行 `Markdown Preview Enhanced: Customize Css` 命令，然后修改 `style.less` 文件。[#68](https://github.com/shd101wyy/markdown-preview-enhanced/issues/68)，[#89](https://github.com/shd101wyy/markdown-preview-enhanced/issues/89)。
6. **预览特别特别卡，该怎么做？**  
如果你的预览特别卡，那么可能是你的文件太大了，或者用到的数学式，画的图过多。  
这里我建议关闭 `Live Update` 的功能。可以运行 `Markdown Preview Enhanced: Toggle Live Update` 来关闭（disable）。然后预览就只会在你保存文件的时候刷新了，这样就不会卡了。  
7. **你需要工作吗？（喂！这和疑难解答有什么关系？）**  
是的！我正在（准备）找工作 `(*/ω＼*)`。（任何国家（地区）都可以考虑，或者远程工作也行）    
我是一名正在 伊利诺伊大学厄巴纳-香槟分校 (UIUC) 学习的计算机科学专业的学生。我即将于今年（2017）5 月份毕业拿到我的 BS/MCS 学位。  
我个人对游戏开发和网络前端很感兴趣。如果你对我感兴趣想给予我工作机会，请通过我的学校邮箱 `ywang189@illinois.edu` 或者我的个人邮箱 `shd101wyy@(sina|gmail)\.com` 联系我。 （如果我没来得及回复，请不要生气，我可能在赶作业 (✿◡‿◡)）。  
非常感谢 :)  

## 鸣谢  
* [remarkable](https://github.com/jonschlinkert/remarkable) - Markdown parser, done right. Commonmark support, extensions, syntax plugins, high speed - all in one. Gulp and metalsmith plugins are also available.  
* [KaTeX](https://github.com/Khan/KaTeX) - Fast math typesetting for the web.  
* [MathJax](https://github.com/mathjax/MathJax) - Beautiful math in all browsers.  
* [mermaid](https://github.com/knsv/mermaid) - Generation of diagram and flowchart from text in a similar manner as markdown.  
* [viz.js](https://github.com/mdaines/viz.js) - A hack to put Graphviz on the web.
* [plantuml](https://github.com/plantuml/plantuml) - Generate UML diagram from textual description.
* [WaveDrom](https://github.com/drom/wavedrom) - Digital timing diagram rendering engine.
* [reveal.js](https://github.com/hakimel/reveal.js) - The HTML Presentation Framework.
* [save-svg-as-png](https://github.com/exupero/saveSvgAsPng) - Save SVGs as PNGs from the browser.
* [pandoc](https://github.com/jgm/pandoc) - Universal markup converter.
* [async](https://github.com/caolan/async) - Async utilities for node and the browser.
* [babyparse](https://github.com/mholt/PapaParse) - Fast and powerful CSV (delimited text) parser that gracefully handles large files and malformed input.
* [cheerio](https://github.com/cheeriojs/cheerio) - Fast, flexible, and lean implementation of core jQuery designed specifically for the server.
* [gray-matter](https://github.com/jonschlinkert/gray-matter) - Smarter yaml front matter parser, used by assemble, metalsmith and many others.
* [html-pdf](https://github.com/marcbachmann/node-html-pdf) - Html to pdf converter in nodejs. It spawns a phantomjs process and passes the pdf as buffer or as filename.
* [node-imgur](https://github.com/kaimallea/node-imgur) - Upload images to imgur.com.
* [request](https://github.com/request/request) - Simplified HTTP request client.
* [node-temp](https://github.com/bruce/node-temp) - Temporary File, Directory, and Stream support for Node.js.
* [uslug](https://github.com/jeremys/uslug) - A permissive slug generator that works with unicode.
* [atom](https://github.com/atom/atom) - The hackable text editor.

## Changelog  
有关 Changelog 请查看 [这里](../CHANGELOG.md).  

## 感谢  
感谢你使用并支持此插件 ;)

> University of Illinois/NCSA Open Source License
