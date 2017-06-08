# PDF 導出  
## 使用
右鍵點擊預覽，然後選擇 `Export to Disk`。  
點擊 `PDF` 標簽。  
點擊 `export` 按鈕。      

![screen shot 2017-06-06 at 4 46 25 pm](https://user-images.githubusercontent.com/1908863/26853612-588688f0-4ad8-11e7-809c-17d9043f49b4.png)

## 局限  
這個 PDF 導出是基於 [electron printToPDF](https://github.com/electron/electron/blob/master/docs/api/web-contents.md#contentsprinttopdfoptions-callback) 函數的。這個函數目前還不支持添加 header 和 footers 到生成的 PDF。    
你還可以嘗試 [PhantomJS](zh-tw/phantomjs.md) 或者 [Prince](zh-tw/prince.md) 來生成 PDF。