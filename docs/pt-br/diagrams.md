# Diagramas

**Markdown Preview Enhanced** suporta a renderização de diagramas de `fluxo`, `sequência`, `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz`, `Vega & Vega-lite` e `Ditaa`.
Você também pode renderizar `TikZ`, `Python Matplotlib`, `Plotly` e todos os tipos de outros gráficos e diagramas usando [Code Chunk](code-chunk.md).

> Por favor, note que alguns diagramas não funcionam bem com exportações de arquivo como PDF, pandoc, etc.

## Mermaid

Markdown Preview Enhanced usa [mermaid](https://github.com/knsv/mermaid) para renderizar fluxogramas e diagramas de sequência.

- Blocos de código com notação `mermaid` serão renderizados pelo [mermaid](https://github.com/knsv/mermaid).
- Consulte a [documentação do mermaid](https://mermaid-js.github.io/mermaid) para mais informações sobre como criar fluxogramas e diagramas de sequência.
  ![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

Três temas mermaid são fornecidos, e você pode escolher o tema nas [configurações do pacote](usages.md?id=package-settings):

- `mermaid.css`
- `mermaid.dark.css`
- `mermaid.forest.css`
  ![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

Você também pode editar a configuração de inicialização do mermaid executando o comando `Markdown Preview Enhanced: Open Mermaid Config`.

Além disso, você pode registrar logotipos de ícones no head.html (aberto via comando `Markdown Preview Enhanced: Customize Preview Html Head`) da seguinte forma:

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

Markdown Preview Enhanced usa [PlantUML](https://plantuml.com/) para criar vários tipos de gráficos. (**Java** precisa estar instalado)

- Você pode instalar o [Graphviz](https://www.graphviz.org/) (opcional) para gerar todos os tipos de diagrama.
- Blocos de código com notação `puml` ou `plantuml` serão renderizados pelo [PlantUML](https://plantuml.com/).

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

Se `@start...` não for encontrado, então `@startuml ... @enduml` será inserido automaticamente.

## WaveDrom

Markdown Preview Enhanced usa [WaveDrom](https://wavedrom.com/) para criar diagramas de temporização digital.

- Blocos de código com notação `wavedrom` serão renderizados pelo [WaveDrom](https://github.com/drom/wavedrom).

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

Diagramas [Bitfield](https://github.com/wavedrom/bitfield) também são suportados. Use `bitfield` como identificador de linguagem.

## GraphViz

Markdown Preview Enhanced usa [Viz.js](https://github.com/mdaines/viz.js) para renderizar diagramas em [linguagem dot](https://tinyurl.com/kjoouup).

- Blocos de código com notação `viz` ou `dot` serão renderizados pelo [Viz.js](https://github.com/mdaines/viz.js).
- Você pode escolher diferentes mecanismos especificando `{engine="..."}`. Os mecanismos `circo`, `dot`, `neato`, `osage` ou `twopi` são suportados. O mecanismo padrão é `dot`.

![screen shot 2018-03-18 at 3 18 17 pm](https://user-images.githubusercontent.com/1908863/37570596-a565306e-2abf-11e8-8904-d73306f675ec.png)

## Vega e Vega-lite

Markdown Preview Enhanced suporta diagramas **estáticos** [vega](https://vega.github.io/vega/) e [vega-lite](https://vega.github.io/vega-lite/).

- Blocos de código com notação `vega` serão renderizados pelo [vega](https://vega.github.io/vega/).
- Blocos de código com notação `vega-lite` serão renderizados pelo [vega-lite](https://vega.github.io/vega-lite/).
- Entradas `JSON` e `YAML` são suportadas.

![screen shot 2017-07-28 at 7 59 58 am](https://user-images.githubusercontent.com/1908863/28718265-d023e1c2-736a-11e7-8678-a29704f3a23c.png)

Você também pode [@importar](file-imports.md) um arquivo `JSON` ou `YAML` como diagrama `vega`, por exemplo:

```markdown
@import "your_vega_source.json" {as="vega"}
@import "your_vega_lite_source.json" {as="vega-lite"}
```

## Kroki

Markdown Preview Enhanced suporta [Kroki](https://kroki.io/), que suporta diferentes tipos de diagramas. Simplesmente defina `kroki=true` ou `kroki=DIAGRAM_TYPE` nos atributos do bloco de código para habilitá-lo.

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

Se você não quiser renderizar gráficos, mas apenas exibir o bloco de código, você pode adicionar `{code_block=true}` como abaixo:

    ```mermaid {code_block=true}
    // seu código mermaid aqui
    ```

---

Você pode definir atributos para o contêiner do diagrama.
Por exemplo:

    ```puml {align="center"}
    a->b
    ```

irá colocar o diagrama puml no centro da visualização.

---

Quando você exportar seu arquivo Markdown para [GFM Markdown](markdown.md), os diagramas serão salvos como imagens png em seu `imageFolderPath` definido nas configurações do pacote.
Você pode controlar o nome do arquivo de imagem exportado declarando `{filename="your_file_name.png"}`.

Por exemplo:

    ```mermaid {filename="my_mermaid.png"}
    ...
    ```

[➔ TOC](toc.md)
