# Markdown Ayrıştırıcıyı Genişletme

`Markdown Preview Enhanced: Extend Parser (Global)` veya `Markdown Preview Enhanced: Extend Parser (Workspace)` komutunu çalıştırın. Ardından `parser.js` dosyasını düzenleyin.

```javascript
({
  /**
   * Markdown kodu ayrıştırılmadan önce değiştirmek için kanca.
   *
   * @param {String} markdown Orijinal Markdown kodu.
   * @returns {String} Değiştirilmiş Markdown kodu.
   */
  onWillParseMarkdown: async function(markdown) {
    return markdown;
  },

  /**
   * Ayrıştırıcının HTML çıktısını değiştirmek için kanca.
   *
   * @param {String} html Ayrıştırıcı tarafından döndürülen HTML kodu.
   * @returns {String} Değiştirilmiş HTML kodu.
   */
  onDidParseMarkdown: async function(html) {
    return html;
  },
});
```

Örneğin, her başlığın önüne `😀` eklemek istiyorsanız, `onWillParseMarkdown`'ı şu şekilde düzenleyin:

```javascript
  onWillParseMarkdown: async function(markdown) {
      return markdown.replace(/#+\s+/gm, ($0) => $0 + "😀 ");
  },
```

![screen shot 2017-07-14 at 1 04 19 am](https://user-images.githubusercontent.com/1908863/28200243-78e1a10a-6830-11e7-836b-2defc528ee07.png)

Örneğin, mermaid grafikleri için `<div class="mermaid"></div>` kullanmak istiyorsanız:

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
