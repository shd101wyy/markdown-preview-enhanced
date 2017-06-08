# PhantomJS Export  

**PhantomJS** supports `pdf`, `jpeg`, and `png` file export.  

## Usage
Right click at the preview, then choose `Export to Disk`.  
Click `PHANTOMJS` tab.  
Click `export` button.    

![screen shot 2017-06-06 at 4 46 33 pm](https://user-images.githubusercontent.com/1908863/26853700-a85dba6a-4ad8-11e7-9d42-78b1e4249e83.png)

## Header and footer configuration    
You can configure header and footer by running `Markdown Preview Enhanced: Open Header Footer Config` command, then modify the `phantomjs_header_footer_config.js` file.  

The `phantomjs_header_footer_config.js` file should look like this:   


```javascript
'use strict'
/*
configure header and footer (and other options)
more information can be found here:
    https://github.com/marcbachmann/node-html-pdf
Attention: this config will override your config in exporter panel.

eg:

  let config = {
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

