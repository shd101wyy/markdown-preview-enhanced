# Documento RTF

## Descripción general

Para crear un documento RTF desde R Markdown, especifica el formato de salida `rtf_document` en el front-matter de tu documento:

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: rtf_document
---

```

## Ruta de exportación

Puedes definir la ruta de exportación del documento especificando la opción `path`. Por ejemplo:

```yaml
---
title: "Habits"
output:
  rtf_document:
    path: /Exports/Habits.rtf
---

```

Si `path` no está definido, el documento se generará en el mismo directorio.

## Tabla de contenidos

Puedes añadir una tabla de contenidos usando la opción `toc` y especificar la profundidad de los encabezados que incluye mediante la opción `toc_depth`. Por ejemplo:

```yaml
---
title: "Habits"
output:
  rtf_document:
    toc: true
    toc_depth: 2
---

```

Si la profundidad de la tabla de contenidos no se especifica explícitamente, el valor predeterminado es 3 (lo que significa que se incluirán todos los encabezados de nivel 1, 2 y 3 en la tabla de contenidos).

_Atención:_ este TOC es diferente del `<!-- toc -->` generado por **Markdown Preview Enhanced**.

## Argumentos de Pandoc

Si hay funciones de pandoc que deseas usar y que no tienen equivalentes en las opciones YAML descritas anteriormente, aún puedes usarlas pasando `pandoc_args` personalizados. Por ejemplo:

```yaml
---
title: "Habits"
output:
  rtf_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## Opciones compartidas

Si deseas especificar un conjunto de opciones predeterminadas para compartir entre múltiples documentos en un directorio, puedes incluir un archivo llamado `_output.yaml` en ese directorio. Ten en cuenta que no se usan delimitadores YAML ni objeto de salida encapsulado en este archivo. Por ejemplo:

**\_output.yaml**

```yaml
rtf_document:
  toc: true
```

Todos los documentos ubicados en el mismo directorio que `_output.yaml` heredarán sus opciones. Las opciones definidas explícitamente en los documentos anularán las especificadas en el archivo de opciones compartidas.
