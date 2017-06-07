# 目錄列表（TOC）
**Markdown Preview Enhanced** 支持你在 markdown 文件中創建 `TOC`。  
你可以通過 <kbd>cmd-shift-p</kbd> 然後選擇 `Markdown Preview Enhanced: Create Toc` 命令來創建 `TOC`。  
多個 TOCs 可以被創建。  
如果你想要在你的 `TOC` 中排除一個標題，請在你的標題 **後面** 添加 `{.ignore}` 即可。

![screen shot 2017-06-05 at 9 02 20 pm](https://cloud.githubusercontent.com/assets/1908863/26810607/47f0aaa8-4a32-11e7-89ef-f5caebf00720.png)

## [TOC]  
你也可以通過在你的 markdown 文件中輸入 `[TOC]` 來創建 `TOC`。  
例如：  
```markdown  

[TOC]  

# 標題1
## 標題2 {.ignore}
標題2 將會被目錄忽略.  
```
但是，這種方式創建的 `TOC` 只會在預覽中顯示，而不會修改你的 markdown 文件。

## 設置  
* **orderedList**  
是否使用有序列表。
* **depthFrom**, **depthTo**  
`[1~6]` 包含的。   

[➔ 導入文件](zh-tw/file-imports.md)
