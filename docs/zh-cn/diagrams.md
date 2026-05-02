# 图像

**Markdown Preview Enhanced** 内部支持 `flow charts`, `sequence diagrams`, `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz`，`Vega & Vega-lite`，`Ditaa` 图像渲染。
你也可以通过使用 [Code Chunk](zh-cn/code-chunk.md) 来渲染 `TikZ`, `Python Matplotlib`, `Plotly` 等图像。

> Please note that some diagrams doesn't work well with file export like PDF, pandoc, etc.

## Mermaid

Markdown Preview Enhanced 使用 [mermaid](https://github.com/knsv/mermaid) 来渲染流程图和时序图。

- `mermaid` 代码块中的内容将会渲染 [mermaid](https://github.com/knsv/mermaid) 图像。
- 查看 [mermaid 文档](https://mermaid-js.github.io/mermaid) 了解更多如果创建图形。
  ![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

三个 mermaid 主题是支持的，并且你可以在 [插件设置](zh-cn/usages.md?id=package-settings) 中设置主题：

- `mermaid.css`
- `mermaid.dark.css`
- `mermaid.forest.css`
  ![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

你还可以通过 `Markdown Preview Enhanced: Open Mermaid Config` 命令打开 mermaid 配置文件。

此外，您可以在 head.html 中注册图标标志（通过 Markdown Preview Enhanced: Customize Preview Html Head 命令打开），如下所示：

```html
<script type="text/javascript">
  const configureMermaidIconPacks = () => {
    window["mermaid"].registerIconPacks([
      {
        name: "logos",
        loader: () =>
          fetch("https://unpkg.com/@iconify-json/logos/icons.json").then(
            (res) => res.json()
          ),
      },
    ]);
  };

  if (document.readyState !== 'loading') {
    configureMermaidIconPacks();
  } else {
    document.addEventListener("DOMContentLoaded", () => {
      configureMermaidIconPacks();
    });
  }
</script>
```

## PlantUML

Markdown Preview Enhanced 使用 [PlantUML](https://plantuml.com/) 来创建各种图形。（**Java** 是需要先被安装好的）

- 你可以安装 [Graphviz](https://www.graphviz.org/)（非必需）来辅助生成各种各种图形。
- `puml` 或者 `plantuml` 代码块中的内容将会被 [PlantUML](https://plantuml.com/) 渲染。

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

如果代码中 `@start...` 没有被找到，那么 `@startuml ... @enduml` 将会被自动添加。

## WaveDrom

Markdown Preview Enhanced 使用 [WaveDrom](https://wavedrom.com/) 来渲染 digital timing diagram.

- `wavedrom` 代码块中的内容将会被 [WaveDrom](https://github.com/drom/wavedrom) 渲染。

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

支持[Bitfield](https://github.com/wavedrom/bitfield)图表。请使用`bitfield`作为语言标识符。

## GraphViz

Markdown Preview Enhanced 使用 [Viz.js](https://github.com/mdaines/viz.js) 来渲染 [dot 语言](https://tinyurl.com/kjoouup) 图形。

- `viz` 或者 `dot` 代码块中的内容将会被 [Viz.js](https://github.com/mdaines/viz.js) 渲染。
- 你可以通过 `{engine="..."}` 来选择不同的渲染引擎。 引擎 `circo`，`dot`，`neato`，`osage`，或者 `twopi` 是被支持的。默认下，使用 `dot` 引擎。

![screen shot 2018-03-18 at 3 18 17 pm](https://user-images.githubusercontent.com/1908863/37570596-a565306e-2abf-11e8-8904-d73306f675ec.png)

## D2

Markdown Preview Enhanced 使用 [D2](https://d2lang.com/) 来渲染图表。D2 是一种声明式图表语言，可以将文本转换为图表。

- [D2](https://d2lang.com/) 必须已安装并位于您的 `PATH` 环境变量中（或通过设置中的 `d2Path` 配置）。
- `d2` 代码块中的内容将会被 [D2](https://d2lang.com/) 渲染。
- 查看 [D2 文档](https://d2lang.com/tour/intro/) 了解完整的语法参考。

您可以为每个代码块覆盖布局引擎、主题和草图样式：
![d2-test](https://github.com/user-attachments/assets/809cc0e7-e7a0-4637-9a4d-3992edab725d)

| 属性       | 描述                                                    | 默认值    |
| --------- | ------------------------------------------------------------------ | ------- |
| `layout`  | 布局引擎：`dagre`、`elk`、`tala`                                       | `dagre` |
| `theme`   | 主题 ID 编号（参见 [D2 主题](https://d2lang.com/tour/themes/)）         | `0`     |
| `sketch`  | 以手绘/草图风格渲染                                                  | `false` |

全局默认值可以在[插件设置](zh-cn/usages.md?id=package-settings)中配置：

| 设置        | 描述                      | 默认值   |
| ---------- | --------------------------- | ------- |
| `d2Path`   | `d2` 可执行文件的路径          | `d2`    |
| `d2Layout` | 默认布局引擎                | `dagre` |
| `d2Theme`  | 默认主题 ID                 | `0`     |
| `d2Sketch` | 默认草图模式                 | `false` |

> **注意：** D2 渲染需要在您的机器上安装 `d2` CLI。如果未找到，代码块将显示为纯文本。请参阅 [D2 安装指南](https://d2lang.com/tour/install/) 了解安装说明。

## TikZ

Markdown Preview Enhanced 支持通过 `tikz` 围栏代码块渲染 [TikZ](https://tikz.dev/) 图表。

- 在 Node.js（桌面版 VS Code）中：使用 [node-tikzjax](https://github.com/prinsss/node-tikzjax) 在服务端将 TikZ 渲染为 SVG，并带有缓存。
- 在 Web（VS Code Web 扩展）和 HTML 导出中：回退到通过 [tikzjax.com](https://tikzjax.com) 进行客户端渲染。
- 如果代码中没有 `\begin{document}...\end{document}`，将自动添加。
- 自动加载基础 TeX 包：`amsmath`、`amssymb`、`amsfonts`、`amstext`、`array`。
- 自动检测并加载专用包：`tikz-cd`（用于 `\begin{tikzcd}`）、`pgfplots`（用于 `\begin{axis}`）、`circuitikz`（用于 `\begin{circuitikz}`）、`chemfig`（用于 `\chemfig`）、`tikz-3dplot`（用于 `\tdplotsetmaincoords`）。

围栏信息字符串中支持的每个代码块选项：

| 选项 | 描述 | 可接受的值 |
| ------ | ----------- | --------------- |
| `texPackages` / `tex_packages` | 额外加载的 TeX 包 | 逗号分隔列表 |
| `tikzLibraries` / `tikz_libraries` | 加载的 TikZ 库 | 逗号分隔列表 |
| `addToPreamble` / `add_to_preamble` | 添加到导言区的自定义 LaTeX 代码 | LaTeX 字符串 |
| `showConsole` / `show_console` | 显示控制台输出 | `true` / `false` |
| `embedFontCss` / `embed_font_css` | 嵌入字体 CSS | `true` / `false` |
| `fontCssUrl` / `font_css_url` | 自定义字体 CSS URL | URL 字符串 |

> **注意：** TikZ 渲染在客户端渲染（tikzjax.com）时需要网络访问。使用 node-tikzjax 的服务端渲染在初始设置后可离线工作。

## WebSequenceDiagrams

Markdown Preview Enhanced 支持通过 `wsd` 围栏代码块渲染 [WebSequenceDiagrams](https://www.websequencediagrams.com/) 图表。

- `wsd` 代码块中的内容将会被 [WebSequenceDiagrams](https://www.websequencediagrams.com/) 渲染。
- 可选的 API 密钥可以在[插件设置](zh-cn/usages.md?id=package-settings)中配置。

> **注意：** WebSequenceDiagrams 渲染需要网络访问 websequencediagrams.com。

## Vega 和 Vega-lite

Markdown Preview Enhanced 支持 [vega](https://vega.github.io/vega/) 以及 [vega-lite](https://vega.github.io/vega-lite/) 的**静态**图像。

- `vega` 代码块中的内容将会被 [vega](https://vega.github.io/vega/) 渲染。
- `vega-lite` 代码块中的内容将会被 [vega-lite](https://vega.github.io/vega-lite/) 渲染。
- `JSON` 以及 `YAML` 的输入是支持的。

![screen shot 2017-07-28 at 7 59 58 am](https://user-images.githubusercontent.com/1908863/28718265-d023e1c2-736a-11e7-8678-a29704f3a23c.png)

你也可以 [@import](zh-cn/file-imports.md) 一个 `JSON` 或者 `YAML` 文件作为 `vega` 图像，例如：

```markdown
@import "your_vega_source.json" {as="vega"}
@import "your_vega_lite_source.json" {as="vega-lite"}
```

## Kroki

Markdown Preview Enhanced 支持 [Kroki](https://kroki.io/)，它支持不同类型的图表。只需在代码块属性中设置 `kroki=true` 或 `kroki=DIAGRAM_TYPE` 即可启用它。

````markdown
```blockdiag {kroki=true}
blockdiag {
  Kroki -> generates -> "Block diagrams";
  Kroki -> is -> "very easy!";

  Kroki [color = "greenyellow"];
  "Block diagrams" [color = "pink"];
  "very easy!" [color = "orange"];
}
```

```javascript {kroki="wavedrom"}
{
  signal: [
    { name: "clk", wave: "p.....|..." },
    {
      name: "Data",
      wave: "x.345x|=.x",
      data: ["head", "body", "tail", "data"],
    },
    { name: "Request", wave: "0.1..0|1.0" },
    {},
    { name: "Acknowledge", wave: "1.....|01." },
  ]
}
```
````

---

如果你只是想要显示代码块而不想画图，则只要在后面添加 `{code_block=true}` 即可：

    ```mermaid {code_block=true}
    // 你的 mermaid 代码
    ```

---

你可以为图像的容器添加属性。
例如：

    ```puml {align="center"}
    a->b
    ```

将会把 puml 的图像放在中间。

---

当你保存你的 markdown 文件到 [GFM Markdown](zh-cn/markdown.md) 时， 所有图像将会被保存为 png 文件到 `imageFolderPath` 文件夹。
你可以设置导出文件的文件名 `{filename="图片.png"}`。

例如：

    ```mermaid {filename="我的 mermaid.png"}
    ...
    ```

[➔ TOC](zh-cn/toc.md)
