# Graphs  

**Markdown Preview Enhanced** supports rendering `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz` graphs.    
You can also render `TikZ`, `Python Matplotlib`, `Plotly` and all sorts of other graphs by using [Code Chunk](code-chunk.md).  

## Mermaid

Markdown Preview Enhanced uses [mermaid](https://github.com/knsv/mermaid) to render flowchart and sequence diagram.    
- code block with `mermaid` notation will be rendered by [mermaid](https://github.com/knsv/mermaid).    
- check [mermaid doc](http://knsv.github.io/mermaid/#flowcharts-basic-syntax) for more information about how to create flowchart and sequence diagram    
![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

Three mermaid themes are provided, and you can choose theme from [package settings](usages.md?id=package-settings):  
* `mermaid.css`
* `mermaid.dark.css`
* `mermaid.forest.css`  
![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

You can also edit the mermaid init config by running `Markdown Preview Enhanced: Open Mermaid Config` command.  


## PlantUML

Markdown Preview Enhanced uses [PlantUML](http://plantuml.com/) to create multiple kinds of graph. (**Java** is required to be installed)    
- You can install [Graphviz](http://www.graphviz.org/) (not required) to generate all diagram types.  
- Code block with `puml` or `plantuml` notation will be rendered by [PlantUML](http://plantuml.com/).  

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

If `@start...` is not found, then `@startuml ... @enduml` will automatically be inserted.  

## WaveDrom
Markdown Preview Enhanced uses [WaveDrom](http://wavedrom.com/) to create digital timing diagram.  
- Code block with `wavedrom` notation will be rendered by [WaveDrom](https://github.com/drom/wavedrom).

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

## GraphViz  
Markdown Preview Enhanced uses [Viz.js](https://github.com/mdaines/viz.js) to render [dot language](https://tinyurl.com/kjoouup) graph.  
- Code block with `viz` or `dot` notation will be rendered by [Viz.js](https://github.com/mdaines/viz.js).  
- Add `engine:[engine_name]` at the first line of code block to choose different render engine. For example `engine:dot`. Engine `circo`, `dot`, `neato`, `osage`, or `twopi` are supported. Default engine is `dot`.

![screen shot 2017-06-05 at 8 08 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809493/d1dd166e-4a2a-11e7-84ff-fdb51c0b332e.png)

---  

If you don't want to render graphs but only display code block, then you can add `{.code-block}` like blow:       

    ```mermaid {.code-block}
    // your mermaid code here
    ```

[➔ TOC](toc.md)
