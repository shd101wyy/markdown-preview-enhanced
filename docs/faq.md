# FAQ  

1. **I am not able to find this package in atom?**  
Please search for the full name of this package. `markdown-preview-enhanced`  
2. **I exported a html file, and I want to deploy it on my own remote server. But math typesetting (MathJax or KaTeX) doesn't work, what should I do?**  
Please make sure you have `Use CDN hosted resources` checked when exporting.  
3. **I exported a presentation html file, and I want to put it on my Github Page or deploy remotely?**  
Please check the last question.  
4. **How do I get dark style preview?**  
If you want the style of the preview to be consistent with your atom editor, go to settings of this package, then change the `Preview Theme`.  
Or you can run `Markdown Preview Enhanced: Customize Css` command, then modify the `style.less` file.  [#68](https://github.com/shd101wyy/markdown-preview-enhanced/issues/68), [#89](https://github.com/shd101wyy/markdown-preview-enhanced/issues/89).  
5. **The preview is super super lagging?**  
This might happen when your markdown file is too big, or you are writing too many math or graphs.  
Therefore I would like to recommend you to disable `Live Update` functionality.  
You can run `Markdown Preview Enhanced: Toggle Live Update` to disable it.  
6. **Keyboard Shortcut doesn't work?**  
<kbd>cmd-shift-p</kbd> then choose `Key Binding Resolver: Toggle`. Check if there is keybinding conflicts, or post an issue on GitHub.  