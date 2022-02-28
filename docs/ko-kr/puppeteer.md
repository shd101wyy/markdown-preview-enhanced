# Chrome (Puppeteer) 내보내기

## 설치

[Chrome 브라우저](https://www.google.com/chrome/) 가 설치되어 있어야한다.

> chrome 실행 파일의 경로를 지정할 수 있는 `chromePath` 라는 확장 프로그램 설정이 있다. 기본적으로 수정할 필요가 없다. MPE 확장은 자동으로 경로를 찾는다.

## 사용법

미리보기에서 마우스 오른쪽 버튼을 클릭한 다음, `Chrome (Puppeteer)` 를 선택한다.

## puppeteer 구성

front-matter 내에서 [PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions) 및 [Screenshot](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions) 내보내기 구성을 작성할 수 있다. 예를 들면:

```yaml
---
puppeteer:
  landscape: true
  format: "A4"
  timeout: 3000 # <= Special config, which means waitFor 3000 ms
---

```

## 저장 시 내보내기

```yaml
---
export_on_save:
    puppeteer: true # export PDF on save
    puppeteer: ["pdf", "png"] # export PDF and PNG files on save
    puppeteer: ["png"] # export PNG file on save
---
```

## CSS 사용자 정의

<kbd>cmd-shift-p</kbd> 누른 다음 `Markdown Preview Enhanced: Customize Css` 커맨드를 실행하여 `style.less` 파일을 열고 다음 행을 추가하고 수정한다:

```less
.markdown-preview.markdown-preview {
  @media print {
    // your code here
  }
}
```
