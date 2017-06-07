# 保存為 Markdown
**Markdown Preview Enhanced** 支持編譯到 **GitHub Flavored Markdown**。這麼做是為了使導出的 markdown 文件可以包含所有的繪制的圖形（為 png 圖片），code chunks，以及數學表達式（圖片形式）等等以方便於發布到 GitHub。    

## 使用
右鍵點擊預覽，然後選擇 `Save as Markdown (GFM)`.

## 設置
你可以通過 front-matter 來設置圖片的保存路徑以及輸出路徑。  
```yaml
---
markdown:
  image_dir: /assets
  path: output.md
  absolute_image_path: true

  front_matter:
    your_front_matter_here: blablabla
---
```

**image_dir** `可選`   
定義了哪裡將保存你的圖片。例如，`/assets` 意味著所有的圖片將會被保存到項目目錄下的 `assets` 文件夾內。如果 `image_dir`。如果 **image_dir** 沒有被定義，那麼插件設置中的 `Image save folder path` 將會被使用。默認為 `/assets`。  

**path** `可選`   
定義了哪裡輸出你的 markdown 文件。如果 **path** 沒有被定義，`filename_.md` 將會被使用。

**absolute_image_path** `可選`   
定義了是否使用絕對或者相對圖片路徑。默認為 `false`。

**front_matter** `可選`   
生成的 markdown 文件中保留的 front matter。

## 已知問題
* `WaveDrom` 無法工作。  
* 數學表達式可能顯示有問題。   
* `latex` code chunk 目前無法工作。  