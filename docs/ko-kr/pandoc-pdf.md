# PDF Document

## 개요

PDF 문서를 생성하기 위해서는 문서의 front-matter 에서 `pdf_document`을 `output`으로 지정한다.
예시:

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: pdf_document
---

```

## 내보내기 경로

`path` 옵션을 지정하여 내보내기 경로를 설정할 수 있다. 예시:

```yaml
---
title: "Habits"
output:
  pdf_document:
    path: /Exports/Habits.pdf
---

```

`path` 가 지정되어 있지 않다면 문서는 자동적으로 같은 리렉토리 안에 내보내기한 파일을 저장한다.

## 목차

목차를 `toc` 옵션을 사용해 삽입할 수 있다. `toc_depth` 옵션을 이용해 헤더의 깊이를 지정할 수 있다. 예시:

```yaml
---
title: "Habits"
output:
  pdf_document:
    toc: true
    toc_depth: 2
---

```

목차 깊이의 기본 값은 3이다.(모든 1, 2, 3 레벨 헤더가 목차에 포함됨)

_주의:_ 이 목자는 **Markdown Preview Enhanced**에서 `<!-- toc -->`로 생성되는 목차와 다르다.

`number_sections` 옵션을 이용해 문단 번호 매기기를 헤더에 적용할 수 있다. 예시:

```yaml
---
title: "Habits"
output:
  pdf_document:
    toc: true
    number_sections: true
---

```

## 구문 하이라이트

`highlight` 옵션은 구문 하이라이트 스타일을 지정한다. 지원되는 스타일로는 “default”, “tango”, “pygments”, “kate”, “monochrome”, “espresso”, “zenburn”, 그리고 “haddock” 이 있다.(구문 하이라이트를 사용하고 싶지 않다면 null 로 지정한다.)
예시:

```yaml
---
title: "Habits"
output:
  pdf_document:
    highlight: tango
---

```

## LaTeX 옵션

PDF 문서를 만드는데 사용되는 LaTeX 템플릿의 많은 부분은 최상위 YAML 메타데이터를 사용하여 사용자 정의할 수 있다.(이런 옵션은 `output` 세션 아래 나타나지 않고, 타이틀, 작성자 등과 같이 최상위 레벨에 나타난다.) 예시:

```yaml
---
title: "Crop Analysis Q3 2013"
output: pdf_document
fontsize: 11pt
geometry: margin=1in
---

```

사용가능한 메타데이터 variable 은 아래와 같다. 예시:

| Variable 이름                  | 설명                                                                              |
| ------------------------------ | --------------------------------------------------------------------------------- |
| papersize                      | 용지 크기, 예시: `letter`, `A4`                                                   |
| lang                           | 문서의 언어 코드                                                                  |
| fontsize                       | 폰트 사이즈 (예시: 10pt, 11pt, 12pt)                                              |
| documentclass                  | LaTeX 문서 클래스 (예시: article)                                                 |
| classoption                    | 문서 클래스 옵션 (예시. oneside); _반복될 수 있다._                               |
| geometry                       | geometry 클래스 옵션 (예시. margin=1in); _반복될 수 있다._                        |
| linkcolor, urlcolor, citecolor | 내부, 외부, 그리고 인용 링크의 색상 지정 (red, green, magenta, cyan, blue, black) |
| thanks                         | 문서 타이틀 뒤에 있는 사사의 말의 내용을 지정한다.                                |

더 사용가능한 variable은 [여기](https://pandoc.org/MANUAL.html#variables-for-latex) 에서 찾을 수 있다.

### 인용문을 위한 LaTeX 패키지

기본적으로 인용문은 모든 출력 포맷에서 작동하는`pandoc-citeproc`으로 처리된다.
PDF 출력의 경우 LaTeX 패키지를 사용하여 `natbib` 이나 `biblatex` 같은 인용문을 처리하는 것이 나을 수 있다.
이 패키지를 사용하려면 `citation_package`옵션을 `natbib` 이나 `biblatex`으로 설정하면 된다.
예시:

```yaml
---
output:
  pdf_document:
    citation_package: natbib
---

```

## 고급 사용자 지정

### LaTeX 엔진

PDF 문서를 렌더링할 때 기본적으로 `pdflatex`을 사용한다. `latex_engine` 옵션을 통해 다른 엔진으로 변경할 수 있다. 사용가능한 “pdflatex”, “xelatex”, 그리고 “lualatex” 가 있다. 예시:

```yaml
---
title: "Habits"
output:
  pdf_document:
    latex_engine: xelatex
---

```

### Include

추가적인 LaTeX directives 포함하거나 pandoc 템플릿의 내용이나 코어를 교체함으로써 PDF 출력의 고급 사용자 정의를 할 수 있다.
문서 헤더나 본문 앞/뒤에 `includes` 옵션을 사용해 내용을 포함할 수 있다.
예:

```yaml
---
title: "Habits"
output:
  pdf_document:
    includes:
      in_header: header.tex
      before_body: doc_prefix.tex
      after_body: doc_suffix.tex
---

```

### 사용자 지정 템플릿

`template` 옵션을 사용해 기본 pandoc 템플릿을 바꿀 수 있다. 예시:

```yaml
---
title: "Habits"
output:
  pdf_document:
    template: quarterly_report.tex
---

```

템플릿에 대한 자세한 정보는 [pandoc templates](https://pandoc.org/README.html#templates) 에서 알아볼 수 있다.
또한 예시로 [default LaTeX template](https://github.com/jgm/pandoc-templates/blob/master/default.latex) 을 학습해도 된다.

### Pandoc Arguments

위에서 설명한 pandoc 기능 중 YAML 옵션에서 해당 기능이 없다면 사용자 지정 `pandoc_args`을 통해 이용할 수 있다. 예시:

```yaml
---
title: "Habits"
output:
  pdf_document:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## 옵션 공유

여러 개의 문서들의 옵션을 통일해서 정해주고 싶다면 디렉토리에 `_output.yaml` 이름을 포함하면 된다. YAML 구분기호나 출력개체는 이 파일에 적용되지 않는다. 예시:

**\_output.yaml**

```yaml
pdf_document:
  toc: true
  highlight: zenburn
```

`_output.yaml` 과 같은 디렉토리에 있는 모든 문서는 해당 옵션을 공유한다. 문서에 명시적으로 정의된 옵션은 해당 사항에 영향을 받지 않는다.
