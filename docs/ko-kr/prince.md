# Prince PDF 내보내기

**Markdown Preview Enhanced** 는 [prince](https://www.princexml.com/) pdf 내보내기를 지원한다.

## 설치

[prince](https://www.princexml.com/)가 설치되어 있어야 한다.
`macOS`의 경우 터미널을 열고 다음 명령을 실행한다:

```sh
brew install Caskroom/cask/prince
```

## 사용법

미리보기에서 마우스 오른쪽 버튼을 클릭한 다음, `PDF (prince)` 를 선택한다.

![screen shot 2017-07-14 at 1 44 23 am](https://user-images.githubusercontent.com/1908863/28201287-fb5ea8d0-6835-11e7-9bdb-2afb458ee5cc.png)

## CSS 사용자 정의

<kbd>cmd-shift-p</kbd> 누른 다음 `Markdown Preview Enhanced: Customize Css` 커맨드를 실행하여 `style.less` 파일을 열고 다음 행을 추가하고 수정한다:

```less
.markdown-preview.markdown-preview {
  &.prince {
    // your prince css here
  }
}
```

예를 들어, 페이지 크기를 `A4 landscape` 로 변경하려면:

```less
.markdown-preview.markdown-preview {
  &.prince {
    @page {
      size: A4 landscape;
    }
  }
}
```

자세한 내용은 [prince 사용자 가이드](https://www.princexml.com/doc/) 에서 확인할 수 있다.
특히 [page styles](https://www.princexml.com/doc/paged/#page-styles) 에서 확인할 수 있다.

## 저장 시 내보내기

fromt-matter에 다음과 같이 추가시켜준다.

```yaml
---
export_on_save:
  prince: true
---

```

따라서 markdown 소스 파일을 저장할 때마다 PDF 파일이 생성된다.

## 알려진 문제

- `KaTeX` 및 `MathJax` 에서는 작동하지 않는다.
