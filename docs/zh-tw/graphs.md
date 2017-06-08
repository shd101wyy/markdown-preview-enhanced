# 圖像  

**Markdown Preview Enhanced** 內部支持 `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz` 圖像渲染。    
你也可以通過使用 [Code Chunk](zh-tw/code-chunk.md) 來渲染 `TikZ`, `Python Matplotlib`, `Plotly` 等圖像。  

## Mermaid

Markdown Preview Enhanced 使用 [mermaid](https://github.com/knsv/mermaid) 來渲染流程圖和時序圖。    
- `mermaid` 代碼塊中的內容將會渲染 [mermaid](https://github.com/knsv/mermaid) 圖像。      
- 查看 [mermaid 文檔](http://knsv.github.io/mermaid/#flowcharts-basic-syntax) 了解更多如果創建圖形。      
![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

三個 mermaid 主題是支持的，並且你可以在 [插件設置](zh-tw/usages.md?id=package-settings) 中設置主題：
* `mermaid.css`
* `mermaid.dark.css`
* `mermaid.forest.css`  
![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

你還可以通過 `Markdown Preview Enhanced: Open Mermaid Config` 命令打開 mermaid 配置文件。


## PlantUML

Markdown Preview Enhanced 使用 [PlantUML](http://plantuml.com/) 來創建各種圖形。（**Java** 是需要先被安裝好的）    
- 你可以安裝 [Graphviz](http://www.graphviz.org/)（非必需）來輔助生成各種各種圖形。
- `puml` 或者 `plantuml` 代碼塊中的內容將會被 [PlantUML](http://plantuml.com/) 渲染。  

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

如果代碼中 `@start...` 沒有被找到，那麼 `@startuml ... @enduml` 將會被自動添加。

## WaveDrom
Markdown Preview Enhanced 使用 [WaveDrom](http://wavedrom.com/) 來渲染 digital timing diagram.  
- `wavedrom` 代碼塊中的內容將會被 [WaveDrom](https://github.com/drom/wavedrom) 渲染。

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

## GraphViz  
Markdown Preview Enhanced 使用 [Viz.js](https://github.com/mdaines/viz.js) 來渲染 [dot 語言](https://tinyurl.com/kjoouup) 圖形。  
- `viz` 或者 `dot` 代碼塊中的內容將會被 [Viz.js](https://github.com/mdaines/viz.js) 渲染。  
- 在第一行中添加 `engine:[engine_name]`來設置不同的渲染引擎。例如 `engine:dot`。 引擎 `circo`，`dot`，`neato`，`osage`，或者 `twopi` 是被支持的。默認下，使用 `dot` 引擎。

![screen shot 2017-06-05 at 8 08 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809493/d1dd166e-4a2a-11e7-84ff-fdb51c0b332e.png)

---  

如果你只是想要顯示代碼塊而不想畫圖，則只要在後面添加 `{.code-block}` 即可：     

    ```mermaid {.code-block}
    // 你的 mermaid 代碼
    ```

[➔ TOC](zh-tw/toc.md)
