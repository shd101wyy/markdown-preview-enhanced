# Estender o Parser Markdown

Execute o comando `Markdown Preview Enhanced: Extend Parser (Global)` ou `Markdown Preview Enhanced: Extend Parser (Workspace)`. Em seguida, edite o arquivo `parser.js`.

```javascript
({
  /**
   * Hook para modificar o código Markdown antes de ser analisado.
   *
   * @param {String} markdown O código Markdown original.
   * @returns {String} O código Markdown modificado.
   */
  onWillParseMarkdown: async function(markdown) {
    return markdown;
  },

  /**
   * Hook para modificar a saída HTML do analisador.
   *
   * @param {String} html O código HTML retornado pelo analisador.
   * @returns {String} O código HTML modificado.
   */
  onDidParseMarkdown: async function(html) {
    return html;
  },
});
```

Por exemplo, se você quiser acrescentar `😀` a todos os cabeçalhos, basta editar `onWillParseMarkdown` assim:

```javascript
  onWillParseMarkdown: async function(markdown) {
      return markdown.replace(/#+\s+/gm, ($0) => $0 + "😀 ");
  },
```

![screen shot 2017-07-14 at 1 04 19 am](https://user-images.githubusercontent.com/1908863/28200243-78e1a10a-6830-11e7-836b-2defc528ee07.png)

Por exemplo, se você quiser usar `<div class="mermaid"></div>` para gráficos mermaid.

```javascript
  onWillParseMarkdown: async function(markdown) {
    return markdown.replace(
      /\<div\s*class\=\"mermaid\"\>([\w\W]+?)\<\/div\>/g,
      (whole, content) => `
\`\`\`mermaid
${content}
\`\`\`
      `,
    );
  },
```

![screen shot 2017-07-22 at 6 25 01 pm](https://user-images.githubusercontent.com/1908863/28495177-1a307b18-6f0b-11e7-9bfc-23213d7b2e35.png)
