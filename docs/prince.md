# Prince PDF Export
**Markdown Preview Enhanced** supports [prince](https://www.princexml.com/) pdf export.  

## Installation  
You need to have [prince](https://www.princexml.com/) installed.  
For `macOS`, open terminal and run the following command:
```sh
brew install Caskroom/cask/prince
```

## Usage
Right click at the preview, then choose `Export to Disk`.  
Click `PRINCE` tab.  
Click `export` button.    

![screen shot 2017-06-06 at 4 46 27 pm](https://user-images.githubusercontent.com/1908863/26853716-b68b279e-4ad8-11e7-896e-8e7c2990326b.png)

## Customize Css
<kbd>cmd-shift-p</kbd> then run `Markdown Preview Enhanced: Customize Css` command or just open `style.less` file and add the following lines:  

```less
.markdown-preview-enhanced.markdown-preview-enhanced {
  &.prince {
    // your prince css here
  }
}
```

For example, to change the page size to `A4 landscape`:  
```less
.markdown-preview-enhanced.markdown-preview-enhanced {
  &.prince {
    @page {
      size: A4 landscape
    }
  }
}
```

More information can be found at [prince user guide](https://www.princexml.com/doc/).  
Especially [page styles](https://www.princexml.com/doc/paged/#page-styles).  


## Known issues
* Doesn't work with `KaTeX` and `MathJax`.  