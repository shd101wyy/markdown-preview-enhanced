# HTML 导出  

## 使用
右键点击预览，然后点击 `HTML` 标签。  
接着选择：

* `HTML (offline)`
选择这个选项如果你要离线使用这个 html 文件。  
* `HTML (cdn hosted)`
选择这个选项如果你要远程或在服务器上使用这个 html 文件。

![screen shot 2017-07-14 at 1 14 28 am](https://user-images.githubusercontent.com/1908863/28200455-d5a12d60-6831-11e7-8572-91d3845ce8cf.png)

## 设置  
```yaml
---
html:
  embed_local_images: false
---
```


如果 `embed_local_images` 被设置为 `true`，那么所有的本地图片都将会被引用为 `base64` 格式。  