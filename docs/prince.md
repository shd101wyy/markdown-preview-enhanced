# Prince PDF Export

**Markdown Preview Enhanced** supports [prince](https://www.princexml.com/) pdf export.

## Installation

You need to have [prince](https://www.princexml.com/) installed.
For `macOS`, open terminal and run the following command:

```sh
brew install Caskroom/cask/prince
```

## Usage

Right click at the preview, then choose `PDF (prince)`.

![screen shot 2017-07-14 at 1 44 23 am](https://user-images.githubusercontent.com/1908863/28201287-fb5ea8d0-6835-11e7-9bdb-2afb458ee5cc.png)

## Customize CSS

<kbd>cmd-shift-p</kbd> then run `Markdown Preview Enhanced: Customize Css` command to open `style.less` file, then add and modify the following lines:

```less
.markdown-preview.markdown-preview {
  &.prince {
    // your prince css here
  }
}
```

For example, to change the page size to `A4 landscape`:

```less
.markdown-preview.markdown-preview {
  &.prince {
    @page {
      size: A4 landscape;
    }
  }
}
```

More information can be found at [prince user guide](https://www.princexml.com/doc/).
Especially [page styles](https://www.princexml.com/doc/paged/#page-styles).

## Export on save

Add the front-matter like below:

```yaml
---
export_on_save:
  prince: true
---

```

So the PDF file will be generated every time you save your markdown source file.

## Known issues

- Doesn't work with `KaTeX` and `MathJax`.
