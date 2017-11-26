# Chrome (Puppeteer) export

## Installation

You need to have [puppeteer](https://github.com/GoogleChrome/puppeteer) installed.

```bash
npm install -g puppeteer
```

## Usage
Right click at the preview, then choose `Chrome (Puppeteer)`.

## Customize CSS
<kbd>cmd-shift-p</kbd> then run `Markdown Preview Enhanced: Customize Css` command to open `style.less` file, then add and modify the following lines:

```less
.markdown-preview.markdown-preview {
    @media print {
        // your code here
    }
}
```
