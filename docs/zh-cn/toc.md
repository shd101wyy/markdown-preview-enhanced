# 目录列表（TOC）
**Markdown Preview Enhanced** 支持你在 markdown 文件中创建 `TOC`。  
你可以通过 <kbd>cmd-shift-p</kbd> 然后选择 `Markdown Preview Enhanced: Create Toc` 命令来创建 `TOC`。  
多个 TOCs 可以被创建。  
如果你想要在你的 `TOC` 中排除一个标题，请在你的标题 **后面** 添加 `{.ignore}` 即可。

![screen shot 2017-06-05 at 9 02 20 pm](https://cloud.githubusercontent.com/assets/1908863/26810607/47f0aaa8-4a32-11e7-89ef-f5caebf00720.png)

## [TOC]  
你也可以通过在你的 markdown 文件中输入 `[TOC]` 来创建 `TOC`。  
例如：  
```markdown  

[TOC]  

# 标题1
## 标题2 {.ignore}
标题2 将会被目录忽略.  
```
但是，这种方式创建的 `TOC` 只会在预览中显示，而不会修改你的 markdown 文件。

## 设置  
* **orderedList**  
是否使用有序列表。
* **depthFrom**, **depthTo**  
`[1~6]` 包含的。   

[➔ 导入文件](zh-cn/file-imports.md)
