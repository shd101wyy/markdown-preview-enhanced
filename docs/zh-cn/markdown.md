# 保存为 Markdown

**Markdown Preview Enhanced** 支持编译到 **GitHub Flavored Markdown**。这么做是为了使导出的 markdown 文件可以包含所有的绘制的图形（为 png 图片），code chunks，以及数学表达式（图片形式）等等以方便于发布到 GitHub。

## 使用

右键点击预览，然后选择 `Save as Markdown`.

## 设置

你可以通过 front-matter 来设置图片的保存路径以及输出路径。

```yaml
---
markdown:
  image_dir: /assets
  path: output.md
  ignore_from_front_matter: true
  absolute_image_path: false
---

```

**image_dir** `可选`  
定义了哪里将保存你的图片。例如，`/assets` 意味着所有的图片将会被保存到项目目录下的 `assets` 文件夹内。如果 `image_dir`。如果 **image_dir** 没有被定义，那么插件设置中的 `Image save folder path` 将会被使用。默认为 `/assets`。

**path** `可选`  
定义了哪里输出你的 markdown 文件。如果 **path** 没有被定义，`filename_.md` 将会被使用。

**ignore_from_front_matter** `可选`  
如果设置为 `false`，那么 `markdown` 将会被包含于导出的文件中的 front-matter 中。

**absolute_image_path** `可选`  
是否使用绝对（相对于项目文件夹）图片路径。

## 保存时自动导出

添加 front-matter 如下：

```yaml
---
export_on_save:
  markdown: true
---

```

这样每次当你保存你的 markdown 文件时，目标 markdown 将会自动被导出。

## 已知问题

- `WaveDrom` 无法工作。
- 数学表达式可能显示有问题。
- `latex` code chunk 目前无法工作。
