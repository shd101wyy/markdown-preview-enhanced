# Diagrams

**Markdown Preview Enhanced** supports rendering `flow charts`, `sequence diagrams`, `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz`, `Vega & Vega-lite`, `Ditaa` diagrams.
You can also render `TikZ`, `Python Matplotlib`, `Plotly` and all sorts of other graphs and diagrams by using [Code Chunk](code-chunk.md).

> Please note that some diagrams don't work well with file exports such as PDF, pandoc, etc.

## Flow Charts

This feature is powered by [flowchart.js](https://flowchart.js.org/).

- code block with `flow` notation will be rendered by [flowchart.js](https://flowchart.js.org/).

![screenshot from 2017-11-25 21-43-02](https://user-images.githubusercontent.com/1908863/33236942-aa809c1c-d229-11e7-9c4b-9a680fd852ed.png)

## Sequence Diagrams

This feature is powered by [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/).

- code block with `sequence` notation will be rendered by [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/).
- Two themes are supported: `simple`(default theme) and `hand`.

![screenshot from 2017-11-25 21-47-41](https://user-images.githubusercontent.com/1908863/33236972-4f190f98-d22a-11e7-842f-d9c4a74d2118.png)

## Mermaid

Markdown Preview Enhanced uses [mermaid](https://github.com/knsv/mermaid) to render flow charts and sequence diagram.

- code block with `mermaid` notation will be rendered by [mermaid](https://github.com/knsv/mermaid).
- check [mermaid doc](https://mermaid-js.github.io/mermaid) for more information about how to create flowchart and sequence diagram
  ![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

Three mermaid themes are provided, and you can choose theme from [package settings](usages.md?id=package-settings):

- `mermaid.css`
- `mermaid.dark.css`
- `mermaid.forest.css`
  ![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

You can also edit the mermaid init config by running `Markdown Preview Enhanced: Open Mermaid Config` command.

## PlantUML

Markdown Preview Enhanced uses [PlantUML](https://plantuml.com/) to create multiple kinds of graph. (**Java** is required to be installed)

- You can install [Graphviz](https://www.graphviz.org/) (not required) to generate all diagram types.
- Code block with `puml` or `plantuml` notation will be rendered by [PlantUML](https://plantuml.com/).

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

If `@start...` is not found, then `@startuml ... @enduml` will automatically be inserted.

## WaveDrom

Markdown Preview Enhanced uses [WaveDrom](https://wavedrom.com/) to create digital timing diagram.

- Code block with `wavedrom` notation will be rendered by [WaveDrom](https://github.com/drom/wavedrom).

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

## GraphViz

Markdown Preview Enhanced uses [Viz.js](https://github.com/mdaines/viz.js) to render [dot language](https://tinyurl.com/kjoouup) diagram.

- Code block with `viz` or `dot` notation will be rendered by [Viz.js](https://github.com/mdaines/viz.js).
- You can choose different engines by specifying `{engine="..."}`. Engine `circo`, `dot`, `neato`, `osage`, or `twopi` are supported. Default engine is `dot`.

![screen shot 2018-03-18 at 3 18 17 pm](https://user-images.githubusercontent.com/1908863/37570596-a565306e-2abf-11e8-8904-d73306f675ec.png)

## Vega and Vega-lite

Markdown Preview Enhanced supports [vega](https://vega.github.io/vega/) and [vega-lite](https://vega.github.io/vega-lite/) **static** diagrams.

- Code block with `vega` notation will be rendered by [vega](https://vega.github.io/vega/).
- Code block with `vega-lite` notation will be rendered by [vega-lite](https://vega.github.io/vega-lite/).
- Both `JSON` and `YAML` inputs are supported.

![screen shot 2017-07-28 at 7 59 58 am](https://user-images.githubusercontent.com/1908863/28718265-d023e1c2-736a-11e7-8678-a29704f3a23c.png)

You can also [@import](file-imports.md) a `JSON` or `YAML` file as `vega` diagram, for example:

```markdown
@import "your_vega_source.json" {as="vega"}
@import "your_vega_lite_source.json" {as="vega-lite"}
```

## Ditaa

Markdown Preview Enhanced supports [ditaa](https://github.com/stathissideris/ditaa) that can convert diagrams drawn using ascii art ('drawings' that contain characters that resemble lines like | / - ), into proper bitmap graphics.

(**Java** is required to be installed)

`ditaa` is integrated with [code chunk](code-chunk.md), for example:

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

> <kbd>shift-enter</kbd> to run code chunk.
> set `{hide=true}` to hide code block.
> set `{run_on_save=true}` to render ditaa when you save the markdown file.

![screen shot 2017-07-28 at 8 11 15 am](https://user-images.githubusercontent.com/1908863/28718626-633fa18e-736c-11e7-8a4a-915858dafff6.png)

---

If you don't want to render graphs but only display code block, then you can add `{code_block=true}` like below:

    ```mermaid {code_block=true}
    // your mermaid code here
    ```

---

You can set attributes for the container of the diagram.
For example:

    ```puml {align="center"}
    a->b
    ```

will put the puml diagram at the center of preview.

---

When you export your markdown file to [GFM Markdown](markdown.md), the diagrams will be saved as png images to your `imageFolderPath` defined in package settings.
You can control the exported image filename by declaring `{filename="your_file_name.png"}`.

For example:

    ```mermaid {filename="my_mermaid.png"}
    ...
    ```

[➔ TOC](toc.md)
