# Markdown 기본

이 글은 [GitHub Flavored Markdown writing](https://guides.github.com/features/mastering-markdown/) 에 대한 간략한 소개이다.

## Markdown 이란?

`Markdown` 은 웹에서 텍스트를 스타일링하는 기법이다. 사용자는 단어 형식을 굵게 또는 기울임꼴로 지정하거나 이미지 추가, 목록 생성 등의 작업을 이용해 문서 디스플레이를 조작할 수 있다. 대부분의 Markdown은 `#` 또는 `*`와 같은 알파벳이 아닌 문자를 이용하는 일반 텍스트이다.

## 구문 가이드

### 머리글(Header)

```markdown
# <h1> 태그

## <h2> 태그

### <h3> 태그

#### <h4> 태그

##### <h5> 태그

###### <h6> 태그
```

`id`와 `class`를 헤더에 추가하려면 `{#id .class1 .class2}`를 덧붙이면 된다.  
예시:

```markdown
# 이 머리글의 id는 1개 {#my_id}이다.

# 이 머리글에는 2개의 클래스 {.class1 .class2}가 있다.
```

> 위 예시는 MPE 확장 기능이다.

### 강조(Emphasis)

<!-- prettier-ignore -->
```markdown
*이 텍스트는 기울임꼴이다*
_이 텍스트 또한 기울임꼴이다_

**이 텍스트는 굵게 표시된다**
__이 텍스트 또한 굵게 표시된다__

_두 강조는 결합이 **가능**하다_

~~이 텍스트는 취소선이다.~~
```

### 목록(Lists)

#### 정렬되지 않은 목록(Unordered List)

```markdown
- Item 1
- Item 2
  - Item 2a
  - Item 2b
```

#### 정렬된 목록(Ordered List)

```markdown
1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b
```

### 이미지(Images)

```markdown
![GitHub Logo](/images/logo.png)
Format: ![Alt Text](url)
```

### 링크(Links)

```markdown
https://github.com - automatic!
[GitHub](https://github.com)
```

### 블록 인용문(Blockquote)

```markdown
Kanye West가 말하길:

> We're living the future so
> the present is our past.
```

### 수평줄

```markdown
세 개 이상...

---

Hyphens

---

Asterisks

---

Underscores
```

### 인라인코드(Inline Code)

```markdown
I think you should use an
`<addr>` element here instead.
```

### 펜스 코드 블록(Fenced code block)

코드 블록 앞과 뒤에 트리플 백틱 <code>\`\`\`</code>을 배치하여 펜스 코드 블록을 만들 수 있다.

#### 구문 강조(Syntax Highlighting)

선택적 언어 식별자를 추가하여 펜스 코드 블록에서 구문 강조를 사용할 수 있다.

루비 코드의 구문 강조 예시:

    ```ruby
    require 'redcarpet'
    markdown = Redcarpet.new("Hello World!")
    puts markdown.to_html
    ```

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

#### 코드블록 클래스(Code block class) (MPE 확장 기능)

코드 블록에 `class`를 설정할 수 있다.

코드 블록에 `class1 class2`를 추가한 예시:

    ```javascript {.class1 .class}
    function add(x, y) {
      return x + y
    }
    ```

##### 줄 번호(line-numbers)

코드 블록에 대해 `line-numbers` 클래스를 추가해 라인 번호를 활성화할 수 있다.

예시:

````markdown
```javascript {.line-numbers}
function add(x, y) {
  return x + y;
}
```
````

![screen shot 2017-07-14 at 1 20 27 am](https://user-images.githubusercontent.com/1908863/28200587-a8582b0a-6832-11e7-83a7-6c3bb011322f.png)

##### 행 강조(highlighting rows)

`highlight` 특성을 추가하여 행을 강조할 수 있다.

````markdown
```javascript {highlight=10}
```

```javascript {highlight=10-20}
```

```javascript {highlight=[1-10,15,20-22]}
```
````

### 작업 목록(Task lists)

```markdown
- [x] @mentions, #refs, [links](), **formatting**, 및 <del>tags</del> 지원
- [x] 목록 구문 필요 (정렬되거나 정렬되지 않은 목록 둘 다 지원됨)
- [x] 완료된 품목
- [ ] 완료되지 않은 품목
```

### 테이블(Tables)

단어 목록을 조합하여 하이픈 `-`(첫 번째 행에 대해)으로 나눈 다음 각 열을 파이프 `|`로 구분하여 테이블을 만들 수 있다.

<!-- prettier-ignore -->
```markdown
첫 번째 머리글 | 두 번째 머리글
------------ | -------------
셀 1의 내용 | 셀 2의 내용
첫 번째 열의 내용 | 두 번째 열의 내용
```

## 확장 구문(Extended syntax)

### 테이블

> 확장 설정의 `enableExtendedTableSyntax`을 활성화시켜야 사용할 수 있다.

![screen shot 2017-07-15 at 8 16 45 pm](https://user-images.githubusercontent.com/1908863/28243710-945e3004-699a-11e7-9a5f-d74f6c944c3b.png)

### 이모티콘 & 폰트어썸(Emoji & Font-Awesome)

> `markdown-it parser`에서만 사용 가능하며 `pandoc parser`에는 사용할 수 없다.  
> 기본적으로 활성화되어 있으며 패키지 설정에서 비활성화시킬 수 있다.

```
:smile:
:fa-car:
```

### 위첨자(Superscript)

```markdown
30^th^
```

### 아래첨자(Subscript)

```markdown
H~2~O
```

### 각주(Footnotes)

```markdown
내용 [^1]

[^1]: 안녕! 나는 각주야.
```

### 약어(Abbreviation)

```markdown
_[HTML]: Hyper Text Markup Language
_[W3C]: World Wide Web Consortium
The HTML specification
is maintained by the W3C.
```

### 표시(Mark)

```markdown
==marked==
```

### 비평가마크업(CriticMarkup)

CriticMarkup은 기본적으로 **비활성화**되어 있지만, 패키지 설정에서 사용하도록 설정할 수 있다.
CriticMarkup에 대한 자세한 내용은 [CriticMarkup 사용 설명서](https://criticmarkup.com/users-guide.php) 에서 찾아볼 수 있다.

Critic 표시의 5가지 유형:

- 추가 `{++ ++}`
- 삭제 `{-- --}`
- 대체 `{~~ ~> ~~}`
- 주석 `{>> <<}`
- 강조 `{== ==}{>> <<}`

> CriticMarkup은 markdown-it parser에서만 작동하며 pandoc parser에서는 작동하지 않는다.

### 훈계(Admonition)

```
!!! 참고. Admonition 제목
    Admonition 내용
```

> 자세한 내용은 [Admonition](https://squidfunk.github.io/mkdocs-material/reference/admonitions/) 에서 확인할 수 있다.

## 참조 사항(References)

- [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
- [Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)

[➔ Math](ko-kr/math.md)
