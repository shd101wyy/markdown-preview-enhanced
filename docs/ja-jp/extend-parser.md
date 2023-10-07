# Markdown Parser の拡張

`Markdown Preview Enhanced: Extend Parser (Global)` または `Markdown Preview Enhanced: Extend Parser (Workspace)` コマンドを実行してから、`parser.js` ファイルを編集してください。

```javascript
({
  onWillParseMarkdown: async function(markdown) {
    return markdown;
  },

  onDidParseMarkdown: async function(html) {
    return html;
  },

  onWillTransformMarkdown: async function(markdown) {
    return markdown;
  },

  onDidTransformMarkdown: async function(markdown) {
    return markdown;
  },
});
```

たとえば、すべての見出しの前に `😀` を付ける場合は、次のように `onWillParseMarkdown` を編集します。

```javascript
  onWillParseMarkdown: async function(markdown) {
      return markdown.replace(/#+\s+/gm, ($0) => $0 + "😀 ");
  },
```

![screen shot 2017-07-14 at 1 04 19 am](https://user-images.githubusercontent.com/1908863/28200243-78e1a10a-6830-11e7-836b-2defc528ee07.png)

たとえば、mermaid ダイアグラムに `<div class="mermaid"></div>` を使用したい場合。

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
