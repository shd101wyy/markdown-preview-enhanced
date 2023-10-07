# Markdown Parser 확장

`Markdown Preview Enhanced: Extend Parser (Global)` 또는 `Markdown Preview Enhanced: Extend Parser (Workspace)` 명령을 실행한 다음 `parser.js` 파일을 편집하세요.

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

예를 들어, 당신이 `😀`를 모든 헤더에 넣고 싶다면, 아래와 같이 `onWillParseMarkdown` 을 수정하면 된다.

```javascript
  onWillParseMarkdown: async function(markdown) {
      return markdown.replace(/#+\s+/gm, ($0) => $0 + "😀 ");
  },
```

![screen shot 2017-07-14 at 1 04 19 am](https://user-images.githubusercontent.com/1908863/28200243-78e1a10a-6830-11e7-836b-2defc528ee07.png)

당신이 mermaid 그래프를 표현하고자 `<div class="mermaid"></div>`을 사용하고 싶다면, 아래와 같이 수정하면 된다.

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
