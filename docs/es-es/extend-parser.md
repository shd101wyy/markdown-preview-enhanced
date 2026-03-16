# Extender el Parser de Markdown

Ejecuta el comando `Markdown Preview Enhanced: Extend Parser (Global)` o `Markdown Preview Enhanced: Extend Parser (Workspace)`. Luego edita el archivo `parser.js`.

```javascript
({
  /**
   * Hook para modificar el código Markdown antes de que sea analizado.
   *
   * @param {String} markdown El código Markdown original.
   * @returns {String} El código Markdown modificado.
   */
  onWillParseMarkdown: async function(markdown) {
    return markdown;
  },

  /**
   * Hook para modificar la salida HTML del analizador.
   *
   * @param {String} html El código HTML devuelto por el analizador.
   * @returns {String} El código HTML modificado.
   */
  onDidParseMarkdown: async function(html) {
    return html;
  },
});
```

Por ejemplo, si deseas añadir `😀` al principio de cada encabezado, edita `onWillParseMarkdown` así:

```javascript
  onWillParseMarkdown: async function(markdown) {
      return markdown.replace(/#+\s+/gm, ($0) => $0 + "😀 ");
  },
```

![screen shot 2017-07-14 at 1 04 19 am](https://user-images.githubusercontent.com/1908863/28200243-78e1a10a-6830-11e7-836b-2defc528ee07.png)

Por ejemplo, si deseas usar `<div class="mermaid"></div>` para gráficos mermaid:

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
