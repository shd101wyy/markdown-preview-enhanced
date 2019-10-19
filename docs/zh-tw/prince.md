# Prince PDF 導出

**Markdown Preview Enhanced** 支持 [prince](https://www.princexml.com/) pdf 文檔導出。

## 安裝

你需要事先安裝好 [prince](https://www.princexml.com/)。  
對於 `macOS`，打開 terminal 終端然後運行一下命令：

```sh
brew install Caskroom/cask/prince
```

## 使用

右鍵點擊預覽，然後選擇 `PDF (prince)`。

![screen shot 2017-07-14 at 1 44 23 am](https://user-images.githubusercontent.com/1908863/28201287-fb5ea8d0-6835-11e7-9bdb-2afb458ee5cc.png)

## 自定義 CSS

<kbd>cmd-shift-p</kbd> 然後運行 `Markdown Preview Enhanced: Customize Css` 命令，添加以下的代碼：

```less
.markdown-preview.markdown-preview {
  &.prince {
    // 你的 prince css
  }
}
```

例如，改變紙張大小到 `A4 landscape`:

```less
.markdown-preview.markdown-preview {
  &.prince {
    @page {
      size: A4 landscape;
    }
  }
}
```

更多信息請查看 [prince 用戶指南](https://www.princexml.com/doc/)。  
特別是 [page 樣式](https://www.princexml.com/doc/paged/#page-styles)。

## 保存時自動導出

添加 front-matter 如下：

```yaml
---
export_on_save:
  prince: true
---

```

這樣每次當你保存你的 markdown 文件時，Prince 將會自動運行生成 PDF 文件。

## 已知問題

- `KaTeX` 和 `MathJax` 無法工作。
