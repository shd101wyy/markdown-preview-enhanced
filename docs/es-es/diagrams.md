# Diagramas

**Markdown Preview Enhanced** admite la renderización de diagramas de `flujo`, `secuencia`, `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz`, `Vega & Vega-lite` y `Ditaa`.
También puedes renderizar `TikZ`, `Python Matplotlib`, `Plotly` y todo tipo de otros gráficos y diagramas usando [Code Chunk](code-chunk.md).

> Ten en cuenta que algunos diagramas no funcionan bien con exportaciones de archivos como PDF, pandoc, etc.

## Mermaid

Markdown Preview Enhanced usa [mermaid](https://github.com/knsv/mermaid) para renderizar diagramas de flujo y de secuencia.

- Los bloques de código con la notación `mermaid` serán renderizados por [mermaid](https://github.com/knsv/mermaid).
- Consulta la [documentación de mermaid](https://mermaid-js.github.io/mermaid) para más información sobre cómo crear diagramas de flujo y de secuencia.
  ![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

Se proporcionan tres temas para mermaid, y puedes elegir el tema desde la [configuración del paquete](usages.md?id=package-settings):

- `mermaid.css`
- `mermaid.dark.css`
- `mermaid.forest.css`
  ![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

También puedes editar la configuración de inicialización de mermaid ejecutando el comando `Markdown Preview Enhanced: Open Mermaid Config`.

Además, puedes registrar logotipos de iconos en head.html (abierto mediante el comando `Markdown Preview Enhanced: Customize Preview Html Head`) de la siguiente forma:

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

Markdown Preview Enhanced usa [PlantUML](https://plantuml.com/) para crear múltiples tipos de gráficos. (Se requiere tener **Java** instalado)

- Puedes instalar [Graphviz](https://www.graphviz.org/) (no obligatorio) para generar todos los tipos de diagramas.
- Los bloques de código con la notación `puml` o `plantuml` serán renderizados por [PlantUML](https://plantuml.com/).

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

Si no se encuentra `@start...`, se insertará automáticamente `@startuml ... @enduml`.

## WaveDrom

Markdown Preview Enhanced usa [WaveDrom](https://wavedrom.com/) para crear diagramas de temporización digital.

- Los bloques de código con la notación `wavedrom` serán renderizados por [WaveDrom](https://github.com/drom/wavedrom).

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

Los diagramas [Bitfield](https://github.com/wavedrom/bitfield) también son compatibles. Usa `bitfield` como identificador de lenguaje.

## GraphViz

Markdown Preview Enhanced usa [Viz.js](https://github.com/mdaines/viz.js) para renderizar diagramas en [lenguaje dot](https://tinyurl.com/kjoouup).

- Los bloques de código con la notación `viz` o `dot` serán renderizados por [Viz.js](https://github.com/mdaines/viz.js).
- Puedes elegir diferentes motores especificando `{engine="..."}`. Los motores `circo`, `dot`, `neato`, `osage` o `twopi` son compatibles. El motor predeterminado es `dot`.

![screen shot 2018-03-18 at 3 18 17 pm](https://user-images.githubusercontent.com/1908863/37570596-a565306e-2abf-11e8-8904-d73306f675ec.png)

## D2

Markdown Preview Enhanced usa [D2](https://d2lang.com/) para renderizar diagramas. D2 es un lenguaje de diagramación declarativo que convierte texto en diagramas.

- [D2](https://d2lang.com/) debe estar instalado y disponible en su `PATH` (o configurado mediante `d2Path` en los ajustes).
- Los bloques de código con la notación `d2` serán renderizados por [D2](https://d2lang.com/).
- Consulte la [documentación de D2](https://d2lang.com/tour/intro/) para la referencia completa de sintaxis.

Puede sobrescribir el motor de diseño, el tema y el estilo de boceto por bloque de código:
![d2-test](https://github.com/user-attachments/assets/809cc0e7-e7a0-4637-9a4d-3992edab725d)

| Atributo  | Descripción                                                       | Por defecto |
| --------- | ----------------------------------------------------------------- | ----------- |
| `layout`  | Motor de diseño: `dagre`, `elk`, `tala`                           | `dagre`     |
| `theme`   | Número de ID del tema (ver [temas D2](https://d2lang.com/tour/themes/)) | `0`    |
| `sketch`  | Renderizar en estilo dibujado a mano / boceto                     | `false`     |

Los valores predeterminados globales se pueden configurar en los [ajustes del paquete](usages.md?id=package-settings):

| Ajuste     | Descripción                      | Por defecto |
| ---------- | -------------------------------- | ----------- |
| `d2Path`   | Ruta al ejecutable `d2`          | `d2`        |
| `d2Layout` | Motor de diseño predeterminado   | `dagre`     |
| `d2Theme`  | ID de tema predeterminado        | `0`         |
| `d2Sketch` | Modo boceto predeterminado       | `false`     |

> **Nota:** El renderizado de D2 requiere que la CLI de `d2` esté instalada en su máquina. Si no se encuentra, el bloque de código se mostrará como texto plano. Consulte la [guía de instalación de D2](https://d2lang.com/tour/install/) para obtener instrucciones.

## TikZ

Markdown Preview Enhanced admite la renderización de diagramas [TikZ](https://tikz.dev/) mediante bloques de código delimitados con `tikz`.

- En Node.js (VS Code de escritorio): renderiza TikZ a SVG del lado del servidor usando [node-tikzjax](https://github.com/prinsss/node-tikzjax), con caché.
- En web (extensión web de VS Code) y exportación HTML: recurre a la renderización del lado del cliente mediante [tikzjax.com](https://tikzjax.com).
- Si no está presente, se agrega automáticamente `\begin{document}...\end{document}`.
- Carga automáticamente los paquetes TeX base: `amsmath`, `amssymb`, `amsfonts`, `amstext`, `array`.
- Detecta y carga automáticamente paquetes especializados: `tikz-cd` (para `\begin{tikzcd}`), `pgfplots` (para `\begin{axis}`), `circuitikz` (para `\begin{circuitikz}`), `chemfig` (para `\chemfig`), `tikz-3dplot` (para `\tdplotsetmaincoords`).

Opciones por bloque admitidas en la cadena de información del delimitador:

| Opción | Descripción | Valores aceptados |
| ------ | ----------- | ----------------- |
| `texPackages` / `tex_packages` | Paquetes TeX adicionales a cargar | Lista separada por comas |
| `tikzLibraries` / `tikz_libraries` | Librerías TikZ a cargar | Lista separada por comas |
| `addToPreamble` / `add_to_preamble` | Código LaTeX personalizado para agregar al preámbulo | Cadena LaTeX |
| `showConsole` / `show_console` | Mostrar la salida de la consola | `true` / `false` |
| `embedFontCss` / `embed_font_css` | Incrustar CSS de fuentes | `true` / `false` |
| `fontCssUrl` / `font_css_url` | URL personalizada de CSS de fuentes | Cadena URL |

> **Nota:** La renderización de TikZ requiere acceso a la red para la renderización del lado del cliente (tikzjax.com). La renderización del lado del servidor con node-tikzjax funciona sin conexión después de la configuración inicial.

## WebSequenceDiagrams

Markdown Preview Enhanced admite la renderización de [WebSequenceDiagrams](https://www.websequencediagrams.com/) mediante bloques de código delimitados con `wsd`.

- Los bloques de código con la notación `wsd` serán renderizados por [WebSequenceDiagrams](https://www.websequencediagrams.com/).
- Una clave API opcional se puede configurar en los [ajustes del paquete](usages.md?id=package-settings).

> **Nota:** La renderización de WebSequenceDiagrams requiere acceso a la red a websequencediagrams.com.

## Vega y Vega-lite

Markdown Preview Enhanced admite diagramas **estáticos** de [vega](https://vega.github.io/vega/) y [vega-lite](https://vega.github.io/vega-lite/).

- Los bloques de código con la notación `vega` serán renderizados por [vega](https://vega.github.io/vega/).
- Los bloques de código con la notación `vega-lite` serán renderizados por [vega-lite](https://vega.github.io/vega-lite/).
- Se admiten entradas en formato `JSON` y `YAML`.

![screen shot 2017-07-28 at 7 59 58 am](https://user-images.githubusercontent.com/1908863/28718265-d023e1c2-736a-11e7-8678-a29704f3a23c.png)

También puedes [@import](file-imports.md) un archivo `JSON` o `YAML` como diagrama `vega`, por ejemplo:

```markdown
@import "your_vega_source.json" {as="vega"}
@import "your_vega_lite_source.json" {as="vega-lite"}
```

## Kroki

Markdown Preview Enhanced admite [Kroki](https://kroki.io/), que soporta diferentes tipos de diagramas. Simplemente establece `kroki=true` o `kroki=DIAGRAM_TYPE` en los atributos del bloque de código para habilitarlo.

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

Si no deseas renderizar gráficos sino solo mostrar el bloque de código, puedes agregar `{code_block=true}` de la siguiente manera:

    ```mermaid {code_block=true}
    // tu código mermaid aquí
    ```

---

Puedes establecer atributos para el contenedor del diagrama.
Por ejemplo:

    ```puml {align="center"}
    a->b
    ```

colocará el diagrama puml en el centro de la vista previa.

---

Cuando exportes tu archivo Markdown a [GFM Markdown](markdown.md), los diagramas se guardarán como imágenes png en tu `imageFolderPath` definido en la configuración del paquete.
Puedes controlar el nombre del archivo de imagen exportado declarando `{filename="your_file_name.png"}`.

Por ejemplo:

    ```mermaid {filename="my_mermaid.png"}
    ...
    ```

[➔ TOC](toc.md)
