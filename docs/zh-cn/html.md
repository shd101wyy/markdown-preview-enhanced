# HTML 导出

## 使用

右键点击预览，然后点击 `HTML` 标签。  
接着选择：

- `HTML (offline)`
  选择这个选项如果你要离线使用这个 html 文件。
- `HTML (cdn hosted)`
  选择这个选项如果你要远程或在服务器上使用这个 html 文件。

![screen shot 2017-07-14 at 1 14 28 am](https://user-images.githubusercontent.com/1908863/28200455-d5a12d60-6831-11e7-8572-91d3845ce8cf.png)

## 设置

默认：

```yaml
---
html:
  embed_local_images: false
  embed_svg: true
  offline: false
  toc: undefined

print_background: false
---

```

如果 `embed_local_images` 被设置为 `true`，那么所有的本地图片将会被嵌入为 `base64` 格式。

如果 `toc` 被设置为 `false`，那么边栏目录将会被隐藏。如果 `toc` 被设置为 `true`，那么边栏目录将会被缺省启动并显示。如果 `toc` 没有被设置，那么缺省边栏目录将会被启动，但是并不显示。

## 保存时自动导出

添加 front-matter 如下：

```yaml
---
export_on_save:
  html: true
---

```

这样当你保存你的 markdown 文件时，html 文件将会被自动导出。
