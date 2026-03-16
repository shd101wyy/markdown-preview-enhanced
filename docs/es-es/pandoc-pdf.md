# Documento PDF

## Descripción general

Para crear un documento PDF, necesitas especificar el formato de salida `pdf_document` en el front-matter de tu documento:

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: pdf_document
---

```

## Ruta de exportación

Puedes definir la ruta de exportación del documento especificando la opción `path`. Por ejemplo:

```yaml
---
title: "Habits"
output:
  pdf_document:
    path: /Exports/Habits.pdf
---

```

Si `path` no está definido, el documento se generará en el mismo directorio.

## Tabla de contenidos

Puedes añadir una tabla de contenidos usando la opción `toc` y especificar la profundidad de los encabezados que incluye mediante la opción `toc_depth`. Por ejemplo:

```yaml
---
title: "Habits"
output:
  pdf_document:
    toc: true
    toc_depth: 2
---

```

Si la profundidad de la tabla de contenidos no se especifica explícitamente, el valor predeterminado es 3 (lo que significa que se incluirán todos los encabezados de nivel 1, 2 y 3 en la tabla de contenidos).

_Atención:_ este TOC es diferente del `<!-- toc -->` generado por **Markdown Preview Enhanced**.

Puedes añadir numeración de secciones a los encabezados usando la opción `number_sections`:

```yaml
---
title: "Habits"
output:
  pdf_document:
    toc: true
    number_sections: true
---

```

## Resaltado de sintaxis

La opción `highlight` especifica el estilo de resaltado de sintaxis. Los estilos admitidos incluyen "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn" y "haddock" (especifica null para evitar el resaltado de sintaxis):

Por ejemplo:

```yaml
---
title: "Habits"
output:
  pdf_document:
    highlight: tango
---

```

## Opciones LaTeX

Muchos aspectos de la plantilla LaTeX usada para crear documentos PDF pueden personalizarse usando metadatos YAML de nivel superior (ten en cuenta que estas opciones no aparecen bajo la sección `output` sino en el nivel superior junto con el título, autor, etc.). Por ejemplo:

```yaml
---
title: "Crop Analysis Q3 2013"
output: pdf_document
fontsize: 11pt
geometry: margin=1in
---

```

Las variables de metadatos disponibles incluyen:

| Variable                       | Descripción                                                                               |
| ------------------------------ | ----------------------------------------------------------------------------------------- |
| papersize                      | tamaño del papel, ej. `letter`, `A4`                                                      |
| lang                           | Código de idioma del documento                                                            |
| fontsize                       | Tamaño de fuente (ej. 10pt, 11pt, 12pt)                                                   |
| documentclass                  | Clase de documento LaTeX (ej. article)                                                    |
| classoption                    | Opción para documentclass (ej. oneside); puede repetirse                                  |
| geometry                       | Opciones para la clase geometry (ej. margin=1in); puede repetirse                         |
| linkcolor, urlcolor, citecolor | Color para enlaces internos, externos y de citas (red, green, magenta, cyan, blue, black) |
| thanks                         | Especifica el contenido de la nota de agradecimientos después del título del documento.   |

Más variables disponibles se pueden encontrar [aquí](https://pandoc.org/MANUAL.html#variables-for-latex).

### Paquetes LaTeX para citas

Por defecto, las citas se procesan a través de `pandoc-citeproc`, que funciona para todos los formatos de salida. Para la salida PDF, a veces es mejor usar paquetes LaTeX para procesar las citas, como `natbib` o `biblatex`. Para usar uno de estos paquetes, simplemente establece la opción `citation_package` en `natbib` o `biblatex`, ej.:

```yaml
---
output:
  pdf_document:
    citation_package: natbib
---

```

## Personalización avanzada

### Motor LaTeX

Por defecto, los documentos PDF se renderizan usando `pdflatex`. Puedes especificar un motor alternativo usando la opción `latex_engine`. Los motores disponibles son "pdflatex", "xelatex" y "lualatex". Por ejemplo:

```yaml
---
title: "Habits"
output:
  pdf_document:
    latex_engine: xelatex
---

```

### Incluir

Puedes realizar una personalización más avanzada de la salida PDF incluyendo directivas y/o contenido LaTeX adicional, o reemplazando completamente la plantilla de pandoc. Para incluir contenido en el encabezado del documento o antes/después del cuerpo del documento, usa la opción `includes` de la siguiente manera:

```yaml
---
title: "Habits"
output:
  pdf_document:
    includes:
      in_header: header.tex
      before_body: doc_prefix.tex
      after_body: doc_suffix.tex
---

```

### Plantillas personalizadas

También puedes reemplazar la plantilla de pandoc subyacente usando la opción `template`:

```yaml
---
title: "Habits"
output:
  pdf_document:
    template: quarterly_report.tex
---

```

Consulta la documentación sobre [plantillas de pandoc](https://pandoc.org/README.html#templates) para más detalles. También puedes estudiar la [plantilla LaTeX predeterminada](https://github.com/jgm/pandoc-templates/blob/master/default.latex) como ejemplo.

### Argumentos de Pandoc

Si hay funciones de pandoc que deseas usar y que no tienen equivalentes en las opciones YAML descritas anteriormente, aún puedes usarlas pasando `pandoc_args` personalizados. Por ejemplo:

```yaml
---
title: "Habits"
output:
  pdf_document:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Opciones compartidas

Si deseas especificar un conjunto de opciones predeterminadas para compartir entre múltiples documentos en un directorio, puedes incluir un archivo llamado `_output.yaml` en ese directorio. Ten en cuenta que no se usan delimitadores YAML ni objeto de salida encapsulado en este archivo. Por ejemplo:

**\_output.yaml**

```yaml
pdf_document:
  toc: true
  highlight: zenburn
```

Todos los documentos ubicados en el mismo directorio que `_output.yaml` heredarán sus opciones. Las opciones definidas explícitamente en los documentos anularán las especificadas en el archivo de opciones compartidas.
