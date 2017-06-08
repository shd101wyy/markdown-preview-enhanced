# Prince PDF 导出
**Markdown Preview Enhanced** 支持 [prince](https://www.princexml.com/) pdf 文档导出。    

## 安装  
你需要事先安装好 [prince](https://www.princexml.com/)。    
对于 `macOS`，打开 terminal 终端然后运行一下命令：
```sh
brew install Caskroom/cask/prince
```

## 使用
右键点击预览，然后选择 `Export to Disk`。    
点击 `PRINCE` 标签。     
点击 `export` 按钮。      

![screen shot 2017-06-06 at 4 46 27 pm](https://user-images.githubusercontent.com/1908863/26853716-b68b279e-4ad8-11e7-896e-8e7c2990326b.png)

## 自定义 Css
<kbd>cmd-shift-p</kbd> 然后运行 `Markdown Preview Enhanced: Customize Css` 命令，添加以下的代码：    

```less
.markdown-preview-enhanced.markdown-preview-enhanced {
  &.prince {
    // 你的 prince css
  }
}
```

例如，改变纸张大小到 `A4 landscape`:  
```less
.markdown-preview-enhanced.markdown-preview-enhanced {
  &.prince {
    @page {
      size: A4 landscape
    }
  }
}
```

更多信息请查看 [prince 用户指南](https://www.princexml.com/doc/)。   
特别是 [page 样式](https://www.princexml.com/doc/paged/#page-styles)。    


## 已知问题
* `KaTeX` 和 `MathJax` 无法工作。    