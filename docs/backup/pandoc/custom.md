[Back](/docs/pandoc.md)


<!-- toc orderedList:0 -->

* [Custom Document](#custom-document)
	* [Overview](#overview)
	* [Pandoc Arguments](#pandoc-arguments)
	* [Shared Options](#shared-options)

<!-- tocstop -->


# Custom Document
## Overview
**Custom Document** grants you the ability to fully utilize the power of `pandoc`.  
To create a custom document, you need to specify `custom_document` output format in the front-matter of your document, **and** `path` **has to be defined**.    

The code example below will behave similarly as [pdf document](./pdf.md).
```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output:
  custom_document:
    path: /Exports/test.pdf
    toc: true
---
```

The code example below will behave similarly as [beamer presentation](./beamer.md).
```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["-t", "beamer"]
---
```

## Pandoc Arguments   
If there are pandoc features you want to use that lack equivalents in the YAML options described above you can still use them by passing custom `pandoc_args`. For example:  
```yaml
---
title: "Habits"
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: [
      "--no-tex-ligatures"
    ]
---
```

## Shared Options
If you want to specify a set of default options to be shared by multiple documents within a directory you can include a file named `_output.yaml` within the directory. Note that no YAML delimeters or enclosing output object are used in this file. For example:    

**_output.yaml**
```yaml
custom_document:
  toc: true
  highlight: zenburn
```
All documents located in the same directory as `_output.yaml` will inherit it’s options. Options defined explicitly within documents will override those specified in the shared options file.
