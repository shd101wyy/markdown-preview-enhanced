# 導入外部文件  

![doc-imports](https://cloud.githubusercontent.com/assets/1908863/22716507/f352a4b6-ed5b-11e6-9bac-88837f111de0.gif)

## 咋使呢？  
僅僅  
  ```markdown
  @import "你的文件"  
  ```
就可以了，很簡單對吧～ <code>d(\`･∀･)b</code>

## 刷新按鈕
刷新按鈕可以在你的預覽右上角找到。  
點擊它將會清空文件緩存並且刷新預覽。  
這個功能將會十分有用如果你想要清除圖片緩存 [#144](https://github.com/shd101wyy/markdown-preview-enhanced/issues/144) [#249](https://github.com/shd101wyy/markdown-preview-enhanced/issues/249)。      

![screen shot 2017-02-07 at 5 48 52 pm](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## 支持的文件類型
* `.jpeg(.jpg), .gif, .png, .apng, .svg, .bmp` 文件將會直接被當作 markdown 圖片被引用。  
* `.csv` 文件將會被轉換成 markdown 表格。
* `.mermaid` 將會被 mermaid 渲染。  
* `.dot` 文件將會被 viz.js (graphviz) 渲染。  
* `.plantuml(.puml)` 文件將會被 PlantUML 渲染。
* `.wavedrom` 文件將會被 wavedrom 渲染。  
* `.html` 將會直接被引入。  
* `.js` 將會在 `window` 范圍內被執行。它的作用類似於 `<script>.. js 代碼 ..</script>`。
* `.less` 和 `.css` 將會被引用為 style。目前 `less` 只支持本地文件。
* `.pdf` 文件將會被 `pdf2svg` 轉換為 `svg` 然後被引用。
* `markdown` 將會被分析處理然後被引用。
* 其他所有的文件都將被視為代碼塊。    

## 設置圖片
```markdown  
@import "test.png" {width:"300px", height:"200px", title:"圖片的標題", alt:"我的 alt"}
```

## 引用在線文件
例如：
```markdown
@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"
```

## 引用 PDF 文件
如果你要引用 PDF 文件，你需要事先安裝好 [pdf2svg](zh-tw/extra.md)。    
Markdown Preview Enhanced 支持引用本地或者在線的 PDF 文件。  
但是，引用大的 PDF 文件是不推薦的。  

例如：
```markdown
@import "test.pdf"
```

### PDF 設置
* **page_no**  
顯示第 `nth` 頁。例如 `{page_no:1}` 將會只顯示 PDF 文件的第 1 頁。
* **page_begin**, **page_end**  
包含的。例如 `{page_begin:2, page_end:4}` 將會顯示第 2，3，4 頁。

## 強制渲染為代碼塊  
```markdown
@import "test.puml" {code_block:true, class:"lineNo"}
@import "test.py" {class:"lineNo"}
```

## 引用文件作為 Code Chunk  
```markdown
@import "test.py" {code_chunk:true, cmd:"python3"}
```

## 已知問題
* 引用文件可能會影響滑動同步。
* code chunk 可能會有問題。

[➔ Code Chunk](zh-tw/code-chunk.md)

