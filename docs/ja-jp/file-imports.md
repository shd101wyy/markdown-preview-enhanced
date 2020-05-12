# Import external files

![doc-imports](https://cloud.githubusercontent.com/assets/1908863/22716507/f352a4b6-ed5b-11e6-9bac-88837f111de0.gif)

## How to use?

just

`@import "your_file"`

easy, right :)

`<!-- @import "your_file" -->` is also valid.

## Refresh button

Refresh button is now added at the right corner of preview.
Clicking it will clear file caches and refresh the preview.
It could be useful if you want to clear image cache. [#144](https://github.com/shd101wyy/markdown-preview-enhanced/issues/144) [#249](https://github.com/shd101wyy/markdown-preview-enhanced/issues/249)

![screen shot 2017-02-07 at 5 48 52 pm](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Supported file types

- `.jpeg(.jpg), .gif, .png, .apng, .svg, .bmp` file will be treated as markdown image.
- `.csv` file will be converted to markdown table.
- `.mermaid` file will be rendered by mermaid.
- `.dot` file will be rendered by viz.js (graphviz).
- `.plantuml(.puml)` file will be rendered by PlantUML.
- `.html` file will be embedded directly.
- `.js` file will be included as `<script src="your_js"></script>`.
- `.less` and `.css` file will be included as style. Only local `less` file is currently supported. `.css` file will be included as `<link rel="stylesheet" href="your_css">`.
- `.pdf` file will be converted to `svg` files by `pdf2svg` and then be included.
- `markdown` file will be parsed and embedded directly.
- All other files will be rendered as code block.

## Configure images

```markdown
@import "test.png" {width="300px" height="200px" title="my title" alt="my alt"}
```

## Import online files

For example:

```markdown
@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"
```

## Import PDF file

To import PDF file, you need to have [pdf2svg](extra.md) installed.
Markdown Preview Enhanced supports importing both local and online PDF files.
However, it is not recommended to import large PDF files.
For example:

```markdown
@import "test.pdf"
```

### PDF configuration

- **page_no**
  Display the `nth` page of PDF. 1-based indexing. For example `{page_no=1}` will display the 1st page of pdf.
- **page_begin**, **page_end**
  Inclusive. For example `{page_begin=2 page_end=4}` will display the number 2, 3, 4 pages.

## Force to render as Code Block

```markdown
@import "test.puml" {code_block=true class="line-numbers"}
@import "test.py" {class="line-numbers"}
```

## As Code Block

```markdown
@import "test.json" {as="vega-lite"}
```

## Import certain lines

```markdown
@import "test.md" {line_begin=2}
@import "test.md" {line_begin=2 line_end=10}
@import "test.md" {line_end=-4}
```

## Import file as Code Chunk

```markdown
@import "test.py" {cmd="python3"}
```

[➔ Code Chunk](code-chunk.md)
