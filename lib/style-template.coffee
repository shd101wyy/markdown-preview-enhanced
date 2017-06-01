module.exports = """
// check markdown-preview-enhanced.coffee loadPreviewTheme function.

@fg-accent: @syntax-cursor-color;
@fg-strong: contrast(@bg, darken(@fg, 32%), lighten(@fg, 32%));
@fg-subtle: contrast(@fg, lighten(@fg, 16%), darken(@fg, 16%));
@border: contrast(@bg, lighten(@bg, 16%), darken(@bg, 16%));
@margin: 16px;

.scrollbar-style {
  &::-webkit-scrollbar {
    width: 8px;
  }

  &::-webkit-scrollbar-track {
    // -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
    border-radius: 10px;
    background-color: @bg;
  }

  &::-webkit-scrollbar-thumb {
    border-radius: 5px;
    // -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5);
    background-color: rgba(150, 150, 150, .66);
    border: 4px solid rgba(150, 150, 150, .66);
    background-clip: content-box;
  }
}

.markdown-preview-enhanced-container {
  .mpe-toolbar {
    position: absolute;
    top: 32px;
    right: 24px;
    opacity: 0;
    display: block;

    .back-to-top-btn, .refresh-btn, .sidebar-toc-btn {
      float: right;
      width: 32px;
      margin-right: 4px;
      opacity: 0.4;

      &:hover {
        opacity: 1.0;
      }
    }
  }

  &:hover {
    .back-to-top-btn, .refresh-btn, .sidebar-toc-btn {
      display: block;
    }
  }

  &.show-sidebar-toc {
    .mpe-sidebar-toc {
      font-family: "Helvetica Neue", Helvetica, "Segoe UI", Arial, freesans, sans-serif;
      position: absolute;
      top: 0;
      right: 0;
      width: 268px;
      height: 100%;
      padding: 32px 0 12px 0;
      overflow: auto;
      background-color: @bg;
      color: @fg;
      font-size: 14px;
      box-shadow: -4px 0px 12px rgba(150, 150, 150, .33);

      a {
        color: @fg;
      }

      ul {
        padding: 0 1.6em;
      }

      li {
        margin-bottom: 0.8em;
      }

      ul {
        list-style-type: none;
      }
    }

    .mpe-toolbar {
      right: 300px;
    }

    .markdown-preview-enhanced {
      width: calc(~"100% - 268px");
    }
  }

  .mpe-sidebar-toc, .markdown-preview-enhanced {
    .scrollbar-style();
  }
}

.markdown-preview-enhanced {
  font-family: "Helvetica Neue", Helvetica, "Segoe UI", Arial, freesans, sans-serif;
  // font-size: 1.2em;
  font-size: 16px;
  line-height: 1.6;
  color: @fg;
  background-color: @bg;
  overflow: initial;
  margin: 10px 13px 10px 13px;
  padding: 2em;
  box-sizing: border-box;
  word-wrap: break-word;

  & > :first-child {
    margin-top: 0;
  }

  &[for="preview"] {
    width: 100%;
    height: 100%;
    margin: 0;
    // z-index: 999;
    overflow: auto;
    font-size: 16px;
    display: block;
    position: absolute;
  }


  // Headings --------------------
  h1, h2, h3, h4, h5, h6 {
    line-height: 1.2;
    margin-top: 1em;
    margin-bottom: @margin;
    color: @fg-strong;
  }

  h1 { font-size: 2.25em; font-weight: 300; padding-bottom: 0.3em; border-bottom: 1px solid @border;}
  h2 { font-size: 1.75em; font-weight: 400; padding-bottom: 0.3em; border-bottom: 1px solid @border;}
  h3 { font-size: 1.5em; font-weight: 500; }
  h4 { font-size: 1.25em; font-weight: 600; }
  h5 { font-size: 1.1em; font-weight: 600; }
  h6 { font-size: 1.0em; font-weight: 600; }

  h1, h2, h3, h4, h5 { font-weight: 600; }
  h5 { font-size: 1em; }
  h6 { color: @fg-subtle; }

  h1, h2 {
    border-bottom: 1px solid @border;
  }

  // Emphasis --------------------

  strong {
    color: @fg-strong;
  }

  del {
    color: @fg-subtle;
  }


  // Link --------------------
  a:not([href]) {
    color: inherit;
    text-decoration: none;
  }

  a {
    color: #08c;
    text-decoration: none;
  }

  a:hover {
    color: #0050a3;
    text-decoration: none;
  }


  // Images --------------------
  img, svg {
    max-width: 100%;
  }


  // Paragraph --------------------

  & > p {
    margin-top: 0;
    margin-bottom: @margin;
    word-wrap: break-word;
  }

  // List --------------------

  & > ul,
  & > ol {
    margin-bottom: @margin;
  }

  ul,
  ol {
    padding-left: 2em;

    &.no-list {
      padding: 0;
      list-style-type: none;
    }
  }

  ul ul,
  ul ol,
  ol ol,
  ol ul {
    margin-top: 0;
    margin-bottom: 0;
  }

  li {
    margin-bottom: 0;

    &.task-list-item {
      list-style: none;
    }
  }


  li > p {
    // margin-top: @margin;
    margin-top: 0;
    margin-bottom: 0;
  }

  .task-list-item-checkbox {
    margin: 0 0.2em 0.25em -1.6em;
    vertical-align: middle;

    &:hover {
      cursor: pointer;
    }
  }


  // Blockquotes --------------------

  blockquote {
    margin: @margin 0;
    font-size: inherit;
    padding: 0 15px;
    color: @fg-subtle;
    border-left: 4px solid @border;

    > :first-child {
      margin-top: 0;
    }

    > :last-child {
      margin-bottom: 0;
    }
  }

  // HR --------------------
  hr {
    height: 4px;
    margin: @margin*2 0;
    background-color: @border;
    border: 0 none;
  }

  // Table --------------------
  table {
    margin: 10px 0 15px 0;
  	border-collapse: collapse;
    border-spacing: 0;

    display: block;
    width: 100%;
    overflow: auto;
    word-break: normal;
    word-break: keep-all;

    th {
      font-weight: bold;
      color: @fg-strong;
    }

    td, th {
    	border: 1px solid @border;
    	padding: 6px 13px;
    }
  }

  // Definition List
  dl {
    padding: 0;

    dt {
      padding: 0;
      margin-top: 16px;
      font-size: 1em;
      font-style: italic;
      font-weight: bold;
    }

    dd {
      padding: 0 16px;
      margin-bottom: 16px;
    }
  }

  // Code --------------------
  code {
    font-family: Menlo, Monaco, Consolas, 'Courier New', monospace;
    font-size: 0.85em !important;
    color: @fg-strong;
    background-color: contrast(@bg, lighten(@bg, 8%), darken(@bg, 6%));

    border-radius: 3px;
    padding: 0.2em 0;

    &::before, &::after {
      letter-spacing: -0.2em;
      content: "\\00a0";
    }
  }

  // YIYI add this
  // Code tags within code blocks (<pre>s)
  pre > code {
    padding: 0;
    margin: 0;
    font-size: 0.85em !important;
    word-break: normal;
    white-space: pre;
    background: transparent;
    border: 0;
  }

  .highlight {
    margin-bottom: @margin;
  }

  .highlight pre,
  pre {
    font-family: Menlo, Monaco, Consolas, 'Courier New', monospace;
    padding: @margin;
    overflow: auto;
    font-size: 0.85em !important;
    line-height: 1.45;

    color: @syntax-text-color;
    background-color: contrast(@syntax-background-color, lighten(@syntax-background-color, 4%), darken(@syntax-background-color, 6%)) !important;

    border: @border;
    border-radius: 3px;
  }

  .highlight pre {
    margin-bottom: 0;
    word-break: normal;
  }

  pre {
    word-wrap: break-word;
    white-space: normal;
    word-break: break-all;

    .section {
      opacity: 1;
    }
  }

  pre code,
  pre tt {
    display: inline;
    max-width: initial;
    padding: 0;
    margin: 0;
    overflow: initial;
    line-height: inherit;
    word-wrap: normal;
    background-color: transparent;
    border: 0;

    &:before,
    &:after {
      content: normal;
    }
  }

  p,
  blockquote,
  ul, ol, dl,
  pre {
    margin-top: 0;
    margin-bottom: @margin;
    // word-wrap: break-word;
  }

  // add line number support
  pre.editor-colors.lineNo {
    counter-reset: lineNo;
    .line {
      &::before {
        display: inline-block;
        counter-increment: lineNo;
        content: counter(lineNo);
        text-align: right;
        padding: 0;
        margin-left: -1em;
        margin-right: 1.5em;
      }
    }

    &.lineno-100 {
      .line::before {
          width: 2em;
      }
    }

    &.lineno-1000 {
      .line::before {
          width: 2.5em;
      }
    }

    &.lineno-10000 {
      .line::before {
          width: 3em;
      }
    }

    &.lineno-100000 {
      .line::before {
          width: 3.5em;
      }
    }
  }

  // KBD --------------------
  kbd {
    color: @fg-strong;
    border: 1px solid @border;
    border-bottom: 2px solid darken(@border, 6%);
    padding: 2px 4px;
    background-color: contrast(@bg, lighten(@bg, 8%), darken(@bg, 6%));
    border-radius: 3px;
    // box-shadow: inset 0 -1px 0 #bbb;
  }

  .pagebreak, .newpage {
    page-break-before: always;
  }

  @media screen and (min-width: 914px) {
    width: 980px;
    margin:10px auto;
    background: @bg;
  }

  // mobile
  @media screen and (max-width: 400px) {
    font-size: 14px;
    margin: 0 auto;
    padding: 15px;
  }

  // very nice tutorial & intro
  // https://www.smashingmagazine.com/2015/01/designing-for-print-with-css/
  @media print{
    background-color: @bg;

    h1, h2, h3, h4, h5, h6 {
      color: @fg-strong;
      page-break-after: avoid;
    }

    blockquote {
      color: @fg-subtle;
    }

    /*table,*/ pre {
       page-break-inside: avoid;
    }

    table {
      display: table;
    }

    img {
        display: block;
        max-width: 100%;
        max-height: 100%;
    }

    pre, code {
        word-wrap: break-word;
        white-space: normal;
    }
  }

  // code chunk
  &[for="preview"] {
    .code-chunk {
      position: relative;

      .output-div {
        overflow-x: auto;

        svg {
          display: block;
        }
      }

      pre {
        cursor: text;
      }

      .btn-group {
        position: absolute;
        right: 0;
        top: 0;
        display: none;

        .run-btn, .run-all-btn {
          float: right;
          margin-left: 4px;
          border-radius: 3px;
          font-size: 0.8em;
          color: #eee;
          background-color: #528bff;
          background-image: none;
          border: none;

          &:hover {
            background-color: #4b7fe8;
            cursor: pointer;
          }
        }
      }

      &:hover {
        .btn-group {
          display: block;
        }
      }

      .status {
        position: absolute;
        right: 0;
        top: 0;
        font-size: 0.85em;
        color: inherit;
        padding: 2px 6px;
        background-color: rgba(0, 0, 0, 0.04);
        display: none;
      }

      &.running {
        .btn-group {
          display: none;
        }
        .status {
          display: block;
        }
      }
    }
  }

  &:not([for="preview"]) {
    .code-chunk {
      .btn-group {
        display: none;
      }
      .status {
        display: none;
      }
    }
  }
}

/*
 * Reveal.js styles
 */
[data-presentation-preview-mode] {
  background-color: #f4f4f4;

  .preview-slides {
    width: 100%;

    .slide {
      position: relative;
      background-color: @bg;

      //width: 100%; # need to be set later
      //height: 100%;

      padding: 2em !important;
      margin-bottom: 12px;
      text-align: left !important;
      display: flex;
      align-items:center;

      border: 1px solid #e6e6e6;

      box-shadow: 0px 0px 16px 4px #eeeeee;

      font-size: 24px;

      h1, h2, h3, h4, h5, h6 {
        margin-top: 0;
      }

      .background-video {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
      }

      .background-iframe, .background-iframe-overlay {
        position: absolute;
        width: 100%;
        height: 100%;
        left: 0;
        top: 0;
        border: none;
        z-index: 1;
      }

      .background-iframe-overlay {
        z-index: 2;
      }
    }
  }

  section {
    display: block;
    width: 100%;
    transform-style: preserve-3d;
    font-size: 100%;
    font: inherit;
    // z-index: 100;
  }
}

.markdown-preview-enhanced[data-presentation-mode] {
  font-size: 24px;
  width: 100%;
  box-sizing: border-box;
  margin: 0;
  padding: 0;

  h1, h2, h3, h4, h5, h6 {
    margin-top: 0;
  }
  strong {
    font-weight: bold; // without this line, the output <strong> doesn't have wrong effect.
  }

  &::-webkit-scrollbar {
    display: none;
  }
}

.markdown-preview-enhanced {
  .slides {
    text-align: left !important;
  }
}

"""