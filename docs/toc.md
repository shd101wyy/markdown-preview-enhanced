
<!-- toc orderedList:0 depthFrom:1 depthTo:6 -->

* [Table of Contents](#table-of-contents)
	* [[TOC]](#toc)
	* [Configuration](#configuration)

<!-- tocstop -->

# Table of Contents
**Markdown Preview Enhanced** can create `TOC` for your markdown file.   
You can press <kbd>cmd+shift+p</kbd> then choose `Markdown Preview Enhanced: Create Toc` to create `TOC`.  
Multiple TOCs can be created.  
To exclude a heading from the `TOC`, append `{.ignore}` **after** your heading.  

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

