# Prince PDF 導出
**Markdown Preview Enhanced** 支持 [prince](https://www.princexml.com/) pdf 文檔導出。    

## 安裝  
你需要事先安裝好 [prince](https://www.princexml.com/)。    
對於 `macOS`，打開 terminal 終端然後運行一下命令：
```sh
brew install Caskroom/cask/prince
```

## 使用
右鍵點擊預覽，然後選擇 `Export to Disk`。    
點擊 `PRINCE` 標簽。     
點擊 `export` 按鈕。      

![screen shot 2017-06-06 at 4 46 27 pm](https://user-images.githubusercontent.com/1908863/26853716-b68b279e-4ad8-11e7-896e-8e7c2990326b.png)

## 自定義 Css
<kbd>cmd-shift-p</kbd> 然後運行 `Markdown Preview Enhanced: Customize Css` 命令，添加以下的代碼：    

```less
.markdown-preview-enhanced.markdown-preview-enhanced {
  &.prince {
    // 你的 prince css
  }
}
```

例如，改變紙張大小到 `A4 landscape`:  
```less
.markdown-preview-enhanced.markdown-preview-enhanced {
  &.prince {
    @page {
      size: A4 landscape
    }
  }
}
```

更多信息請查看 [prince 用戶指南](https://www.princexml.com/doc/)。   
特別是 [page 樣式](https://www.princexml.com/doc/paged/#page-styles)。    


## 已知問題
* `KaTeX` 和 `MathJax` 無法工作。    