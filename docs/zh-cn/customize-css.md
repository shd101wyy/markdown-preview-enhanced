# 自定义 CSS  

## style.less

要自定义 css，<kbd>cmd-shift-p</kbd> 然后运行 `Markdown Preview Enhanced: Customize Css`  

`style.less` 文件将会被打开，然后你就可以开始编写样式了：  

> `style.less` 文件位于 `~/.mume/style.less`


```less
html body {
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
  .slides > section:nth-child(1) {
    // this will modify `the first slide`
  }
}
```

## 本地样式  
Markdown Preview Enhanced 允许你对于不同的 markdown 文件定义不同的样式。    
你可以在 front-matter 设置 markdown 文档的 `id` 和 `class`。  
你可以在你的 markdown 文件中非常简单地 [引用](zh-cn/file-imports.md) `less` 或者 `css` 文件。  

```markdown
---
id: "my-id"
class: "my-class1 my-class2"
---

@import "my-style.less"

# Heading1
```  

`my-style.less` 如下：    

```less
#my-id {
    background-color: #222;
    color: #fff;

    h1, h2, h3, h4, h5, h6 {
        color: #fff;
    }
}
```

每一次你更新了你的 `less` 文件，你都需要点击 刷新按钮 来重新编译 less 到 css。  

![](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## 改编字体  
要改变你的预览的字体，你需要首先下载字体文件 `(.ttf)`，然后编辑 `style.less` 如下：  

```less
html body {
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

> 推荐使用在线的字体，例如从 google fonts 获得。