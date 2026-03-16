# Pandoc

**Markdown Preview Enhanced** admite la función de `exportación de documentos pandoc`, que funciona de manera similar a `RStudio Markdown`.  
Para usar esta función, necesitas tener [pandoc](https://pandoc.org/) instalado.  
Las instrucciones de instalación de pandoc se pueden encontrar [aquí](https://pandoc.org/installing.html).  
Puedes usar la `exportación de documentos pandoc` haciendo clic derecho en la vista previa; aparecerá en el menú contextual.

---

## Analizador Pandoc

Por defecto, **Markdown Preview Enhanced** usa [markdown-it](https://github.com/markdown-it/markdown-it) para analizar Markdown.  
También puedes configurarlo para usar el analizador `pandoc` desde la configuración del paquete.

![Screen Shot 2017-03-07 at 10.05.25 PM](https://i.imgur.com/NdCJBgR.png)

También puedes establecer argumentos de pandoc para archivos individuales escribiendo el front-matter:

```markdown
---
pandoc_args: ["--toc", "--toc-depth=2"]
---
```

Ten en cuenta que `--filter=pandoc-citeproc` se añadirá automáticamente si hay `references` o `bibliography` en tu front-matter.

**Atención**: Esta función aún es experimental. No dudes en publicar issues o sugerencias.  
**Problemas conocidos y limitaciones**:

1. La exportación a `ebook` tiene problemas.
2. `Code Chunk` a veces tiene errores.

## Front-Matter

La `exportación de documentos pandoc` requiere escribir `front-matter`.  
Más información y tutoriales sobre cómo escribir `front-matter` se pueden encontrar [aquí](https://jekyllrb.com/docs/frontmatter/).

## Exportar

No es necesario usar el `Analizador Pandoc` mencionado anteriormente para exportar archivos.

Los siguientes formatos están actualmente soportados; **se admitirán más formatos en el futuro.**  
(Algunos ejemplos están referenciados de [RStudio Markdown](https://rmarkdown.rstudio.com/formats.html))  
Haz clic en el enlace para ver el formato de documento que deseas exportar.

- [PDF](pandoc-pdf.md)
- [Word](pandoc-word.md)
- [RTF](pandoc-rtf.md)
- [Beamer](pandoc-beamer.md)

También puedes definir tu propio documento personalizado:

- [personalizado](pandoc-custom.md)

## Exportar al guardar

Agrega el front-matter como se muestra a continuación:

```yaml
---
export_on_save:
  pandoc: true
---

```

Así, pandoc se ejecutará cada vez que guardes tu archivo Markdown de origen.

## Artículos

- [Bibliografías y citas](pandoc-bibliographies-and-citations.md)

## Atención

`mermaid, wavedrom` no funcionarán con la `exportación de documentos pandoc`.  
El [code chunk](code-chunk.md) es parcialmente compatible con la `exportación de documentos pandoc`.
