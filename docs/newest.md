## 0.15.0

- Upgraded mume to [0.2.4](https://github.com/shd101wyy/mume/blob/master/CHANGELOG.md).
- Fixed <kbd>shift-enter</kbd> keymap bug.

## 0.14.11

- Upgraded mume to [0.2.3](https://github.com/shd101wyy/mume/blob/master/CHANGELOG.md).
- Added `enableEmojiSyntax` option.
- Added `imageDropAction` option.

## 0.14.10

- Upgraded mume to [0.2.2](https://github.com/shd101wyy/mume/blob/master/CHANGELOG.md).
  - Added `enableCriticMarkupSyntax` option. [Syntax guide](https://criticmarkup.com/users-guide.php).
  - Added `toc` config to front-matter for `[TOC]` and sidebar TOC [#606](https://github.com/shd101wyy/markdown-preview-enhanced/issues/606).
  - Fixed ordered list TODO box bug [#592](https://github.com/shd101wyy/markdown-preview-enhanced/issues/592).
  - Upgraded `KaTeX` to version `0.8.3`.
  - Changed `MathJax` CDN url.
  - Fixed markdown export math issue [#601](https://github.com/shd101wyy/markdown-preview-enhanced/issues/601).
- Removed `ctrl-shift-i` keyboard shortcut.

## 0.14.9

- Added `ignoreLink` option to TOC [#583](https://github.com/shd101wyy/markdown-preview-enhanced/issues/583).
- Fixed issue [#584](https://github.com/shd101wyy/markdown-preview-enhanced/issues/584), [#585](https://github.com/shd101wyy/markdown-preview-enhanced/issues/585), [#586](https://github.com/shd101wyy/markdown-preview-enhanced/issues/585).

## 0.14.8

- Removed the `Welcome Page`.
- Supported revealjs `fragment` [#559](https://github.com/shd101wyy/markdown-preview-enhanced/issues/559).
- Supported Experimental Puppeteer export (Headless Chrome).

## 0.14.7

- Fixed revealjs html export style bug.
- Supported configuring attributes for diagram **containers**.
  For example:

          ```puml {.center}
          // your code here
          ```
      will add `class="center"` to the container.

- By default, all exported files will use `github-light.css` style. You can use your preview theme for export by setting `printBackground` to `true` from the extension settings, or add `print_background:true` to front-matter.

## 0.14.6

- Supported quick image upload. Just drop your image file to markdown editor (not preview).

![upload](https://i.loli.net/2017/08/07/5987db34cb33c.gif)

- Fixed HTML export style bug.

## 0.14.5

- The old feature [WaveDrom diagram](https://shd101wyy.github.io/markdown-preview-enhanced/#/diagrams?id=wavedrom) is now supported again.
- The doc of customization css is updated, please [check it here](https://shd101wyy.github.io/markdown-preview-enhanced/#/customize-css).
- Sidebar TOC is now supported in HTML export, and it is enabled by default.
  ![screen shot 2017-08-05 at 8 50 16 pm](https://user-images.githubusercontent.com/1908863/28999904-c40b56b6-7a1f-11e7-9a9e-ab2e19a82b41.png)

  You can configure the sidebar TOC by front-matter. For more information, please check [this doc](https://shd101wyy.github.io/markdown-preview-enhanced/#/html?id=configuration).

- Upgraded [mume](https://github.com/shd101wyy/mume) to version [0.1.7](https://github.com/shd101wyy/mume/blob/master/CHANGELOG.md).

## 0.14.4

- Deprecated the old way of defining attributes (still supported but not recommended) [#529](https://github.com/shd101wyy/markdown-preview-enhanced/issues/529). Now attributes should be defined like below in order to be compatible with the pandoc parser:

        {#identifier .class .class key=value key=value}

  And here are a few changes:

        # Hi {#id .class1 .class2}

        Show `line-numbers`
        ```javascript {.line-numbers}
        x = 1
        ```

        ```python {cmd=true output="markdown"}
        print("**Hi there**")
        ```

        <!-- slide vertical=true .slide-class1 .slide-class2 #slide-id -->

        \@import "test.png" {width=50% height=30%}

- Added a few more preview themes.
- Supported [vega](https://vega.github.io/vega/) and [vega-lite](https://vega.github.io/vega-lite/). [#524](https://github.com/shd101wyy/markdown-preview-enhanced/issues/524).

  - Code block with `vega` notation will be rendered by [vega](https://vega.github.io/vega/).
  - Code block with `vega-lite` notation will be rendered by [vega-lite](https://vega.github.io/vega-lite/).
  - Both `JSON` and `YAML` inputs are supported.

  ![screen shot 2017-07-28 at 7 59 58 am](https://user-images.githubusercontent.com/1908863/28718265-d023e1c2-736a-11e7-8678-a29704f3a23c.png)

  You can also [@import](https://shd101wyy.github.io/markdown-preview-enhanced/#/file-imports) a `JSON` or `YAML` file as `vega` diagram, for example:

<pre>
    \@import "your_vega_source.json" {as="vega"}
    \@import "your_vega_lite_source.json" {as="vega-lite"}
</pre>

- Supported [ditaa](https://github.com/stathissideris/ditaa).
  ditaa can convert diagrams drawn using ascii art ('drawings' that contain characters that resemble lines like | / - ), into proper bitmap graphics. (**Java** is required to be installed)

  `ditaa` is integrated with [code chunk](https://shd101wyy.github.io/markdown-preview-enhanced/#/code-chunk), for example:

  <pre>
    ```ditaa {cmd=true args=["-E"]}
    +--------+   +-------+    +-------+
    |        | --+ ditaa +--> |       |
    |  Text  |   +-------+    |diagram|
    |Document|   |!magic!|    |       |
    |     {d}|   |       |    |       |
    +---+----+   +-------+    +-------+
        :                         ^
        |       Lots of work      |
        +-------------------------+
    ```
  </pre>

> <kbd>shift-enter</kbd> to run code chunk.
> set `{hide=true}` to hide code block.
> set `{run_on_save=true}` to render ditaa when you save the markdown file.

![screen shot 2017-07-28 at 8 11 15 am](https://user-images.githubusercontent.com/1908863/28718626-633fa18e-736c-11e7-8a4a-915858dafff6.png)

## 0.14.3

- Upgraded [mume](https://github.com/shd101wyy/mume) to version `0.1.4`.
  - Fixed header id bug [#516](https://github.com/shd101wyy/markdown-preview-enhanced/issues/516).
  - Fixed `enableExtendedTableSyntax` bug.
  - Fixed `MathJax` init error [#28](https://github.com/shd101wyy/vscode-markdown-preview-enhanced/issues/28), [#504](https://github.com/shd101wyy/markdown-preview-enhanced/issues/504).
  - Fixed plain text code block font size issue.
  - Fixed `transformMarkdown` function `Maximum call stack size exceeded` issue [515](https://github.com/shd101wyy/markdown-preview-enhanced/issues/515), [#517](https://github.com/shd101wyy/markdown-preview-enhanced/issues/517).

## 0.14.2

- Upgraded [mume](https://github.com/shd101wyy/mume) to version `0.1.3`.

  - Fixed pandoc export bug on Windows.
  - Fixed markdown export bug. Added `ignore_from_front_matter` option in `markdown` field. Removed `front_matter` option from `markdown` field.
  - Added `latexEngine` and `enableExtendedTableSyntax` config options. Now supporting merging table cells (disabled by default. Could be enabled from settings).
    [#479](https://github.com/shd101wyy/markdown-preview-enhanced/issues/479), [#133](https://github.com/shd101wyy/markdown-preview-enhanced/issues/133).

  ![screen shot 2017-07-15 at 8 16 45 pm](https://user-images.githubusercontent.com/1908863/28243710-945e3004-699a-11e7-9a5f-d74f6c944c3b.png)

  - Supported `export_on_save` front-matter that exports files when you save your markdown file. However, `phantomjs`, `prince`, `pandoc`, `ebook` are not recommended for `export_on_save` because it's too slow.

  eg:

  ```javascript
  ---
  export_on_save:
      html: true
      markdown: true
      prince: true
      phantomjs: true // or "pdf" | "jpeg" | "png" | ["pdf", ...]
      pandoc: true
      ebook: true // or "epub" | "mobi" | "html" | "pdf" | array
  ---
  ```

  - Added `embed_svg` front-matter option for HTML export, which is enabled by default.

* Now preview is rendered using electron `webview` instead of `iframe`. Fixed issue [#500](https://github.com/shd101wyy/markdown-preview-enhanced/issues/500).

## 0.14.1

- Upgraded [mume](https://github.com/shd101wyy/mume) to version `0.1.2`.
  - Switched the default markdown parser from `remarkable` to `markdown-it`.
  - Fixed pandoc export front-matter not included bug.
  - Fixed `bash` language highlighting bug.
  - Fixed phantomjs export task list bug.
  - Upgraded `webview.ts` script for preview. Now both Atom and VS Code versions share the same preview logic.
  - Removed several redundant dependencies.

## 0.14.0

- Fully rewritten in TypeScript, so there might be some potential bugs.
- Now powered by [Mume](https://github.com/shd101wyy/mume) project. The Atom version of this package shares the same core with the vscode version.
- Multiple new preview themes and code block themes are provided.

  - Github Light
    ![screen shot 2017-07-14 at 12 58 37 pm](https://user-images.githubusercontent.com/1908863/28224323-4899d896-6894-11e7-823a-233ee433d832.png)
  - Night
    ![screen shot 2017-07-14 at 12 59 04 pm](https://user-images.githubusercontent.com/1908863/28224327-4b0f77a2-6894-11e7-8133-99a2d04172a4.png)

- New presentation mode design, all reveal.js official themes are supported.

![screen shot 2017-07-14 at 12 33 14 pm](https://user-images.githubusercontent.com/1908863/28223480-2c61461c-6891-11e7-9389-5adec0588c32.png)

- Much easier to customize css. The `.markdown-preview-enhanced.markdown-preview-enhanced` is now deprecated. You can simply write your styles inside `html body`.
  [Customize CSS Tutorial](https://shd101wyy.github.io/markdown-preview-enhanced/#/customize-css).

- Code chunk syntax change. You have to define `cmd` property to declare a code chunk, and `id` is no longer required. The new syntax is like below:

      ```python {cmd:true}
      print("Hi There")
      ```

- And many more, please go check the [project website](https://shd101wyy.github.io/markdown-preview-enhanced).
