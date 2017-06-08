![code-chunk](http://i.imgur.com/MAtC3SD.gif)

# Code Chunk
**未來可能會有變動**  
如果你想要啟動 code chunk 語法高亮，請安裝 [language-gfm-enhanced](https://atom.io/packages/language-gfm-enhanced) 插件然後禁掉 `language-gfm` 插件。  

**Markdown Preview Enhanced** 支持渲染代碼的運行結果。       

    ```{bash}
    ls .
    ```

    ```{javascript cmd:"node"}
    var date = Date.now()
    console.log(date.toString())
    ```   

## 命令 & 快捷鍵
* `Markdown Preview Enhanced: Run Code Chunk` 或者 <kbd>shift-enter</kbd>      
運行你現在光標所在的一個 code chunk。  
* `Markdown Preview Enhanced: Run All Code Chunks` 或者 <kbd>ctrl-shift-enter</kbd>   
運行所有的 code chunks。  

## 格式  
你可以通過以下形式來設置 code chunk ：  
`{lang  opt1:value1, opt2:value2, ...}`    

**lang**  
你想要代碼所高亮的語言。
這個是要被放在最前面的。    

## 基本設置  
**cmd**  
將要被運行的命令。    
如果 `cmd` 沒有被提供，那麼 `lang` 將會被視作為命令。  

例如：  

		```{python cmd:"/usr/local/bin/python3"}
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
如果 `stdin` 被設置為 true，那麼代碼將會被傳遞到 stdin 而不是作為文件。  

**hide**  
`hide` 將會隱藏代碼塊但是會顯示運行結果，默認為 `false`。    
例如：

    ```{python hide:true}
    print('你將會看到這條輸出的文字，但是你不會看到這段代碼')
    ```

**continue**  
如果設置 `continue: true`，那麼這個 code chunk 將會繼續運行上一個 code chunk 的內容。  
如果設置`continue: id`，那麼這個 code chunk 從擁有這個 id 的 code chunk 運行。    
例如：  

	```{python id:"izdlk700"}
	x = 1
	```

	```{python id:"izdlkdim"}
	x = 2
	```

	```{python continue:"izdlk700", id:"izdlkhso"}
	print(x) # 將會打印出 1
	```

**class**  
如果設置 `class:"class1 class2"`，那麼 `class1 class2` 將會被添加到 code chunk。    
* `lineNo` class 將會添加代碼行數到 code chunk。  

**element**  
你想要添加的元素。   
請查看下面的 **Plotly** 例子。  

**id**  
`id` 將會被自動生成用來標記運行結果。     
請 **不要** 修改它。如果你就是管不住手修改了它，請確保他在你的 markdown 文件中是獨特唯一的。  

## 宏
* **input_file**  
`input_file` 將會拷貝你的 code chunk 中的代碼，然後在你的 markdown 文件的目錄下生成一個臨時文件，並且會在 code chunk 運行結束後被自動刪除。  
默認條件下，它被作為程序運行的最後一個參數。  
但是，如果你想要改變 `input_file` 在你的 `args` 中的位置，你可以使用 `{input_file}` 宏。例如：  


    ```{program args:["-i", "{input_file}", "-o", "./output.png"], id:"chj3kxsvao"}
    ...your code here
    ```


## Matplotlib  
如果設置 `matplotlib: true`，那麼你的 python code chunk 將會在你的預覽中繪制圖像。      
例如：  

	```{python matplotlib:true, id:"izbp0zt9"}
	import matplotlib.pyplot as plt
	plt.plot([1,2,3, 4])
	plt.show() # show figure
	```
![screen shot 2017-06-05 at 9 21 25 pm](https://cloud.githubusercontent.com/assets/1908863/26811044/f39404d4-4a34-11e7-8be2-0e20c0e9b00e.png)

## LaTeX
Markdown Preview Enhanced 也支持 `LaTeX` 編譯。  
在使用這個特性之前，你需要先安裝好 [pdf2svg](zh-tw/extra.md?id=install-svg2pdf) 以及 [LaTeX engine](zh-tw/extra.md?id=install-latex-distribution)。  
然後你就可以很簡單的利用 code chunk 編寫 LaTeX 了：


    ```{latex}
    \documentclass{standalone}
    \begin{document}
       Hello world!
    \end{document}
    ```

![screen shot 2017-06-05 at 9 41 05 pm](https://cloud.githubusercontent.com/assets/1908863/26811469/b234c584-4a37-11e7-977c-73f7a3e07bd7.png)


### LaTeX 輸出設置    
**latex_zoom**  
如果設置了 `latex_zoom:num`，那麼輸出結果將會被縮放 `num` 倍。  

**latex_width**  
輸出結果的寬度。  

**latex_height**  
輸出結果的高度。  

**latex_engine**   
就會被用來編譯 `tex` 文件的 latex 引擎。默認下 `pdflatex` 是被使用的。你可以在 [插件設置](zh-tw/usages.md?id=package-settings) 中改變它的默認值。    


### TikZ 例子  
推薦使用 `standalone` 繪制 `tikz` 圖形。    
![screen shot 2017-06-05 at 9 48 10 pm](https://cloud.githubusercontent.com/assets/1908863/26811633/b018aa76-4a38-11e7-9ec2-688f273468bb.png)

## Plotly
Markdown Preview Enhanced 支持你輕松的繪制 [Plotly](https://plot.ly/) 圖形。
例如：  
![screen shot 2017-06-06 at 3 27 28 pm](https://user-images.githubusercontent.com/1908863/26850341-c6095a94-4acc-11e7-83b4-7fdb4eb8b1d8.png)

* 第一行中的 `@import "https://cdn.plot.ly/plotly-latest.min.js" ` 使用了 [文件引用](zh-tw/file-imports.md) 的特性來引用 `plotly-latest.min.js` 文件。但是，引用本地的 js 文件是推薦的，因為這樣更快。  
* 接著我們創建了 `javascript` code chunk.

## Demo  
下面的例子展示了如何利用 [erd](https://github.com/BurntSushi/erd) 庫繪制 ER diagram。     

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
* `erd` 是我們將要用到的程序。 (*當然你得先安裝好這個程序*)  
* `output:"html"` 意味著代碼的輸出結果將會被視作為 `html`。  
* `args` 顯示了我們將要用到的參數。    
* `id` 是自動生成的，你不用管它。    

接著我們點擊 `運行`按鈕來運行我們的代碼。  

![code_chunk](http://i.imgur.com/a7LkJYD.gif)

## 展示  
**bash**  
![Screen Shot 2016-09-24 at 1.41.06 AM](http://i.imgur.com/v5Y7juh.png)

**gnuplot with svg output**    
![Screen Shot 2016-09-24 at 1.44.14 AM](http://i.imgur.com/S93g7Tk.png)

## 局限
* 暫時不能在 `ebook` 工作。  
* `pandoc document export` 中可能會有問題。  


[➔ 幻燈片制作](zh-tw/presentation.md)