# 图像  

**Markdown Preview Enhanced** 内部支持 `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz` 图像渲染。    
你也可以通过使用 [Code Chunk](zh-cn/code-chunk.md) 来渲染 `TikZ`, `Python Matplotlib`, `Plotly` 等图像。  

## Mermaid

Markdown Preview Enhanced 使用 [mermaid](https://github.com/knsv/mermaid) 来渲染流程图和时序图。    
- `mermaid` 代码块中的内容将会渲染 [mermaid](https://github.com/knsv/mermaid) 图像。      
- 查看 [mermaid 文档](http://knsv.github.io/mermaid/#flowcharts-basic-syntax) 了解更多如果创建图形。      
![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

三个 mermaid 主题是支持的，并且你可以在 [插件设置](zh-cn/usages.md?id=package-settings) 中设置主题：
* `mermaid.css`
* `mermaid.dark.css`
* `mermaid.forest.css`  
![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

你还可以通过 `Markdown Preview Enhanced: Open Mermaid Config` 命令打开 mermaid 配置文件。


## PlantUML

Markdown Preview Enhanced 使用 [PlantUML](http://plantuml.com/) 来创建各种图形。（**Java** 是需要先被安装好的）    
- 你可以安装 [Graphviz](http://www.graphviz.org/)（非必需）来辅助生成各种各种图形。
- `puml` 或者 `plantuml` 代码块中的内容将会被 [PlantUML](http://plantuml.com/) 渲染。  

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

如果代码中 `@start...` 没有被找到，那么 `@startuml ... @enduml` 将会被自动添加。

## WaveDrom
Markdown Preview Enhanced 使用 [WaveDrom](http://wavedrom.com/) 来渲染 digital timing diagram.  
- `wavedrom` 代码块中的内容将会被 [WaveDrom](https://github.com/drom/wavedrom) 渲染。

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

## GraphViz  
Markdown Preview Enhanced 使用 [Viz.js](https://github.com/mdaines/viz.js) 来渲染 [dot 语言](https://tinyurl.com/kjoouup) 图形。  
- `viz` 或者 `dot` 代码块中的内容将会被 [Viz.js](https://github.com/mdaines/viz.js) 渲染。  
- 在第一行中添加 `engine:[engine_name]`来设置不同的渲染引擎。例如 `engine:dot`。 引擎 `circo`，`dot`，`neato`，`osage`，或者 `twopi` 是被支持的。默认下，使用 `dot` 引擎。

![screen shot 2017-06-05 at 8 08 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809493/d1dd166e-4a2a-11e7-84ff-fdb51c0b332e.png)

---  

如果你只是想要显示代码块而不想画图，则只要在后面添加 `{.code-block}` 即可：     

    ```mermaid {.code-block}
    // 你的 mermaid 代码
    ```

[➔ TOC](zh-cn/toc.md)
