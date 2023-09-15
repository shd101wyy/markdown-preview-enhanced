# Word Document

## 개요

Word 문서를 생성하기 위해서는 문서의 front-matter 에서 `word_document`을 `output`으로 지정한다.
예시:

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: word_document
---

```

## 내보내기 경로

`path` 옵션을 지정하여 내보내기 경로를 설정할 수 있다. 예시:

```yaml
---
title: "Habits"
output:
  word_document:
    path: /Exports/Habits.docx
---

```

`path` 가 지정되어 있지 않다면 문서는 자동적으로 같은 리렉토리 안에 내보내기한 파일을 저장한다.

## 구문 하이라이트

You can use the `highlight` option to control the syntax highlighting theme. For example:

```yaml
---
title: "Habits"
output:
  word_document:
    highlight: "tango"
---

```

## 스타일 참조

지정된 파일을 docx 파일을 생성할 때 스타일 참조로 사용한다.
이 때, 참조 docx 로 pandoc 을 사용하여 생성된 docx 파일의 수정된 버전을 지정하길 권고한다.
참조 내용은 무시되지만 해당 스타일시트 및 문서 특성(여백, 페이지 크기, 머리글 및 바닥글 포함)이 새 docx 에 적용된다.
명령줄에 참조 docx 가 지정되지 않은 경우 pandoc 은 사용자 데이터 디렉토리에서 `reference.docx` 파일을 찾는다.(--data-dir 참조)
이 파일도 찾을 수 없는 경우 적절한 기본값이 사용된다.

```yaml
---
title: "Habits"
output:
  word_document:
    reference_docx: mystyles.docx
---

```

## Pandoc Arguments

위에서 설명한 pandoc 기능 중 YAML 옵션에서 해당 기능이 없다면 사용자 지정 `pandoc_args`을 통해 이용할 수 있다. 예시:

```yaml
---
title: "Habits"
output:
  word_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## 옵션 공유

여러 개의 문서들의 옵션을 통일해서 정해주고 싶다면 디렉토리에 `_output.yaml` 이름을 포함하면 된다. YAML 구분기호나 출력개체는 이 파일에 적용되지 않는다. 예시:

**\_output.yaml**

```yaml
word_document:
  highlight: zenburn
```

`_output.yaml`과 같은 디렉토리에 있는 모든 문서는 \_output.yaml의 옵션과
같은 값을 입력받는다. 문서에 명시적으로 정의된 선택사항은 공유 옵션 파일에 지정된 선택사항 보다 우선시 한다.
