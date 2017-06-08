## 0.13.0
* [x] Support `LaTeX` code chunk.  [pdf2svg](https://shd101wyy.github.io/markdown-preview-enhanced/#/extra) and [LaTeX engine](https://shd101wyy.github.io/markdown-preview-enhanced/#/extra) are required. See below.      
* [x] Add `Markdown Preview Enhanced: Show Uploaded Images`. Now every time you upload an image, it will be stored to history.    
* [x] Support `@import` PDF file. For example: `@import "test.pdf"`. [pdf2svg](https://shd101wyy.github.io/markdown-preview-enhanced/#/extra) is required.    
* [x] Support `@import` JavaScript file. The JavaScript will be evaluated in `window` scope but not by `node.js`.  
* [x] **Attension:** <code>\`\`\`@mermaid</code> is deprecated. From now on only <code>\`\`\`mermaid</code> is supprted. Same as `PlantUML`, `viz.js`, and `WaveDrom`.   
      For more information, check [this doc](https://shd101wyy.github.io/markdown-preview-enhanced/#/graphs).     
* [x] Migrate docs to GitHub page by [docsify](https://docsify.js.org/#/). [Project website is here](https://shd101wyy.github.io/markdown-preview-enhanced/#/). Contact me if you are willing to help translate the documentation :)   
* [ ] Tried hard to fix key bindings issue, but dunno if resolved or not :(  
* [x] Fix eBook generation issue. Add `include_toc` option.   
* [x] Better support for multiple previews [#435](https://github.com/shd101wyy/markdown-preview-enhanced/issues/435).  
* [x] Fix `sm.ms` image upload API issue. [#390](https://github.com/shd101wyy/markdown-preview-enhanced/issues/390).  
* [x] Fix issue [#436](https://github.com/shd101wyy/markdown-preview-enhanced/issues/436).   

### LaTeX Code Chunk
Markdown Preview Enhanced now supports `LaTeX` compilation.  
Before using this feature, you need to have [pdf2svg](https://shd101wyy.github.io/markdown-preview-enhanced/#/extra?id=install-svg2pdf) and [LaTeX engine](https://shd101wyy.github.io/markdown-preview-enhanced/#/extra?id=install-latex-distribution) installed.  
Then you can simply write LaTeX in code chunk like this:  


    ```{latex}
    \documentclass{standalone}
    \begin{document}
       Hello world!
    \end{document}
    ```

![screen shot 2017-06-05 at 9 41 05 pm](https://cloud.githubusercontent.com/assets/1908863/26811469/b234c584-4a37-11e7-977c-73f7a3e07bd7.png)


#### LaTeX output configuration  
**latex_zoom**  
If set `latex_zoom:num`, then the result will be scaled `num` times.  

**latex_width**  
The width of result.  

**latex_height**  
The height of result.  

**latex_engine**  
The latex engine that you used to parse `tex` file. By default `pdflatex` is used. You can change the default value from the [pacakge settings](https://shd101wyy.github.io/markdown-preview-enhanced/#/usages?id=package-settings).    


#### TikZ example  
It is recommended to use `standalone` while drawing `tikz` graphs.  
![screen shot 2017-06-05 at 9 48 10 pm](https://cloud.githubusercontent.com/assets/1908863/26811633/b018aa76-4a38-11e7-9ec2-688f273468bb.png)

