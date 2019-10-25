# Markdown Preview Enhanced

markdown compilation test, modified from [remarkable demo](https://jonschlinkert.github.io/remarkable/demo/).

> Experience real-time editing with Markdown Preview Enhanced!

---

# h1 Heading

## h2 Heading

### h3 Heading

#### h4 Heading

##### h5 Heading

###### h6 Heading

## Horizontal Rules

---

---

---

## Math

<img src="http://api.gmath.guru/cgi-bin/gmath?%5Cleft%28%20%5Cbegin%7Barray%7D%7Bccc%7Da%20%26%20b%20%26%20c%20%5C%5Cd%20%26%20e%20%26%20f%20%5C%5Cg%20%26%20h%20%26%20i%20%5Cend%7Barray%7D%20%5Cright%29"/>
is given by the formula
<p align="center"><img src="http://api.gmath.guru/cgi-bin/gmath?%20%5Cchi%28%5Clambda%29%20%3D%20%5Cleft%7C%20%5Cbegin%7Barray%7D%7Bccc%7D%5Clambda%20-%20a%20%26%20-b%20%26%20-c%20%5C%5C-d%20%26%20%5Clambda%20-%20e%20%26%20-f%20%5C%5C-g%20%26%20-h%20%26%20%5Clambda%20-%20i%20%5Cend%7Barray%7D%20%5Cright%7C"/></p>

## Diagrams

![](../images/14a74c04e7ac28c07c91de04db868473d1dc0daf33c2caa42287902ffe6deed73fcf295164e511abdce713236952cb0b5d149f3cd94fd06ca078d552040db58685100a6ebe4d76ca0.png?0.5753406417911875)

![](../images/14a74c04e7ac28c07c91de04db868473d1dc0daf33c2caa42287902ffe6deed73fcf295164e511abdce713236952cb0b5d149f3cd94fd06ca078d552040db58685100a6ebe4d76ca1.png?0.20133669061082116)

![](../images/14a74c04e7ac28c07c91de04db868473d1dc0daf33c2caa42287902ffe6deed73fcf295164e511abdce713236952cb0b5d149f3cd94fd06ca078d552040db58685100a6ebe4d76ca4.png?0.7705040409323205)

## Code Chunk

![](../images/14a74c04e7ac28c07c91de04db868473d1dc0daf33c2caa42287902ffe6deed73fcf295164e511abdce713236952cb0b5d149f3cd94fd06ca078d552040db58685100a6ebe4d76ca2.png?0.1267141024966374)

![](../images/14a74c04e7ac28c07c91de04db868473d1dc0daf33c2caa42287902ffe6deed73fcf295164e511abdce713236952cb0b5d149f3cd94fd06ca078d552040db58685100a6ebe4d76ca3.png?0.18251954690262662)

## Typographic replacements

Enable typographer option to see result.

(c) (C) (r) (R) (tm) (TM) (p) (P) +-

test.. test... test..... test?..... test!....

!!!!!! ???? ,,

Remarkable -- awesome

"Smartypants, double quotes"

'Smartypants, single quotes'

## Emphasis

**This is bold text**

<!-- prettier-ignore -->
__This is bold text__

<!-- prettier-ignore -->
*This is italic text*

_This is italic text_

~~Deleted text~~

Superscript: 19^th^

Subscript: H~2~O

++Inserted text++

==Marked text==

## Blockquotes

<!-- prettier-ignore-start -->
> Blockquotes can also be nested...
>> ...by using additional greater-than signs right next to each other...
> > > ...or with spaces between arrows.
<!-- prettier-ignore-end -->

## Lists

Unordered

<!-- prettier-ignore-start -->

+ Create a list by starting a line with `+`, `-`, or `*`
+ Sub-lists are made by indenting 2 spaces:
  - Marker character change forces new list start:
    * Ac tristique libero volutpat at
    + Facilisis in pretium nisl aliquet
    - Nulla volutpat aliquam velit
+ Very easy!

<!-- prettier-ignore-end -->

Ordered

1. Lorem ipsum dolor sit amet
2. Consectetur adipiscing elit
3. Integer molestie lorem at massa

<!-- -->

1. You can use sequential numbers...
1. ...or keep all the numbers as `1.`

Start numbering with offset:

57. foo
1. bar

## Code

Inline `code`

Indented code

    // Some comments
    line 1 of code
    line 2 of code
    line 3 of code

Block code "fences"

```
Sample text here...
```

Syntax highlighting

```js
var foo = function(bar) {
  return bar++;
};

console.log(foo(5));
```

## Tables

| Option | Description                                                               |
| ------ | ------------------------------------------------------------------------- |
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default.    |
| ext    | extension to be used for dest files.                                      |

Right aligned columns

| Option |                                                               Description |
| -----: | ------------------------------------------------------------------------: |
|   data | path to data files to supply the data that will be passed into templates. |
| engine |    engine to be used for processing templates. Handlebars is the default. |
|    ext |                                      extension to be used for dest files. |

## Links

[link text](http://dev.nodeca.com)

[link with title](http://nodeca.github.io/pica/demo/ "title text!")

Autoconverted link https://github.com/nodeca/pica (enable linkify to see)

## Images

![Minion](https://octodex.github.com/images/minion.png)
![Stormtroopocat](https://octodex.github.com/images/stormtroopocat.jpg "The Stormtroopocat")

Like links, Images also have a footnote style syntax

![Alt text][id]

With a reference later in the document defining the URL location:

[id]: https://octodex.github.com/images/dojocat.jpg "The Dojocat"

## Footnotes

Footnote 1 link[^first].

Footnote 2 link[^second].

Inline footnote^[Text of inline footnote] definition.

Duplicated footnote reference[^second].

[^first]: Footnote **can have markup**

  and multiple paragraphs.

[^second]: Footnote text.

## Definition lists

Term 1

: Definition 1
with lazy continuation.

Term 2 with _inline markup_

: Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.

_Compact style:_

Term 1
~ Definition 1

Term 2
~ Definition 2a
~ Definition 2b

## Abbreviations

This is HTML abbreviation example.

It converts "HTML", but keep intact partial entries like "xxxHTMLyyy" and so on.

\*[HTML]: Hyper Text Markup Language

---

**Advertisement :)**

- **[pica](https://nodeca.github.io/pica/demo/)** - high quality and fast image
  resize in browser.
- **[babelfish](https://github.com/nodeca/babelfish/)** - developer friendly
  i18n with plurals support and easy syntax.

You'll like those projects! :)
