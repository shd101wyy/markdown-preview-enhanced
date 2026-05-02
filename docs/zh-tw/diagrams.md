# 圖像

**Markdown Preview Enhanced** 內部支持 `flow charts`, `sequence diagrams`, `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz`，`Vega & Vega-lite`，`Ditaa` 圖像渲染。
你也可以通過使用 [Code Chunk](zh-tw/code-chunk.md) 來渲染 `TikZ`, `Python Matplotlib`, `Plotly` 等圖像。

> Please note that some diagrams doesn't work well with file export like PDF, pandoc, etc.

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

此外，您可以在 head.html 中註冊圖標標誌（通過 Markdown Preview Enhanced: Customize Preview Html Head 命令打開），如下所示：

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

Markdown Preview Enhanced 使用 [PlantUML](https://plantuml.com/) 來創建各種圖形。（**Java** 是需要先被安裝好的）

- 你可以安裝 [Graphviz](https://www.graphviz.org/)（非必需）來輔助生成各種各種圖形。
- `puml` 或者 `plantuml` 代碼塊中的內容將會被 [PlantUML](https://plantuml.com/) 渲染。

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

如果代碼中 `@start...` 沒有被找到，那麼 `@startuml ... @enduml` 將會被自動添加。

## WaveDrom

Markdown Preview Enhanced 使用 [WaveDrom](https://wavedrom.com/) 來渲染 digital timing diagram.

- `wavedrom` 代碼塊中的內容將會被 [WaveDrom](https://github.com/drom/wavedrom) 渲染。

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

支持[Bitfield](https://github.com/wavedrom/bitfield)圖表。請使用`bitfield`作為語言識別符。

## GraphViz

Markdown Preview Enhanced 使用 [Viz.js](https://github.com/mdaines/viz.js) 來渲染 [dot 語言](https://tinyurl.com/kjoouup) 圖形。

- `viz` 或者 `dot` 代碼塊中的內容將會被 [Viz.js](https://github.com/mdaines/viz.js) 渲染。
- 你可以通過 `{engine="..."}` 來選擇不同的渲染引擎。 引擎 `circo`，`dot`，`neato`，`osage`，或者 `twopi` 是被支持的。默認下，使用 `dot` 引擎。

![screen shot 2018-03-18 at 3 18 17 pm](https://user-images.githubusercontent.com/1908863/37570596-a565306e-2abf-11e8-8904-d73306f675ec.png)

## D2

Markdown Preview Enhanced 使用 [D2](https://d2lang.com/) 來渲染圖表。D2 是一種宣告式圖表語言，可以將文字轉換為圖表。

- [D2](https://d2lang.com/) 必須已安裝並位於您的 `PATH` 環境變數中（或透過設定中的 `d2Path` 配置）。
- `d2` 程式碼區塊中的內容將會被 [D2](https://d2lang.com/) 渲染。
- 查看 [D2 文件](https://d2lang.com/tour/intro/) 了解完整的語法參考。

您可以為每個程式碼區塊覆蓋佈局引擎、主題和草圖樣式：
![d2-test](https://github.com/user-attachments/assets/809cc0e7-e7a0-4637-9a4d-3992edab725d)

| 屬性       | 描述                                                    | 預設值    |
| --------- | ------------------------------------------------------------------ | ------- |
| `layout`  | 佈局引擎：`dagre`、`elk`、`tala`                                       | `dagre` |
| `theme`   | 主題 ID 編號（參見 [D2 主題](https://d2lang.com/tour/themes/)）         | `0`     |
| `sketch`  | 以手繪/草圖風格渲染                                                  | `false` |

全域預設值可以在[插件設定](zh-tw/usages.md?id=package-settings)中配置：

| 設定        | 描述                      | 預設值   |
| ---------- | --------------------------- | ------- |
| `d2Path`   | `d2` 可執行檔案的路徑          | `d2`    |
| `d2Layout` | 預設佈局引擎                | `dagre` |
| `d2Theme`  | 預設主題 ID                 | `0`     |
| `d2Sketch` | 預設草圖模式                 | `false` |

> **注意：** D2 渲染需要在您的機器上安裝 `d2` CLI。如果未找到，程式碼區塊將顯示為純文字。請參閱 [D2 安裝指南](https://d2lang.com/tour/install/) 了解安裝說明。

## TikZ

Markdown Preview Enhanced 支援透過 `tikz` 圍欄程式碼區塊渲染 [TikZ](https://tikz.dev/) 圖表。

- 在 Node.js（桌面版 VS Code）中：使用 [node-tikzjax](https://github.com/prinsss/node-tikzjax) 在伺服端將 TikZ 渲染為 SVG，並帶有快取。
- 在 Web（VS Code Web 擴充功能）和 HTML 匯出中：回退到透過 [tikzjax.com](https://tikzjax.com) 進行客戶端渲染。
- 如果程式碼中沒有 `\begin{document}...\end{document}`，將自動新增。
- 自動載入基礎 TeX 套件：`amsmath`、`amssymb`、`amsfonts`、`amstext`、`array`。
- 自動偵測並載入專用套件：`tikz-cd`（用於 `\begin{tikzcd}`）、`pgfplots`（用於 `\begin{axis}`）、`circuitikz`（用於 `\begin{circuitikz}`）、`chemfig`（用於 `\chemfig`）、`tikz-3dplot`（用於 `\tdplotsetmaincoords`）。

圍欄資訊字串中支援的每個程式碼區塊選項：

| 選項 | 描述 | 可接受的值 |
| ------ | ----------- | --------------- |
| `texPackages` / `tex_packages` | 額外載入的 TeX 套件 | 逗號分隔清單 |
| `tikzLibraries` / `tikz_libraries` | 載入的 TikZ 庫 | 逗號分隔清單 |
| `addToPreamble` / `add_to_preamble` | 新增到前言的自訂 LaTeX 程式碼 | LaTeX 字串 |
| `showConsole` / `show_console` | 顯示控制台輸出 | `true` / `false` |
| `embedFontCss` / `embed_font_css` | 嵌入字型 CSS | `true` / `false` |
| `fontCssUrl` / `font_css_url` | 自訂字型 CSS URL | URL 字串 |

> **注意：** TikZ 渲染在客戶端渲染（tikzjax.com）時需要網路存取。使用 node-tikzjax 的伺服端渲染在初始設定後可離線工作。

## WebSequenceDiagrams

Markdown Preview Enhanced 支援透過 `wsd` 圍欄程式碼區塊渲染 [WebSequenceDiagrams](https://www.websequencediagrams.com/) 圖表。

- `wsd` 程式碼區塊中的內容將會被 [WebSequenceDiagrams](https://www.websequencediagrams.com/) 渲染。
- 可選的 API 金鑰可以在[插件設定](zh-tw/usages.md?id=package-settings)中配置。

> **注意：** WebSequenceDiagrams 渲染需要網路存取 websequencediagrams.com。

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

## Kroki

Markdown Preview Enhanced 支持 [Kroki](https://kroki.io/)，它支援不同種類的圖表。只需在程式碼區塊的屬性中設置 `kroki=true` 或 `kroki=DIAGRAM_TYPE` 即可啟用它。

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
