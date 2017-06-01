# Import external files.  

![doc-imports](https://cloud.githubusercontent.com/assets/1908863/22716507/f352a4b6-ed5b-11e6-9bac-88837f111de0.gif)

## How to use?  
just  
  ```markdown
  @import "your_file"  
  ```
easy, right :)

## Refresh button  
Refresh button is now added at the right corner of preview.  
Clicking it will clear file caches and refresh the preview.  
It could be useful if you want to clear image cache. [#144](https://github.com/shd101wyy/markdown-preview-enhanced/issues/144) [#249](https://github.com/shd101wyy/markdown-preview-enhanced/issues/249)      

![screen shot 2017-02-07 at 5 48 52 pm](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Supported file types
* `.jpeg(.jpg), .gif, .png, .apng, .svg, .bmp` file will be treated as markdown image.  
* `.csv` file will be converted to markdown table.  
* `.mermaid` file will be rendered by mermaid.  
* `.dot` file will be rendered by viz.js (graphviz).  
* `.plantuml(.puml)` file will be rendered by plantuml.  
* `.wavedrom` file will be rendered by wavedrom.  
* `.html` file will be embeded directly.  
* `.less` and `.css` file will be included as style.
* `markdown` file will be parsed and embeded directly.     
* All other files will be rendered as code block.    

## Configure images  
  ```markdown  
  @import "test.png" {width:"300px", height:"200px", title:"my title", alt:"my alt"}
  ```

## Import online files
For example:  
  ```markdown
  @import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"
  ```

## Force to render Code Block  
  ```markdown
  @import "test.puml" {code_block:true, class:"lineNo"}
  @import "test.py" {class:"lineNo"}
  ```

## Import file as Code Chunk  
  ```markdown
  @import "test.py" {code_chunk:true, cmd: "python3", id: "you_have_to_declare_id_here"}
  ```

## Known issues  
* importing other docs might break scroll sync functionality.  
* code chunk might be buggy.  