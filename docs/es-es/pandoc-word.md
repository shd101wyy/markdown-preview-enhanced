# Documento Word

## Descripción general

Para crear un documento Word, necesitas especificar el formato de salida word_document en el front-matter de tu documento:

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: word_document
---

```

## Ruta de exportación

Puedes definir la ruta de exportación del documento especificando la opción `path`. Por ejemplo:

```yaml
---
title: "Habits"
output:
  word_document:
    path: /Exports/Habits.docx
---

```

Si `path` no está definido, el documento se generará en el mismo directorio.

## Resaltado de sintaxis

Puedes usar la opción `highlight` para controlar el tema de resaltado de sintaxis. Por ejemplo:

```yaml
---
title: "Habits"
output:
  word_document:
    highlight: "tango"
---

```

## Referencia de estilo

Usa el archivo especificado como referencia de estilo al producir un archivo docx. Para mejores resultados, el docx de referencia debe ser una versión modificada de un archivo docx producido con pandoc. El contenido del docx de referencia se ignora, pero sus hojas de estilo y propiedades del documento (incluyendo márgenes, tamaño de página, encabezado y pie de página) se usan en el nuevo docx. Si no se especifica un docx de referencia en la línea de comandos, pandoc buscará un archivo `reference.docx` en el directorio de datos del usuario (ver --data-dir). Si tampoco se encuentra, se usarán valores predeterminados razonables.

```yaml
---
title: "Habits"
output:
  word_document:
    reference_docx: mystyles.docx
---

```

## Argumentos de Pandoc

Si hay funciones de pandoc que deseas usar y que no tienen equivalentes en las opciones YAML descritas anteriormente, aún puedes usarlas pasando `pandoc_args` personalizados. Por ejemplo:

```yaml
---
title: "Habits"
output:
  word_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## Opciones compartidas

Si deseas especificar un conjunto de opciones predeterminadas para compartir entre múltiples documentos en un directorio, puedes incluir un archivo llamado `_output.yaml` en ese directorio. Ten en cuenta que no se usan delimitadores YAML ni objeto de salida encapsulado en este archivo. Por ejemplo:

**\_output.yaml**

```yaml
word_document:
  highlight: zenburn
```

Todos los documentos ubicados en el mismo directorio que `_output.yaml` heredarán sus opciones. Las opciones definidas explícitamente en los documentos anularán las especificadas en el archivo de opciones compartidas.
