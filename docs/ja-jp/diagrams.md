# ダイアグラム

**Markdown Preview Enhanced** は、`flow charts`, `sequence diagrams`, `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz`, `Vega & Vega-lite`, `Ditaa` ダイアグラムのレンダリングをサポートします。
[コード チャンク](ja-jp/code-chunk.md) を使用して、 `TikZ`, `Python Matplotlib`, `Plotly`、およびその他のあらゆるグラフや図をレンダリングすることもできます。

> 一部のダイアグラムは、PDF、pandoc などのファイルエクスポートではうまく機能しないことに注意してください。

## Flow Charts

この機能は、[flowchart.js](https://flowchart.js.org/) を利用しています。

- `flow` 表記のコードブロックは [flowchart.js](https://flowchart.js.org/) によってレンダリングされます。

![screenshot from 2017-11-25 21-43-02](https://user-images.githubusercontent.com/1908863/33236942-aa809c1c-d229-11e7-9c4b-9a680fd852ed.png)

## Sequence Diagrams

この機能は、[js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/) を利用しています。

- `sequence` 表記のコードブロックは [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/) によってレンダリングされます。
- 2 つのテーマがサポートされています： `simple`(既定のテーマ)と `hand`

![screenshot from 2017-11-25 21-47-41](https://user-images.githubusercontent.com/1908863/33236972-4f190f98-d22a-11e7-842f-d9c4a74d2118.png)

## Mermaid

Markdown Preview Enhanced は、[mermaid](https://github.com/knsv/mermaid) を使用して、フローチャートとシーケンス図をレンダリングします。

- `mermaid` 表記のコードブロックは [mer​​maid](https://github.com/knsv/mermaid) によってレンダリングされます。
- フローチャートとシーケンス図の作成方法の詳細については、[mermaid doc](https://mermaid-js.github.io/mermaid) を参照してください
  ![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

3 種類のテーマが提供されており、[package settings](ja-jp/usages.md?id=package-settings) からテーマを選択できます：

- `mermaid.css`
- `mermaid.dark.css`
- `mermaid.forest.css`
  ![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

`Markdown Preview Enhanced：Open Mermaid Config` コマンドを実行して、`mermaid` の初期設定を編集することもできます。

## PlantUML

Markdown Preview Enhanced は、[PlantUML](https://plantuml.com/) を使用して複数の種類のグラフを作成します。(**Java** のインストールが必要です)

- [Graphviz](https://www.graphviz.org/)(必須ではありません) をインストールすると、すべての種類の図を生成できます。
- `puml` または `plantuml` 表記のコードブロックは、[PlantUML](https://plantuml.com/) によってレンダリングされます。

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

`@start ...` が見つからない場合、`@ startuml ... @ enduml` が自動的に挿入されます。

## WaveDrom

Markdown Preview Enhanced は、[WaveDrom](https://wavedrom.com/) を使用してデジタルタイミングチャートを作成します。

- `wavedrom` 表記のコードブロックは、[WaveDrom](https://github.com/drom/wavedrom) によってレンダリングされます。

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

## GraphViz

Markdown Preview Enhanced は、[Viz.js](https://github.com/mdaines/viz.js) を使用して [dot 言語](https://tinyurl.com/kjoouup) ダイアグラムをレンダリングします。

- `viz` または `dot` 表記のコードブロックは [Viz.js](https://github.com/mdaines/viz.js) によってレンダリングされます。
- `{engine =" ... "}` を指定すると、描画エンジンを選択できます。`circo`, `dot`, `neato`, `osage`, `twopi` がサポートされています。既定の描画エンジンは `dot` です。

![screen shot 2018-03-18 at 3 18 17 pm](https://user-images.githubusercontent.com/1908863/37570596-a565306e-2abf-11e8-8904-d73306f675ec.png)

## Vega and Vega-lite

Markdown Preview Enhanced は、[vega](https://vega.github.io/vega/) および [vega-lite](https://vega.github.io/vega-lite/) **静的**グラフをサポートしています。

- `vega` 表記のコードブロックは [vega](https://vega.github.io/vega/) によってレンダリングされます。
- `vega-lite` 表記のコードブロックは、[vega-lite](https://vega.github.io/vega-lite/) によってレンダリングされます。
- `JSON` と `YAML` の両方の入力がサポートされています。

![screen shot 2017-07-28 at 7 59 58 am](https://user-images.githubusercontent.com/1908863/28718265-d023e1c2-736a-11e7-8678-a29704f3a23c.png)

`JSON` または `YAML` ファイルを `vega` ダイアグラムとして [@import](ja-jp/file-imports.md) することもできます。
例：

```markdown
@import "your_vega_source.json" {as="vega"}
@import "your_vega_lite_source.json" {as="vega-lite"}
```

## Ditaa

Markdown Preview Enhanced は、[ditaa](https://github.com/stathissideris/ditaa) をサポートし、アスキーアートを使用して描画された図(| /-のような線に似た文字を含む '図面') をビットマップグラフィックに変換できます。

(**Java** のインストールが必要です)

`ditaa` は [コードチャンク](ja-jp/code-chunk.md) と統合されています。例：

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

> <kbd>shift-enter</kbd>でコード チャンクを実行できます。
> コードブロックを非表示にするには、`{hide = true}` を設定します。
> markdown ファイルを保存するときに ditaa をレンダリングするには、`{run_on_save = true}` を設定します。

![screen shot 2017-07-28 at 8 11 15 am](https://user-images.githubusercontent.com/1908863/28718626-633fa18e-736c-11e7-8a4a-915858dafff6.png)

---

グラフをレンダリングせずにコードブロックのみを表示する場合は、次のように `{code_block = true}` を追加できます。

    ```mermaid {code_block=true}
    // your mermaid code here
    ```

---

ダイアグラムのコンテナの属性を設定できます。
例：

    ```puml {align="center"}
    a->b
    ```

この場合、プレビューの中央に puml ダイアグラムが配置されます。

---

markdown ファイルを [GFM Markdown](ja-jp/markdown.md) にエクスポートすると、ダイアグラムはパッケージ設定で定義された `imageFolderPath` に png 画像として保存されます。
`{filename ="your_file_name.png"}` を宣言することで、エクスポートされる画像のファイル名を制御できます。

例：

    ```mermaid {filename="my_mermaid.png"}
    ...
    ```

[➔ 目次](ja-jp/toc.md)
