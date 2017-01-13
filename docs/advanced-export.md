# Pandoc document export (beta)
After version `0.8.4`, **Markdown Preview Enhanced** supports `pandoc document export` feature that works similarly to `RStudio Markdown`.   
To use this feature, you need to have [pandoc](http://pandoc.org/) installed.   
Installation instruction of pandoc can be found [here](http://pandoc.org/installing.html).  
You can use `pandoc document export` by right clicking at the preview, then you will see it on the context menu.  

---
## Front-Matter   
`pandoc document export` requires writing `front-matter`.  
more information and tutorial about how to write `front-matter` can be found [here](https://jekyllrb.com/docs/frontmatter/).

## Formats
The following formats are currently supported, **more formats will be supported in the future.**  
(Some examples are referred from [RStudio Markdown](http://rmarkdown.rstudio.com/formats.html))  
Click the link below to see the document format that you want to export.  

* [PDF](./pandoc/pdf.md)  
* [Word](./pandoc/word.md)
* [RTF](./pandoc/rtf.md)
* [Beamer](./pandoc/beamer.md)  


You can also define your own custom document:  
* [custom](./pandoc/custom.md)

## Articles  
* [Bibliographies and Citations](./pandoc/bibliographies-and-citations.md)

## Attention
`mermaid, wavedrom` will not be working with `pandoc document export`.      
[code chunk](./code-chunk.md) is partially compatible with `pandoc document export`.    
