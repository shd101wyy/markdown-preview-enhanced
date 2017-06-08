# 导入外部文件  

![doc-imports](https://cloud.githubusercontent.com/assets/1908863/22716507/f352a4b6-ed5b-11e6-9bac-88837f111de0.gif)

## 咋使呢？  
仅仅  
  ```markdown
  @import "你的文件"  
  ```
就可以了，很简单对吧～ <code>d(\`･∀･)b</code>

## 刷新按钮
刷新按钮可以在你的预览右上角找到。  
点击它将会清空文件缓存并且刷新预览。  
这个功能将会十分有用如果你想要清除图片缓存 [#144](https://github.com/shd101wyy/markdown-preview-enhanced/issues/144) [#249](https://github.com/shd101wyy/markdown-preview-enhanced/issues/249)。      

![screen shot 2017-02-07 at 5 48 52 pm](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## 支持的文件类型
* `.jpeg(.jpg), .gif, .png, .apng, .svg, .bmp` 文件将会直接被当作 markdown 图片被引用。  
* `.csv` 文件将会被转换成 markdown 表格。
* `.mermaid` 将会被 mermaid 渲染。  
* `.dot` 文件将会被 viz.js (graphviz) 渲染。  
* `.plantuml(.puml)` 文件将会被 PlantUML 渲染。
* `.wavedrom` 文件将会被 wavedrom 渲染。  
* `.html` 将会直接被引入。  
* `.js` 将会在 `window` 范围内被执行。它的作用类似于 `<script>.. js 代码 ..</script>`。
* `.less` 和 `.css` 将会被引用为 style。目前 `less` 只支持本地文件。
* `.pdf` 文件将会被 `pdf2svg` 转换为 `svg` 然后被引用。
* `markdown` 将会被分析处理然后被引用。
* 其他所有的文件都将被视为代码块。    

## 设置图片
```markdown  
@import "test.png" {width:"300px", height:"200px", title:"图片的标题", alt:"我的 alt"}
```

## 引用在线文件
例如：
```markdown
@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"
```

## 引用 PDF 文件
如果你要引用 PDF 文件，你需要事先安装好 [pdf2svg](zh-cn/extra.md)。    
Markdown Preview Enhanced 支持引用本地或者在线的 PDF 文件。  
但是，引用大的 PDF 文件是不推荐的。  

例如：
```markdown
@import "test.pdf"
```

### PDF 设置
* **page_no**  
显示第 `nth` 页。例如 `{page_no:1}` 将会只显示 PDF 文件的第 1 页。
* **page_begin**, **page_end**  
包含的。例如 `{page_begin:2, page_end:4}` 将会显示第 2，3，4 页。

## 强制渲染为代码块  
```markdown
@import "test.puml" {code_block:true, class:"lineNo"}
@import "test.py" {class:"lineNo"}
```

## 引用文件作为 Code Chunk  
```markdown
@import "test.py" {code_chunk:true, cmd:"python3"}
```

## 已知问题
* 引用文件可能会影响滑动同步。
* code chunk 可能会有问题。

[➔ Code Chunk](zh-cn/code-chunk.md)

