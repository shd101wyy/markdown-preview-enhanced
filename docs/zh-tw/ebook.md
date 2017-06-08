# eBook 導出

Inspired by *GitBook*  
**Markdown Preview Enhanced** 可以導出 ePub，Mobi，PDF 的電子書。  

![Screen Shot 2016-09-08 at 9.42.43 PM](http://ooo.0o0.ooo/2016/09/09/57d221c0a618a.png)

要導出電子書，你需要事先安裝好 `ebook-convert`。

## 安裝 ebook-convert
**macOS**  
下載 [Calibre](https://calibre-ebook.com/download)。  
在將 `calibre.app` 添加到你的 Applications 添加一個 symbolic link 到 `ebook-convert` 工具：  
```shell
$ sudo ln -s ~/Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin
```
**Windows**  
下載並安裝 [Calibre Application](https://calibre-ebook.com/download)。    
添加 `ebook-convert` 到你的系統路徑。  

## eBook 例子
一個電子書項目的例子可以查看 [這裡](https://github.com/shd101wyy/ebook-example).   

## 開始編寫 eBook    
你可以在你的 markdown 文件中添加 `ebook front-matter` 來設置你的電子書。     
```yaml
---
ebook:
  title: My eBook
  authors: shd101wyy
---
```

---

## Demo
`SUMMARY.md` 是一個**主文件**。他應該擁有一個 目錄（TOC）來幫忙組織書的結構：

```markdown
---
ebook:
  title: Markdown Preview Enhanced
  author: shd101wyy
---

# 前言  
這個是前言，但是不是必須的。

# 目錄
* [章 1](/chapter1/README.md)
  * [Markdown Preview Enhanced 的介紹](/chapter1/intro.md)
  * [特性](/chapter1/feature.md)
* [章 2](/chapter2/README.md)
  * [已知問題](/chapter2/issues.md)
```


一般來講，最後一個列表會被視為目錄（TOC）。  

---

如果你要導出一個電子書，打開你的主文件預覽，例如上面提到的 `SUMMARY.md`。然後右鍵點擊預覽，選擇 `Export to Disk`，然後選擇 `EBOOK` 選項。接著你就可以導出你的電子書了。  


### Metadata
* **title**  
你的書的標題    
* **authors**  
作者1 & 作者2 & ...  
* **cover**  
http://path-to-image.png  
* **comments**  
關於這本書的描述  
* **publisher**  
發行商是誰？    
* **book-producer**  
制作商是誰？    
* **pubdate**  
發布日期    
* **language**  
語言
* **isbn**  
書的 ISBN
* **tags**  
輸的標簽。應該用英文 `,` 隔開。  
* **series**  
書的系列。  
* **rating**  
書的評價。應該是 1 到 5 之間的數字。    
* **include_toc**  
`默認：true` 是否包含主文件中所寫的目錄（TOC）。

例如：  
```yaml
ebook:
  title: My eBook
  author: shd101wyy
  rating: 5  
```

### 感覺和外觀    
下面的選項幫助你設置輸出的電子書的外觀：   
* **asciiize** `[true/false]`   
`默認：false`, 是否將 unicode 字符轉化為 ASCII 。請小心使用這一選項因為這將會將 unicode 字符轉化為 ASCII。
* **base-font-size** `[number]`   
基本字體大小，單位 pts。所有的字體大小將會根據這個基本字體大小進行縮放。選擇大的字體意味著你輸出的內容的字體會更大。默認下，基本字體大小和你的 profile 設置中的相同。
* **disable-font-rescaling** `[true/false]`     
`默認：false` 禁掉所有字體的縮放。  
* **line-height** `[number]`  
行間距，單位 pts。用於控制行與行之間的空隙大小。這個選項僅僅作用於沒有定義自己行間距的元素。在普遍情況下，小的行間距是最有用的。默認下，沒有行間距的操作。  
* **margin-top** `[number]`  
`默認：72.0` Set the top margin in pts. Default is 72. Setting this to less than zero will cause no margin to be set (the margin setting in the original document will be preserved). Note: 72 pts equals 1 inch
* **margin-right** `[number]`  
`默認：72.0`
* **margin-bottom** `[number]`  
`默認：72.0`
* **margin-left** `[number]`  
`默認：72.0`
* **margin** `[number/array]`  
`默認：72.0`  
你也可以同時定義 **margin top/right/bottom/left**。例如：
```yaml
ebook:
  margin: 5 # margin-top = margin-right = margin-bottom = margin-left = 5
```
```yaml
ebook:
  margin: [4, 8] # margin-top = margin-bottom = 4, margin-left = margin-right = 8
```
```yaml
ebook:
  margin: [1, 2, 3, 4] # margin-top=1, margin-right=2, margin-bottom=3, margin-left=4
```

例如：
```yaml
ebook:
  title: My eBook
  base-font-size: 8
  margin: 72
```
## 輸出類型
目前你可以輸出以下類型的電子書：    
`ePub`, `mobi`, `pdf`, `html`。    

### ePub
要設置 `ePub` 的輸出，添加 `epub` 在 `ebook` 之後。     
```yaml
---
ebook:
  epub:
    no-default-epub-cover: true
    pretty-print: true
---
```
可進行的設置如下：  
* **no-default-epub-cover** `[true/false]`    
通常情況下，如果你沒有提供書籍的封面 `(cover)`，那麼我們會自動為你生成一個包含書名，作者名等的封面。禁用這個選項將會禁止自動生成封面。    
* **no-svg-cover** `[true/false]`  
不使用 SVG 作為書籍封面。啟用這個選項如果你的 EPUB 將會被用於不支持 SVG 的設備，例如 iPhone 或者 JetBook Lite。沒有這個選項，上述的設備將會顯示空白頁。  
* **pretty-print** `[true/false]`  
如果啟用了這個選項，那麼輸出插件將會盡可能的生成人類可讀的文檔。可能對其他一些插件沒作用。  


### PDF  
要設置 `ePub` 的輸出，添加 `pdf` 在 `ebook` 之後。     
```yaml
ebook:
  pdf:
    paper-size: letter
    default-font-size: 12
    header-template: "<span> Written by shd101wyy _PAGENUM_ </span>"
```
可進行的設置如下：  
* **paper-size**  
紙張的大小。這個選項將會覆蓋掉默認 profile 中的大小。默認是 letter。可選的選項有：`a0`，`a1`，`a2`，`a3`，`a4`，`a5`，`a6`，`b0`，`b1`，`b2`，`b3`，`b4`，`b5`，`b6`，`legal`，`letter`
* **default-font-size** `[number]`    
默認字體大小  
* **footer-template**  
為每個頁面的 footer 的模版。字符串 `_PAGENUM_`，`_TITLE_`，`_AUTHOR_` 已經 `_SECTION_` 將會被相應的值替代。    
* **header-template**  
為每個頁面的 header 的模版。字符串 `_PAGENUM_`，`_TITLE_`，`_AUTHOR_` 已經 `_SECTION_` 將會被相應的值替代。    
* **page-numbers** `[true/false]`     
`默認：false`  
添加頁碼到每一頁的底部。如果你定義了 `footer-template`，那麼 `footer-template` 會先被處理。  
* **pretty-print** `[true/false]`  
如果啟用了這個選項，那麼輸出插件將會盡可能的生成人類可讀的文檔。可能對其他一些插件沒作用。  


### HTML
導出 `.html` 不依賴於 `ebook-convert`.  
如果你要導出 `.html` 文件，那麼所有的本地圖片都將會被引用為 `base64` 數據到一個 `html` 文件中。    
要設置 `html` 的輸出，添加 `html` 在 `ebook` 之後。     
```yaml
ebook:
  html:
    cdn: true
```
* **cdn**  
是否從 `cdn.js` 讀取 css 和 javascript 文件。

## ebook-convert 參數
如果這裡有 `ebook-convert` 的一些你想要使用的特性，但是上面沒有提到，你依舊可以在 `args` 中使用它們。  
例如：  
```yaml
---
ebook:
  title: My eBook
  args: ["--embed-all-fonts", "--embed-font-family"]
---
```  
你可以在 [ebook-convert 手冊](https://manual.calibre-ebook.com/generated/en/ebook-convert.html) 中找到一系列的參數。  


## 已知問題 & 局限
* 這個特性還在開發中。  
* 所有由 `mermaid`，`PlantUML`，等 生成的 SVG 圖像將不會在電子書中工作。只有 `viz` 沒問題。
* 只有 **KaTeX** 可以在電子書中使用。   
  生成的電子書中的數學表達式無法在 **iBook** 顯示。  
* **PDF** 以及 **Mobi** 導出有些問題。  
* **Code Chunk** 無法在電子書中工作。  