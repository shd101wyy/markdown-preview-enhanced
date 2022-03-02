# 사용자 정의 CSS 

## style.less

markdown 파일의 css를 사용자 정의 하려면, <kbd>cmd-shift-p</kbd> 다음에 `Markdown Preview Enhanced: Customize Css` 명령을 실행한다.

그러면 `style.less` 파일이 열리고, 다음과 같이 기존의 style을 재정의할 수 있다.:

> `style.less` 파일은 `~/.mume/style.less` 경로에 있다.

```less
.markdown-preview.markdown-preview {
  // please write your custom style here
  // eg:
  //  color: blue;          // change font color
  //  font-size: 14px;      // change font size
  // custom pdf output style
  @media print {
  }

  // custom prince pdf export style
  &.prince {
  }

  // custom presentation style
  .reveal .slides {
    // modify all slides
  }

  .slides > section:nth-child(1) {
    // this will modify `the first slide`
  }
}

.md-sidebar-toc.md-sidebar-toc {
  // sidebar TOC style
}
```

## Local style

Markdown Preview Enhanced 에서는 각각의 markdown 파일에 대해 style을 정의할 수도 있다.  
`id` 와 `class` 를 파일의 front-matter에 설정할 수 있다. 그리고 markdown 파일에 `less` 또는 `css` 파일을 [import](ko-kr/file-imports.md) 할 수 있다:

```markdown
---
id: "my-id"
class: "my-class1 my-class2"
---

@import "my-style.less"

# Heading1
```

`my-style.less`은 다음과 같다.

```less
#my-id {
  background-color: #222;
  color: #fff;

  h1,
  h2,
  h3,
  h4,
  h5,
  h6 {
    color: #fff;
  }
}
```

`less` 파일을 변경한 경우 미리보기 오른쪽 상단의 refresh 버튼을 눌러 less를 css로 다시 컴파일할 수 있다.

![](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## font family 변경

미리보기의 font family를 변경하려면 먼저 폰트 파일 `(.ttf)` 을 다운로드하고 `style.less` 를 다음과 같이 수정하시오:

```less
@font-face {
  font-family: "your-font-family";
  src: url("your-font-file-url");
}

.markdown-preview.markdown-preview {
  font-family: "your-font-family" sans-serif;

  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  pre,
  code {
    font-family: "your-font-family" sans-serif;
  }
}
```
> google 폰트와 같은 온라인 폰트 사용을 권장한다.
