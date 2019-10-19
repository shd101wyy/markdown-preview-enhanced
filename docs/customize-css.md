# Customize CSS

## style.less

To customize css for your markdown file, <kbd>cmd-shift-p</kbd> then run `Markdown Preview Enhanced: Customize Css` command.

The `style.less` file will open, and you can override existing style like this:

> `style.less` file is located at `~/.mume/style.less`

```less
.markdown-preview.markdown-preview {
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

  // custom presentation style
  .reveal .slides {
    // modify all slides
  }

  .slides > section:nth-child(1) {
    // this will modify `the first slide`
  }
}

.md-sidebar-toc.md-sidebar-toc {
  // sidebar TOC style
}
```

## Local style

Markdown Preview Enhanced also allows you to define different styles for different markdown files.  
`id` and `class` can be configured inside front-matter.
You can [import](file-imports.md) a `less` or `css` file in your markdown file easily:

```markdown
---
id: "my-id"
class: "my-class1 my-class2"
---

@import "my-style.less"

# Heading1
```

the `my-style.less` could look like this:

```less
#my-id {
  background-color: #222;
  color: #fff;

  h1,
  h2,
  h3,
  h4,
  h5,
  h6 {
    color: #fff;
  }
}
```

Every time you changed your `less` file, you can click the refresh button at the right top corner of the preview to recompile less to css.

![](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Change the font family

To change the font family of preview, you first need to download the font file `(.ttf)`, then modify `style.less` like below:

```less
@font-face {
  font-family: "your-font-family";
  src: url("your-font-file-url");
}

.markdown-preview.markdown-preview {
  font-family: "your-font-family" sans-serif;

  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  pre,
  code {
    font-family: "your-font-family" sans-serif;
  }
}
```

> However, it is recommended to use online fonts like google fonts.
