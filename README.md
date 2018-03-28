# Markdown preview enhanced with litvis

This project is a fork of [`markdown-preview-enhanced`](https://github.com/shd101wyy/markdown-preview-enhanced), which is a popular [Atom package](https://atom.io/packages/markdown-preview-enhanced) for previewing markdown files.
Most of the code in this fork is inherited from the upstream repository and is thus courtesy of [@shd101wyy](https://github.com/shd101wyy) and other [contributors](https://github.com/shd101wyy/markdown-preview-enhanced/graphs/contributors) to `markdown-preview-enhanced`.

The fork produces an Atom package called [`markdown-preview-enhanced-with-litvis`](https://atom.io/packages/markdown-preview-enhanced-with-litvis), which enables _Literate Visualisation_ ([litvis](http://litvis.org/)) in rendered markdown previews.

Litvis functionality has been designed and developed at [giCentre](https://www.gicentre.net/) by [Jo Wood](https://github.com/jwoLondon), [Alexander Kachkaev](https://github.com/kachkaev) and [Jason Dykes](https://github.com/jsndyks).
This research was in part supported by the EU under the EC Grant Agreement No. FP7-IP-608142 to Project [VALCRI](http://valcri.org/).

## Prerequisites

Please ensure that you have `elm` and `run-elm` installed on your machine before proceeding to the setup.
The following command will ensure that both of these tools are in place and are up-to-date.

```bash
npm install --global elm run-elm
```

If you don’t have npm, please download it as a part of Node.js from https://nodejs.org/.

## Setup for Atom users

### Via Atom’s GUI

1.  Go to _Preferences_ → _Packages_ and disable `markdown-preview` (Atom’s standard preview tool)

1.  If you are using `markdown-preview-enhanced`, temporary disable it too while you are trying out this fork.

1.  Switch to _Install_ section in _Preferences_ and search for `markdown-preview-enhanced-with-litvis`.
    Click _Install_ and reload Atom.

### Via command line

```
apm disable markdown-preview markdown-preview-enhanced
apm install markdown-preview-enhanced-with-litvis
```

## Getting started with litvis narratives

Literate visualization uses [Elm](http://elm-lang.org) and [Vega-Lite](https://vega.github.io/vega-lite) in the form of a declarative visualization language [elm-vega](http://package.elm-lang.org/packages/gicentre/elm-vega/latest).
While you don't have to use elm-vega in a litvis document it does enable quick declarative generation of interactive data graphics and therefore considerably enhances the capability of a litvis document.

Creating your own litvis narrative is as easy as writing a markdown file.
You can start with exploring the examples available at
https://github.com/gicentre/litvis/tree/master/examples.

## Formatting litvis narratives

It is possible to automatically format litvis-enabled markdown files including embedded Elm code blocks with [Prettier](https://prettier.io/), which is an opinionated code formatting tool.

Prettier is available in Atom via [`prettier-atom`](https://github.com/prettier/prettier-atom) package, but it does not format literate Elm code blocks in markdown files out of box.

Please follow these steps to enable full-featured formatting support for litvis in Atom:

1.  Globally install Prettier and its [Elm plugin](https://github.com/gicentre/prettier-plugin-elm) via npm:

    ```
    npm install --global github:kachkaev/prettier#fix-global-plugin-api-dist prettier-plugin-elm
    ```

    > Installing from `github:kachkaev/prettier#...` instead of just `prettier` is necessary until [prettier/prettier#4192](https://github.com/prettier/prettier/pull/4192) is merged.

1.  Install `prettier-atom` package via Atom’s _Preferences_ or from a command line:

    ```bash
    apm install prettier-atom
    ```

1.  Enable _Format on save_ in `prettier-atom` package preferences.

1.  _(optional)_ Configure Prettier globally by creating `~/.prettierrc` with the following yaml:

    ```yaml
    overrides:
    - files: "*.md"
      options:
      tabWidth: 4
    ```

    This will indent bullet point lists in markdowns with four spaces instead of two.

## Getting linting feedback for litvis narratives

When a currently opened litvis narrative contains issues such as errors in Elm code blocks, you are automatically shown a list of problems via Atom's built-in linter.

![kapture 2018-03-26 at 21 00 45](https://user-images.githubusercontent.com/608862/37930310-4ba86c40-313a-11e8-99f5-a6b7ac99f38c.gif)

If you have used Atom linting for any programming language before, all the necessary packages should be already installed.
Otherwise, please install packages called [`linter`](https://atom.io/packages/linter), [`linter-ui-default`](https://atom.io/packages/linter-ui-default), [`intentions`](https://atom.io/packages/intentions) and [`busy-signal`](https://atom.io/packages/busy-signal).

```bash
apm install linter linter-ui-default intentions busy-signal
```

When you are working on a complex litvis narrative that consists of several documents or depends on narrative schemas, you may benefit from going to `linter-ui-default` settings and changing _Panel Represents_ parameter to _Entire project_.
This will make the list of reported issues more informative.
