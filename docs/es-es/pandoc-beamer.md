# Documento Beamer

## Descripción general

Para crear una presentación Beamer desde **Markdown Preview Enhanced**, especifica el formato de salida `beamer_presentation` en el front-matter de tu documento.  
Puedes crear una presentación de diapositivas dividida en secciones usando las etiquetas de encabezado `#` y `##` (también puedes crear una nueva diapositiva sin encabezado usando una regla horizontal (`----`).  
Por ejemplo, aquí hay una presentación de diapositivas simple:

```markdown
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: beamer_presentation
---

# Por la mañana

## Levantarse

- Apagar la alarma
- Salir de la cama

## Desayuno

- Comer huevos
- Tomar café

# Por la tarde

## Cena

- Comer espaguetis
- Tomar vino

---

![foto de espaguetis](images/spaghetti.jpg)

## Ir a dormir

- Meterse en la cama
- Contar ovejas
```

## Ruta de exportación

Puedes definir la ruta de exportación del documento especificando la opción `path`. Por ejemplo:

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    path: /Exports/Habits.pdf
---

```

Si `path` no está definido, el documento se generará en el mismo directorio.

## Viñetas incrementales

Puedes renderizar las viñetas de forma incremental añadiendo la opción `incremental`:

```yaml
---
output:
  beamer_presentation:
    incremental: true
---

```

Si deseas renderizar las viñetas de forma incremental solo en algunas diapositivas, puedes usar esta sintaxis:

```markdown
> - Comer huevos
> - Tomar café
```

## Temas

Puedes especificar temas Beamer usando las opciones `theme`, `colortheme` y `fonttheme`:

```yaml
---
output:
  beamer_presentation:
    theme: "AnnArbor"
    colortheme: "dolphin"
    fonttheme: "structurebold"
---

```

## Tabla de contenidos

La opción `toc` especifica que se debe incluir una tabla de contenidos al principio de la presentación (solo se incluirán los encabezados de nivel 1 en la tabla de contenidos). Por ejemplo:

```yaml
---
output:
  beamer_presentation:
    toc: true
---

```

## Nivel de diapositiva

La opción `slide_level` define el nivel de encabezado que define las diapositivas individuales. Por defecto, es el nivel de encabezado más alto en la jerarquía que va seguido inmediatamente de contenido, y no de otro encabezado, en algún lugar del documento. Este valor predeterminado puede anularse especificando un `slide_level` explícito:

```yaml
---
output:
  beamer_presentation:
    slide_level: 2
---

```

## Resaltado de sintaxis

La opción `highlight` especifica el estilo de resaltado de sintaxis. Los estilos admitidos incluyen "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn" y "haddock" (especifica null para evitar el resaltado de sintaxis):

Por ejemplo:

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    highlight: tango
---

```

## Argumentos de Pandoc

Si hay funciones de pandoc que deseas usar y que no tienen equivalentes en las opciones YAML descritas anteriormente, aún puedes usarlas pasando `pandoc_args` personalizados. Por ejemplo:

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Opciones compartidas

Si deseas especificar un conjunto de opciones predeterminadas para compartir entre múltiples documentos en un directorio, puedes incluir un archivo llamado `_output.yaml` en ese directorio. Ten en cuenta que no se usan delimitadores YAML ni objeto de salida encapsulado en este archivo. Por ejemplo:

**\_output.yaml**

```yaml
beamer_presentation:
  toc: true
```

Todos los documentos ubicados en el mismo directorio que `_output.yaml` heredarán sus opciones. Las opciones definidas explícitamente en los documentos anularán las especificadas en el archivo de opciones compartidas.
