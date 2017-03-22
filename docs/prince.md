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

![Screen Shot 2017-03-19 at 3.37.43 PM](http://i.imgur.com/vFHRABY.png)

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