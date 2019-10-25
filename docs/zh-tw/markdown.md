# 保存為 Markdown

**Markdown Preview Enhanced** 支持編譯到 **GitHub Flavored Markdown**。這麼做是為了使導出的 markdown 文件可以包含所有的繪制的圖形（為 png 圖片），code chunks，以及數學表達式（圖片形式）等等以方便於發布到 GitHub。

## 使用

右鍵點擊預覽，然後選擇 `Save as Markdown`.

## 設置

你可以通過 front-matter 來設置圖片的保存路徑以及輸出路徑。

```yaml
---
markdown:
  image_dir: /assets
  path: output.md
  ignore_from_front_matter: true
  absolute_image_path: false
---

```

**image_dir** `可選`  
定義了哪裡將保存你的圖片。例如，`/assets` 意味著所有的圖片將會被保存到項目目錄下的 `assets` 文件夾內。如果 `image_dir`。如果 **image_dir** 沒有被定義，那麼插件設置中的 `Image save folder path` 將會被使用。默認為 `/assets`。

**path** `可選`  
定義了哪裡輸出你的 markdown 文件。如果 **path** 沒有被定義，`filename_.md` 將會被使用。

**ignore_from_front_matter** `可選`  
如果設置為 `false`，那麼 `markdown` 將會被包含於導出的文件中的 front-matter 中。

**absolute_image_path** `可選`  
是否使用絕對（相對於項目文件夾）圖片路徑。

## 保存時自動導出

添加 front-matter 如下：

```yaml
---
export_on_save:
  markdown: true
---

```

這樣每次當你保存你的 markdown 文件時，目標 markdown 將會自動被導出。

## 已知問題

- `WaveDrom` 無法工作。
- 數學表達式可能顯示有問題。
- `latex` code chunk 目前無法工作。
