# Exportar PDF com Prince

**Markdown Preview Enhanced** suporta a exportação de PDF via [prince](https://www.princexml.com/).

## Instalação

Você precisa ter o [prince](https://www.princexml.com/) instalado.
Para `macOS`, abra o terminal e execute o seguinte comando:

```sh
brew install Caskroom/cask/prince
```

## Uso

Clique com o botão direito na visualização, depois escolha `PDF (prince)`.

![screen shot 2017-07-14 at 1 44 23 am](https://user-images.githubusercontent.com/1908863/28201287-fb5ea8d0-6835-11e7-9bdb-2afb458ee5cc.png)

## Personalizar CSS

<kbd>cmd-shift-p</kbd> depois execute o comando `Markdown Preview Enhanced: Customize Css` para abrir o arquivo `style.less`, então adicione e modifique as seguintes linhas:

```less
.markdown-preview.markdown-preview {
  &.prince {
    // seu css prince aqui
  }
}
```

Por exemplo, para alterar o tamanho da página para `A4 paisagem`:

```less
.markdown-preview.markdown-preview {
  &.prince {
    @page {
      size: A4 landscape;
    }
  }
}
```

Mais informações podem ser encontradas no [guia do usuário do prince](https://www.princexml.com/doc/).
Especialmente [estilos de página](https://www.princexml.com/doc/paged/#page-styles).

## Exportar ao salvar

Adicione o front-matter como abaixo:

```yaml
---
export_on_save:
  prince: true
---

```

Assim o arquivo PDF será gerado toda vez que você salvar seu arquivo Markdown.

## Problemas conhecidos

- Não funciona com `KaTeX` e `MathJax`.
