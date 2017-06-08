# Table of Contents
**Markdown Preview Enhanced** can create `TOC` for your markdown file.   
You can press <kbd>cmd-shift-p</kbd> then choose `Markdown Preview Enhanced: Create Toc` to create `TOC`.  
Multiple TOCs can be created.  
To exclude a heading from the `TOC`, append `{.ignore}` **after** your heading.  

![screen shot 2017-06-05 at 9 02 20 pm](https://cloud.githubusercontent.com/assets/1908863/26810607/47f0aaa8-4a32-11e7-89ef-f5caebf00720.png)


## [TOC]  
You can also create `TOC` by inserting `[TOC]` to your markdown file.  
For example:  
```markdown  

[TOC]  

# Heading 1
## Heading 2 {.ignore}
Heading 2 will be ignored from TOC.  
```
However, this way will only display TOC in preview, while leaving editor content unchanged.  

## Configuration  
* **orderedList**  
Use orderedList or not.  
* **depthFrom**, **depthTo**  
`[1~6]` inclusive.   

[➔ File Imports](file-imports.md)
