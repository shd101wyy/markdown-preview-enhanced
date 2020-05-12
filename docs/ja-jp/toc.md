# Table of Contents

**Markdown Preview Enhanced** can create `TOC` for your markdown file.
You can press <kbd>cmd-shift-p</kbd> then choose `Markdown Preview Enhanced: Create Toc` to create `TOC`.
Multiple TOCs can be created.
To exclude a heading from the `TOC`, append `{ignore=true}` **after** your heading.

![screen shot 2018-03-14 at 12 03 00 pm](https://user-images.githubusercontent.com/1908863/37418218-bb624e62-277f-11e8-88f5-8747a1c2e012.png)

> The TOC will be updated when you save the markdown file.
> You need to keep the preview open to get TOC updated.

## Configuration

- **orderedList**
  Use orderedList or not.
- **depthFrom**, **depthTo**
  `[1~6]` inclusive.
- **ignoreLink**
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
