module.exports = """
// github syntax theme
// forked and modified from https://github.com/primer/github-atom-light-syntax

// General colors
@syntax-text-color: #333;
@syntax-cursor-color: #000;
@syntax-selection-color: #c8c8fa;
// @syntax-background-color: #f7f7f7;
@syntax-background-color: #fff;
@syntax-cursor-line: #f5f5f5;
@syntax-invisible-color: #c0c0c0;

// Guide colors
@syntax-wrap-guide-color: #c0c0c0;
@syntax-indent-guide-color: #c0c0c0;
@syntax-invisible-character-color: #c0c0c0;

// For find and replace markers
@syntax-result-marker-color: #ed6a43;
@syntax-result-marker-color-selected: #fff;

// Gutter colors
@syntax-gutter-text-color: #333;
@syntax-gutter-text-color-selected: #333;
@syntax-gutter-background-color: #fff;
@syntax-gutter-background-color-selected: #f5f5f5;

// For git diff info. i.e. in the gutter
@syntax-color-renamed: #f2f9fc;
@syntax-color-added: #eaffea;
@syntax-color-modified: #fff9ea;
@syntax-color-removed: #ffecec;

// YIYI add this
.markdown-preview-enhanced {
  pre.editor-colors.editor-colors, code {
    background-color: #f7f7f7 !important;
  }
}

pre.editor-colors {
  background-color: @syntax-background-color;
  color: @syntax-text-color;

  .line.cursor-line {
    background-color: @syntax-cursor-line;
  }

  .invisible {
    color: @syntax-invisible-color;
  }

  .cursor {
    border-left: 2px solid @syntax-cursor-color;
  }

  .selection .region {
    background-color: @syntax-selection-color;
  }

  .bracket-matcher .region {
    border-bottom: 1px solid @syntax-cursor-color;
    box-sizing: border-box;
  }

  .invisible-character {
    color: @syntax-invisible-character-color;
  }

  .indent-guide {
    color: @syntax-indent-guide-color;
  }

  .wrap-guide {
    background-color: @syntax-wrap-guide-color;
  }

  .gutter {
    background-color: @syntax-gutter-background-color;
    color: @syntax-gutter-text-color;

    .line-number {
      color: @syntax-gutter-text-color;
      -webkit-font-smoothing: antialiased;

      &.cursor-line {
        color: @syntax-gutter-text-color-selected;
        background-color: @syntax-gutter-background-color-selected;
      }
      &.cursor-line-no-selection {
        background-color: transparent;
      }

      .icon-right {
        color: @syntax-text-color;
      }
    }

    &:not(.git-diff-icon) .line-number.git-line-removed {
      &.git-line-removed::before {
        bottom: -3px;
      }
      &::after {
        content: "";
        position: absolute;
        left: 0px;
        bottom: 0px;
        width: 25px;
        border-bottom: 1px dotted fade(@syntax-color-removed, 50%);
        pointer-events: none;
      }
    }
  }

  .gutter .line-number.folded,
  .gutter .line-number:after,
  .fold-marker:after {
    color: @syntax-gutter-text-color-selected;
  }
}

pre.editor-colors .search-results .syntax--marker .region {
  background-color: transparent;
  border: 1px solid @syntax-result-marker-color;
}

pre.editor-colors .search-results .syntax--marker.current-result .region {
  border: 1px solid @syntax-result-marker-color-selected;
}


.syntax--comment,
.syntax--punctuation.syntax--definition.syntax--comment,
.syntax--string.syntax--comment {
  color: #969896;
}

.syntax--constant,
.syntax--entity.syntax--name.syntax--constant,
.syntax--variable.syntax--other.syntax--constant,
.syntax--variable.syntax--language {
  color: #0086b3;
}

.syntax--keyword.syntax--operator.syntax--symbole,
.syntax--keyword.syntax--other.syntax--mark {
}

.syntax--entity,
.syntax--entity.syntax--name {
  font-weight: normal;
  font-style: normal;
  text-decoration: none;
  color: #795da3;
}

.syntax--variable.syntax--parameter.syntax--function {
  color: #333;
}

.syntax--entity.syntax--name.syntax--tag {
  font-weight: normal;
  font-style: normal;
  text-decoration: none;
  color: #63a35c;
}

.syntax--keyword {
  font-weight: normal;
  font-style: normal;
  text-decoration: none;
  color: #a71d5d;
}

.syntax--storage,
.syntax--storage.syntax--type {
  color: #a71d5d;
}

.syntax--storage.syntax--modifier.syntax--package,
.syntax--storage.syntax--modifier.syntax--import,
.syntax--storage.syntax--type.syntax--java {
  color: #333;
}

.syntax--string,
.syntax--punctuation.syntax--definition.syntax--string,
.syntax--string .syntax--punctuation.syntax--section.syntax--embedded .syntax--source {
  font-weight: normal;
  font-style: normal;
  text-decoration: none;
  color: #183691;
}

.syntax--string.syntax--unquoted.syntax--import.syntax--ada {
}

.syntax--support {
  font-weight: normal;
  font-style: normal;
  text-decoration: none;
  color: #0086b3;
}

.syntax--meta.syntax--property-name {
  font-weight: normal;
  font-style: normal;
  text-decoration: none;
  color: #0086b3;
}

.syntax--variable {
  font-weight: normal;
  font-style: normal;
  text-decoration: none;
  color: #ed6a43;
}

.syntax--variable.syntax--other {
  color: #333;
}

.syntax--invalid.syntax--broken {
  font-weight: bold;
  font-style: italic;
  text-decoration: underline;
  color: #b52a1d;
}

.syntax--invalid.syntax--deprecated {
  font-weight: bold;
  font-style: italic;
  text-decoration: underline;
  color: #b52a1d;
}

.syntax--invalid.syntax--illegal {
  font-style: italic;
  text-decoration: underline;
  background-color: #b52a1d;
  color: #f8f8f8;
}

.syntax--carriage-return {
  font-style: italic;
  text-decoration: underline;
  background-color: #b52a1d;
  color: #f8f8f8;
  undefined: ^M;
}

.syntax--invalid.syntax--unimplemented {
  font-weight: bold;
  font-style: italic;
  text-decoration: underline;
  color: #b52a1d;
}

.syntax--message.syntax--error {
  color: #b52a1d;
}

.syntax--string .syntax--source {
  font-weight: normal;
  font-style: normal;
  text-decoration: none;
  color: #333;
}

.syntax--string .syntax--variable {
  font-weight: normal;
  font-style: normal;
  text-decoration: none;
  color: #0086b3;
}

.syntax--source.syntax--regexp,
.syntax--string.syntax--regexp {
  font-weight: normal;
  font-style: normal;
  text-decoration: none;
  color: #183691;
}

.syntax--string.syntax--regexp.syntax--character-class,
.syntax--string.syntax--regexp .syntax--constant.syntax--character.syntax--escape,
.syntax--string.syntax--regexp .syntax--source.syntax--ruby.syntax--embedded,
.syntax--string.syntax--regexp .syntax--string.syntax--regexp.syntax--arbitrary-repitition {
  color: #183691;
}

.syntax--string.syntax--regexp .syntax--constant.syntax--character.syntax--escape {
  font-weight: bold;
  color: #63a35c;
}

.syntax--support.syntax--constant {
  font-weight: normal;
  font-style: normal;
  text-decoration: none;
  color: #0086b3;
}

.syntax--support.syntax--variable {
  color: #0086b3;
}

.syntax--meta.syntax--module-reference {
  color: #0086b3;
}

.syntax--markup.syntax--list {
  color: #693a17;
}

.syntax--markup.syntax--heading,
.syntax--markup.syntax--heading .syntax--entity.syntax--name {
  font-weight: bold;
  color: #1d3e81;
}

.syntax--markup.syntax--quote {
  color: #008080;
}

.syntax--markup.syntax--italic {
  font-style: italic;
  color: #333;
}

.syntax--markup.syntax--bold {
  font-weight: bold;
  color: #333;
}

.syntax--markup.syntax--raw {
  font-weight: normal;
  font-style: normal;
  text-decoration: none;
  color: #0086b3;
}

.syntax--markup.syntax--deleted,
.syntax--meta.syntax--diff.syntax--header.syntax--from-file,
.syntax--punctuation.syntax--definition.syntax--deleted {
  background-color: #ffecec;
  color: #bd2c00;
}

.syntax--markup.syntax--inserted,
.syntax--meta.syntax--diff.syntax--header.syntax--to-file,
.syntax--punctuation.syntax--definition.syntax--inserted {
  background-color: #eaffea;
  color: #55a532;
}

.syntax--markup.syntax--changed,
.syntax--punctuation.syntax--definition.syntax--changed {
  background-color: #ffe3b4;
  color: #ef9700;
}

.syntax--markup.syntax--ignored,
.syntax--markup.syntax--untracked {
  color: #d8d8d8;
  background-color: #808080;
}

.syntax--meta.syntax--diff.syntax--range {
  color: #795da3;
  font-weight: bold;
}

.syntax--meta.syntax--diff.syntax--header {
  color: #0086b3;
}

.syntax--meta.syntax--separator {
  font-weight: bold;
  color: #1d3e81;
}

.syntax--meta.syntax--output {
  color: #1d3e81;
}

.syntax--brackethighlighter.syntax--tag,
.syntax--brackethighlighter.syntax--curly,
.syntax--brackethighlighter.syntax--round,
.syntax--brackethighlighter.syntax--square,
.syntax--brackethighlighter.syntax--angle,
.syntax--brackethighlighter.syntax--quote {
  color: #595e62;
}

.syntax--brackethighlighter.syntax--unmatched {
  color: #b52a1d;
}

.syntax--sublimelinter.syntax--mark.syntax--error {
  color: #b52a1d;
}

.syntax--sublimelinter.syntax--mark.syntax--warning {
  color: #ed6a43;
}

.syntax--sublimelinter.syntax--gutter-mark {
  color: #c0c0c0;
}

.syntax--constant.syntax--other.syntax--reference.syntax--link,
.syntax--string.syntax--other.syntax--link {
  color: #183691;
  text-decoration: underline;
}
"""