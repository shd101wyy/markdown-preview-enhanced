# 다이어그램

**Markdown Preview Enhanced** 는 `flow charts`, `sequence diagrams`, `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz`, `Vega & Vega-lite`, `Ditaa` 다이어그램 렌더링을 지원한다. 또한 [Code Chunk](code-chunk.md) 를 사용하여 `TikZ`, `Python Matplotlib`, `Plotly` 및 기타 그래프 및 다이어그램을 렌더링할 수도 있다.

> 일부 다이어그램은 PDF, pandoc 등의 파일 내보내기에서는 제대로 작동하지 않는다.

## Flow Charts

이 기능은 [flowchart.js](https://flowchart.js.org/) 를 사용한다.

- `flow` 표기법의 코드 블록은 [flowchart.js](https://flowchart.js.org/) 에 의해 렌더링된다.

![screenshot from 2017-11-25 21-43-02](https://user-images.githubusercontent.com/1908863/33236942-aa809c1c-d229-11e7-9c4b-9a680fd852ed.png)

## Sequence Diagrams

이 기능은 [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/) 를 사용한다.

- `sequence` 표기법의 코드 블록은 [js-sequence-diagrams](https://bramp.github.io/js-sequence-diagrams/) 에 의해 렌더링 된다.
- 두 가지 테마 지원: `simple`(기본 테마)와 `hand`.

![screenshot from 2017-11-25 21-47-41](https://user-images.githubusercontent.com/1908863/33236972-4f190f98-d22a-11e7-842f-d9c4a74d2118.png)

## Mermaid

Markdown Preview Enhanced는 [mermaid](https://github.com/knsv/mermaid) 를 사용하여 flow chart와 sequence diagram을 렌더링한다.

- `mermaid` 표기법의 코드 블록은 [mermaid](https://github.com/knsv/mermaid) 에 의해 렌더링된다.
- flow chart와 sequence diagram을 만드는 방법에 대한 자세한 내용은 [mermaid doc](https://mermaid-js.github.io/mermaid) 을 참조하기 바란다.
  ![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

세 가지 테마가 제공되며 [package settings](usages.md?id=package-settings)에서 테마를 선택할 수 있다:

- `mermaid.css`
- `mermaid.dark.css`
- `mermaid.forest.css`
  ![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

또한 `Markdown Preview Enhanced: Open Mermaid Config` 명령을 실행하여 mermaid의 초기 설정을 편집할 수도 있다.

## PlantUML

Markdown Preview Enhanced는 [PlantUML](https://plantuml.com/) 을 사용하여 여러 유형의 그래프를 만든다. (**Java** 설치 필요)

- [Graphviz](https://www.graphviz.org/) (필수는 아님)를 설치하면 모든 종류의 다이어그램을 생성할 수 있다.
- `puml` 또는 `plantuml` 표기법의 코드 블록은 [PlantUML](https://plantuml.com/) 에 의해 렌더링된다.

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

만약 `@start...` 가 없으면 `@startuml ... @enduml` 이 자동으로 삽입된다.

## WaveDrom

Markdown Preview Enhanced는 [WaveDrom](https://wavedrom.com/) 을 사용하여 digital timing diagram을 만든다.

- `wavedrom` 표기법의 코드 블록은 [WaveDrom](https://github.com/drom/wavedrom) 에 의해 렌더링된다.

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

## GraphViz

Markdown Preview Enhanced는 [Viz.js](https://github.com/mdaines/viz.js) 를 사용하여 [dot language](https://tinyurl.com/kjoouup) diagram을 렌더링한다.

- `viz` 또는 `dot` 표기법의 코드 블록은 [Viz.js](https://github.com/mdaines/viz.js) 에 의해 렌더링된다.
- `{engine =" ... "}` 을 지정하여 엔진을 선택할 수 있다. `circo`, `dot`, `neato`, `osage`, `twopi` 엔진이 지원된다. 기본 엔진은 `dot` 이다.

![screen shot 2018-03-18 at 3 18 17 pm](https://user-images.githubusercontent.com/1908863/37570596-a565306e-2abf-11e8-8904-d73306f675ec.png)

## Vega and Vega-lite

Markdown Preview Enhanced는 [vega](https://vega.github.io/vega/) 와 [vega-lite](https://vega.github.io/vega-lite/) **정적** 그래프를 지원한다.

- `vega` 표기법의 코드 블록은 [vega](https://vega.github.io/vega/) 에 의해 렌더링된다.
- `vega-lite` 표기법의 코드 블록은 [vega-lite](https://vega.github.io/vega-lite/) 에 의해 렌더링된다.
- `JSON` 및 `YAML` 입력이 모두 지원된다.

![screen shot 2017-07-28 at 7 59 58 am](https://user-images.githubusercontent.com/1908863/28718265-d023e1c2-736a-11e7-8678-a29704f3a23c.png)

`JSON` 또는 `YAML` 파일을 `vega` 다이어그램으로 [@import](file-imports.md) 할 수도 있다. 예:

```markdown
@import "your_vega_source.json" {as="vega"}
@import "your_vega_lite_source.json" {as="vega-lite"}
```

## Ditaa

Markdown Preview Enhanced는 ascii art로 그려진 다이어그램 (| /-과 같은 선과 유사한 문자가 포함된 '그림')을 비트맵 그래픽으로 변환할 수 있는 [ditaa](https://github.com/stathissideris/ditaa) 를 지원한다.

(**Java** 설치가 요구됨)

`ditaa`는 [code chunk](code-chunk.md)와 통합되어 있다. 예:

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

> <kbd>shift-enter</kbd> 로 code chunk를 실행할 수 있다.
> 코드 블럭을 숨기려면 `{hide=true}` 를 설정한다.
> markdown 파일을 저장할 때 ditaa를 렌더링하려면 `{run_on_save=true}`를 설정한다.

![screen shot 2017-07-28 at 8 11 15 am](https://user-images.githubusercontent.com/1908863/28718626-633fa18e-736c-11e7-8a4a-915858dafff6.png)

---

그래프를 렌더링하지 않고 코드 블록만 표시하려면 아래와 같이 {code_block = true} 를 추가한다:

    ```mermaid {code_block=true}
    // your mermaid code here
    ```

---

다이어그램의 컨테이너 속성을 설정할 수 있다.
예:

    ```puml {align="center"}
    a->b
    ```

이 경우 미리보기 중앙에 puml 다이어그램이 배치된다.

---

markdown 파일을 [GFM Markdown](markdown.md) 으로 내보내면 다이어그램이 패키지 설정에 정의된 `imageFolderPath` 에 png 이미지로 저장된다.
`{filename ="your_file_name.png"}` 를 선언하여 내보낼 이미지의 파일 이름을 제어할 수 있다.

예:

    ```mermaid {filename="my_mermaid.png"}
    ...
    ```

[➔ 목차](toc.md)
