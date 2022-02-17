# Markdown Parser 확장

`Markdown Preview Enhanced: Extend Parser` 명령어로 실행한다.  
그리고 `parser.js` 파일을 편집한다..

> `parser.js` 파일은 `~/.mume/parser.js` 경로에 위치한다.

```javascript
module.exports = {
  onWillParseMarkdown: function(markdown) {
    return new Promise((resolve, reject) => {
      return resolve(markdown);
    });
  },
  onDidParseMarkdown: function(html) {
    return new Promise((resolve, reject) => {
      return resolve(html);
    });
  },
};
```

예를 들어, 당신이 `😀`를 모든 헤더에 넣고 싶다면, 아래와 같이 `onWillParseMarkdown` 을 수정하면 된다.

```javascript
module.exports = {
  onWillParseMarkdown: function(markdown) {
    return new Promise((resolve, reject) => {
      markdown = markdown.replace(/#+\s+/gm, ($0) => $0 + "😀 ");
      return resolve(markdown);
    });
  },
};
```

![screen shot 2017-07-14 at 1 04 19 am](https://user-images.githubusercontent.com/1908863/28200243-78e1a10a-6830-11e7-836b-2defc528ee07.png)

당신이 mermaid 그래프를 표현하고자 `<div class="mermaid"></div>`을 사용하고 싶다면, 아래와 같이 수정하면 된다.

```javascript
module.exports = {
  onWillParseMarkdown: function(markdown) {
    return new Promise((resolve, reject) => {
      markdown = markdown.replace(
        /\<div\s*class\=\"mermaid\"\>([\w\W]+?)\<\/div\>/g,
        (whole, content) => `
\`\`\`mermaid
${content}
\`\`\`
        `,
      );
      return resolve(markdown);
    });
  },
};
```

![](https://user-images.githubusercontent.com/1908863/28495177-1a307b18-6f0b-11e7-9bfc-23213d7b2e35.png)
![screen shot 2017-07-22 at 6 25 01 pm](https://user-images.githubusercontent.com/1908863/28495177-1a307b18-6f0b-11e7-9bfc-23213d7b2e35.png)