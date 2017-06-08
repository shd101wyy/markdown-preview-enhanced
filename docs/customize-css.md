# Customize CSS  

## style.less

To customize css for your markdown file, <kbd>cmd-shift-p</kbd> then run `Markdown Preview Enhanced: Customize Css` command or `Application: Open your stylesheet` command.    

The `style.less` file will open, and you can override existing style like this:  
```less
.markdown-preview-enhanced.markdown-preview-enhanced {
  // please write your custom style here
  // eg:
  //  color: blue;          // change font color
  //  font-size: 14px;      // change font size
  // custom pdf output style
  @media print {
  }

  // custom prince pdf export style
  &.prince {
  }

  // custom phantomjs png/jpeg export style
  &.phantomjs-image {
  }

  //custom phantomjs pdf export style
  &.phantomjs-pdf {
  }

  // custom presentation style
  .preview-slides .slide,
  &[data-presentation-mode] {
    // eg
    // background-color: #000;
  }
}
```

## Local style
Markdown Preview Enhanced also allows you to define different styles for different markdown files.  
`id` and `class` can be configured inside front-matter.
You can [import](file-imports.md) a `less` or `css` file in your markdown file easily:  

```markdown
---
id: "my-id"
class: ["my-class1", "my-class2"]
---

@import "my-style.less"

# Heading1
```  

the `my-style.less` could look like this:  

```less
#my-id {
    background-color: #222;
    color: #fff;

    h1, h2, h3, h4, h5, h6 {
        color: #fff;
    }
}
```

Every time you changed your `less` file, you can click the refresh button at the right top corner of the preview to recompile less to css.   

![](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Change the font family  
To change the font family of preview, you first need to download the font file `(.ttf)`, then modify `style.less` like below:   

```less
.markdown-preview-enhanced.markdown-preview-enhanced {
  @font-face {
    font-family: 'your-font-family';
    src: url('your-font-file-url');
  }

  font-family: 'your-font-family' sans-serif;

  h1, h2, h3, h4, h5, h6, pre, code {
    font-family: 'your-font-family' sans-serif;
  }
}
```

You can also try the [fonts](https://atom.io/packages/fonts) package, which pre-installed a lot of fonts. For example, to use the `VT323` font:   

```less  
.markdown-preview-enhanced.markdown-preview-enhanced {
  font-family: 'VT323';

  h1, h2, h3, h4, h5, h6, pre, code {
    font-family: 'VT323' sans-serif;
  }
}
```  

![screen shot 2017-06-06 at 4 10 34 pm](https://user-images.githubusercontent.com/1908863/26852092-b03ef1c8-4ad2-11e7-951d-e384dc926b49.png)
