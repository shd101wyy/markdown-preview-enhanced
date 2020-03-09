## v0.12.7 & v0.12.8

- [x] Quick fix Welcome page issue. So the Welcome page will only open when this package is updated [#428](https://github.com/shd101wyy/markdown-preview-enhanced/issues/428).

## v0.12.6

- [x] Add `WELCOME.md` page and `Markdown Preview Enhanced: Open Welcome Page` command. The `WELCOME.md` will display the changes and updates of this package.
- [x] Add `mathjax_config.js` file and `Markdown Preview Enhanced: Open MathJax Config` command. Remove `mathJaxProcessEnvironments` from config schema. However, some `MathJax` extensions don't work well.
- [x] Support multiple previews. You can uncheck the `Open only one preview` in package settings to enable multiple previews so that each markdown source will have a preview.
- [x] `cmd-r` keyboard shortcut in preview to refresh the preview.
- [x] More powerful `@import`:
  1. Support importing online files.
  2. Support configuring images
  3. Force to render Code Block
  4. Code Chunk
- [x] Support TOC to ignore headings by appending `{.ignore}` after the heading:
- [x] Support showing line numbers for Code Block and Code Chunk by adding `line-numbers` class.
- [x] Modifed scroll sync logic (Might cause issue).
- [x] Support `Markdown Preview Enhanced: Sync Preview` and `Markdown Preview Enhanced: Sync Source` [#424](https://github.com/shd101wyy/markdown-preview-enhanced/issues/424).
- [x] Fix image `@import` issue on Windows [#414](https://github.com/shd101wyy/markdown-preview-enhanced/issues/414).
- [x] Fix one PlantUML rendering [issue](https://github.com/shd101wyy/markdown-preview-enhanced/commit/4b9f7df66af18a96905b60eb845463771fdd034a).

## 0.12.5

- [x] fix issue [#418](https://github.com/shd101wyy/markdown-preview-enhanced/issues/418).
- [x] fix issue [#417](https://github.com/shd101wyy/markdown-preview-enhanced/issues/417)

## 0.12.4

- [x] support preview `zoom`.
- [x] upgrade `viz` to `v1.8.0`.
- [x] upgrade `plantuml` to `1.2017.13`.
- [x] upgrade `reveal.js` to `3.5.0`.
- [x] faster `plantuml` rendering thanks to the contribution by [@river0825](https://github.com/river0825).
- [x] fix one toc bug [#406](https://github.com/shd101wyy/markdown-preview-enhanced/issues/406).
- [x] add `class` support for code block and code chunk. Support `line-numbers` class for showing line number for code block and code chunk.
- [x] support `sidebar` toc.
- [x] fix pandoc bibliography absolute file path issue [#409](https://github.com/shd101wyy/markdown-preview-enhanced/issues/409).
- [x] support `language-diff` [#415](https://github.com/shd101wyy/markdown-preview-enhanced/issues/415).
- [x] remove `showBackToTopButton` config.
- [x] different preview theme will now have different scrollbar style.

## 0.12.2 & 0.12.3

- [x] quick fix plantuml file import issue [#398](https://github.com/shd101wyy/markdown-preview-enhanced/issues/398).
- [x] add `xypic` support for MathJax [#393](https://github.com/shd101wyy/markdown-preview-enhanced/pull/393).
- [x] upgrade `MathJax` to version `2.7.1`.
- [x] fix <code>\`\`\`math</code> content escape issue.

## 0.12.1

- [x] fix issue [#387](https://github.com/shd101wyy/markdown-preview-enhanced/issues/387) `Pagebreak command ignored`.
- [x] fix issue [#388](https://github.com/shd101wyy/markdown-preview-enhanced/issues/388).
- [x] upgrade `plantuml` to version `1.2017.12` [#382](https://github.com/shd101wyy/markdown-preview-enhanced/issues/382).
- [x] add `\(...\)` and `\[...\]` to default math inline and block delimiters.

## 0.11.1

- [x] add `class` and `id` field to `slide` of presentation & update presentation-intro.md.
- [x] fix issue [#368](https://github.com/shd101wyy/markdown-preview-enhanced/issues/368), open file whose path has space.
- [x] upgrade MathJax cdn [#361](https://github.com/shd101wyy/markdown-preview-enhanced/issues/361).
- [x] support local style [#351](https://github.com/shd101wyy/markdown-preview-enhanced/issues/351).
- [x] add doc for customizing css.
- [ ] <strike>`@import` double quotes and single quotes.</strike> doesn't work well.
- [x] add `id` and `class` front-matter config.

## 0.10.12

- [x] `file import` now can import image whose path has spaces, eg: `@import "test copy.png"`.
- [x] fix issue [#345](https://github.com/shd101wyy/markdown-preview-enhanced/issues/345).
- [x] fix issue [#352](https://github.com/shd101wyy/markdown-preview-enhanced/issues/352).
- [x] fix TOC numbered list tab issue [#355](https://github.com/shd101wyy/markdown-preview-enhanced/issues/355).
- [x] pandoc parser now supports `[TOC]`.
- [x] add `Pandoc Options: Markdown Flavor` configuration in settings.
- [x] add presentation support for pandoc parser [#354](https://github.com/shd101wyy/markdown-preview-enhanced/issues/354).

## 0.10.11

- [x] fix plantuml `@import` issue. [#342](https://github.com/shd101wyy/markdown-preview-enhanced/issues/342).
- [x] add `embed image` for html export. [#345](https://github.com/shd101wyy/markdown-preview-enhanced/issues/345).
- [x] wikilink file extension option [#346](https://github.com/shd101wyy/markdown-preview-enhanced/issues/346).

## 0.10.10

- [ ] speaker note Windows issue [#199](https://github.com/shd101wyy/markdown-preview-enhanced/issues/199).
- [x] support `[TOC]`.
- [x] add `whiteBackground` option.
- [x] presentation scroll sync (partially done).

## 0.10.9

- [x] fix issue [#325](https://github.com/shd101wyy/markdown-preview-enhanced/issues/325). Code block indicator is now case insensitive.
- [x] fix some pandoc parser code chunk issues.
- [x] added `prince` support. [doc](./docs/prince.md).
- [x] fix export file style issue. changed `Customize Css` command.
- [x] fix issue [#313](https://github.com/shd101wyy/markdown-preview-enhanced/issues/313).

## 0.10.8

- [x] add `pandoc parser` support [#315](https://github.com/shd101wyy/markdown-preview-enhanced/issues/315).
- [x] fix `ebook` export theme issue.

## 0.10.7

- [x] restore `pdfUseGithub` option.
- [x] add `mpe-github-syntax` for Github.com style.

## 0.10.6

- [x] fix zen mode style issue.
- [x] fix preview theme list empty issue.

## 0.10.4 & 0.10.5

- [x] quick fix theme bug.
- [x] added loading gif, same as the official `markdown preview` package.

## 0.10.3

- [x] quick fix theme bug.
- [x] remove `useGitHubStyle` and `useGitHubSyntaxTheme`.

## 0.10.2

- [x] allow user to pick theme when not using `Github.com style theme`. [#297](https://github.com/shd101wyy/markdown-preview-enhanced/issues/297#issuecomment-283619527)
- [ ] issue [#298](https://github.com/shd101wyy/markdown-preview-enhanced/issues/298). But this is hard to be supported.
- [ ] add blog (jekyll, hexo, etc...) support. But I never used them before, so gonna take a while to figure out how to use them.
- [ ] move docs to github wiki.
- [x] fix `unsafe eval` issue [#303](https://github.com/shd101wyy/markdown-preview-enhanced/issues/303). As this issue is urgent, I will finish the 3 todos above in the future.

## 0.10.1

- [x] `Save as Markdown` code chunk `continue issue`
- [x] add <code>\`\`\`math</code> [#295](https://github.com/shd101wyy/markdown-preview-enhanced/issues/295)
- [x] add `vhdl` and `vhd` for file import [#294](https://github.com/shd101wyy/markdown-preview-enhanced/issues/294)
- [ ] ~~fix python3 matplotlib issue.~~ (nvm, it works after I upgrade python3 to `3.6.0`)

## 0.9.12

- [x] fix issue [#255](https://github.com/shd101wyy/markdown-preview-enhanced/issues/255) deprecated call.
- [x] add whitelist for protocols [#288](https://github.com/shd101wyy/markdown-preview-enhanced/issues/288).
- [x] update docs.
- [x] change variable `rootDirectoryPath` to `fileDirectoryPath`.

## 0.9.10

- [x] support standard code fencing for graphs. [#286](https://github.com/shd101wyy/markdown-preview-enhanced/issues/286).

## 0.9.9

- [x] enhance code chunk. Now support `matplotlib` very well. [#280](https://github.com/shd101wyy/markdown-preview-enhanced/issues/280).

```sh
matplotlib: true      # enable inline matplotlib plot.
continue: true | id   # continue last code chunk or code chunk with id.
element: "<canvas id=\"hi\"></canvas>" # element to append.
```

- [x] add `Markdown Preview Enhanced: Toggle Live Update`. And improve scroll sync when live update is disabled.
- [x] add `FAQ` section.
- [x] add `mathJaxProcessEnvironments` options that allows `processEnvironments` for MathJax.
- [ ] add cnpm url for phantomjs.

## 0.9.8

- [x] fix issue [#273](https://github.com/shd101wyy/markdown-preview-enhanced/issues/273). thanks for pull request from `@cuyl`.
- [x] added `markdown` output for code chunk.

## 0.9.7

- [x] add relative image path option for exporting html. fix issue [#264](https://github.com/shd101wyy/markdown-preview-enhanced/issues/264).
- [x] fix zen mode.

## 0.9.6

- [x] support external files import. [introduction doc](./docs/doc-imports.md)

```javascript
import "test.csv"
import "test.jpg"
import "test.txt"
import "test.md"
import "test.html"
import "test.js"
...
```

- [x] use [PapaParse](https://github.com/mholt/PapaParse) to parse `csv` file import.
- [x] fix syntax theme issue.
- [x] WaveDrom now doesn't require to use strict JSON. javascript code is fine as well.
- [x] fix toggle issue.
- [x] shrink output html file size.
- [ ] zen mode is broken...

## 0.9.5

- [x] upgrade `mermaid` to `7.0.0`, but class diagram still doesn't work.
- [x] upgrade `reveal.js` to `1.4.1`.
- [x] upgrade `katex` to `0.7.1`, fix cdn.js issue.
- [x] upgrade `plantuml` to version `8054`.
- [x] upgrade `viz.js` to version `1.7.0`, could be buggy though.
- [x] partially fixed issue [#248](https://github.com/shd101wyy/markdown-preview-enhanced/issues/248). But can't navigate to anchor.
- [x] better support for zen mode.

## 0.9.4

- [x] fix non-github syntax color issue [#243](https://github.com/shd101wyy/markdown-preview-enhanced/issues/243)
- [x] fix vertical slides issue [#241](https://github.com/shd101wyy/markdown-preview-enhanced/issues/241)

## 0.9.3

- [x] fix issue, 中文，日文 file image path error. [#236](https://github.com/shd101wyy/markdown-preview-enhanced/issues/236)
- [x] fix issue [#237](https://github.com/shd101wyy/markdown-preview-enhanced/issues/237)
- [x] fix back to top button and code chunks run btn `onclick` event after restoring CACHE.
- [x] save as markdown `front_matter` config.

## 0.9.2

- [x] quick fix issue [#223](https://github.com/shd101wyy/markdown-preview-enhanced/issues/223)

## 0.9.1

- [x] quick fix issue [#234](https://github.com/shd101wyy/markdown-preview-enhanced/issues/234)

## 0.9.0

- [x] soft tabs (spaces of tabs) in TOC [#187](https://github.com/shd101wyy/markdown-preview-enhanced/issues/187)
- [x] add cache support for better performance [#210](https://github.com/shd101wyy/markdown-preview-enhanced/issues/210)
- [x] add speaker notes support for presentation (reveal.js) issue [#199](https://github.com/shd101wyy/markdown-preview-enhanced/issues/199)
- [x] add back to top button in preview [#222](https://github.com/shd101wyy/markdown-preview-enhanced/issues/222)
- [x] support multiple TOCs [#130](https://github.com/shd101wyy/markdown-preview-enhanced/issues/130)
- [x] viz.js engine config
- [x] Save as Markdown
- [x] update several dependencies such as `KaTeX`, `saveSvgAsPng`, etc.

## 0.8.9

- [x] `<kbr>` style is not consistent in browser
- [x] fix issue [#177](https://github.com/shd101wyy/markdown-preview-enhanced/issues/177)
- [x] add `stdin` option to code chunk
- [x] restore `run` and `all` buttons but only shown when hovered.

## 0.8.8

- [x] ISSUE: MathJax will also update when changing headings.
- [x] update all dependencies.
  - seems that `mermaid` is still of version `6.0.0` and class diagram doesn't work as expected.
- [x] fix bug [#168](https://github.com/shd101wyy/markdown-preview-enhanced/issues/168).
- [x] disable `MathJax` `processEnvironments` [#167](https://github.com/shd101wyy/markdown-preview-enhanced/issues/167).
- [x] fix issue [#160](https://github.com/shd101wyy/markdown-preview-enhanced/issues/160)
- [x] fix issue [#150](https://github.com/shd101wyy/markdown-preview-enhanced/issues/150)
- [x] extend `TOC`. [#171](https://github.com/shd101wyy/markdown-preview-enhanced/issues/171)
- [x] remove `run` and `all` button for code chunk. also updated [code-chunk.md](/docs/code-chunk.md)

## 0.8.7 `minor update`

- [ ] <strike>reload cached image when necessary. (eg: replace `#cached=false` with `#cached=uid`)</strike>[**doesn't work very well; the image will flicker**]
- [x] fix one MathJax bug [#147](https://github.com/shd101wyy/markdown-preview-enhanced/issues/147)
- [ ] mermaid class diagram [#143](https://github.com/shd101wyy/markdown-preview-enhanced/issues/143) [**seem to be mermaid bug**]
- [ ] pandoc and ebook graph include [**implement in next major release**]
- [x] better pandoc error notification

## 0.8.6

- [x] ebook export exception [#136](https://github.com/shd101wyy/markdown-preview-enhanced/issues/136)
- [x] TOC heading level bug [#134](https://github.com/shd101wyy/markdown-preview-enhanced/issues/134)
- [ ] extend table notation [#133](https://github.com/shd101wyy/markdown-preview-enhanced/issues/133)
- [x] ERD [#128](https://github.com/shd101wyy/markdown-preview-enhanced/issues/128) [**might be removed in the future**]
- [ ] <strike>ebook glossary like gitbook</strike>. [**not implemented**]
- [x] change graph APIs.
- [ ] change parseMD function to async function with callback.
- [ ] pandoc graph include [**may be implemented in next version**]
- [x] fix scroll sync bug for code block
- [x] support Code Chunk
- [x] change `Markdown Preview Enhanced: Toc Create` to `Markdown Preview Enhanced: Create Toc`
- [x] save `codeChunksData` state for each editor.

## 0.8.5

- [ ] support `yaml_table` [**not implement**]
- [ ] support `erd` [#128](https://github.com/shd101wyy/markdown-preview-enhanced/issues/128) [**not implement**]
- [x] scroll preview to the very bottom when cursor is in last 2 lines. (right now it is the last line)
- [x] fix ebook network image error [#129](https://github.com/shd101wyy/markdown-preview-enhanced/issues/129#issuecomment-245778986)
- [x] support `ebook-convert` args option
- [x] improve `ebook` config
- [x] fix `loading preview` stuck bug
- [ ] remove `Markdown Preivew Enhanced: Config Header and Footer`, use `front-matter` instead. [**Might be implemented in next release**]

## 0.8.4

- [ ] fix issue [#107](https://github.com/shd101wyy/markdown-preview-enhanced/issues/107)
- [ ] add TOC sidebar [#117](https://github.com/shd101wyy/markdown-preview-enhanced/issues/117)
- [x] fix issue [#121](https://github.com/shd101wyy/markdown-preview-enhanced/issues/121) location save
- [x] add default document export path [#120](https://github.com/shd101wyy/markdown-preview-enhanced/issues/120)
- [x] fix issue [#118](https://github.com/shd101wyy/markdown-preview-enhanced/issues/118) add hint for image paste
- [x] support **pandoc**
- [x] add vertical slides for presentation [#123](https://github.com/shd101wyy/markdown-preview-enhanced/issues/123)
- [x] remove `Markdown Preview Enhanced: Config Presentation`, use front-matter instead

## 0.8.3

- [x] add option to `hide` frontmatter.
- [x] change to `UIUC` license
- [x] upgrade APIs to match newest `electron`
- [ ] solve lagging issue
- [ ] header/footer for presentation
- [x] smooth scroll sync

## 0.8.2

- [x] fix issue [#106](https://github.com/shd101wyy/markdown-preview-enhanced/issues/106)
- [x] add file extensions support [#102](https://github.com/shd101wyy/markdown-preview-enhanced/issues/104)
- [x] fix issue [#107](https://github.com/shd101wyy/markdown-preview-enhanced/issues/107), now can use MathJax for phantomjs export
- [x] add zoomFactor [#93](https://github.com/shd101wyy/markdown-preview-enhanced/issues/93)
- [ ] image drop to upload like github.

Known issues:

- `"` in MathJax are not escaped. `getAttribute('data-original')`

## 0.8.1

- [x] refactor **parseMD** function. (it's too messy now)
- [x] for KaTeX rendering, save rendered results like MathJax.
- [ ] split on left side (it seems that `atom.workspace.open` doesn't work as I expected)
- [x] typographer [#94](https://github.com/shd101wyy/markdown-preview-enhanced/issues/94)
- [ ] format markdown on save
- [x] modify `mermaid.css` [#95](https://github.com/shd101wyy/markdown-preview-enhanced/issues/95)
- [x] fix [#97](https://github.com/shd101wyy/markdown-preview-enhanced/issues/97)
- [ ] fix [#93](https://github.com/shd101wyy/markdown-preview-enhanced/issues/93) specify image resolution when exporting png/jpeg using phantomjs
- [x] support front matter [#100](https://github.com/shd101wyy/markdown-preview-enhanced/issues/100)
- [ ] support hooks [#101](https://github.com/shd101wyy/markdown-preview-enhanced/issues/101)
- [ ] **found [issue](https://github.com/marcbachmann/node-html-pdf/issues/156)**, I might implement phantomjs html2pdf by myself in the future...

## 0.8.0

- [ ] solve issue [#85](https://github.com/shd101wyy/markdown-preview-enhanced/issues/85)
- [x] merge pull request [#86](https://github.com/shd101wyy/markdown-preview-enhanced/pull/86)
- [ ] presentation print pdf link not working
- [x] epub generation. useful links [manual](https://pandoc.org/MANUAL.html) and [epub](https://pandoc.org/epub.html)

## 0.7.9

- [x] viz.js dot language
- [x] customize reveal css
- [x] check custom comment subject
- [x] shield.io
- [ ] table formatter

## 0.7.7

- [ ] distraction free writing mode like [laverna](https://github.com/Laverna/laverna) or zen. [useful link](https://discuss.atom.io/t/set-atom-cursor-to-font-size-not-line-height/11965/5).
- [x] presentation mode like [marp](https://github.com/yhatt/marp)
- [x] add **phantomjs** option besides **html** and **pdf**.
- [x] fix [issue](https://github.com/shd101wyy/markdown-preview-enhanced/issues/79)

## 0.7.3

- [ ] fix print to pdf deadlock issue (if I can...) (_Update_: It seems to be **electron** related, therefore I can't fix it.)
- [ ] print image [capturePage function](https://github.com/electron/electron/blob/master/docs/api/web-contents.md)
- [x] right click on preview displays 'print' option on context menu (**I decide not to implement this**)
- [x] update PlantUML to newest version
- [x] fix toggle bug.
- [x] support mermaid customized init function [see this issue](https://github.com/shd101wyy/markdown-preview-enhanced/issues/9#issuecomment-229552470)
- [ ] [this](https://github.com/shd101wyy/markdown-preview-enhanced/issues/9#issuecomment-231215294) is too hard.
- [x] open other files in atom through links [see this issue](https://github.com/shd101wyy/markdown-preview-enhanced/issues/72)
- [ ] let user choose to use local puml jar or through internet by [encode](https://github.com/markushedvall/plantuml-encoder) (no java required)(**I decide not to implement this**)
- [x] remove mermaidStyle at markdown-preview-enhanced-view.coffee. (as it is already included in markdown-preview-enhanced.less)
- [x] [WaveDrom](https://github.com/shd101wyy/markdown-preview-enhanced/issues/73) support?
- [x] preview window copy text.
- [ ] mermaid style: three .css file choice.

## 0.7.2

- [x] preview black color background problem

## 0.7.1

- [x] support customizable math delimiters
- [x] increase MathJax rendering speed
- [x] fix code block `//` comment color bug (现在是黑色的。。。)
- [x] fix WikiLink [#45](https://github.com/shd101wyy/markdown-preview-enhanced/issues/45)
- [x] fix TOC header bug [#48](https://github.com/shd101wyy/markdown-preview-enhanced/issues/48)
- [ ] add `javascript` support [#47](https://github.com/shd101wyy/markdown-preview-enhanced/issues/47) (可能无法完成)
- [x] image path config [here](https://github.com/shd101wyy/markdown-preview-enhanced/issues/30#issuecomment-224273160)
- [x] fix image project paths bug [here](https://github.com/shd101wyy/markdown-preview-enhanced/issues/34#issuecomment-224303126)

## 0.6.9

- [x] TOC numbered list

## 0.3.8

- support better way for customizing markdown down style.
- change markdown style.
- improve markdown parsing efficiency (use <strong>onDidStopChanging</strong> function instead of <strong>onDidChange</strong>).
- <strong>TODO</strong>: support scroll sync in the future.

## 0.3.7

- fix image path bug when export pdf and html.

## 0.3.6

- fix math expression parsing bug... caused by \_underscore\_.

## 0.3.5

- add \\newpage support.

## 0.3.3

- Add 'Open in Browser' option.
- Fix \$ bug.

## 0.1.0 - Initial Release

- Every feature added.
- Every bug fixed.
