
<!-- toc orderedList:0 -->

- [Code Chunk (Beta)](#code-chunk-beta)
	- [Options](#options)
	- [Macro](#macro)
	- [Demo](#demo)

<!-- tocstop -->

# Code Chunk (Beta)
**Markdown Preview Enhanced** allows you to run code on your system.   

    ```{bash}
    ls .
    ```

    ```{node}
    var date = Date.now()
    console.log(date.toString())
    ```

where the first argument within `{}` is the path to your program.   

## Options
You can define code chunk options in format of `{path/to/program  opt1:value1, opt2:value2, ...}`   

**output**  
`html`, `text`, `png`, `none`  

defines how to render code output.   
`html` will append output as html.   
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

**args**  
args that append to command. eg:    

    ```{python args:["-v"]}
    print("Verbose will be printed first")
    ```

    ```{erd args:["-f", "svg", "-i"], output:"html"}
		# output svg format and append as html result.
    ```

**hide**  
`hide` will hide code chunk but only leave the output visible when exporting document. default: `false`  
eg:

    ```{python hide:true}
    print('you can see this output message, but not this code')
    ```

**id**  
`id` will be automatically generated to track the running result.  
Please **Do Not** modify it.  

## Macro
* **input_file**  
`input_file` is automatically generated under the same directory of your markdown file and will be deleted after running code that is copied to `input_file`.      
By default, it is appended at the very end of arguments.  
However, you can set the position of `input_file` path in your `args` option by `{input_file}` macro. eg:  

		```{program args:["-i", "{input_file}", "-o", "./output.png"]}


## Demo
**bash**  
![Screen Shot 2016-09-24 at 1.41.06 AM](http://i.imgur.com/v5Y7juh.png)

**python matplotlib 3d plot with png output**  
![Screen Shot 2016-09-24 at 1.34.56 AM](http://i.imgur.com/TDFxRNy.png)

**gnuplot with svg output**    
![Screen Shot 2016-09-24 at 1.44.14 AM](http://i.imgur.com/S93g7Tk.png)

