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
# This heading has 1 id      {#id1}
# This heading has 2 classes {.class1 .class2}
```
> This is a MPE extended feature.

### Emphasis
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
* Item 1
* Item 2
  * Item 2a
  * Item 2b
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
http://github.com - automatic!
[GitHub](http://github.com)
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

***

Asterisks

___

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

    ```javascript {.class1 .class2}
    function add(x, y) {
      return x + y
    }
    ```

##### lineNo
You can enable line number for a code block by adding `lineNo` class.  

For example:    

    ```javascript {.lineNo}
    function add(x, y) {
      return x + y
    }
    ```

![Screen Shot 2017-05-27 at 6.10.10 PM](http://i.imgur.com/5wfq8Uq.png)


### Task lists   
```markdown  
- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item
```

### Tables
You can create tables by assembling a list of words and dividing them with hyphens `-` (for the first row), and then separating each column with a pipe `|`:  
```markdown  
First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column
```

### Footnotes
```markdown
Content [^1]

[^1]: Hi! This is a footnote
```

## References
* [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
* [Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)


[➔ Math](math.md)