# Code Chunk

**未来可能会有变动**

**Markdown Preview Enhanced** 支持渲染代码的运行结果。

    ```bash {cmd=true}
    ls .
    ```

    ```javascript {cmd="node"}
    const date = Date.now()
    console.log(date.toString())
    ```

> ⚠️ **脚本运行默认是禁用的并且需要在 Atom 和 VSCode 的插件设置中开启来进行使用**
>
> 请小心使用这一特性，因为它很有可能造成安全问题！
> 当你的脚本运行设置是开启的，你的电脑很有可能被黑客攻击，如果有人使你运行了 Markdown 文档中的恶意代码。
>
> 设置名称： `enableScriptExecution`

## 命令 & 快捷键

- `Markdown Preview Enhanced: Run Code Chunk` 或者 <kbd>shift-enter</kbd>
  运行你现在光标所在的一个 code chunk。
- `Markdown Preview Enhanced: Run All Code Chunks` 或者 <kbd>ctrl-shift-enter</kbd>
  运行所有的 code chunks。

## 格式

你可以通过以下形式来设置 code chunk：<code>\`\`\`lang {cmd=your_cmd opt1=value1 opt2=value2 ...}</code>。

如果一个属性的值是 `true`，那么它可以被省略，（e.g. `{cmd hide}` 和 `{cmd=true hide=true}` 相同）。

**lang**
你想要代码所高亮的语言。
这个是要被放在最前面的。

## 基本设置

**cmd**
将要被运行的命令。
如果 `cmd` 没有被提供，那么 `lang` 将会被视作为命令。

例如：

    	```python {cmd="/usr/local/bin/python3"}
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
需要被添加到命令的 args 。 例如：

    ```python {cmd=true args=["-v"]}
    print("Verbose will be printed first")
    ```

    ```erd {cmd=true args=["-i", "$input_file", "-f", "svg"] output="html"}
    # output svg format and append as html result.
    ```

**stdin**
如果 `stdin` 被设置为 true，那么代码将会被传递到 stdin 而不是作为文件。

**hide**
`hide` 将会隐藏代码块但是会显示运行结果，默认为 `false`。
例如：

    ```python {hide=true}
    print('you can see this output message, but not this code')
    ```

**continue**
如果设置 `continue: true`，那么这个 code chunk 将会继续运行上一个 code chunk 的内容。
如果设置`continue: id`，那么这个 code chunk 从拥有这个 id 的 code chunk 运行。
例如：

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
如果设置 `class="class1 class2"`，那么 `class1 class2` 将会被添加到 code chunk。

- `line-numbers` class 将会添加代码行数到 code chunk。

**element**
你想要添加的元素。
请查看下面的 **Plotly** 例子。

**run_on_save** `boolean`
当 markdown 文件被保存时，自动运行 code chunk。默认 `false`。

**modify_source** `boolean`
插入 code chunk 的运行结果直接到 markdown 文件。默认 `false`。

**id**
Code chunk 的 `id`。这个选项可以配合 `continue` 选项使用。

## 宏

- **input_file**
  `input_file` 将会拷贝你的 code chunk 中的代码，然后在你的 markdown 文件的目录下生成一个临时文件，并且会在 code chunk 运行结束后被自动删除。
  默认条件下，它被作为程序运行的最后一个参数。
  但是，如果你想要改变 `input_file` 在你的 `args` 中的位置，你可以使用 `$input_file` 宏。例如：


    ```program {cmd=true args=["-i", "$input_file", "-o", "./output.png"]}
    ...your code here
    ```

## Matplotlib

如果设置 `matplotlib=true`，那么你的 python code chunk 将会在你的预览中绘制图像。
例如：

    ```python {cmd=true matplotlib=true}
    import matplotlib.pyplot as plt
    plt.plot([1,2,3, 4])
    plt.show() # show figure
    ```

![screen shot 2017-07-28 at 7 12 50 am](https://user-images.githubusercontent.com/1908863/28716704-4009d43a-7364-11e7-9e46-889f961e5afd.png)

## LaTeX

Markdown Preview Enhanced 也支持 `LaTeX` 编译。
在使用这个特性之前，你需要先安装好 [pdf2svg](zh-cn/extra.md?id=install-svg2pdf) 以及 [LaTeX engine](zh-cn/extra.md?id=install-latex-distribution)。
然后你就可以很简单的利用 code chunk 编写 LaTeX 了：

    ```latex {cmd=true}
    \documentclass{standalone}
    \begin{document}
       Hello world!
    \end{document}
    ```

![screen shot 2017-07-28 at 7 15 16 am](https://user-images.githubusercontent.com/1908863/28716762-8686d980-7364-11e7-9669-71138cb2e6e7.png)

### LaTeX 输出设置

**latex_zoom**
如果设置了 `latex_zoom=num`，那么输出结果将会被缩放 `num` 倍。

**latex_width**
输出结果的宽度。

**latex_height**
输出结果的高度。

**latex_engine**
就会被用来编译 `tex` 文件的 latex 引擎。默认下 `pdflatex` 是被使用的。你可以在 [插件设置](zh-cn/usages.md?id=package-settings) 中改变它的默认值。

### TikZ 例子

推荐使用 `standalone` 绘制 `tikz` 图形。

![screen shot 2017-07-14 at 11 27 56 am](https://user-images.githubusercontent.com/1908863/28221069-8113a5b0-6887-11e7-82fa-23dd68f2be82.png)

## Plotly

Markdown Preview Enhanced 支持你轻松的绘制 [Plotly](https://plot.ly/) 图形。
例如：
![screen shot 2017-10-20 at 10 41 25 am](https://user-images.githubusercontent.com/1908863/31829580-526a0c06-b583-11e7-82f2-09ea7a0b9672.png)

- 第一行中的 `@import "https://cdn.plot.ly/plotly-latest.min.js"` 使用了 [文件引用](zh-cn/file-imports.md) 的特性来引用 `plotly-latest.min.js` 文件。但是，引用本地的 js 文件是推荐的，因为这样更快。
- 接着我们创建了 `javascript` code chunk.

## Demo

下面的例子展示了如何利用 [erd](https://github.com/BurntSushi/erd) 库绘制 ER diagram。

    ```erd {cmd=true output="html" args=["-i", "$input_file", "-f", "svg"]}

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

- `erd` 是我们将要用到的程序。 (_当然你得先安装好这个程序_)
- `output="html"` 意味着代码的输出结果将会被视作为 `html`。
- `args` 显示了我们将要用到的参数。

接着我们点击 `运行`按钮来运行我们的代码。

![erd](https://user-images.githubusercontent.com/1908863/28221395-bcd0bd76-6888-11e7-8c6e-925e228d02cc.gif)

## 展示

**bash**
![Screen Shot 2016-09-24 at 1.41.06 AM](https://i.imgur.com/v5Y7juh.png)

**gnuplot with svg output**
![Screen Shot 2016-09-24 at 1.44.14 AM](https://i.imgur.com/S93g7Tk.png)

## 局限

- 暂时不能在 `ebook` 工作。
- `pandoc document export` 中可能会有问题。

[➔ 幻灯片制作](zh-cn/presentation.md)
