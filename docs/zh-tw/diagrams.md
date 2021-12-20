# 圖像

**Markdown Preview Enhanced** 內部支持 `flow charts`, `sequence diagrams`, `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz`，`Vega & Vega-lite`，`Ditaa` 圖像渲染。
你也可以通過使用 [Code Chunk](zh-tw/code-chunk.md) 來渲染 `TikZ`, `Python Matplotlib`, `Plotly` 等圖像。

> Please note that some diagrams doesn't work well with file export like PDF, pandoc, etc.

## Flow Charts

這一特性基於 [flowchart.js](https://flowchart.js.org/)。

- `flow` 代碼快中的內容將會被 [flowchart.js](https://flowchart.js.org/) 渲染。

![screenshot from 2017-11-25 21-43-02](https://user-images.githubusercontent.com/1908863/33236942-aa809c1c-d229-11e7-9c4b-9a680fd852ed.png)

## Sequence Diagrams

這一特性基於 [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/)。

- `sequence` 代碼快中的內容將會被 [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/) 渲染。
- 支持兩個主題 `simple`（默認主題）和 `hand`。

![screenshot from 2017-11-25 21-47-41](https://user-images.githubusercontent.com/1908863/33236972-4f190f98-d22a-11e7-842f-d9c4a74d2118.png)

## Mermaid

Markdown Preview Enhanced 使用 [mermaid](https://github.com/knsv/mermaid) 來渲染流程圖和時序圖。

- `mermaid` 代碼塊中的內容將會渲染 [mermaid](https://github.com/knsv/mermaid) 圖像。
- 查看 [mermaid 文檔](https://mermaid-js.github.io/mermaid) 了解更多如果創建圖形。
  ![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

三個 mermaid 主題是支持的，並且你可以在 [插件設置](zh-tw/usages.md?id=package-settings) 中設置主題：

- `mermaid.css`
- `mermaid.dark.css`
- `mermaid.forest.css`
  ![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

你還可以通過 `Markdown Preview Enhanced: Open Mermaid Config` 命令打開 mermaid 配置文件。

## PlantUML

Markdown Preview Enhanced 使用 [PlantUML](https://plantuml.com/) 來創建各種圖形。（**Java** 是需要先被安裝好的）

- 你可以安裝 [Graphviz](https://www.graphviz.org/)（非必需）來輔助生成各種各種圖形。
- `puml` 或者 `plantuml` 代碼塊中的內容將會被 [PlantUML](https://plantuml.com/) 渲染。

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

如果代碼中 `@start...` 沒有被找到，那麼 `@startuml ... @enduml` 將會被自動添加。

## WaveDrom

Markdown Preview Enhanced 使用 [WaveDrom](https://wavedrom.com/) 來渲染 digital timing diagram.

- `wavedrom` 代碼塊中的內容將會被 [WaveDrom](https://github.com/drom/wavedrom) 渲染。

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

## GraphViz

Markdown Preview Enhanced 使用 [Viz.js](https://github.com/mdaines/viz.js) 來渲染 [dot 語言](https://tinyurl.com/kjoouup) 圖形。

- `viz` 或者 `dot` 代碼塊中的內容將會被 [Viz.js](https://github.com/mdaines/viz.js) 渲染。
- 你可以通過 `{engine="..."}` 來選擇不同的渲染引擎。 引擎 `circo`，`dot`，`neato`，`osage`，或者 `twopi` 是被支持的。默認下，使用 `dot` 引擎。

![screen shot 2018-03-18 at 3 18 17 pm](https://user-images.githubusercontent.com/1908863/37570596-a565306e-2abf-11e8-8904-d73306f675ec.png)

## Vega 和 Vega-lite

Markdown Preview Enhanced 支持 [vega](https://vega.github.io/vega/) 以及 [vega-lite](https://vega.github.io/vega-lite/) 的**靜態**圖像。

- `vega` 代碼塊中的內容將會被 [vega](https://vega.github.io/vega/) 渲染。
- `vega-lite` 代碼塊中的內容將會被 [vega-lite](https://vega.github.io/vega-lite/) 渲染。
- `JSON` 以及 `YAML` 的輸入是支持的。

![screen shot 2017-07-28 at 7 59 58 am](https://user-images.githubusercontent.com/1908863/28718265-d023e1c2-736a-11e7-8678-a29704f3a23c.png)

你也可以 [@import](zh-tw/file-imports.md) 一個 `JSON` 或者 `YAML` 文件作為 `vega` 圖像，例如：

```markdown
@import "your_vega_source.json" {as="vega"}
@import "your_vega_lite_source.json" {as="vega-lite"}
```

## Ditaa

Markdown Preview Enhanced 支持 [ditaa](https://github.com/stathissideris/ditaa)。

(**Java** 是需要先被安裝好的)

`ditaa` 整合於 [code chunk](zh-tw/code-chunk.md), for example:

<pre>
  ```ditaa {cmd=true args=["-E"]}
  +--------+   +-------+    +-------+
  |        | --+ ditaa +--> |       |
  |  Text  |   +-------+    |diagram|
  |Document|   |!magic!|    |       |
  |     {d}|   |       |    |       |
  +---+----+   +-------+    +-------+
      :                         ^
      |       Lots of work      |
      +-------------------------+
  ```
</pre>

> <kbd>shift-enter</kbd> 來運行 code chunk。
> 設置 `{hide=true}` 來隱藏代碼塊。
> 設置 `{run_on_save=true}` 啟動當文件保存時，渲染 ditaa 圖像。

![screen shot 2017-07-28 at 8 11 15 am](https://user-images.githubusercontent.com/1908863/28718626-633fa18e-736c-11e7-8a4a-915858dafff6.png)

---

如果你只是想要顯示代碼塊而不想畫圖，則只要在後面添加 `{code_block=true}` 即可：

    ```mermaid {code_block=true}
    // 你的 mermaid 代碼
    ```

---

你可以為圖像的容器添加屬性。
例如：

    ```puml {align="center"}
    a->b
    ```

將會把 puml 的圖像放在中間。

---

當你保存你的 markdown 文件到 [GFM Markdown](zh-tw/markdown.md) 時， 所有圖像將會被保存為 png 文件到 `imageFolderPath` 文件夾。
你可以設置導出文件的文件名 `{filename="圖片.png"}`。

例如：

    ```mermaid {filename="我的 mermaid.png"}
    ...
    ```

[➔ TOC](zh-tw/toc.md)
