# Documento personalizado

## Descripción general

El **Documento personalizado** te otorga la capacidad de aprovechar todo el poder de `pandoc`.  
Para crear un documento personalizado, necesitas especificar el formato de salida `custom_document` en el front-matter de tu documento, **y** `path` **debe estar definido**.

El siguiente ejemplo de código se comportará de manera similar a un [documento PDF](pdf.md).

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output:
  custom_document:
    path: /Exports/test.pdf
    toc: true
---

```

El siguiente ejemplo de código se comportará de manera similar a una [presentación Beamer](pandoc-beamer.md).

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["-t", "beamer"]
---

```

## Argumentos de Pandoc

Si hay funciones de pandoc que deseas usar y que no tienen equivalentes en las opciones YAML descritas anteriormente, aún puedes usarlas pasando `pandoc_args` personalizados. Por ejemplo:

```yaml
---
title: "Habits"
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Opciones compartidas

Si deseas especificar un conjunto de opciones predeterminadas para compartir entre múltiples documentos en un directorio, puedes incluir un archivo llamado `_output.yaml` en ese directorio. Ten en cuenta que no se usan delimitadores YAML ni objeto de salida encapsulado en este archivo. Por ejemplo:

**\_output.yaml**

```yaml
custom_document:
  toc: true
  highlight: zenburn
```

Todos los documentos ubicados en el mismo directorio que `_output.yaml` heredarán sus opciones. Las opciones definidas explícitamente en los documentos anularán las especificadas en el archivo de opciones compartidas.
