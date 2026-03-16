# Bibliografias e Citações

## Bibliografias

### Especificando uma Bibliografia

O [Pandoc](https://pandoc.org/MANUAL.html#citations) pode gerar automaticamente citações e uma bibliografia em vários estilos. Para usar esse recurso, você precisará especificar um arquivo de bibliografia usando o campo de metadados `bibliography` em uma seção de metadados YAML. Por exemplo:

```yaml
---
title: "Documento de Exemplo"
output: pdf_document
bibliography: bibliography.bib
---

```

Se você estiver incluindo vários arquivos de bibliografia, você pode defini-los assim:

```yaml
---
bibliography: [bibliography1.bib, bibliography2.bib]
---

```

A bibliografia pode ter qualquer um destes formatos:

| Formato     | Extensão de arquivo |
| ----------- | -------------- |
| BibLaTeX    | .bib           |
| BibTeX      | .bibtex        |
| Copac       | .copac         |
| CSL JSON    | .json          |
| CSL YAML    | .yaml          |
| EndNote     | .enl           |
| EndNote XML | .xml           |
| ISI         | .wos           |
| MEDLINE     | .medline       |
| MODS        | .mods          |
| RIS         | .ris           |

### Referências Inline

Como alternativa, você pode usar um campo `references` nos metadados YAML do documento. Isso deve incluir um array de referências codificadas em YAML, por exemplo:

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

### Posicionamento da Bibliografia

As bibliografias serão colocadas no final do documento. Normalmente, você vai querer terminar seu documento com um cabeçalho apropriado:

```markdown
último parágrafo...

# Referências
```

A bibliografia será inserida após este cabeçalho.

## Citações

### Sintaxe de Citação

As citações ficam dentro de colchetes e são separadas por ponto e vírgula. Cada citação deve ter uma chave, composta por '@' + o identificador da citação no banco de dados, e pode opcionalmente ter um prefixo, um localizador e um sufixo. Aqui estão alguns exemplos:

```
Blah blah [see @doe99, pp. 33-35; also @smith04, ch. 1].

Blah blah [@doe99, pp. 33-35, 38-39 and *passim*].

Blah blah [@smith04; @doe99].
```

Um sinal de menos `(-)` antes do `@` suprimirá a menção do autor na citação. Isso pode ser útil quando o autor já é mencionado no texto:

```
Smith says blah [-@smith04].
```

Você também pode escrever uma citação no texto, da seguinte forma:

```
@smith04 says blah.

@smith04 [p. 33] says blah.
```

### Referências Não Citadas (nocite)

Se você quiser incluir itens na bibliografia sem realmente citá-los no corpo do texto, você pode definir um campo de metadados fictício `nocite` e colocar as citações lá:

```
---
nocite: |
  @item1, @item2
...

@item3
```

Neste exemplo, o documento conterá uma citação apenas para `item3`, mas a bibliografia conterá entradas para `item1`, `item2` e `item3`.

### Estilos de Citação

Por padrão, o pandoc usará o formato autor-data de Chicago para citações e referências. Para usar outro estilo, você precisará especificar um arquivo de estilo CSL 1.0 no campo de metadados `csl`. Por exemplo:

```yaml
---
title: "Documento de Exemplo"
output: pdf_document
bibliography: bibliography.bib
csl: biomed-central.csl
---

```

Um guia sobre como criar e modificar estilos CSL pode ser encontrado [aqui](https://citationstyles.org/downloads/primer.html). Um repositório de estilos CSL pode ser encontrado [aqui](https://github.com/citation-style-language/styles). Veja também https://zotero.org/styles para fácil navegação.

### Citações para Saída PDF

Por padrão, as citações são geradas pelo utilitário pandoc-citeproc, e funciona para todos os formatos de saída. Quando a saída é LaTeX/PDF, você também pode usar pacotes LaTeX (como natbib) para gerar citações; veja [documentos PDF](pandoc-pdf.md) para detalhes.
