---
presentation:
  enableSpeakerNotes: true
---

<!-- slide -->

# Presentation Writer

by **Markdown Preview Enhanced**
powered by [reveal.js](https://github.com/hakimel/reveal.js)
<br>

<p style="font-size: 18px;">press <kbd>?</kbd> key to see keyboard help.</p>
<p style="font-size: 18px;">press <kbd>s</kbd> key to open note window.</p>
<p style="font-size: 18px;">press <kbd>arrow</kbd> key to navigate.</p>
<p style="font-size: 18px;">press <kbd>esc</kbd> to toggle overview.</p>

<!-- slide -->

You can easily create beautiful presentation by running command

`Markdown Preview Enhanced: Insert New Slide`

Or just insert to your markdown file
`<!-- slide -->`

<!-- slide -->

Multiple Presentation themes are supported, you can change it easily from the extension settings.

- vscode
  @import "https://i.loli.net/2017/07/12/5965b5c7783fb.png" {width: 60%}
- atom  
  @import "https://i.imgur.com/lwaogVZ.png" {width: 60%}

<!-- slide -->

All features of **Markdown Preview Enhanced** are supported.

$$
f(x) = \int_{-\infty}^\infty
    \hat f(\xi)\,e^{2 \pi i \xi x}
    \,d\xi
$$

<!-- slide -->

You can set initialization config for your presentation.
Just add front-matter to your presentation markdown file.

```yaml
---
presentation:
  width: 800
  height: 600
  controls: false
---

```

More information about front-matter settings can be found [here](https://shd101wyy.github.io/markdown-preview-enhanced/#/presentation).

<!-- slide data-notes="This is speaker note"-->

**Speaker notes** is also supported (not in preview).
Press the <kbd>s</kbd> key on your keyboard to open the notes window.

<!-- slide -->

To enable speaker notes, set front-matter as:

```yaml
---
presentation:
  enableSpeakerNotes: true
---

```

To add notes, simply set `data-notes` property:

```html
<!-- slide data-notes="Write your note here" -->
```

check [Reveal.js Speaker Notes](https://github.com/hakimel/reveal.js#speaker-notes) section for more information.

<!-- slide -->

By default, all slides are aligned horizontally, but you can also create vertical slides by adding `vertical=true`.
For example:

```html
<!-- slide vertical=true -->
```

<!-- slide vertical=true -->

You just discovered a vertical slide!

<!-- slide -->

You can set `id` and `class` for your slide like this:

```html
<!-- slide id="my-id" class="my-class1 my-class2" -->
```

<!-- slide -->

You can set slide background very easily.
For example:

```html
<!-- slide data-background-color="#ff0000" -->
```

<!-- slide data-background-color="#ffebcf"-->

Of course you can do more about slide **background**.

- `data-background-image`
  URL of the image to show. GIFs restart when the slide opens.
- `data-background-size`
  See [background-size](https://developer.mozilla.org/docs/Web/CSS/background-size) on MDN.
- `data-background-position`
  See [background-position](https://developer.mozilla.org/docs/Web/CSS/background-position) on MDN.
- `data-background-repeat`
  See [background-repeat](https://developer.mozilla.org/docs/Web/CSS/background-repeat) on MDN.

<!-- slide -->

You can also set **video background** and **iframe background**.

- `data-background-video`
  A single video source, or a comma separated list of video sources.
- `data-background-video-loop`
  Flags if the video should play repeatedly.
- `data-background-video-muted`
  Flags if the audio should be muted.
- `data-background-iframe`
  Embeds a web page as a background.

<!-- slide -->

Fragment is supported.

```
- Item 1 <!-- .element: class="fragment" data-fragment-index="2" -->
- Item 2 <!-- .element: class="fragment" data-fragment-index="1" -->
```

- See [this doc](https://github.com/hakimel/reveal.js#fragments) for different fragment animations <!-- .element: class="fragment" -->
- Item 1 <!-- .element: class="fragment" data-fragment-index="2" -->
- Item 2 <!-- .element: class="fragment" data-fragment-index="1" -->

<!-- slide -->

For example, the markdown snippet below will generate slide like...

```html
<!-- slide data-background-image="https://i.loli.net/2017/07/12/5965b7edd3a2a.jpeg" data-transition="zoom" -->
<p style="color: #fff;">国漫大法好！</p>
<p style="color: #fff;">国漫大法好！</p>
<p style="color: #fff;">国漫大法好！</p>
```

<!-- slide data-background-image="https://i.loli.net/2017/07/12/5965b7edd3a2a.jpeg"
data-transition="zoom"
-->
<p style="color: #fff;">国漫大法好！</p>
<p style="color: #fff;">国漫大法好！</p>
<p style="color: #fff;">国漫大法好！</p>

<!-- slide -->

It is also very easy to customize presentation css.
Run command:
`Markdown Preview Enhanced: Customize Css`
then edit:

```less
.markdown-preview.markdown-preview {
  .slides {
    // This will modify all slides.
  }
  .slides > section:nth-child(1) {
    // This will modify `the first slide`.
    background-color: blue;
  }
}
```

<!-- slide -->

You can check your presentation in browser by
right clicking at the preview, then choose

`Open in Browser`

<!-- slide -->

**Markdown Preview Enhanced** can also generate beautiful **HTML** or **PDF** files for your presentation.

<!-- slide -->

#### Star this project if you like it ;)

- Github Repository can be found [here](https://github.com/shd101wyy/markdown-preview-enhanced)
- Feel free to post issues and request new features [here](https://github.com/shd101wyy/markdown-preview-enhanced/issues)
- Source code of this presentation can be found [here](https://github.com/shd101wyy/markdown-preview-enhanced/blob/master/docs/presentation-intro.md), [raw](https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.md)

<!-- slide data-background-image="https://ooo.0o0.ooo/2016/07/18/578c66da6a5a3.jpg" -->
