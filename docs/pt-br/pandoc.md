# Pandoc

**Markdown Preview Enhanced** suporta o recurso de `exportação de documento pandoc` que funciona de forma semelhante ao `RStudio Markdown`.  
Para usar esse recurso, você precisa ter o [pandoc](https://pandoc.org/) instalado.  
As instruções de instalação do pandoc podem ser encontradas [aqui](https://pandoc.org/installing.html).  
Você pode usar a `exportação de documento pandoc` clicando com o botão direito na visualização, onde você a verá no menu de contexto.

---

## Analisador Pandoc

Por padrão, **Markdown Preview Enhanced** usa [markdown-it](https://github.com/markdown-it/markdown-it) para analisar Markdown.  
Você também pode configurá-lo para usar o analisador `pandoc` nas configurações do pacote.

![Screen Shot 2017-03-07 at 10.05.25 PM](https://i.imgur.com/NdCJBgR.png)

Você também pode definir argumentos pandoc para arquivos individuais escrevendo front-matter:

```markdown
---
pandoc_args: ["--toc", "--toc-depth=2"]
---
```

Observe que `--filter=pandoc-citeproc` será automaticamente adicionado se houver `references` ou `bibliography` no seu front-matter.

**Atenção**: Este recurso ainda é experimental. Sinta-se à vontade para publicar issues ou sugestões.  
**Problemas & Limitações Conhecidos**:

1. A exportação `ebook` apresenta problemas.
2. O `Code Chunk` às vezes apresenta bugs.

## Front-Matter

A `exportação de documento pandoc` requer a escrita de `front-matter`.  
Mais informações e tutoriais sobre como escrever `front-matter` podem ser encontrados [aqui](https://jekyllrb.com/docs/frontmatter/).

## Exportar

Você não precisa usar o `Analisador Pandoc` mencionado acima para exportar arquivos.

Os seguintes formatos são atualmente suportados, **mais formatos serão suportados no futuro.**  
(Alguns exemplos são referenciados do [RStudio Markdown](https://rmarkdown.rstudio.com/formats.html))  
Clique no link abaixo para ver o formato de documento que você quer exportar.

- [PDF](pandoc-pdf.md)
- [Word](pandoc-word.md)
- [RTF](pandoc-rtf.md)
- [Beamer](pandoc-beamer.md)

Você também pode definir seu próprio documento personalizado:

- [Personalizado](pandoc-custom.md)

## Exportar ao salvar

Adicione o front-matter como abaixo:

```yaml
---
export_on_save:
  pandoc: true
---

```

Assim o pandoc será executado toda vez que você salvar seu arquivo Markdown.

## Artigos

- [Bibliografias e Citações](pandoc-bibliographies-and-citations.md)

## Atenção

`mermaid, wavedrom` não funcionarão com `exportação de documento pandoc`.  
[code chunk](code-chunk.md) é parcialmente compatível com `exportação de documento pandoc`.
