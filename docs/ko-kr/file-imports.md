# 외부 파일 가져오기

![doc-imports](https://cloud.githubusercontent.com/assets/1908863/22716507/f352a4b6-ed5b-11e6-9bac-88837f111de0.gif)

## 사용 방법

아래와 같은

`@import "your_file"`

을 통해 간단하게 사용 가능하다 :)

`<!-- @import "your_file" -->` 또한 가능하다.

또는

```markdown
- image like syntax
  ![](file/path/to/your_file)

- wikilink like syntax
  ![[ file/path/to/your_file ]]
  ![[ my_file ]]
```

## 새로고침 버튼

새로고침(Refresh) 버튼은 미리보기의 오른쪽 하단 위치해 있다. 클릭을 하면 파일 캐시가 지워지며 미리보기가 새로고침된다.
이미지 캐시를 지우려는 경우 유용하게 사용 가능하다. [#144](https://github.com/shd101wyy/markdown-preview-enhanced/issues/144) [#249](https://github.com/shd101wyy/markdown-preview-enhanced/issues/249)

![screen shot 2017-02-07 at 5 48 52 pm](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## 지원되는 파일 형식

- `.jpeg(.jpg), .gif, .png, .apng, .svg, .bmp` 파일은 markdown 이미지로 처리된다.
- `.csv` 파일은 markdown 테이블로 변환된다.
- `.mermaid` 파일은 mermaid에 의해 렌더링된다.
- `.dot` 파일은 viz.js (graphviz)에 의해 렌더링된다.
- `.plantuml(.puml)` 파일은 PlantUML에 의해 렌더링 된다.
- `.html` 파일은 아무 조건없이 바로 추가된다.
- `.js` 파일은 `<script src="your_js"></script>`로 추가된다.
- `.less`와 `.css` 파일은 스타일로 추가된다. 현재까지는 로컬 `less` 파일만 지원되며, `.css` 파일은 `<link rel="stylesheet" href="your_css">`로 추가된다.
- `.pdf` `pdf2svg`에 의해 `svg` 파일로 변환된 후 추가된다.
- `markdown` 파일은 파싱하여 직접 추가된다.
- 다른 모든 파일은 코드 블록으로 렌더링된다.

## 이미지 구성

```markdown
@import "test.png" {width="300px" height="200px" title="my title" alt="my alt"}

![](test.png){width="300px" height="200px"}

![[ test.png ]]{width="300px" height="200px"}
```

## 온라인 파일 가져오기

예시:

```markdown
@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"
```

## PDF 파일 가져오기

Markdown Preview Enhanced는 로컬 및 온라인 PDF 파일 가져오기를 지원하며, PDF 파일을 가져오려면 [pdf2svg](extra.md)가 설치되어 있어야 한다. 다만, 큰 PDF 파일을 가져오는건 권장되지 않는다.  
예시:

```markdown
@import "test.pdf"
```

### PDF 설정

- **page_no**
  PDF의 `n번째` 페이지를 표시. 한 페이지만 표시한다. 예를 들어 `{page_no=1}` 는 1 페이지를 의미한다.
- **page_begin**, **page_end**
  를 사용하면 범위의 페이지를 표시한다. 예를 들어 `{page_begin=2 page_end=4}` 은 2, 3, 4 페이지를 의미한다.

## Code Block으로 강제 렌더링

```markdown
@import "test.puml" {code_block=true class="line-numbers"}
@import "test.py" {class="line-numbers"}
```

## Code Block으로

```markdown
@import "test.json" {as="vega-lite"}
```

## 특정 라인 가져오기

```markdown
@import "test.md" {line_begin=2}
@import "test.md" {line_begin=2 line_end=10}
@import "test.md" {line_end=-4}
```

## 파일을 Code Chunk로 가져오기

```markdown
@import "test.py" {cmd="python3"}
```

[➔ Code Chunk](ko-kr/code-chunk.md)
