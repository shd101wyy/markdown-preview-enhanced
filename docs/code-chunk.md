<!-- toc orderedList:0 depthFrom: 1 -->

* [Code Chunk (Beta)](#code-chunk-beta)
	* [Format](#format)
	* [Options](#options)
	* [Commands & Keyboard Shortcust](#commands-keyboard-shortcust)
	* [Macro](#macro)
	* [Demo](#demo)
	* [Showcases](#showcases)
	* [Limitations](#limitations)

<!-- tocstop -->

![code-chunk](http://i.imgur.com/MAtC3SD.gif)

# Code Chunk (Beta)  
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

## Format
You can configure code chunk options in format of `{lang  opt1:value1, opt2:value2, ...}`    

**lang**  
The grammar that the code block should highlight.  
It should be put at the most front.  

## Options
**cmd**    
The command to run.  
If `cmd` is not provided, then `lang` will be regarded as command.    

eg:  

		```{python cmd:"/usr/local/bin/python3"}
		print("This will run python3 program")
		```


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

**stdin**  
if `stdin` is set to true, then the code will be passed as stdin instead of as file.

**hide**  
`hide` will hide code chunk but only leave the output visible. default: `false`  
eg:

    ```{python hide:true}
    print('you can see this output message, but not this code')
    ```

**id**  
`id` will be automatically generated to track the running result.  
Please **Do Not** modify it.  

## Commands & Keyboard Shortcust
<strike>`run` and `all` buttons are removed in version `0.8.8`. So you need to use keyboard instead.</strike> nvm I put those buttons back.      
* `Markdown Preview Enhanced: Run Code Chunk` or <kbd>shift-enter</kbd>      
execute single code chunk where your cursor is at.    
* `Markdown Preview Enhanced: Run All Code Chunks` or <kbd>ctrl-shift-enter</kbd>   
execute all code chunks.    

## Macro
* **input_file**  
`input_file` is automatically generated under the same directory of your markdown file and will be deleted after running code that is copied to `input_file`.      
By default, it is appended at the very end of program arguments.  
However, you can set the position of `input_file` in your `args` option by `{input_file}` macro. eg:  

<pre>
```{program args:["-i", "{input_file}", "-o", "./output.png"]}
...your code here
```
</pre>

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

**python matplotlib 3d plot with png output**  
![Screen Shot 2016-09-24 at 1.34.56 AM](http://i.imgur.com/TDFxRNy.png)

**gnuplot with svg output**    
![Screen Shot 2016-09-24 at 1.44.14 AM](http://i.imgur.com/S93g7Tk.png)

## Limitations
* Doesn't work with `ebook` yet.  
* Might be buggy when using`pandoc document export`