# Exportar com Chrome (Puppeteer)

## Instalação

Você precisa ter o [navegador Chrome](https://www.google.com/chrome/) instalado.

> Há uma configuração de extensão chamada `chromePath` que permite especificar o caminho para o executável do Chrome. Por padrão, você não precisa modificá-la. A extensão MPE buscará o caminho automaticamente.

## Uso

Clique com o botão direito na visualização, depois escolha `Chrome (Puppeteer)`.

## Configurar puppeteer

Você pode escrever a configuração de exportação de [PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions) e [Screenshot](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions) no front-matter. Por exemplo:

```yaml
---
puppeteer:
  landscape: true
  format: "A4"
  timeout: 3000 # <= Configuração especial, que significa aguardar 3000 ms
---

```

## Exportar ao salvar

```yaml
---
export_on_save:
    puppeteer: true # exportar PDF ao salvar
    puppeteer: ["pdf", "png"] # exportar arquivos PDF e PNG ao salvar
    puppeteer: ["png"] # exportar arquivo PNG ao salvar
---
```

## Personalizar CSS

<kbd>cmd-shift-p</kbd> depois execute o comando `Markdown Preview Enhanced: Customize Css` para abrir o arquivo `style.less`, então adicione e modifique as seguintes linhas:

```less
.markdown-preview.markdown-preview {
  @media print {
    // seu código aqui
  }
}
```
