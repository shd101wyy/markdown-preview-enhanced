# Table of content (목차)

**Markdown Preview Enhanced**는 markdown파일에 대해 `TOC`를 만들 수있다.
<kbd>cmd-shift-p</kbd>를 누른 후 `Markdown Preview Enhanced: Create Toc` 
TOC를 여러 개 만들 수 있다.
`TOC` 에서 heading을 제외하려면 heading에 `{ignore = true}`를 추가한다.

![screen shot 2018-03-14 at 12 03 00 pm](https://user-images.githubusercontent.com/1908863/37418218-bb624e62-277f-11e8-88f5-8747a1c2e012.png)

> The TOC will be updated when you save the markdown file.
> You need to keep the preview open to get TOC updated.

> TOC는 markdown파일을 저장할때 마다 업데이트 되며 TOC의 변경본 preview를 열어둬야 한다.

## Configuration

- **orderedList**
- **depthFrom**, **depthTo**
  `[1~6]` inclusive.
- **ignoreLink**
  `true`로 설정시 TOC 항목에서 하이퍼링크 사용이 불가능해 진다.

## [TOC]

또한 markdown 파일에 `[TOC]`를 입력하여 `TOC`를 만들수도 있다.

예를들어:

```markdown
[TOC]

# Heading 1
## Heading 2 {ignore=true}

Heading 2는 하이퍼 사용이 불가능해진다.
```

그러나 **이방법은 TOC preview에서만 나타나고.** 편집기 내용은 바뀌지 않는다. 

## [TOC] and Sidebar TOC Configuration

`[TOC]` sidebar TOC는 front-matter를 써서 구현할 수 있다.

```markdown
---
toc:
  depth_from: 1
  depth_to: 6
  ordered: false
---
```

[➔ File Imports](file-imports.md)
