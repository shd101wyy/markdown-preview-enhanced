# PhantomJS Export

**PhantomJS** supports `pdf`, `jpeg`, and `png` file export.

Before using this feature, you need to have `phantomjs` installed.

* Windows
Check [PhantomJS](http://phantomjs.org/) website.
* macOS
`brew install phantomjs`

## Usage
Right click at the preview, then click `PhantomJS` tab.
Choose the file type you want to export.

![screen shot 2017-07-14 at 1 37 38 am](https://user-images.githubusercontent.com/1908863/28201098-0e5fe3be-6835-11e7-8db6-75fe7e5c35c7.png)

## Configuration
### For all files
You can configure header and footer by running `Markdown Preview Enhanced: Open PhantomJS Config` command, then modify the `phantomjs_config.js` file.

> `phantomjs_config.js` file is located at `~/.mume/phantomjs_config.js`

The `phantomjs_config.js` file should look like this:

```javascript
'use strict'
/*
configure header and footer (and other options)
more information can be found here:
    https://github.com/marcbachmann/node-html-pdf
Attention: this config will override your config in exporter panel.

eg:

  let config = {
    ""
    "header": {
      "height": "45mm",
      "contents": '<div style="text-align: center;">Author: Marc Bachmann</div>'
    },
    "footer": {
      "height": "28mm",
      "contents": '<span style="color: #444;">{{page}}</span>/<span>{{pages}}</span>'
    }
  }
*/
// you can edit the 'config' variable below
let config = {
}

module.exports = config || {}
```

### For single file
You can write front-matter to configure phantomjs:

```yaml
---
phantomjs:
  orientation: landscape
---
```

Check [node-html-pdf](https://github.com/marcbachmann/node-html-pdf#options) for more information.

## Customize CSS
<kbd>cmd-shift-p</kbd> then run `Markdown Preview Enhanced: Customize Css` command to open `style.less` file, then add and modify the following lines:
```less
.markdown-preview.markdown-preview {
  // custom phantomjs png/jpeg export style
  &.phantomjs-image {
    // your code here
  }

  //custom phantomjs pdf export style
  &.phantomjs-pdf {
    // your code here
  }
}
```

## Export on save
Add the front-matter like below:
```yaml
---
export_on_save:
  phantomjs: true
  // or
  phantomjs: "pdf"
  phantomjs: "jpeg"
  phantomjs: "png"
  phantomjs: ["pdf", "png", ...]
---
```
So the files will be generated every time you save your markdown source file.
