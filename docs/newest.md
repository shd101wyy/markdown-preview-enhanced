## Anouncement
[Markdown Preview Enhanced for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced) is now available! Cheeeers!


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