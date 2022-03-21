# Custom Document

## 개요

**Custom Document**를 사용하면 `pandoc`의 능력을 최대한 활용할 수 있다
Custom Document를 작성하려면 문서의 맨 끝에 `custom_document` 출력 형식을 지정하고 `경로`를 **정의해야 한다.**

다음 코드 예시는 [pdf document](https://github.com/shd101wyy/markdown-preview-enhanced/blob/master/docs/pdf.md)와 같은 방법으로 동작한다.

```javascript 
---
title: "Habits"
author: John Doe
date: March 22, 2005
output:
  custom_document:
    path: /Exports/test.pdf
    toc: true
---
```

아래 코드 예제는 [beamer presentation](ko-kr/pandoc-beamer.md)과 유사하게 동작한다.
```javascript 
---
title: "Habits"
author: John Doe
date: March 22, 2005
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["-t", "beamer"]
---
```
## Pandoc Arguments

사용하고자 하는 pandoc 기능들이 YAML 옵션에 부합하지 않을 경우, 사용자 지정 `pandoc_args`를 전달하여 해당 기능을 사용할 수 있다.  
예시:

```yaml
---
title: "Habits"
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["--no-tex-ligatures"]
---
```

## 공유 옵션

디렉토리 내의 여러 문서에서 공유할 기본 옵션 세트를 지정하려는 경우 디렉토리 내에 `_output.yaml`이라는 파일을 포함할 수 있다. 이 파일에는 YAML 구분 기호 또는 둘러싸는 출력 개체가 사용되지 않는다. 예를 들어:

**\_output.yaml**

```yaml
custom_document:
  toc: true
  highlight: zenburn
  ```
`_output.yaml`과 같은 디렉토리에 있는 모든 문서는 해당 옵션을 상속한다. 문서 내에 명시적으로 정의된 옵션은 공유 옵션 파일에 지정된 옵션보다 우선한다.
