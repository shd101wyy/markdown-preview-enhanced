# Personalizar CSS

## style.less

Para personalizar o CSS para seu arquivo Markdown, pressione <kbd>cmd-shift-p</kbd> e execute o comando `Markdown Preview Enhanced: Customize CSS (Global)` ou `Markdown Preview Enhanced: Customize CSS (Workspace)`.

O arquivo `style.less` será aberto, e você pode sobrescrever o estilo existente assim:

```less
.markdown-preview.markdown-preview {
  // por favor, escreva seu estilo personalizado aqui
  // ex:
  //  color: blue;          // alterar a cor da fonte
  //  font-size: 14px;      // alterar o tamanho da fonte
  // estilo personalizado para saída pdf
  @media print {
  }

  // estilo personalizado para exportação pdf via prince
  &.prince {
  }

  // estilo personalizado para apresentação
  .reveal .slides {
    // modificar todos os slides
  }

  .slides > section:nth-child(1) {
    // isso irá modificar `o primeiro slide`
  }
}

.md-sidebar-toc.md-sidebar-toc {
  // estilo do TOC lateral
}
```

## Estilo local

Markdown Preview Enhanced também permite que você defina estilos diferentes para arquivos Markdown diferentes.  
`id` e `class` podem ser configurados dentro do front-matter.
Você pode [importar](file-imports.md) um arquivo `less` ou `css` no seu arquivo Markdown facilmente:

```markdown
---
id: "my-id"
class: "my-class1 my-class2"
---

@import "my-style.less"

# Cabeçalho 1
```

o `my-style.less` pode ser assim:

```less
#my-id {
  background-color: #222;
  color: #fff;

  h1,
  h2,
  h3,
  h4,
  h5,
  h6 {
    color: #fff;
  }
}
```

Toda vez que você alterar seu arquivo `less`, você pode clicar no botão de atualização no canto superior direito da visualização para recompilar less para css.

![](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Alterar a família de fontes

Para alterar a família de fontes da visualização, você primeiro precisa baixar o arquivo de fonte `(.ttf)`, depois modificar `style.less` como abaixo:

```less
@font-face {
  font-family: "sua-familia-de-fontes";
  src: url("url-do-seu-arquivo-de-fonte");
}

.markdown-preview.markdown-preview {
  font-family: "sua-familia-de-fontes", sans-serif;

  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  pre,
  code {
    font-family: "sua-familia-de-fontes", sans-serif;
  }
}
```

> No entanto, recomenda-se usar fontes online como as do Google Fonts.
