# HTML 導出  

## 使用
右鍵點擊預覽，然後點擊 `HTML` 標簽。  
接著選擇：

* `HTML (offline)`
選擇這個選項如果你要離線使用這個 html 文件。  
* `HTML (cdn hosted)`
選擇這個選項如果你要遠程或在服務器上使用這個 html 文件。

![screen shot 2017-07-14 at 1 14 28 am](https://user-images.githubusercontent.com/1908863/28200455-d5a12d60-6831-11e7-8572-91d3845ce8cf.png)

## 設置  
```yaml
---
html:
  embed_local_images: false
---
```


如果 `embed_local_images` 被設置為 `true`，那麼所有的本地圖片都將會被引用為 `base64` 格式。  