# HTML 導出

## 使用

右鍵點擊預覽，然後點擊 `HTML` 標簽。  
接著選擇：

- `HTML (offline)`
  選擇這個選項如果你要離線使用這個 html 文件。
- `HTML (cdn hosted)`
  選擇這個選項如果你要遠程或在服務器上使用這個 html 文件。

![screen shot 2017-07-14 at 1 14 28 am](https://user-images.githubusercontent.com/1908863/28200455-d5a12d60-6831-11e7-8572-91d3845ce8cf.png)

## 設置

默認：

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

如果 `embed_local_images` 被設置為 `true`，那麼所有的本地圖片將會被嵌入為 `base64` 格式。

如果 `toc` 被設置為 `false`，那麼邊欄目錄將會被隱藏。如果 `toc` 被設置為 `true`，那麼邊欄目錄將會被缺省啟動並顯示。如果 `toc` 沒有被設置，那麼缺省邊欄目錄將會被啟動，但是並不顯示。

## 保存時自動導出

添加 front-matter 如下：

```yaml
---
export_on_save:
  html: true
---

```

這樣當你保存你的 markdown 文件時，html 文件將會被自動導出。
