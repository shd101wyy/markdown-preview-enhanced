# Étendre le parseur Markdown

Exécutez la commande `Markdown Preview Enhanced: Extend Parser (Global)` ou `Markdown Preview Enhanced: Extend Parser (Workspace)`. Puis modifiez le fichier `parser.js`.

```javascript
({
  /**
   * Hook pour modifier le code Markdown avant qu'il soit analysé.
   *
   * @param {String} markdown Le code Markdown original.
   * @returns {String} Le code Markdown modifié.
   */
  onWillParseMarkdown: async function(markdown) {
    return markdown;
  },

  /**
   * Hook pour modifier la sortie HTML du parseur.
   *
   * @param {String} html Le code HTML retourné par le parseur.
   * @returns {String} Le code HTML modifié.
   */
  onDidParseMarkdown: async function(html) {
    return html;
  },
});
```

Par exemple, si vous souhaitez ajouter `😀` en préfixe à chaque en-tête, modifiez `onWillParseMarkdown` comme ceci :

```javascript
  onWillParseMarkdown: async function(markdown) {
      return markdown.replace(/#+\s+/gm, ($0) => $0 + "😀 ");
  },
```

![screen shot 2017-07-14 at 1 04 19 am](https://user-images.githubusercontent.com/1908863/28200243-78e1a10a-6830-11e7-836b-2defc528ee07.png)

Par exemple, si vous souhaitez utiliser `<div class="mermaid"></div>` pour les graphiques mermaid.

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
