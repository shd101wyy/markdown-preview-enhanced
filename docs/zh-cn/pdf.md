# PDF 导出  
## 使用
右键点击预览，然后选择 `Export to Disk`。  
点击 `PDF` 标签。  
点击 `export` 按钮。      

![screen shot 2017-06-06 at 4 46 25 pm](https://user-images.githubusercontent.com/1908863/26853612-588688f0-4ad8-11e7-809c-17d9043f49b4.png)

## 局限  
这个 PDF 导出是基于 [electron printToPDF](https://github.com/electron/electron/blob/master/docs/api/web-contents.md#contentsprinttopdfoptions-callback) 函数的。这个函数目前还不支持添加 header 和 footers 到生成的 PDF。    
你还可以尝试 [PhantomJS](zh-cn/phantomjs.md) 或者 [Prince](zh-cn/prince.md) 来生成 PDF。