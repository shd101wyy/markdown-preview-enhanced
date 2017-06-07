![code-chunk](http://i.imgur.com/MAtC3SD.gif)

# Code Chunk
**Changes might happen in the future.**  
To enable code chunk highlighting, install [language-gfm-enhanced](https://atom.io/packages/language-gfm-enhanced) package and disable the `language-gfm` package.    

**Markdown Preview Enhanced** allows you to render code output into documents.     

    ```{bash}
    ls .
    ```

    ```{javascript cmd:"node"}
    var date = Date.now()
    console.log(date.toString())
    ```   

## Commands & Keyboard Shortcuts
* `Markdown Preview Enhanced: Run Code Chunk` or <kbd>shift-enter</kbd>      
execute single code chunk where your cursor is at.    
* `Markdown Preview Enhanced: Run All Code Chunks` or <kbd>ctrl-shift-enter</kbd>   
execute all code chunks.    

## Format
You can configure code chunk options in format of `{lang  opt1:value1, opt2:value2, ...}`    

**lang**  
The grammar that the code block should highlight.  
It should be put at the most front.  

## Basic Configurations
**cmd**    
The command to run.  
If `cmd` is not provided, then `lang` will be regarded as command.    

eg:  

		```{python cmd:"/usr/local/bin/python3"}
		print("This will run python3 program")
		```


**output**  
`html`, `markdown`, `text`, `png`, `none`  

Defines how to render code output.   
`html` will append output as html.    
`markdown` will parse output as markdown. (MathJax and graphs will not be supported in this case, but KaTeX works)      
`text` will append output to a `pre` block.    
`png` will append output as `base64` image.  
`none` will hide the output.  

eg:     

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
args that append to command. eg:    

    ```{python args:["-v"]}
    print("Verbose will be printed first")
    ```

    ```{erd args:["-f", "svg", "-i"], output:"html"}
		# output svg format and append as html result.
    ```

**stdin**  
If `stdin` is set to true, then the code will be passed as stdin instead of as file.

**hide**  
`hide` will hide code chunk but only leave the output visible. default: `false`  
eg:

    ```{python hide:true}
    print('you can see this output message, but not this code')
    ```

**continue**  
If set `continue: true`, then this code chunk will continue from the last code chunk.  
If set `continue: id`, then this code chunk will continue from the code chunk of id.  
eg:    

	```{python id:"izdlk700"}
	x = 1
	```

	```{python id:"izdlkdim"}
	x = 2
	```

	```{python continue:"izdlk700", id:"izdlkhso"}
	print(x) # will print 1
	```

**class**  
If set `class:"class1 class2"`, then `class1 class2` will be add to the code chunk.  
* `lineNo` class will show line numbers to code chunk.

**element**  
The element that you want to append after.  
Check the **Plotly** example below.

**id**  
`id` will be automatically generated to track the running result.  
Please **Do Not** modify it. If you modify it, please make sure it is unique in your markdown file.    

## Macro
* **input_file**  
`input_file` is automatically generated under the same directory of your markdown file and will be deleted after running code that is copied to `input_file`.      
By default, it is appended at the very end of program arguments.  
However, you can set the position of `input_file` in your `args` option by `{input_file}` macro. eg:  


    ```{program args:["-i", "{input_file}", "-o", "./output.png"], id:"chj3kxsvao"}
    ...your code here
    ```


## Matplotlib  
If set `matplotlib: true`, then the python code chunk will plot graphs inline in the preview.    
eg:    

	```{python matplotlib:true, id:"izbp0zt9"}
	import matplotlib.pyplot as plt
	plt.plot([1,2,3, 4])
	plt.show() # show figure
	```
![screen shot 2017-06-05 at 9 21 25 pm](https://cloud.githubusercontent.com/assets/1908863/26811044/f39404d4-4a34-11e7-8be2-0e20c0e9b00e.png)

## LaTeX
Markdown Preview Enhanced also supports `LaTeX` compilation.  
Before using this feature, you need to have [pdf2svg](extra.md?id=install-svg2pdf) and [LaTeX engine](extra.md?id=install-latex-distribution) installed.  
Then you can simply write LaTeX in code chunk like this:  


    ```{latex}
    \documentclass{standalone}
    \begin{document}
       Hello world!
    \end{document}
    ```

![screen shot 2017-06-05 at 9 41 05 pm](https://cloud.githubusercontent.com/assets/1908863/26811469/b234c584-4a37-11e7-977c-73f7a3e07bd7.png)


### LaTeX output configuration  
**latex_zoom**  
If set `latex_zoom:num`, then the result will be scaled `num` times.  

**latex_width**  
The width of result.  

**latex_height**  
The height of result.  

**latex_engine**  
The latex engine that you used to compile `tex` file. By default `pdflatex` is used. You can change the default value from the [pacakge settings](usages.md?id=package-settings).    


### TikZ example  
It is recommended to use `standalone` while drawing `tikz` graphs.  
![screen shot 2017-06-05 at 9 48 10 pm](https://cloud.githubusercontent.com/assets/1908863/26811633/b018aa76-4a38-11e7-9ec2-688f273468bb.png)


## Plotly
Markdown Preview Enhanced allows you to draw [Plotly](https://plot.ly/) easily.  
For example:  
![screen shot 2017-06-06 at 3 27 28 pm](https://user-images.githubusercontent.com/1908863/26850341-c6095a94-4acc-11e7-83b4-7fdb4eb8b1d8.png)

* The first line `@import "https://cdn.plot.ly/plotly-latest.min.js" ` uses the [file import](file-imports.md) functionality to import `plotly-latest.min.js` file. However, it is recommended to download the js file to local disk for better performance.  
* Then we created a `javascript` code chunk.

## Demo
This demo shows you how to render entity-relation diagram by using [erd](https://github.com/BurntSushi/erd) library.   

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
* `erd` the program that we are using. (*you need to have the program installed first*)  
* `output:"html"` we will append the running result as `html`.  
* `args` field shows the arguments that we will use.  
* `id` is a unique identifier automatically generated, you don't need to care about it.  

Then we can click the `run` button at the preview to run our code.  

![code_chunk](http://i.imgur.com/a7LkJYD.gif)

## Showcases
**bash**  
![Screen Shot 2016-09-24 at 1.41.06 AM](http://i.imgur.com/v5Y7juh.png)

**gnuplot with svg output**    
![Screen Shot 2016-09-24 at 1.44.14 AM](http://i.imgur.com/S93g7Tk.png)

## Limitations
* Doesn't work with `ebook` yet.  
* Might be buggy when using`pandoc document export`


[➔ Presentation](presentation.md)