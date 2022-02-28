# Beamer Document

## 개요

**Markdown Preview Enhanced**에서 Beamer 프레젠테이션을 만들려면 문서의 front-matter에 `beamer_presentation` 출력 형식을 지정해야 한다.
`#` 및 `##` 머리글 태그를 사용해 섹션으로 나뉜 슬라이드 쇼를 만들 수 있다. (수평줄(`----`)를 사용해 머리글 없이 새 슬라이드를 만들 수도 있다.)  
다음은 간단한 슬라이드 쇼다.

```markdown
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: beamer_presentation
---

# 아침

## 기상
- 알람을 끄고
- 침대에서 일어난다.

## 아침식사

- 계란을 먹고
- 커피를 마신다

# 저녁

## 저녁식사

- 스파케티를 먹고
- 와인을 마신다.

---

![picture of spaghetti](images/spaghetti.jpg)

## 잘 시간

- 침대에 눕고
- 잠에 든다.
```

## 내보내기 경로

`path` 옵션을 설정하여 문서 내보내기 경로를 정의할 수 있다.

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    path: /Exports/Habits.pdf
---

```

`path` 가 지정되어 있지 않다면 문서는 자동적으로 같은 리렉토리 안에 내보내기한 파일을 저장한다.

## 글머리 기호

`incremental` 옵션을 더해 글머리 기호를 설정할 수 있다. 예시:

```yaml
---
output:
  beamer_presentation:
    incremental: true
---

```

일부 슬라이드에 대해서만 글머리 기호를 렌더링하기 위해서는 아래의 구문을 사용할 수 있습니다. 예시:

```markdown
> - Eat eggs
> - Drink coffee
```

## 테마

`theme`, `colortheme`, 그리고 `fonttheme` 옵션들을 이용하여 특정 Beamer 테마를 적용할 수 있다.

```yaml
---
output:
  beamer_presentation:
    theme: "AnnArbor"
    colortheme: "dolphin"
    fonttheme: "structurebold"
---

```

## 목차

`toc` 옵션은 프레젠테이션의 시작부분에 목차를 추가시킬 수 있다.(목차에는 1 레벨 목차로만 구성된다.) 예시:

```yaml
---
output:
  beamer_presentation:
    toc: true
---

```

## Slide Level

`slide_level` 옵션은 각각의 슬라이드의 제목 레벨을 정의한다. 기본값으로 제일 높은 헤더 단계이며, 문서의 다른 헤더가 아닌 내용이 바로 뒤에 나온다. 이 기본 값은 `slide_level`로 지정하여 변경할 수 있습니다. :

```yaml
---
output:
  beamer_presentation:
    slide_level: 2
---

```

## 구문 하이라이트

`highlight` 옵션은 구문 하이라이트 스타일을 지정한다. 지원되는 스타일로는 “default”, “tango”, “pygments”, “kate”, “monochrome”, “espresso”, “zenburn”, 그리고 “haddock” 이 있다.(구문 하이라이트를 사용하고 싶지 않다면 null 로 지정한다.)


예시:

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    highlight: tango
---

```

## Pandoc Arguments

위에서 설명한 pandoc 기능 중 YAML 옵션에서 해당 기능이 없다면 사용자 지정 `pandoc_args`을 통해 이용할 수 있다. 예시:

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## 공유 옵션

여러 개의 문서들의 옵션을 통일해서 정해주고 싶다면 디렉토리에  `_output.yaml` 이름을 포함하면 된다. YAML 구분기호나 출력개체는 이 파일에 적용되지 않는다. 예시:

**\_output.yaml**

```yaml
beamer_presentation:
  toc: true
```

`_output.yaml` 과 같은 디렉토리에 있는 모든 문서는 해당 옵션을 공유한다. 문서에 명시적으로 정의된 옵션은 해당 사항에 영향을 받지 않는다.