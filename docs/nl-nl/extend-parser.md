# Markdown-parser uitbreiden

Voer de opdracht `Markdown Preview Enhanced: Extend Parser (Global)` of `Markdown Preview Enhanced: Extend Parser (Workspace)` uit. Bewerk vervolgens het bestand `parser.js`.

```javascript
({
  /**
   * Hook om de Markdown-code te wijzigen voordat deze wordt geparseerd.
   *
   * @param {String} markdown De originele Markdown-code.
   * @returns {String} De gewijzigde Markdown-code.
   */
  onWillParseMarkdown: async function(markdown) {
    return markdown;
  },

  /**
   * Hook om de HTML-uitvoer van de parser te wijzigen.
   *
   * @param {String} html De HTML-code die door de parser is geretourneerd.
   * @returns {String} De gewijzigde HTML-code.
   */
  onDidParseMarkdown: async function(html) {
    return html;
  },
});
```

Als u bijvoorbeeld `😀` voor elke kop wilt toevoegen, bewerk dan `onWillParseMarkdown` als volgt:

```javascript
  onWillParseMarkdown: async function(markdown) {
      return markdown.replace(/#+\s+/gm, ($0) => $0 + "😀 ");
  },
```

![screen shot 2017-07-14 at 1 04 19 am](https://user-images.githubusercontent.com/1908863/28200243-78e1a10a-6830-11e7-836b-2defc528ee07.png)

Als u bijvoorbeeld `<div class="mermaid"></div>` voor mermaid-grafieken wilt gebruiken:

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
