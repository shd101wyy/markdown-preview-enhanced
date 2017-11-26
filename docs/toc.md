# Table of Contents
**Markdown Preview Enhanced** can create `TOC` for your markdown file.
You can press <kbd>cmd-shift-p</kbd> then choose `Markdown Preview Enhanced: Create Toc` to create `TOC`.
Multiple TOCs can be created.
To exclude a heading from the `TOC`, append `{ignore=true}` **after** your heading.

![screen shot 2017-07-14 at 1 56 32 am](https://user-images.githubusercontent.com/1908863/28201657-abf1ac78-6837-11e7-9a08-e785df68e19b.png)

> The TOC will be updated when you save the markdown file.
> You need to keep the preview open to get TOC updated.

## Configuration
* **orderedList**
Use orderedList or not.
* **depthFrom**, **depthTo**
`[1~6]` inclusive.
* **ignoreLink**
If set to `true`, then TOC entry will not be hyperlinks.

## [TOC]
You can also create `TOC` by inserting `[TOC]` to your markdown file.
For example:
```markdown

[TOC]

# Heading 1
## Heading 2 {ignore=true}
Heading 2 will be ignored from TOC.
```
However, **this way will only display TOC in preview**, while leaving editor content unchanged.

## [TOC] and Sidebar TOC Configuration
You can configure `[TOC]` and sidebar TOC by writting front-matter:

```markdown
---
toc:
  depth_from: 1
  depth_to: 6
  ordered: false
---
```

[➔ File Imports](file-imports.md)
