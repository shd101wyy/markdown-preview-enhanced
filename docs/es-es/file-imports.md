# Importar archivos externos

![doc-imports](https://cloud.githubusercontent.com/assets/1908863/22716507/f352a4b6-ed5b-11e6-9bac-88837f111de0.gif)

## ¿Cómo se usa?

Simplemente escribe

`@import "your_file"`

Fácil, ¿verdad? :)

`<!-- @import "your_file" -->` también es válido.

O también:

```markdown
- sintaxis similar a imagen
  ![](file/path/to/your_file)

- sintaxis similar a wikilink
  ![[ file/path/to/your_file ]]
  ![[ my_file ]]
```

## Botón de actualización

Se ha añadido un botón de actualización en la esquina derecha de la vista previa.
Hacer clic en él limpiará la caché de archivos y actualizará la vista previa.
Puede ser útil si deseas limpiar la caché de imágenes. [#144](https://github.com/shd101wyy/markdown-preview-enhanced/issues/144) [#249](https://github.com/shd101wyy/markdown-preview-enhanced/issues/249)

![screen shot 2017-02-07 at 5 48 52 pm](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Tipos de archivos compatibles

- Los archivos `.jpeg(.jpg), .gif, .png, .apng, .svg, .bmp` se tratarán como imágenes Markdown.
- Los archivos `.csv` se convertirán a tabla Markdown.
- Los archivos `.mermaid` serán renderizados por mermaid.
- Los archivos `.dot` serán renderizados por viz.js (graphviz).
- Los archivos `.plantuml(.puml)` serán renderizados por PlantUML.
- Los archivos `.html` se incrustarán directamente.
- Los archivos `.js` se incluirán como `<script src="your_js"></script>`.
- Los archivos `.less` y `.css` se incluirán como estilos. Solo los archivos `less` locales están soportados actualmente. Los archivos `.css` se incluirán como `<link rel="stylesheet" href="your_css">`.
- Los archivos `.pdf` se convertirán a archivos `svg` mediante `pdf2svg` y luego se incluirán.
- Los archivos `markdown` se analizarán e incrustarán directamente.
- Todos los demás archivos se renderizarán como bloque de código.

## Configurar imágenes

```markdown
@import "test.png" {width="300px" height="200px" title="mi título" alt="mi alt"}

![](test.png){width="300px" height="200px"}

![[ test.png ]]{width="300px" height="200px"}
```

## Importar archivos en línea

Por ejemplo:

```markdown
@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"
```

## Importar archivo PDF

Para importar un archivo PDF, necesitas tener [pdf2svg](extra.md) instalado.
Markdown Preview Enhanced admite la importación de archivos PDF tanto locales como en línea.
Sin embargo, no se recomienda importar archivos PDF grandes.
Por ejemplo:

```markdown
@import "test.pdf"
```

### Configuración de PDF

- **page_no**
  Muestra la página `n` del PDF. Indexación basada en 1. Por ejemplo, `{page_no=1}` mostrará la primera página del PDF.
- **page_begin**, **page_end**
  Inclusivo. Por ejemplo, `{page_begin=2 page_end=4}` mostrará las páginas 2, 3 y 4.

## Forzar la renderización como bloque de código

```markdown
@import "test.puml" {code_block=true class="line-numbers"}
@import "test.py" {class="line-numbers"}
```

## Como bloque de código

```markdown
@import "test.json" {as="vega-lite"}
```

## Importar líneas específicas

```markdown
@import "test.md" {line_begin=2}
@import "test.md" {line_begin=2 line_end=10}
@import "test.md" {line_end=-4}
```

## Importar archivo como Code Chunk

```markdown
@import "test.py" {cmd="python3"}
```

[➔ Code Chunk](code-chunk.md)
