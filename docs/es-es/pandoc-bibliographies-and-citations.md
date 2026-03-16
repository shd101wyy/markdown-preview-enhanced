# Bibliografías y citas

## Bibliografías

### Especificar una bibliografía

[Pandoc](https://pandoc.org/MANUAL.html#citations) puede generar automáticamente citas y una bibliografía en varios estilos. Para usar esta función, necesitas especificar un archivo de bibliografía usando el campo de metadatos `bibliography` en una sección de metadatos YAML. Por ejemplo:

```yaml
---
title: "Sample Document"
output: pdf_document
bibliography: bibliography.bib
---

```

Si incluyes múltiples archivos de bibliografía, puedes definirlos así:

```yaml
---
bibliography: [bibliography1.bib, bibliography2.bib]
---

```

La bibliografía puede tener cualquiera de estos formatos:

| Formato     | Extensión de archivo |
| ----------- | -------------------- |
| BibLaTeX    | .bib                 |
| BibTeX      | .bibtex              |
| Copac       | .copac               |
| CSL JSON    | .json                |
| CSL YAML    | .yaml                |
| EndNote     | .enl                 |
| EndNote XML | .xml                 |
| ISI         | .wos                 |
| MEDLINE     | .medline             |
| MODS        | .mods                |
| RIS         | .ris                 |

### Referencias en línea

Alternativamente, puedes usar un campo `references` en los metadatos YAML del documento. Este debe incluir un array de referencias codificadas en YAML, por ejemplo:

```yaml
---
references:
  - id: fenner2012a
    title: One-click science marketing
    author:
      - family: Fenner
        given: Martin
    container-title: Nature Materials
    volume: 11
    URL: "https://dx.doi.org/10.1038/nmat3283"
    DOI: 10.1038/nmat3283
    issue: 4
    publisher: Nature Publishing Group
    page: 261-263
    type: article-journal
    issued:
      year: 2012
      month: 3
---

```

### Ubicación de la bibliografía

Las bibliografías se colocarán al final del documento. Normalmente, querrás terminar tu documento con un encabezado apropiado:

```markdown
último párrafo...

# Referencias
```

La bibliografía se insertará después de este encabezado.

## Citas

### Sintaxis de citas

Las citas van dentro de corchetes y se separan por punto y coma. Cada cita debe tener una clave, compuesta de '@' + el identificador de cita de la base de datos, y puede tener opcionalmente un prefijo, un localizador y un sufijo. Aquí hay algunos ejemplos:

```
Blah blah [see @doe99, pp. 33-35; also @smith04, ch. 1].

Blah blah [@doe99, pp. 33-35, 38-39 and *passim*].

Blah blah [@smith04; @doe99].
```

Un signo menos `(-)` antes del `@` suprimirá la mención del autor en la cita. Esto puede ser útil cuando el autor ya se menciona en el texto:

```
Smith says blah [-@smith04].
```

También puedes escribir una cita en el texto, de la siguiente forma:

```
@smith04 says blah.

@smith04 [p. 33] says blah.
```

### Referencias no utilizadas (nocite)

Si deseas incluir elementos en la bibliografía sin citarlos realmente en el cuerpo del texto, puedes definir un campo de metadatos ficticio `nocite` y poner las citas ahí:

```
---
nocite: |
  @item1, @item2
...

@item3
```

En este ejemplo, el documento contendrá una cita para `item3` únicamente, pero la bibliografía contendrá entradas para `item1`, `item2` e `item3`.

### Estilos de cita

Por defecto, pandoc usará el formato autor-fecha de Chicago para citas y referencias. Para usar otro estilo, necesitas especificar un archivo de estilo CSL 1.0 en el campo de metadatos `csl`. Por ejemplo:

```yaml
---
title: "Sample Document"
output: pdf_document
bibliography: bibliography.bib
csl: biomed-central.csl
---

```

Una guía sobre cómo crear y modificar estilos CSL se puede encontrar [aquí](https://citationstyles.org/downloads/primer.html). Un repositorio de estilos CSL se puede encontrar [aquí](https://github.com/citation-style-language/styles). Consulta también https://zotero.org/styles para una navegación sencilla.

### Citas para salida PDF

Por defecto, las citas son generadas por la utilidad pandoc-citeproc y funciona para todos los formatos de salida. Cuando la salida es LaTeX/PDF, también puedes usar paquetes LaTeX (ej. natbib) para generar citas; consulta [documentos PDF](pandoc-pdf.md) para más detalles.
