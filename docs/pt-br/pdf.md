# Exportar PDF

> Recomendamos usar o [Chrome (Puppeteer) para exportar PDF](puppeteer.md).

## Uso

Clique com o botão direito na visualização, depois escolha `Open in Browser`.
Imprima como PDF no navegador.

![screen shot 2017-07-14 at 1 46 39 am](https://user-images.githubusercontent.com/1908863/28201366-536dbc0a-6836-11e7-866f-db9a5d12de16.png)

## Personalizar CSS

<kbd>cmd-shift-p</kbd> depois execute o comando `Markdown Preview Enhanced: Customize Css` para abrir o arquivo `style.less`, então adicione e modifique as seguintes linhas:

```less
.markdown-preview.markdown-preview {
  @media print {
    // seu código aqui
  }
}
```

---

Você também pode gerar arquivo PDF via [puppeteer](puppeteer.md) ou [prince](prince.md).
