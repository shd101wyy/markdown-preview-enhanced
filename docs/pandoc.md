# Pandoc
**Markdown Preview Enhanced** supports `pandoc document export` feature that works similarly to `RStudio Markdown`.   
To use this feature, you need to have [pandoc](http://pandoc.org/) installed.   
Installation instruction of pandoc can be found [here](http://pandoc.org/installing.html).  
You can use `pandoc document export` by right clicking at the preview, then you will see it on the context menu.  

---

## Pandoc Parser
By default **Markdown Preview Enhanced** uses [remarkable](https://github.com/jonschlinkert/remarkable) to parse markdown.  
You can also set it to `pandoc` parser from package settings.    

![Screen Shot 2017-03-07 at 10.05.25 PM](http://i.imgur.com/NdCJBgR.png)  

You can also set pandoc arguments for individual files by writing front-matter   
```markdown
---
pandoc_args: ['--toc', '--toc-depth=2']
---
```

Please note that `--filter=pandoc-citeproc` will be automatically added if there is `references` or `bibliography` in your front-matter.    

**Attention**: This feature is still experimental. Feel free to post issues or suggestions.    
**Known Issues & Limitations**:  
1. `ebook` export has problem.  
2. `Code Chunk` is sometimes buggy.  
3. `Create TOC` command doesn't work, but `[TOC]` works.  

## Front-Matter   
`pandoc document export` requires writing `front-matter`.  
More information and tutorial about how to write `front-matter` can be found [here](https://jekyllrb.com/docs/frontmatter/).

## Exports

You don't have to use the `Pandoc Parser` that I mentioned above to export files.    

The following formats are currently supported, **more formats will be supported in the future.**  
(Some examples are referred from [RStudio Markdown](http://rmarkdown.rstudio.com/formats.html))  
Click the link below to see the document format that you want to export.  

* [PDF](pandoc-pdf.md)  
* [Word](pandoc-word.md)
* [RTF](pandoc-rtf.md)
* [Beamer](pandoc-beamer.md)  


You can also define your own custom document:  
* [custom](pandoc-custom.md)

## Articles  
* [Bibliographies and Citations](pandoc-bibliographies-and-citations.md)

## Attention
`mermaid, wavedrom` will not be working with `pandoc document export`.      
[code chunk](code-chunk.md) is partially compatible with `pandoc document export`.    
