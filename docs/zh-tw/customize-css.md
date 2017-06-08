# 自定義 CSS  

## style.less

要自定義 css，<kbd>cmd-shift-p</kbd> 然後運行 `Markdown Preview Enhanced: Customize Css` 命令或者 `Application: Open your stylesheet` 命令。      

`style.less` 文件將會被打開，然後你就可以開始編寫樣式了：  

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

## 本地樣式  
Markdown Preview Enhanced 允許你對於不同的 markdown 文件定義不同的樣式。    
你可以在 front-matter 設置 markdown 文檔的 `id` 和 `class`。  
你可以在你的 markdown 文件中非常簡單地 [引用](zh-tw/file-imports.md) `less` 或者 `css` 文件。  

```markdown
---
id: "my-id"
class: ["my-class1", "my-class2"]
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

每一次你更新了你的 `less` 文件，你都需要點擊 刷新按鈕 來重新編譯 less 到 css。  

![](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## 改編字體  
要改變你的預覽的字體，你需要首先下載字體文件 `(.ttf)`，然後編輯 `style.less` 如下：  

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

你還可以嘗試 [fonts](https://atom.io/packages/fonts) 插件。這個插件預先安裝好了很多字體。例如，如果你想要使用 `VT323` 字體：    

```less  
.markdown-preview-enhanced.markdown-preview-enhanced {
  font-family: 'VT323';

  h1, h2, h3, h4, h5, h6, pre, code {
    font-family: 'VT323' sans-serif;
  }
}
```  

![screen shot 2017-06-06 at 4 10 34 pm](https://user-images.githubusercontent.com/1908863/26852092-b03ef1c8-4ad2-11e7-951d-e384dc926b49.png)
