# PDF export  
## Usage
Right click at the preview, then choose `Export to Disk`.  
Click `PDF` tab.  
Click `export` button.    

![screen shot 2017-06-06 at 4 46 25 pm](https://user-images.githubusercontent.com/1908863/26853612-588688f0-4ad8-11e7-809c-17d9043f49b4.png)

## Limits  
This PDF export is powered by [electron printToPDF](https://github.com/electron/electron/blob/master/docs/api/web-contents.md#contentsprinttopdfoptions-callback) function. It is not possible to configure headers and footers for the generated PDF file.   
You can also try [PhantomJS](phantomjs.md) or [Prince](prince.md) to generate PDF.   