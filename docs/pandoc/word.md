[Back](/docs/advanced-export.md)

<!-- toc orderedList:0 -->

- [Word Document](#word-document)
	- [Overview](#overview)
	- [Syntax Highlighting](#syntax-highlighting)
	- [Pandoc Arguments](#pandoc-arguments)
	- [Shared Options](#shared-options)

<!-- tocstop -->

# Word Document
## Overview
To create a Word document, you need to specify the word_document output format in the front-matter of your document:  
```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: word_document
---
```  
## Syntax Highlighting  
You can use the `highlight` option to control the syntax highlighting theme. For example:  
```yaml
---
title: "Habits"
output:
  word_document:
    highlight: "tango"
---
```


## Pandoc Arguments   
If there are pandoc features you want to use that lack equivilants in the YAML options described above you can still use them by passing custom `pandoc_args`. For example:  
```yaml
---
title: "Habits"
output:
  pdf_document:
    pandoc_args: [
      "--no-tex-ligatures"
    ]
---
```

## Shared Options
If you want to specify a set of default options to be shared by multiple documents within a directory you can include a file named `_output.yaml` within the directory. Note that no YAML delimeters or enclosing output object are used in this file. For example:    

**_output.yaml**
```yaml
pdf_document:
  toc: true
  highlight: zenburn
```
All documents located in the same directory as `_output.yaml` will inherit it’s options. Options defined explicitly within documents will override those specified in the shared options file.
