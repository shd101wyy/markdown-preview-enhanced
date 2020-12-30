# CSS の編集

## style.less

markdown ファイルの css ファイルを編集するには、 <kbd>cmd-shift-p</kbd> に続けて `Markdown Preview Enhanced: Customize Css` コマンドを実行してください。

`style.less` ファイルが開くので、既定の style を以下のようにオーバーライドすることができます。:

> `style.less` ファイルは `~/.mume/style.less` にあります

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

Markdown Preview Enhanced では markdown ファイル毎に style を定義することができます。
`id` と `class` をファイルのフロント マターに設定することができます。
あとは単に markdown ファイルに `less` か `css` ファイルを [import](ja-jp/file-imports.md) することができます:

```markdown
---
id: "my-id"
class: "my-class1 my-class2"
---

@import "my-style.less"

# Heading1
```

`my-style.less` は以下のような内容です。

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

`less` ファイルを変更した場合、プレビュー右上の refresh ボタンを押すことで less を css にコンパイルし直すことができます。

![](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## font family の変更

プレビューの font family を変更するには、まず、フォントファイル`(.ttf)`をダウンロードし、`style.less`を以下のように修正してください:

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

> google フォントのようなオンラインフォントの使用を推奨します
