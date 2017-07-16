## Anouncement
[Markdown Preview Enhanced for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced) is now available! Cheeeers!

## 0.14.2
* Upgraded [mume](https://github.com/shd101wyy/mume) to version `0.1.3`
* Added `latexEngine` and `enableExtendedTableSyntax` config options.
Now supporting merging table cells (disabled by default. Could be enabled from the settings) [#479](https://github.com/shd101wyy/markdown-preview-enhanced/issues/479), [#133](https://github.com/shd101wyy/markdown-preview-enhanced/issues/133).    

![screen shot 2017-07-15 at 8 16 45 pm](https://user-images.githubusercontent.com/1908863/28243710-945e3004-699a-11e7-9a5f-d74f6c944c3b.png)

* Now preview is rendered using electron `webview` instead of `iframe`. Fixed issue [#500](https://github.com/shd101wyy/markdown-preview-enhanced/issues/500).  

* Fixed pandoc export bug on Windows [#496](https://github.com/shd101wyy/markdown-preview-enhanced/issues/496).  

## 0.14.1
* Upgraded [mume](https://github.com/shd101wyy/mume) to version `0.1.2`.  
    * Switched the default markdown parser from `remarkable` to `markdown-it`.  
    * Fixed pandoc export front-matter not included bug.  
    * Fixed `bash` language highlighting bug.
    * Fixed phantomjs export task list bug.   
    * Upgraded `webview.ts` script for preview. Now both Atom and VS Code versions share the same preview logic.  
    * Removed several redundandent dependencies.  


## 0.14.0  
* Fully rewritten in TypeScript, so there might be some potential bugs.
* Now powered by [Mume](https://github.com/shd101wyy/mume) project. The Atom version of this package shares the same core with the vscode version.
* Multiple new preview themes and code block themes are provided.
  * Github Light
  ![screen shot 2017-07-14 at 12 58 37 pm](https://user-images.githubusercontent.com/1908863/28224323-4899d896-6894-11e7-823a-233ee433d832.png)
  * Night  
  ![screen shot 2017-07-14 at 12 59 04 pm](https://user-images.githubusercontent.com/1908863/28224327-4b0f77a2-6894-11e7-8133-99a2d04172a4.png)

* New presentation mode design, all reveal.js official themes are supported.  

![screen shot 2017-07-14 at 12 33 14 pm](https://user-images.githubusercontent.com/1908863/28223480-2c61461c-6891-11e7-9389-5adec0588c32.png)

* Much easier to customize css. The `.markdown-preview-enhanced.markdown-preview-enhanced` is now deprecated. You can simply write your styles inside `html body`.   
[Customize CSS Tutorial](https://shd101wyy.github.io/markdown-preview-enhanced/#/customize-css).   

* Code chunk syntax change. You have to define `cmd` property to declare a code chunk, and `id` is no longer required. The new syntax is like below:

      ```python {cmd:true}
      print("Hi There")
      ```

* And many more, please go check the [project website](https://shd101wyy.github.io/markdown-preview-enhanced).