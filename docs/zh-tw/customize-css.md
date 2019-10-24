# 自定義 CSS

## style.less

要自定義 css，<kbd>cmd-shift-p</kbd> 然後運行 `Markdown Preview Enhanced: Customize Css`

`style.less` 文件將會被打開，然後你就可以開始編寫樣式了：

> `style.less` 文件位於 `~/.mume/style.less`

```less
.markdown-preview.markdown-preview {
  // 在這裡編寫你的樣式
  // 例如：
  //  color: blue;          // 改變字體顏色
  //  font-size: 14px;      // 改變字體大小
  // 自定義 pdf 導出樣式
  @media print {
  }

  // 自定義 prince pdf 導出樣式
  &.prince {
  }

  // 自定義 presentation 樣式
  .reveal .slides {
    // 修改所有幻燈片
  }

  // 自定義 presentation 樣式
  .slides > section:nth-child(1) {
    // 修改 `第 1 個幻燈片`
  }
}

.md-sidebar-toc.md-sidebar-toc {
  // 邊欄目錄樣式
}
```

## 本地樣式

Markdown Preview Enhanced 允許你對於不同的 markdown 文件定義不同的樣式。
你可以在 front-matter 設置 markdown 文檔的 `id` 和 `class`。
你可以在你的 markdown 文件中非常簡單地 [引用](zh-tw/file-imports.md) `less` 或者 `css` 文件。

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

每一次你更新了你的 `less` 文件，你都需要點擊 刷新按鈕 來重新編譯 less 到 css。

![](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## 改編字體

要改變你的預覽的字體，你需要首先下載字體文件 `(.ttf)`，然後編輯 `style.less` 如下：

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

> 推薦使用在線的字體，例如從 google fonts 獲得。
