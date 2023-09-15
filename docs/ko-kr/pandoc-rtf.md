# RTF Document

## 개요

RTF 문서를 생성하기 위해서는 문서의 front-matter 에서 `rtf_document`을 `output`으로 지정한다.
예시:

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: rtf_document
---

```

## 내보내기 경로

`path` 옵션을 지정하여 내보내기 경로를 설정할 수 있다. 예시:

```yaml
---
title: "Habits"
output:
  rtf_document:
    path: /Exports/Habits.rtf
---

```

`path` 가 지정되어 있지 않다면 문서는 자동적으로 같은 리렉토리 안에 내보내기한 파일을 저장한다.

## 목차

목차를 `toc` 옵션을 사용해 삽입할 수 있다. `toc_depth` 옵션을 이용해 헤더의 깊이를 지정할 수 있다. 예시:

```yaml
---
title: "Habits"
output:
  rtf_document:
    toc: true
    toc_depth: 2
---

```

목차 깊이의 기본 값은 3이다.(모든 1, 2, 3 레벨 헤더가 목차에 포함됨)

_주의:_ 이 목차는 **Markdown Preview Enhanced**에서 `<!-- toc -->`로 생성되는 목차와 다르다.

## Pandoc Arguments

위에서 설명한 pandoc 기능 중 YAML 옵션에서 해당 기능이 없다면 사용자 지정 `pandoc_args`을 통해 이용할 수 있다. 예시:

```yaml
---
title: "Habits"
output:
  rtf_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## 옵션 공유

여러 개의 문서들의 옵션을 통일해서 정해주고 싶다면 디렉토리에 `_output.yaml` 이름을 포함하면 된다. YAML 구분기호나 출력개체는 이 파일에 적용되지 않는다. 예시:

**\_output.yaml**

```yaml
rtf_document:
  toc: true
```

`_output.yaml`과 같은 directory에 있는 모든 문서는 \_output.yaml의 옵션과
같은 값을 입력받는다. 문서에 명시적으로 정의된 선택사항은 공유 옵션 파일에 지정된 선택사항 보다 우선시 한다.
