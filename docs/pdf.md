# PDF export

> We recommend to use [Chrome (Puppeteer) to export PDF](./puppeteer.md).

## Usage

Right click at the preview, then choose `Open in Browser`.
Print as PDF from browser.

![screen shot 2017-07-14 at 1 46 39 am](https://user-images.githubusercontent.com/1908863/28201366-536dbc0a-6836-11e7-866f-db9a5d12de16.png)

## Customize CSS

<kbd>cmd-shift-p</kbd> then run `Markdown Preview Enhanced: Customize Css` command to open `style.less` file, then add and modify the following lines:

```less
.markdown-preview.markdown-preview {
  @media print {
    // your code here
  }
}
```

---

You can also generate PDF file by [puppeteer](puppeteer.md) or [prince](prince.md).
