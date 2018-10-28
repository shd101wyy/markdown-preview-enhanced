# Chrome (Puppeteer) export

## Installation

You need to have [puppeteer](https://github.com/GoogleChrome/puppeteer) installed.

```bash
npm install -g puppeteer
```

## Usage
Right click at the preview, then choose `Chrome (Puppeteer)`.

## Configure puppeteer
You could write [PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions) and [Screenshot](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions) export configuration inside front-matter. For example:

````yaml
---
puppeteer:
    landscape: true
    format: "A4"
---
````

## Customize CSS
<kbd>cmd-shift-p</kbd> then run `Markdown Preview Enhanced: Customize Css` command to open `style.less` file, then add and modify the following lines:

```less
.markdown-preview.markdown-preview {
    @media print {
        // your code here
    }
}
```
