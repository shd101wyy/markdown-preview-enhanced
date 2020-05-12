# Chrome (Puppeteer) export

## Installation

You need to have the [Chrome browser](https://www.google.com/chrome/) installed.

> There is an extension setting with name `chromePath` that allows you to specify the path to the chrome executable. By default you don't have to modify it. The MPE extension will look for the path automatically.

## Usage

Right click at the preview, then choose `Chrome (Puppeteer)`.

## Configure puppeteer

You could write [PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions) and [Screenshot](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions) export configuration inside front-matter. For example:

```yaml
---
puppeteer:
  landscape: true
  format: "A4"
  timeout: 3000 # <= Special config, which means waitFor 3000 ms
---

```

## Export on save

```yaml
---
export_on_save:
    puppeteer: true # export PDF on save
    puppeteer: ["pdf", "png"] # export PDF and PNG files on save
    puppeteer: ["png"] # export PNG file on save
---
```

## Customize CSS

<kbd>cmd-shift-p</kbd> then run `Markdown Preview Enhanced: Customize Css` command to open `style.less` file, then add and modify the following lines:

```less
.markdown-preview.markdown-preview {
  @media print {
    // your code here
  }
}
```
