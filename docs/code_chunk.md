# Code Chunk (Beta)
**Markdown Preview Enhanced** allows you to run code on your system.   

    ```{bash}
    ls .
    ```

    ```{node}
    var date = Date.now()
    date.toString()
    ```

For example, if you want to run `gnuplot` and embed the graph created in markdown:   

    ```{gnuplot output:"html"}

    ```

where the first argument within `{}` is the path to your program.   

## Options
You can define code chunk options in format of `{path/to/program  opt1:value1, opt2:value2, ...}`   

**output**  
`html`, `text`, `png`, `none`  

defines how to render code output.   
`html` will append output as html.   
`text` will append output within `pre` block.    
`png` will append output as `base64` to an image.  
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
args that appends to your first command. eg:    

    ```{python args:"-v"}
    print("Verbose will be printed first")
    ```

**hide**  
`hide` will hide code chunk but only leave the output. default: `false`  
eg:

    ```{python hide:true}
    print('you can see this message, but not this code')
    ```

**id**  
`id` will be automatically generated to track the running result. Please don't modify it.  