## 0.8.1
* [ ] refactor **parseMD** function. (it's too messy now)  
* [ ] for KaTeX rendering, save rendered results like MathJax.
    
## 0.8.0
* [ ] solve issue [#85](https://github.com/shd101wyy/markdown-preview-enhanced/issues/85)
* [x] merge pull request [#86](https://github.com/shd101wyy/markdown-preview-enhanced/pull/86)
* [ ] presentation print pdf link not working
* [x] epub generation. useful links [manual](http://pandoc.org/MANUAL.html) and [epub](http://pandoc.org/epub.html)

## 0.7.9
* [x] viz.js dot language
* [x] customize reveal css
* [x] check custom comment subject
* [x] shield.io
* [ ] table formatter
## 0.7.7
* [ ] distraction free writing mode like [laverna](https://github.com/Laverna/laverna) or zen. [useful link](https://discuss.atom.io/t/set-atom-cursor-to-font-size-not-line-height/11965/5).
* [x] presentation mode like [marp](https://github.com/yhatt/marp)
* [x] add **phantomjs** option besides **html** and **pdf**.
* [x] fix [issue](https://github.com/shd101wyy/markdown-preview-enhanced/issues/79)
## 0.7.3
* [ ] fix print to pdf deadlock issue (if I can...) (*Update*: It seems to be **electron** related, therefore I can't fix it.)
* [ ] print image [capturePage function](https://github.com/electron/electron/blob/master/docs/api/web-contents.md)
* [x] right click on preview displays 'print' option on context menu (**I decide not to implement this**)
* [x] update PlantUML to newest version
* [x] fix toggle bug.
* [x] support mermaid customized init function [see this issue](https://github.com/shd101wyy/markdown-preview-enhanced/issues/9#issuecomment-229552470)
* [ ] [this](https://github.com/shd101wyy/markdown-preview-enhanced/issues/9#issuecomment-231215294) is too hard.
* [x] open other files in atom through links [see this issue](https://github.com/shd101wyy/markdown-preview-enhanced/issues/72)
* [ ] let user choose to use local puml jar or through internet by [encode](https://github.com/markushedvall/plantuml-encoder) (no java required)(**I decide not to implement this**)
* [x] remove mermaidStyle at markdown-preview-enhanced-view.coffee. (as it is already included in markdown-preview-enhanced.less)
* [x] [WaveDrom](https://github.com/shd101wyy/markdown-preview-enhanced/issues/73) support?
* [x] preview window copy text.
* [ ] mermaid style: three .css file choice.

## 0.7.2
* [x] preview black color background problem

## 0.7.1
* [x] support customizable math delimiters
* [x] increase MathJax rendering speed
* [x] fix code block `//` comment color bug (现在是黑色的。。。)
* [x] fix WikiLink [#45](https://github.com/shd101wyy/markdown-preview-enhanced/issues/45)
* [x] fix TOC header bug [#48](https://github.com/shd101wyy/markdown-preview-enhanced/issues/48)
* [ ] add `javascript` support [#47](https://github.com/shd101wyy/markdown-preview-enhanced/issues/47) (可能无法完成)
* [x] image path config [here](https://github.com/shd101wyy/markdown-preview-enhanced/issues/30#issuecomment-224273160)
* [x] fix image project paths bug [here](https://github.com/shd101wyy/markdown-preview-enhanced/issues/34#issuecomment-224303126)

## 0.6.9
* [x] TOC numbered list

## 0.3.8
* support better way for customizing markdown down style.
* change markdown style.
* improve markdown parsing efficiency (use <strong>onDidStopChanging</strong> function instead of <strong>onDidChange</strong>).
* <strong>TODO</strong>: support scroll sync in the future.

## 0.3.7
* fix image path bug when export pdf and html.

## 0.3.6
* fix math expression parsing bug... caused by \_underscore\_.

## 0.3.5
* add \\newpage support.

## 0.3.3
* Add 'Open in Browser' option.
* Fix \$ bug.

## 0.1.0 - Initial Release
* Every feature added.
* Every bug fixed.
