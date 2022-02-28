# eBook 생성

_GitBook_ 에서 영감을 받음.  
**Markdown Preview Enhanced**는 컨텐츠를 ebook(ePub, Mobi, PDF)로 출력할 수 있다.

![Screen Shot 2016-09-08 at 9.42.43 PM](https://ooo.0o0.ooo/2016/09/09/57d221c0a618a.png)

ebook을 생성하려면 `ebook-convert`가 설치되어 있어야 한다.

## ebook-convert 설치

**macOS**  
[Calibre Application](https://calibre-ebook.com/download)을 다운로드하시오. `calibre.app` 를 응용 프로그램 폴더로 이동한 후 `ebook-convert` 도구에 대한 심볼릭 링크를 만든다:

```shell
$ sudo ln -s ~/Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin
```

**Windows**  
[Calibre Application](https://calibre-ebook.com/download)을 다운로드하고 설치한다. `$PATH`에 `ebook-convert`를 추가한다.

## eBook 예제

eBook 샘플 프로젝트는 [여기](https://github.com/shd101wyy/ebook-example)에 있다.

## eBook 작성 시작하기

markdown 파일에 `ebook front-matter`를 추가하기만 하면 ebook 설정을 구성할 수 있다.

```yaml
---
ebook:
  theme: github-light.css
  title: My eBook
  authors: shd101wyy
---

```

---

## 데모

`SUMMARY.md`는 sample entry 파일이다. 책을 정리하는 목차가 붙어 있다:

```markdown
---
ebook:
  theme: github-light.css
  title: Markdown Preview Enhanced
  author: shd101wyy
---

# Preface

This is the preface, but not necessary.

# Table of Contents

- [Chapter 1](/chapter1/README.md)
  - [Introduction of Markdown Preview Enhanced](/chapter1/intro.md)
  - [Features](/chapter1/feature.md)
- [Chapter 2](/chapter2/README.md)
  - [Known issues](/chapter2/issues.md)
```

markdown 파일의 마지막 list는 목차로 간주된다.

링크의 제목은 챕터의 제목으로 사용되며 링크의 대상은 해당 챕터의 파일에 대한 경로다.

---

전자책을 내보내려면 미리보기를 연 상태에서 `SUMMARY.md` 를 연다. 그런 다음 미리보기를 마우스 오른쪽 단추로 클릭하고 `Export to Disk` 를 선택한 다음 `EBOOK` 옵션을 선택해서 ebook을 내보낼 수 있다.

### Metadata

- **theme**  
  eBook에 사용할 테마. 기본적으로 미리보기 테마를 사용한다. 사용 가능한 테마 목록은 [이 문서](https://github.com/shd101wyy/mume/#markdown-engine-configuration) 의 `previewTheme` 섹션에 있다.
- **title**  
  ebook의 제목
- **authors**  
  저자1 & 저자2 & ...
- **cover**  
  https://path-to-image.png
- **comments**  
  ebook에 대한 설명
- **publisher**  
  ebook의 퍼블리셔
- **book-producer**  
  ebook의 프로듀서
- **pubdate**  
  ebook 발행일
- **language**  
  ebook의 언어
- **isbn**  
  ebook의 ISBN
- **tags**  
  ebook의 태그를 설정한다. 목록은 쉼표로 구분되어 있어야 한다.
- **series**  
  ebook이 속한 시리즈
- **rating**  
  ebook의 평점. 1에서 5점 사이의 숫자로 설정되어야 한다.
- **include_toc**  
  `기본값: true` 항목 파일에 기록한 목차를 포함할지 여부를 설정한다.

예:

```yaml
ebook:
  title: My eBook
  author: shd101wyy
  rating: 5
```

### Feel and Look

다음 옵션은 출력의 look and feel을 제어하는 데 도움을 준다.

- **asciiize** `[true/false]`  
  `기본값: false`, 유니코드 문자를 ASCII 표현으로 변환한다. 이것은 유니 코드 문자를 ASCII로 대체하므로 주의해서 사용하시오.
- **base-font-size** `[number]`  
  기본 글꼴 크기를 포인트 단위로 설정한다. 작성된 ebook의 모든 폰트 사이즈는, 이 사이즈에 의해 재조정 된다. 큰 사이즈를 선택해 출력의 폰트를 크게 하거나, 그 반대를 할 수도 있다. 기본적으로 기본 글꼴 크기는 선택한 출력 프로필을 기반으로 선택된다.
- **disable-font-rescaling** `[true/false]`  
  `기본값: false` 글꼴 크기의 모든 재조정을 비활성화한다.
- **line-height** `[number]`  
  포인트 단위로 줄 높이를 설정한다. 연속된 텍스트 줄 사이의 간격을 제어한다. 고유한 행의 높이를 정의하지 않는 요소에만 적용된다. 대부분의 경우 최소 행 높이 옵션이 더 편리하다. 기본적으로 행 높이 조작은 수행되지 않는다.
- **margin-top** `[number]`  
  `기본값: 72.0` 상단 여백을 포인트 단위로 설정한다. 이것을 0보다 작게 설정하면 여백이 설정되지 않는다 (원본 문서의 여백 설정은 유지된다). 참고 : 72 포인트는 1 인치에 해당함
- **margin-right** `[number]`  
  `기본값: 72.0`
- **margin-bottom** `[number]`  
  `기본값: 72.0`
- **margin-left** `[number]`  
  `기본값: 72.0`
- **margin** `[number/array]`  
  `기본값: 72.0`  
  **상하좌우 여백** 을 동시에 정의할 수 있다. 예를 들어:

```yaml
ebook:
  margin: 5 # margin-top = margin-right = margin-bottom = margin-left = 5
```

```yaml
ebook:
  margin: [4, 8] # margin-top = margin-bottom = 4, margin-left = margin-right = 8
```

```yaml
ebook:
  margin: [1, 2, 3, 4] # margin-top=1, margin-right=2, margin-bottom=3, margin-left=4
```

예:

```yaml
ebook:
  title: My eBook
  base-font-size: 8
  margin: 72
```

## 출력 형식

현재 ebook을 `ePub`, `mobi`, `pdf`, `html` 형식으로 출력할 수 있다.

### ePub

`ePub` 출력을 설정하려면 `ebook` 뒤에 `epub` 을 추가한다.

```yaml
---
ebook:
  epub:
    no-default-epub-cover: true
    pretty-print: true
---

```

다음의 옵션들을 사용할 수 있다:

- **no-default-epub-cover** `[true/false]`  
  일반적으로 입력 파일에 표지가 없고 지정되지 않았으면, 기본 표지가 제목, 저자 등과 함께 생성된다. 이 옵션은 이 표지 생성을 비활성화한다.
- **no-svg-cover** `[true/false]`  
  표지에 SVG를 사용하지 마시오. iPhone 또는 JetBook Lite와 같은 SVG를 지원하지 않는 장치에서 EPUB를 사용하려면 이 옵션을 사용한다. 이 옵션이 없으면 이러한 장치는 표지를 빈 페이지로 표시할 것이다.
- **pretty-print** `[true/false]`  
  지정된 경우 출력 플러그인은 가능한 한 인간이 읽을 수 있는 형식의 출력을 작성하려고 한다. 일부 출력 플러그인에는 효과가 없을 수 있다.  

### PDF

`pdf` 출력을 설정하려면 `ebook` 뒤에 `pdf` 를 추가한다.

```yaml
ebook:
  pdf:
    paper-size: letter
    default-font-size: 12
    header-template: "<span> Written by shd101wyy _PAGENUM_ </span>"
```

다음의 옵션들을 사용할 수 있다:

- **paper-size**  
  용지 크기. 이 크기는 기본이 아닌 출력 프로파일을 사용할 때 재정의 된다. 기본값은 letter 이다. `a0`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `b0`, `b1`, `b2`, `b3`, `b4`, `b5`, `b6`, `legal`, `letter` 를 사용할 수 있다.
- **default-font-size** `[number]`  
  기본 폰트 크기
- **footer-template**  
  각 페이지에 꼬리말을 생성하는 데 사용되는 HTML 템플릿이다. 문자열 `_PAGENUM_`, `_TITLE _`, `_AUTHOR_`, `_SECTION_` 은 현재 값으로 대체된다.
- **header-template**  
  각 페이지에 머리말을 생성하는 데 사용되는 HTML 템플릿이다. 문자열 `_PAGENUM_`, `_TITLE _`, `_AUTHOR_`, `_SECTION_` 은 현재 값으로 대체된다.
- **page-numbers** `[true/false]`  
  `기본값: false` 
  생성된 PDF 파일의 모든 페이지 하단에 페이지 번호를 추가한다. 꼬리말 템플릿을 지정하면 이 옵션보다 먼저 적용된다. 
- **pretty-print** `[true/false]`  
  지정된 경우 출력 플러그인은 가능한 한 인간이 읽을 수 있는 형식의 출력을 작성하려고 한다. 일부 출력 플러그인에는 효과가 없을 수 있다. 

### HTML

`.html` 내보내기는 `ebook-convert` 에 의존하지 않는다. `.html` 파일을 내보낼 때 모든 로컬 이미지는 하나의 `html` 파일에 `base64` 데이터로 포함된다. `html` 출력을 설정하려면 `ebook` 뒤에 `html` 을 추가한다.

```yaml
ebook:
  html:
    cdn: true
```

- **cdn**  
  `cdn.js` 에서 css 및 javascript 파일을 로드한다. 이 옵션은 `.html` 파일을 내보낼 때만 사용된다.

## ebook-convert Arguments

위의 YAML 옵션에 해당하는 기능이 없는 `ebook-convert` 기능을 사용하려는 경우, 사용자 정의된 `args` 를 건네주는 것으로 사용할 수 있다. 예를 들어:

```yaml
---
ebook:
  title: My eBook
  args: ["--embed-all-fonts", "--embed-font-family"]
---

```

arguments 리스트는 [ebook-convert manual](https://manual.calibre-ebook.com/generated/en/ebook-convert.html) 에 있다.

## 저장과 함께 내보내기

다음과 같이 front-matter를 추가한다:

```yaml
---
export_on_save:
  ebook: true
  // or
  ebook: "epub"
  ebook: "pdf"
  ebook: "mobi"
  ebook: "html"
  ebook: ["pdf", ...]
---
```

이렇게 설정하면 markdown 파일을 저장할 때마다 ebook이 생성된다.

## 알려진 이슈 & 한계

- eBook 생성은 아직 개발 중인 기능이다.
- `mermaid`, `PlantUML` 등으로 생성된 모든 SVG 그래프는 생성된 전자책에서 작동하지 않는다. 오직 `viz`만 작동한다. 
- 오직 **KaTeX** 만 수식에 사용될 수 있다. 
  또한 생성된 ebook 파일은 **iBook**에서 수식을 제대로 렌더링하지 못한다.
- **PDF** 및 **Mobi** 출력에는 버그가 있다.
- **Code Chunk** 는 ebook 생성에서 작동하지 않는다.
