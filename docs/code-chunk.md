# Code Chunk

**Changes might happen in the future.**

**Markdown Preview Enhanced** allows you to render code output into documents.

    ```bash {cmd}
    ls .
    ```

    ```bash {cmd=true}
    ls .
    ```

    ```javascript {cmd="node"}
    const date = Date.now()
    console.log(date.toString())
    ```

> ⚠️ **Script execution is off by default and needs to be explicitly enabled in Atom package / VSCode extension preferences**
>
> Please use this feature with caution because it may put your security at risk!
> Your machine can get hacked if someone makes you open a markdown with malicious code while script execution is enabled.
>
> Option name: `enableScriptExecution`

## Commands & Keyboard Shortcuts

- `Markdown Preview Enhanced: Run Code Chunk` or <kbd>shift-enter</kbd>
  execute single code chunk where your cursor is at.
- `Markdown Preview Enhanced: Run All Code Chunks` or <kbd>ctrl-shift-enter</kbd>
  execute all code chunks.

## Format

You can configure code chunk options in format of <code>\`\`\`lang {cmd=your_cmd opt1=value1 opt2=value2 ...}</code>.
When a value of an attribute is `true`, it can be omitted (e.g. `{cmd hide}` is identical to `{cmd=true hide=true}`).

**lang**
The grammar that the code block should highlight.
It should be put at the most front.

## Basic Options

**cmd**
The command to run.
If `cmd` is not provided, then `lang` will be regarded as command.

eg:

    ```python {cmd="/usr/local/bin/python3"}
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

    ```gnuplot {cmd=true output="html"}
    set terminal svg
    set title "Simple Plots" font ",20"
    set key left box
    set samples 50
    set style data points

    plot [-10:10] sin(x),atan(x),cos(atan(x))
    ```

![screen shot 2017-07-28 at 7 14 24 am](https://user-images.githubusercontent.com/1908863/28716734-66142a5e-7364-11e7-83dc-a66df61971dc.png)

**args**
args that append to command. eg:

    ```python {cmd=true args=["-v"]}
    print("Verbose will be printed first")
    ```

    ```erd {cmd=true args=["-i", "$input_file", "-f", "svg"] output="html"}
      # output svg format and append as html result.
    ```

**stdin**
If `stdin` is set to true, then the code will be passed as stdin instead of as file.

**hide**
`hide` will hide code chunk but only leave the output visible. default: `false`
eg:

    ```python {hide=true}
    print('you can see this output message, but not this code')
    ```

**continue**
If set `continue=true`, then this code chunk will continue from the last code chunk.
If set `continue=id`, then this code chunk will continue from the code chunk of id.
eg:

    ```python {cmd=true id="izdlk700"}
    x = 1
    ```

    ```python {cmd=true id="izdlkdim"}
    x = 2
    ```

    ```python {cmd=true continue="izdlk700" id="izdlkhso"}
    print(x) # will print 1
    ```

**class**
If set `class="class1 class2"`, then `class1 class2` will be add to the code chunk.

- `line-numbers` class will show line numbers to code chunk.

**element**
The element that you want to append after.
Check the **Plotly** example below.

**run_on_save** `boolean`
Run code chunk when the markdown file is saved. Default `false`.

**modify_source** `boolean`
Insert code chunk output directly into markdown source file. Default `false`.

**id**
The `id` of the code chunk. This option would be useful if `continue` is used.

## Macro

- **input_file**
  `input_file` is automatically generated under the same directory of your markdown file and will be deleted after running code that is copied to `input_file`.
  By default, it is appended at the very end of program arguments.
  However, you can set the position of `input_file` in your `args` option by `$input_file` macro. eg:

      ```program {cmd=true args=["-i", "$input_file", "-o", "./output.png"]}
      ...your code here
      ```

## Matplotlib

If set `matplotlib=true`, then the python code chunk will plot graphs inline in the preview.
eg:

    ```python {cmd=true matplotlib=true}
    import matplotlib.pyplot as plt
    plt.plot([1,2,3, 4])
    plt.show() # show figure
    ```

![screen shot 2017-07-28 at 7 12 50 am](https://user-images.githubusercontent.com/1908863/28716704-4009d43a-7364-11e7-9e46-889f961e5afd.png)

## LaTeX

Markdown Preview Enhanced also supports `LaTeX` compilation.
Before using this feature, you need to have [pdf2svg](extra.md?id=install-svg2pdf) and [LaTeX engine](extra.md?id=install-latex-distribution) installed.
Then you can simply write LaTeX in code chunk like this:

    ```latex {cmd=true}
    \documentclass{standalone}
    \begin{document}
      Hello world!
    \end{document}
    ```

![screen shot 2017-07-28 at 7 15 16 am](https://user-images.githubusercontent.com/1908863/28716762-8686d980-7364-11e7-9669-71138cb2e6e7.png)

### LaTeX output configuration

**latex_zoom**
If set `latex_zoom=num`, then the result will be scaled `num` times.

**latex_width**
The width of result.

**latex_height**
The height of result.

**latex_engine**
The latex engine that you used to compile `tex` file. By default `pdflatex` is used.

### TikZ example

It is recommended to use `standalone` while drawing `tikz` graphs.
![screen shot 2017-07-14 at 11 27 56 am](https://user-images.githubusercontent.com/1908863/28221069-8113a5b0-6887-11e7-82fa-23dd68f2be82.png)

## Plotly

Markdown Preview Enhanced allows you to draw [Plotly](https://plot.ly/) easily.
For example:
![screen shot 2017-10-20 at 10 41 25 am](https://user-images.githubusercontent.com/1908863/31829580-526a0c06-b583-11e7-82f2-09ea7a0b9672.png)

- The first line `@import "https://cdn.plot.ly/plotly-latest.min.js"` uses the [file import](file-imports.md) functionality to import `plotly-latest.min.js` file.
  However, it is recommended to download the js file to local disk for better performance.
- Then we created a `javascript` code chunk.

## Demo

This demo shows you how to render entity-relation diagram by using [erd](https://github.com/BurntSushi/erd) library.

    ```erd {cmd=true output="html" args=["-i", "$input_file" "-f", "svg"]}

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

`erd {cmd=true output="html" args=["-i", "$input_file", "-f", "svg"]}`

- `erd` the program that we are using. (_you need to have the program installed first_)
- `output="html"` we will append the running result as `html`.
- `args` field shows the arguments that we will use.

Then we can click the `run` button at the preview to run our code.

![erd](https://user-images.githubusercontent.com/1908863/28221395-bcd0bd76-6888-11e7-8c6e-925e228d02cc.gif)

## Showcases (outdated)

**bash**
![Screen Shot 2016-09-24 at 1.41.06 AM](https://i.imgur.com/v5Y7juh.png)

**gnuplot with svg output**
![Screen Shot 2016-09-24 at 1.44.14 AM](https://i.imgur.com/S93g7Tk.png)

## Limitations

- Doesn't work with `ebook` yet.
- Might be buggy when using `pandoc document export`

[➔ Presentation](presentation.md)
