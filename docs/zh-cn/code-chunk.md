![code-chunk](http://i.imgur.com/MAtC3SD.gif)

# Code Chunk
**未来可能会有变动**  
如果你想要启动 code chunk 语法高亮，请安装 [language-gfm-enhanced](https://atom.io/packages/language-gfm-enhanced) 插件然后禁掉 `language-gfm` 插件。  

**Markdown Preview Enhanced** 支持渲染代码的运行结果。       

    ```{bash}
    ls .
    ```

    ```{javascript cmd:"node"}
    var date = Date.now()
    console.log(date.toString())
    ```   

## 命令 & 快捷键
* `Markdown Preview Enhanced: Run Code Chunk` 或者 <kbd>shift-enter</kbd>      
运行你现在光标所在的一个 code chunk。  
* `Markdown Preview Enhanced: Run All Code Chunks` 或者 <kbd>ctrl-shift-enter</kbd>   
运行所有的 code chunks。  

## 格式  
你可以通过以下形式来设置 code chunk ：  
`{lang  opt1:value1, opt2:value2, ...}`    

**lang**  
你想要代码所高亮的语言。
这个是要被放在最前面的。    

## 基本设置  
**cmd**  
将要被运行的命令。    
如果 `cmd` 没有被提供，那么 `lang` 将会被视作为命令。  

例如：  

		```{python cmd:"/usr/local/bin/python3"}
		print("这个将会运行 python3 程序")
		```


**output**  
`html`, `markdown`, `text`, `png`, `none`  

设置你想要如何显示你的代码结果。     
`html` 将会添加输出结果为 html。    
`markdown` 将会添加输出结果为 markdown。（MathJax 以及 graphs 在这种情况下是不被支持的）      
`text` 将会添加输出结果到 `pre` 块。      
`png` 将会添加输出结果到 `base64` 图片。  
`none` 将会隐藏输出结果。  

例如：

    ```{gnuplot output:"html"}
    set terminal svg
    set title "Simple Plots" font ",20"
    set key left box
    set samples 50
    set style data points

    plot [-10:10] sin(x),atan(x),cos(atan(x))
    ```

![screen shot 2017-06-06 at 11 03 29 pm](https://user-images.githubusercontent.com/1908863/26861847-5f03df6e-4b0c-11e7-8eb1-bfdef40eb09d.png)


**args**  
需要被添加到命令的 args 。 例如：  

    ```{python args:["-v"]}
    print("Verbose will be printed first")
    ```

    ```{erd args:["-f", "svg", "-i"], output:"html"}
		# output svg format and append as html result.
    ```

**stdin**  
如果 `stdin` 被设置为 true，那么代码将会被传递到 stdin 而不是作为文件。  

**hide**  
`hide` 将会隐藏代码块但是会显示运行结果，默认为 `false`。    
例如：

    ```{python hide:true}
    print('你将会看到这条输出的文字，但是你不会看到这段代码')
    ```

**continue**  
如果设置 `continue: true`，那么这个 code chunk 将会继续运行上一个 code chunk 的内容。  
如果设置`continue: id`，那么这个 code chunk 从拥有这个 id 的 code chunk 运行。    
例如：  

	```{python id:"izdlk700"}
	x = 1
	```

	```{python id:"izdlkdim"}
	x = 2
	```

	```{python continue:"izdlk700", id:"izdlkhso"}
	print(x) # 将会打印出 1
	```

**class**  
如果设置 `class:"class1 class2"`，那么 `class1 class2` 将会被添加到 code chunk。    
* `lineNo` class 将会添加代码行数到 code chunk。  

**element**  
你想要添加的元素。   
请查看下面的 **Plotly** 例子。  

**id**  
`id` 将会被自动生成用来标记运行结果。     
请 **不要** 修改它。如果你就是管不住手修改了它，请确保他在你的 markdown 文件中是独特唯一的。  

## 宏
* **input_file**  
`input_file` 将会拷贝你的 code chunk 中的代码，然后在你的 markdown 文件的目录下生成一个临时文件，并且会在 code chunk 运行结束后被自动删除。  
默认条件下，它被作为程序运行的最后一个参数。  
但是，如果你想要改变 `input_file` 在你的 `args` 中的位置，你可以使用 `{input_file}` 宏。例如：  


    ```{program args:["-i", "{input_file}", "-o", "./output.png"], id:"chj3kxsvao"}
    ...your code here
    ```


## Matplotlib  
如果设置 `matplotlib: true`，那么你的 python code chunk 将会在你的预览中绘制图像。      
例如：  

	```{python matplotlib:true, id:"izbp0zt9"}
	import matplotlib.pyplot as plt
	plt.plot([1,2,3, 4])
	plt.show() # show figure
	```
![screen shot 2017-06-05 at 9 21 25 pm](https://cloud.githubusercontent.com/assets/1908863/26811044/f39404d4-4a34-11e7-8be2-0e20c0e9b00e.png)

## LaTeX
Markdown Preview Enhanced 也支持 `LaTeX` 编译。  
在使用这个特性之前，你需要先安装好 [pdf2svg](zh-cn/extra.md?id=install-svg2pdf) 以及 [LaTeX engine](zh-cn/extra.md?id=install-latex-distribution)。  
然后你就可以很简单的利用 code chunk 编写 LaTeX 了：


    ```{latex}
    \documentclass{standalone}
    \begin{document}
       Hello world!
    \end{document}
    ```

![screen shot 2017-06-05 at 9 41 05 pm](https://cloud.githubusercontent.com/assets/1908863/26811469/b234c584-4a37-11e7-977c-73f7a3e07bd7.png)


### LaTeX 输出设置    
**latex_zoom**  
如果设置了 `latex_zoom:num`，那么输出结果将会被缩放 `num` 倍。  

**latex_width**  
输出结果的宽度。  

**latex_height**  
输出结果的高度。  

**latex_engine**   
就会被用来编译 `tex` 文件的 latex 引擎。默认下 `pdflatex` 是被使用的。你可以在 [插件设置](zh-cn/usages.md?id=package-settings) 中改变它的默认值。    


### TikZ 例子  
推荐使用 `standalone` 绘制 `tikz` 图形。    
![screen shot 2017-06-05 at 9 48 10 pm](https://cloud.githubusercontent.com/assets/1908863/26811633/b018aa76-4a38-11e7-9ec2-688f273468bb.png)

## Plotly
Markdown Preview Enhanced 支持你轻松的绘制 [Plotly](https://plot.ly/) 图形。
例如：  
![screen shot 2017-06-06 at 3 27 28 pm](https://user-images.githubusercontent.com/1908863/26850341-c6095a94-4acc-11e7-83b4-7fdb4eb8b1d8.png)

* 第一行中的 `@import "https://cdn.plot.ly/plotly-latest.min.js" ` 使用了 [文件引用](zh-cn/file-imports.md) 的特性来引用 `plotly-latest.min.js` 文件。但是，引用本地的 js 文件是推荐的，因为这样更快。  
* 接着我们创建了 `javascript` code chunk.

## Demo  
下面的例子展示了如何利用 [erd](https://github.com/BurntSushi/erd) 库绘制 ER diagram。     

    ```{erd output:"html", args:["-i", "{input_file}", "-f", "svg"], id:"ithhv4z4"}

    [Person]
    *name
    height
    weight
    +birth_location_id

    [Location]
    *id
    city
    state
    country

    Person *--1 Location
    ```

`{erd output:"html", args:["-i", "{input_file}", "-f", "svg"], id:"ithhv4z4"}`  
* `erd` 是我们将要用到的程序。 (*当然你得先安装好这个程序*)  
* `output:"html"` 意味着代码的输出结果将会被视作为 `html`。  
* `args` 显示了我们将要用到的参数。    
* `id` 是自动生成的，你不用管它。    

接着我们点击 `运行`按钮来运行我们的代码。  

![code_chunk](http://i.imgur.com/a7LkJYD.gif)

## 展示  
**bash**  
![Screen Shot 2016-09-24 at 1.41.06 AM](http://i.imgur.com/v5Y7juh.png)

**gnuplot with svg output**    
![Screen Shot 2016-09-24 at 1.44.14 AM](http://i.imgur.com/S93g7Tk.png)

## 局限
* 暂时不能在 `ebook` 工作。  
* `pandoc document export` 中可能会有问题。  


[➔ 幻灯片制作](zh-cn/presentation.md)