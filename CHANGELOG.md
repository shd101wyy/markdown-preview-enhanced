## 0.7.3
* [ ] fix print to pdf deadlock issue (if I can...)
* [ ] print image [capturePage function](https://github.com/electron/electron/blob/master/docs/api/web-contents.md)
* [ ] right click on preview displays 'print' option on context menu (**I decide not to implement this**)
* [ ] update PlantUML to newest version
* [ ] fix toggle bug. （右边的关不掉）
* [ ] support mermaid customize init function [see this issue](https://github.com/shd101wyy/markdown-preview-enhanced/issues/9#issuecomment-229552470)
* [ ] [this](https://github.com/shd101wyy/markdown-preview-enhanced/issues/9#issuecomment-231215294) is too hard.
* [x] open other files in atom through links [see this issue](https://github.com/shd101wyy/markdown-preview-enhanced/issues/72)
* [ ] let user choose to use local puml jar or through internet by [encode](https://github.com/markushedvall/plantuml-encoder) (no java required)
* [x] remove mermaidStyle at markdown-preview-enhanced-view.coffee. (as it is already included in markdown-preview-enhanced.less)
* [ ] [WaveDrom](https://github.com/shd101wyy/markdown-preview-enhanced/issues/73) support?
* [x] preview window copy text.
* [ ] mermaid style: three .css file choice.

## 0.7.2
* [x] preview black color background problem

## 0.7.1
* [x] support customizable math delimiters
* [ ] increase MathJax rendering speed
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
