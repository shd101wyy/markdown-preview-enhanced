# Advanced document export (beta)
After version `0.8.4`, **Markdown Preview Enhanced** will support `advanced document export` feature that works similar to `RStudio Markdown`.   
To use this feature, you need to have [pandoc](http://pandoc.org/) installed.  
You can use `advanced document export` by right clicking at the preview, then you will see it on the context menu.  

---
## Front-Matter   
`advanced document export` requires writing `front-matter`.  
more information and tutorial about how to write `front-matter` can be found [here](https://jekyllrb.com/docs/frontmatter/).

## Formats
The following formats are currently supported, **more formats will be supported in the future.**  
(Some example are referred from [RStudio Markdown](http://rmarkdown.rstudio.com/formats.html))  
Click the link below to see the document format that you want to export.  

* [PDF](./pandoc/pdf.md)  
* [HTML](./pandoc/html.md)
* [Word](./pandoc/word.md)
* [RTF](./pandoc/rtf.md)
<!-- * [Beamer](./pandoc/beamer.md) -->
<!-- * [ODT](./pandoc/odt.md) -->

## Attention
graphs like `mermaid, wavedrom, viz, plantuml` will not be working with `advanced document export`
