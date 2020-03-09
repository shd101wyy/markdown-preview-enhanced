# Code Chunk

**未來可能會有變動**

**Markdown Preview Enhanced** 支持渲染代碼的運行結果。

    ```bash {cmd=true}
    ls .
    ```

    ```javascript {cmd="node"}
    const date = Date.now()
    console.log(date.toString())
    ```

> ⚠️ **腳本運行默認是禁用的並且需要在 Atom 和 VSCode 的插件設置中開啟來進行使用**
>
> 請小心使用這一特性，因為它很有可能造成安全問題！
> 當你的腳本運行設置是開啟的，你的電腦很有可能被黑客攻擊，如果有人使你運行了 Markdown 文檔中的惡意代碼。
>
> 設置名稱： `enableScriptExecution`

## 命令 & 快捷鍵

- `Markdown Preview Enhanced: Run Code Chunk` 或者 <kbd>shift-enter</kbd>
  運行你現在光標所在的一個 code chunk。
- `Markdown Preview Enhanced: Run All Code Chunks` 或者 <kbd>ctrl-shift-enter</kbd>
  運行所有的 code chunks。

## 格式

你可以通過以下形式來設置 code chunk：<code>\`\`\`lang {cmd=your_cmd opt1=value1 opt2=value2 ...}</code>。

如果一個屬性的值是 `true`，那麼它可以被省略，（e.g. `{cmd hide}` 和 `{cmd=true hide=true}` 相同）。

**lang**
你想要代碼所高亮的語言。
這個是要被放在最前面的。

## 基本設置

**cmd**
將要被運行的命令。
如果 `cmd` 沒有被提供，那麼 `lang` 將會被視作為命令。

例如：

    	```python {cmd="/usr/local/bin/python3"}
    	print("這個將會運行 python3 程序")
    	```

**output**
`html`, `markdown`, `text`, `png`, `none`

設置你想要如何顯示你的代碼結果。
`html` 將會添加輸出結果為 html。
`markdown` 將會添加輸出結果為 markdown。（MathJax 以及 graphs 在這種情況下是不被支持的）
`text` 將會添加輸出結果到 `pre` 塊。
`png` 將會添加輸出結果到 `base64` 圖片。
`none` 將會隱藏輸出結果。

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
如果 `stdin` 被設置為 true，那麼代碼將會被傳遞到 stdin 而不是作為文件。

**hide**
`hide` 將會隱藏代碼塊但是會顯示運行結果，默認為 `false`。
例如：

    ```python {hide=true}
    print('you can see this output message, but not this code')
    ```

**continue**
如果設置 `continue: true`，那麼這個 code chunk 將會繼續運行上一個 code chunk 的內容。
如果設置`continue: id`，那麼這個 code chunk 從擁有這個 id 的 code chunk 運行。
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
如果設置 `class="class1 class2"`，那麼 `class1 class2` 將會被添加到 code chunk。

- `line-numbers` class 將會添加代碼行數到 code chunk。

**element**
你想要添加的元素。
請查看下面的 **Plotly** 例子。

**run_on_save** `boolean`
當 markdown 文件被保存時，自動運行 code chunk。默認 `false`。

**modify_source** `boolean`
插入 code chunk 的運行結果直接到 markdown 文件。默認 `false`。

**id**
Code chunk 的 `id`。這個選項可以配合 `continue` 選項使用。

## 宏

- **input_file**
  `input_file` 將會拷貝你的 code chunk 中的代碼，然後在你的 markdown 文件的目錄下生成一個臨時文件，並且會在 code chunk 運行結束後被自動刪除。
  默認條件下，它被作為程序運行的最後一個參數。
  但是，如果你想要改變 `input_file` 在你的 `args` 中的位置，你可以使用 `$input_file` 宏。例如：


    ```program {cmd=true args=["-i", "$input_file", "-o", "./output.png"]}
    ...your code here
    ```

## Matplotlib

如果設置 `matplotlib=true`，那麼你的 python code chunk 將會在你的預覽中繪制圖像。
例如：

    ```python {cmd=true matplotlib=true}
    import matplotlib.pyplot as plt
    plt.plot([1,2,3, 4])
    plt.show() # show figure
    ```

![screen shot 2017-07-28 at 7 12 50 am](https://user-images.githubusercontent.com/1908863/28716704-4009d43a-7364-11e7-9e46-889f961e5afd.png)

## LaTeX

Markdown Preview Enhanced 也支持 `LaTeX` 編譯。
在使用這個特性之前，你需要先安裝好 [pdf2svg](zh-tw/extra.md?id=install-svg2pdf) 以及 [LaTeX engine](zh-tw/extra.md?id=install-latex-distribution)。
然後你就可以很簡單的利用 code chunk 編寫 LaTeX 了：

    ```latex {cmd=true}
    \documentclass{standalone}
    \begin{document}
       Hello world!
    \end{document}
    ```

![screen shot 2017-07-28 at 7 15 16 am](https://user-images.githubusercontent.com/1908863/28716762-8686d980-7364-11e7-9669-71138cb2e6e7.png)

### LaTeX 輸出設置

**latex_zoom**
如果設置了 `latex_zoom=num`，那麼輸出結果將會被縮放 `num` 倍。

**latex_width**
輸出結果的寬度。

**latex_height**
輸出結果的高度。

**latex_engine**
就會被用來編譯 `tex` 文件的 latex 引擎。默認下 `pdflatex` 是被使用的。你可以在 [插件設置](zh-tw/usages.md?id=package-settings) 中改變它的默認值。

### TikZ 例子

推薦使用 `standalone` 繪制 `tikz` 圖形。

![screen shot 2017-07-14 at 11 27 56 am](https://user-images.githubusercontent.com/1908863/28221069-8113a5b0-6887-11e7-82fa-23dd68f2be82.png)

## Plotly

Markdown Preview Enhanced 支持你輕松的繪制 [Plotly](https://plot.ly/) 圖形。
例如：
![screen shot 2017-10-20 at 10 41 25 am](https://user-images.githubusercontent.com/1908863/31829580-526a0c06-b583-11e7-82f2-09ea7a0b9672.png)

- 第一行中的 `@import "https://cdn.plot.ly/plotly-latest.min.js"` 使用了 [文件引用](zh-tw/file-imports.md) 的特性來引用 `plotly-latest.min.js` 文件。但是，引用本地的 js 文件是推薦的，因為這樣更快。
- 接著我們創建了 `javascript` code chunk.

## Demo

下面的例子展示了如何利用 [erd](https://github.com/BurntSushi/erd) 庫繪制 ER diagram。

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

- `erd` 是我們將要用到的程序。 (_當然你得先安裝好這個程序_)
- `output="html"` 意味著代碼的輸出結果將會被視作為 `html`。
- `args` 顯示了我們將要用到的參數。

接著我們點擊 `運行`按鈕來運行我們的代碼。

![erd](https://user-images.githubusercontent.com/1908863/28221395-bcd0bd76-6888-11e7-8c6e-925e228d02cc.gif)

## 展示

**bash**
![Screen Shot 2016-09-24 at 1.41.06 AM](https://i.imgur.com/v5Y7juh.png)

**gnuplot with svg output**
![Screen Shot 2016-09-24 at 1.44.14 AM](https://i.imgur.com/S93g7Tk.png)

## 局限

- 暫時不能在 `ebook` 工作。
- `pandoc document export` 中可能會有問題。

[➔ 幻燈片制作](zh-tw/presentation.md)
