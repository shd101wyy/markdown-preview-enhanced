# 참고 문헌 및 인용문

## 참고 문헌

### 참고 문헌 지정

[Pandoc](https://pandoc.org/MANUAL.html#citations) 은 자동적으로 참고문헌과 인용문을 여러가지 스타일로 생성해준다.
이 기능을 사용하려면 YAML 메타데이터 세션에서 `bibliography` 메타데이터 필드를 사용하여 bib 파일을 지정해줘야한다.
예시:

```yaml
---
title: "샘플_문서"
output: pdf_document
bibliography: bibliography.bib
---

```

여러 개의 bib 파일을 포함하는 경우 다음과 같이 지정하면 된다.

```yaml
---
bibliography: [bibliography1.bib, bibliography2.bib]
---

```

참고 문헌은 아래의 포맷을 따른다.

| 포맷      | 확장자명 |
| ----------- | -------------- |
| BibLaTeX    | .bib           |
| BibTeX      | .bibtex        |
| Copac       | .copac         |
| CSL JSON    | .json          |
| CSL YAML    | .yaml          |
| EndNote     | .enl           |
| EndNote XML | .xml           |
| ISI         | .wos           |
| MEDLINE     | .medline       |
| MODS        | .mods          |
| RIS         | .ris           |

### 인라인 참조

또는 문서의 YAML 메타 데이터의 `references` 필드를 이용할 수 있다. 아래와 같이 YAML 로 인코딩된 참조 배열이 포함되어야 한다. 

예시:

```yaml
---
references:
  - id: fenner2012a
    title: One-click science marketing
    author:
      - family: Fenner
        given: Martin
    container-title: Nature Materials
    volume: 11
    URL: "https://dx.doi.org/10.1038/nmat3283"
    DOI: 10.1038/nmat3283
    issue: 4
    publisher: Nature Publishing Group
    page: 261-263
    type: article-journal
    issued:
      year: 2012
      month: 3
---

```

### 참고문헌 배치

참고문헌은 문서의 끝에 배치된다. 보통 적절한 헤더를 이용해 문서를 마무리 짓는다. 

예시:

```markdown
last paragraph...

# References
```

이 헤더 뒤에 참고문헌이 삽입된다.

## 인용문

### 인용 구문

인용문은 대괄호안에 들어가며 세미클론으로 구분한다. 각 인용문은 반드시 `'@' + 데이터베이스의 인용 식별자`로 구성된 키가 있어야 하며 선택적으로 접두사, 로케이터 및 접미사를 사용할 수 있다.
예시:

```
Blah blah [see @doe99, pp. 33-35; also @smith04, ch. 1].

Blah blah [@doe99, pp. 33-35, 38-39 and *passim*].

Blah blah [@smith04; @doe99].
```

`(-)`  `@` 앞에 마이너스 기호`(-)를 붙이면 저자를 언급하지 않는다. 작성자가 이미 텍스트에 언급된 경우 유용하다.

```
Smith says blah [-@smith04].
```

다음과 같이 본문 내 인용을 작성할 수 있다.

```
@smith04 says blah.

@smith04 [p. 33] says blah.
```

### 사용되지 않은 참고 문헌 (nocite)

본문에서 문헌을 하지 않고 참고 문헌에 포함시키고 싶은 경우, 더미 `nocite` 메타데이터 필드를 정의하고, 거기에 인용문을 추가할 수 있다.
```
---
nocite: |
  @item1, @item2
...

@item3
```

위의 예시에서 문서는 `item3`만 인용하지만, 참고문헌은 `item1`, `item2`, 그리고 `item3`을 포함한다.

### 인용 스타일

기본적으로 pandoc은 인용 및 참조에 Chicago author-date 형식을 사용한다. 다른 스타일을 사용하려면 `csl` 메타데이터 필드에 CSL 1.0 스타일 파일을 지정해야 한다. 예시:

```yaml
---
title: "샘플 문서"
output: pdf_document
bibliography: bibliography.bib
csl: biomed-central.csl
---

```

CSL 스타일 생성 및 수정에 대한 기본 사항은 [여기](https://citationstyles.org/downloads/primer.html) 에서 확인할 수 있다. CSL 스타일의 저장소는 [여기](https://github.com/citation-style-language/styles) 에서 찾을 수 있다. 손쉬운 검색은 https://zotero.org/styles 를 참조.

### PDF 출력에 대한 인용문

기본적으로 인용문은 유틸리티 pandoc-citeproc에 의해 생성되며 모든 출력 형식에 대해 작동한다. 출력이 LaTeX/PDF인 경우, LaTeX 패키지(예: natbib)를 사용하여 인용문을  생성할 수 있다. 자세한 내용은 [PDF documents](pandoc-pdf.md) 를 참조.
