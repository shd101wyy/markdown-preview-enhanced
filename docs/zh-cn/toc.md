# 目录列表（TOC）

**Markdown Preview Enhanced** 支持你在 markdown 文件中创建 `TOC`。
你可以通过 <kbd>cmd-shift-p</kbd> 然后选择 `Markdown Preview Enhanced: Create Toc` 命令来创建 `TOC`。
多个 TOCs 可以被创建。
如果你想要在你的 `TOC` 中排除一个标题，请在你的标题 **后面** 添加 `{ignore=true}` 即可。

![screen shot 2018-03-14 at 12 03 00 pm](https://user-images.githubusercontent.com/1908863/37418218-bb624e62-277f-11e8-88f5-8747a1c2e012.png)

> TOC 将会在你的 markdown 文件保存时更新。
> 你需要保持预览打开才能更新 TOC。

## 设置

- **orderedList**
  是否使用有序列表。
- **depthFrom**, **depthTo**
  `[1~6]` 包含的。
- **ignoreLink**
  如果设置为 `true`，那么 TOC 将不会被超链接。

## [TOC]

你也可以通过在你的 markdown 文件中输入 `[TOC]` 来创建 `TOC`。
例如：

```markdown
[TOC]

# 标题 1

## 标题 2 {ignore=true}

标题 2 将会被目录忽略.
```

但是，这种方式创建的 `TOC` 只会在预览中显示，而不会修改你的 markdown 文件。

## [TOC] 以及边栏 TOC 的设置

你可以通过编写 front-matter 来进行设置：

```markdown
---
toc:
  depth_from: 1
  depth_to: 6
  ordered: false
---
```

[➔ 导入文件](zh-cn/file-imports.md)
