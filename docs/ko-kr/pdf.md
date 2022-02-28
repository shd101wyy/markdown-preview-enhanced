# PDF 내보내기

> [Chrome (Puppeteer) 를 사용하여 PDF 내보내기](./puppeteer.md) 를 사용하는 것이 좋다.

## 사용법

미리보기에서 마우스 오른쪽 버튼을 클릭한 다음, `Open in Browser` 를 선택한다.
브라우저에서 PDF로 인쇄.

![screen shot 2017-07-14 at 1 46 39 am](https://user-images.githubusercontent.com/1908863/28201366-536dbc0a-6836-11e7-866f-db9a5d12de16.png)

## CSS 사용자 정의

<kbd>cmd-shift-p</kbd> 을 누른 다음 `Markdown Preview Enhanced: Customize Css` 명령을 실행하여 `style.less` 파일을 열고 다음 행을 추가하고 수정한다:

```less
.markdown-preview.markdown-preview {
  @media print {
    // your code here
  }
}
```

---

[puppeteer](puppeteer.md) 또는 [prince](prince.md)로 PDF 파일을 생성할 수도 있습니다
