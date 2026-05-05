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

> [!NOTE]
> This is a note blockquote.

> [!WARNING]
> This is a warning blockquote.
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

```
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

### Wikilinks

> Available since vscode-mpe 0.8.25 / crossnote 0.9.23. Obsidian-style note linking.

```markdown
[[Note]]                       <!-- link to Note (resolves to Note.md by default) -->
[[Note|Display text]]          <!-- link with custom display text -->
[[Note#Heading]]               <!-- link to a specific heading inside Note -->
[[Note^block-id]]              <!-- link to a specific ^block-id inside Note -->
[[Note#Heading^block-id]]      <!-- combined heading + block reference -->
[[#Heading]]                   <!-- link to a heading in the current note -->
[[^block-id]]                  <!-- link to a block in the current note -->
```

In the preview, click any wikilink to navigate. In the editor, alt+click (Ctrl+click on macOS) to follow. Hover over a wikilink for a preview of the target's content (full-file head, the heading section, or the block body — whatever the link points at).

If you click `[[NewNote]]` and `NewNote.md` doesn't exist yet, the file is created with a `# NewNote` stub and opened — same behaviour as Obsidian's "click to create" flow.

Configuration keys (notebook config):

- `wikiLinkTargetFileExtension` (default `.md`) — the extension appended when the link has none. Set to `.markdown` / `.mdx` / `.qmd` for non-`.md` notebooks.
- `useGitHubStylePipedLink` (default `false`) — when `true`, the order is `[[display|link]]` (GitHub-style); when `false`, `[[link|display]]` (Obsidian / Wikipedia-style).

### Note embedding (`![[…]]`)

The `!` prefix embeds the target's content inline:

```markdown
![[Note]]                      <!-- embed the entire note -->
![[Note#Heading]]              <!-- embed only that heading section -->
![[Note^block-id]]             <!-- embed only that block -->
![[Note|Title to show]]        <!-- embed with a custom heading -->
![[image.png]]                 <!-- standard image embed (any image extension) -->
```

Recursion is capped at 3 levels — an embed cycle won't blow up the preview.

### Block references (`^block-id`)

Append `^block-id` at the end of a paragraph or list item to mark it as a referenceable block:

```markdown
This paragraph can be referenced. ^my-block

- A list item too. ^another-block
```

Reference it from anywhere in the workspace:

```markdown
See [[Note^my-block]] or embed it: ![[Note^my-block]]
```

The command `Markdown Preview Enhanced: Copy Block Reference` (Command Palette) generates a `^id` for the paragraph at the cursor (or reuses the existing one) and copies a ready-to-paste `[[Note#^id]]` link to your clipboard.

### Tags

Body-text `#tag-name` syntax:

```markdown
This thought is tagged #important and #project/q1.
```

- **Nested tags** via `/`: `#parent/child`, and deeper (`#a/b/c`).
- Tags don't fire when a line starts with only `#`s (so `# Heading`, `## Heading` etc. still work).
- Click a tag in the preview to open a Quick Pick listing every note that mentions it.
- The setting `enableTagSyntax` (default `true`) toggles the feature.

## References

- [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
- [Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)

[➔ Math](math.md)
