# Pandoc
**Markdown Preview Enhanced** 支持類似於 `RStudio Markdown` 的 `pandoc 文檔導出`特性。    
要使用這一特性，你需要安裝好 [pandoc](http://pandoc.org/)。  
Pandoc 的安裝說明可以參考 [這裡](http://pandoc.org/installing.html)。    
你可以通過右鍵點擊預覽，然後在菜單中點擊 `Pandoc` 使用 `pandoc document export`。

---

## Pandoc Parser
默認情況下， **Markdown Preview Enhanced** 使用 [remarkable](https://github.com/jonschlinkert/remarkable) 來轉換 markdown。  
你也可以在插件設置中設置使用 `Pandoc Parser` 來轉換 markdown。      

![Screen Shot 2017-03-07 at 10.05.25 PM](http://i.imgur.com/NdCJBgR.png)  

你還可以為單獨的文件設置 pandoc 的參數通過編寫 front-matter：  
```markdown
---
pandoc_args: ['--toc', '--toc-depth=2']
---
```

請注意，如果在你的 front-matter 中寫有 `references` 或者 `bibliography`，那麼 `--filter=pandoc-citeproc` 將會被自動添加 。  

**請注意**：這一特性依舊是實驗性質的。請隨意發表你的看法以及建議。  
**已知的問題 & 局限**:  
1. `ebook` 導出有問題。  
2. `Code Chunk` 有時候有問題。  
3. `Create TOC` 命令無法工作，但是 `[TOC]` 這種寫法沒問題。  

## Front-Matter   
`pandoc document export` 要求編寫 `front-matter`。    
如果你想了解更多的關於如何編寫 `front-matter` 的信息，請查看 [這裡](https://jekyllrb.com/docs/frontmatter/)。

## 文檔導出  

你不是必須使用我上面提到的 `Pandoc Parser` 才可以使用 Pandoc 導出文件。  

以下的文件類型是支持的，**更多的文件類型可能會在未來添加。**  
（一些例子引用於 [RStudio Markdown](http://rmarkdown.rstudio.com/formats.html)）   
點擊以下的鏈接查看如何導出相應的文件類型。    

* [PDF](zh-tw/pandoc-pdf.md)  
* [Word](zh-tw/pandoc-word.md)
* [RTF](zh-tw/pandoc-rtf.md)
* [Beamer](zh-tw/pandoc-beamer.md)  


你還可以創建你自己的自定義文檔：
* [custom](zh-tw/pandoc-custom.md)

## 文章  
* [Bibliographies and Citations](zh-tw/pandoc-bibliographies-and-citations.md)

## 注意
`mermaid，wavedrom` 將無法在 `pandoc document export` 中工作。        
[code chunk](code-chunk.md) 部分工作於 `pandoc document export`。      
