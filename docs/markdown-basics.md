# Markdown Basics

This article is a brief introduction to [GitHub Flavored Markdown writing](https://guides.github.com/features/mastering-markdown/).

## What is Markdown?

`Markdown` is a way to style text on the web. You control the display of the document; formatting words as bold or italic, adding images, and creating lists are just a few of the things we can do with Markdown. Mostly, Markdown is just regular text with a few non-alphabetic characters thrown in, like `#` or `*`.

## Syntax guide

### Headers

```markdown
# This is an <h1> tag

## This is an <h2> tag

### This is an <h3> tag

#### This is an <h4> tag

##### This is an <h5> tag

###### This is an <h6> tag
```

If you want to add `id` and `class` to the header, then simply append `{#id .class1 .class2}`. For example:

```markdown
# This heading has 1 id {#my_id}

# This heading has 2 classes {.class1 .class2}
```

> This is a MPE extended feature.

### Emphasis

<!-- prettier-ignore -->
```markdown
*This text will be italic*
_This will also be italic_

**This text will be bold**
__This will also be bold__

_You **can** combine them_

~~This text will be strikethrough~~
```

### Lists

#### Unordered List

```markdown
- Item 1
- Item 2
  - Item 2a
  - Item 2b
```

#### Ordered List

```markdown
1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b
```

### Images

```markdown
![GitHub Logo](/images/logo.png)
Format: ![Alt Text](url)
```

### Links

```markdown
https://github.com - automatic!
[GitHub](https://github.com)
```

### Blockquote

```markdown
As Kanye West said:

> We're living the future so
> the present is our past.
```

### Horizontal Rule

```markdown
Three or more...

---

Hyphens

---

Asterisks

---

Underscores
```

### Inline code

```markdown
I think you should use an
`<addr>` element here instead.
```

### Fenced code block

You can create fenced code blocks by placing triple backticks <code>\`\`\`</code> before and after the code block.

#### Syntax Highlighting

You can add an optional language identifier to enable syntax highlighting in your fenced code block.

For example, to syntax highlight Ruby code:

    ```ruby
    require 'redcarpet'
    markdown = Redcarpet.new("Hello World!")
    puts markdown.to_html
    ```

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

#### Code block class (MPE extended feature)

You can set `class` for your code blocks.

For example, to add `class1 class2` to a code block

    ```javascript {.class1 .class}
    function add(x, y) {
      return x + y
    }
    ```

##### line-numbers

You can enable line number for a code block by adding `line-numbers` class.

For example:

````markdown
```javascript {.line-numbers}
function add(x, y) {
  return x + y;
}
```
````

![screen shot 2017-07-14 at 1 20 27 am](https://user-images.githubusercontent.com/1908863/28200587-a8582b0a-6832-11e7-83a7-6c3bb011322f.png)

##### highlighting rows

You can highlight rows by add `highlight` attribute:

````markdown
```javascript {highlight=10}
```

```javascript {highlight=10-20}
```

```javascript {highlight=[1-10,15,20-22]}
```
````

### Task lists

```markdown
- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item
```

### Tables

You can create tables by assembling a list of words and dividing them with hyphens `-` (for the first row), and then separating each column with a pipe `|`:

<!-- prettier-ignore -->
```markdown
First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column
```

## Extended syntax

### Table

> Need to enable `enableExtendedTableSyntax` in extension settings to get it work.

![screen shot 2017-07-15 at 8 16 45 pm](https://user-images.githubusercontent.com/1908863/28243710-945e3004-699a-11e7-9a5f-d74f6c944c3b.png)

### Emoji & Font-Awesome

> This only works for `markdown-it parser` but not `pandoc parser`.  
> Enabled by default. You can disable it from the package settings.

```
:smile:
:fa-car:
```

### Superscript

```markdown
30^th^
```

### Subscript

```markdown
H~2~O
```

### Footnotes

```markdown
Content [^1]

[^1]: Hi! This is a footnote
```

### Abbreviation

```markdown
*[HTML]: Hyper Text Markup Language
*[W3C]: World Wide Web Consortium
The HTML specification
is maintained by the W3C.
```

### Mark

```markdown
==marked==
```

### CriticMarkup

CriticMarkup is **disabled** by default, but you can enable it from the package settings.  
For more information about CriticMarkup, check [CriticMarkup User's Guide](https://criticmarkup.com/users-guide.php).

There are five types of Critic marks:

- Addition `{++ ++}`
- Deletion `{-- --}`
- Substitution `{~~ ~> ~~}`
- Comment `{>> <<}`
- Highlight `{== ==}{>> <<}`

> CriticMarkup only works with the markdown-it parser, but not the pandoc parser.

### Admonition

```
!!! note This is the admonition title
    This is the admonition body
```

> Please see more information at https://squidfunk.github.io/mkdocs-material/reference/admonitions/

## References

- [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
- [Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)

[➔ Math](math.md)
