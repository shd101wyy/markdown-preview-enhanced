[Back](/docs/pandoc.md)

<!-- toc orderedList:0 -->

* [Word Document](#word-document)
	* [Overview](#overview)
	* [Export Path](#export-path)
	* [Syntax Highlighting](#syntax-highlighting)
	* [Style Reference](#style-reference)
	* [Pandoc Arguments](#pandoc-arguments)
	* [Shared Options](#shared-options)

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

## Export Path  
You can define the document export path by specifying `path` option. For example:    

```yaml
---
title: "Habits"
output:
  word_document:
    path: /Exports/Habits.docx
---
```   
If `path` is not defined, then document will be generated under the same directory.

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

## Style Reference
Use the specified file as a style reference in producing a docx file. For best results, the reference docx should be a modified version of a docx file produced using pandoc. The contents of the reference docx are ignored, but its stylesheets and document properties (including margins, page size, header, and footer) are used in the new docx. If no reference docx is specified on the command line, pandoc will look for a file `reference.docx` in the user data directory (see --data-dir). If this is not found either, sensible defaults will be used.  
```yaml
---
title: "Habits"
output:
  word_document:
    reference_docx: mystyles.docx
---
```

## Pandoc Arguments   
If there are pandoc features you want to use that lack equivalents in the YAML options described above you can still use them by passing custom `pandoc_args`. For example:  
```yaml
---
title: "Habits"
output:
  word_document:
    pandoc_args: [
      "--csl", "/var/csl/acs-nano.csl"
    ]
---
```

## Shared Options
If you want to specify a set of default options to be shared by multiple documents within a directory you can include a file named `_output.yaml` within the directory. Note that no YAML delimeters or enclosing output object are used in this file. For example:    

**_output.yaml**
```yaml
word_document:
  highlight: zenburn
```
All documents located in the same directory as `_output.yaml` will inherit it’s options. Options defined explicitly within documents will override those specified in the shared options file.
