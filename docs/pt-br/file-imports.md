# Importar arquivos externos

![doc-imports](https://cloud.githubusercontent.com/assets/1908863/22716507/f352a4b6-ed5b-11e6-9bac-88837f111de0.gif)

## Como usar?

simplesmente

`@import "seu_arquivo"`

fácil, não é :)

`<!-- @import "seu_arquivo" -->` também é válido.

Ou

```markdown
- sintaxe similar a imagem
  ![](file/path/to/your_file)

- sintaxe similar a wikilink
  ![[ file/path/to/your_file ]]
  ![[ my_file ]]
```

## Botão de atualização

O botão de atualização foi adicionado no canto direito da visualização.
Clicar nele limpará os caches de arquivo e atualizará a visualização.
Pode ser útil se você quiser limpar o cache de imagens. [#144](https://github.com/shd101wyy/markdown-preview-enhanced/issues/144) [#249](https://github.com/shd101wyy/markdown-preview-enhanced/issues/249)

![screen shot 2017-02-07 at 5 48 52 pm](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Tipos de arquivo suportados

- Arquivos `.jpeg(.jpg), .gif, .png, .apng, .svg, .bmp` serão tratados como imagens Markdown.
- Arquivos `.csv` serão convertidos em tabela Markdown.
- Arquivos `.mermaid` serão renderizados pelo mermaid.
- Arquivos `.dot` serão renderizados pelo viz.js (graphviz).
- Arquivos `.plantuml(.puml)` serão renderizados pelo PlantUML.
- Arquivos `.html` serão incorporados diretamente.
- Arquivos `.js` serão incluídos como `<script src="your_js"></script>`.
- Arquivos `.less` e `.css` serão incluídos como estilos. Apenas o arquivo `less` local é suportado atualmente. O arquivo `.css` será incluído como `<link rel="stylesheet" href="your_css">`.
- Arquivos `.pdf` serão convertidos em arquivos `svg` pelo `pdf2svg` e então incluídos.
- Arquivos `markdown` serão analisados e incorporados diretamente.
- Todos os outros arquivos serão renderizados como bloco de código.

## Configurar imagens

```markdown
@import "test.png" {width="300px" height="200px" title="meu título" alt="meu alt"}

![](test.png){width="300px" height="200px"}

![[ test.png ]]{width="300px" height="200px"}
```

## Importar arquivos online

Por exemplo:

```markdown
@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"
```

## Importar arquivo PDF

Para importar um arquivo PDF, você precisa ter o [pdf2svg](extra.md) instalado.
Markdown Preview Enhanced suporta a importação de arquivos PDF locais e online.
No entanto, não é recomendado importar arquivos PDF grandes.
Por exemplo:

```markdown
@import "test.pdf"
```

### Configuração de PDF

- **page_no**
  Exibe a `n-ésima` página do PDF. Indexação começa em 1. Por exemplo, `{page_no=1}` exibirá a 1ª página do PDF.
- **page_begin**, **page_end**
  Inclusivo. Por exemplo, `{page_begin=2 page_end=4}` exibirá as páginas 2, 3 e 4.

## Forçar renderização como Bloco de Código

```markdown
@import "test.puml" {code_block=true class="line-numbers"}
@import "test.py" {class="line-numbers"}
```

## Como Bloco de Código

```markdown
@import "test.json" {as="vega-lite"}
```

## Importar certas linhas

```markdown
@import "test.md" {line_begin=2}
@import "test.md" {line_begin=2 line_end=10}
@import "test.md" {line_end=-4}
```

## Importar arquivo como Code Chunk

```markdown
@import "test.py" {cmd="python3"}
```

[➔ Code Chunk](code-chunk.md)
