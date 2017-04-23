---
presentation:
  width: 960
  height: 700
  help: true
  enableSpeakerNotes: true
---

<!-- slide data-notes:"Congrats! You just opened speaker notes" -->
# Presentation Writer (Beta)
by **Markdown Preview Enhanced**  
powered by [reveal.js](https://github.com/hakimel/reveal.js)  
<br>
<p style="font-size: 18px;">press <kbd>?</kbd> key to see keyboard help.</p>  
<p style="font-size: 18px;">press <kbd>s</kbd> key to open note window.</p>

<!-- slide -->
You can easily create beautiful presentation by running command   
<center> `Markdown Preview Enhanced: Insert New Slide` </center>  
<aside class="notes">
    Pretty cool haha ;)
</aside>

<!-- slide -->
Just like this  

![presentation](http://ooo.0o0.ooo/2016/07/17/578c61408dd73.gif)

<!-- slide -->
The style of the presentation is consistent with the style of your beloved **Atom**.  
```javascript
const さかもと = 'cool cooler coolest'
```

<!-- slide -->  
You can change your presentation theme very easily:   

![presentation-theme](https://cloud.githubusercontent.com/assets/1908863/23577767/951531b2-008d-11e7-95d0-08cd53d277a6.gif)


<!-- slide -->
All features of **Markdown Preview Enhanced** are supported.   
Such as Math typesetting, mermaid graph, code chunk etc...  
<br>
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
More information about front-matter settings can be found [here](https://github.com/shd101wyy/markdown-preview-enhanced/blob/master/docs/presentation-front-matter.md).

<!-- slide data-notes:"This is speaker note"-->  
**Speaker notes** is also supported.  
Press the <kbd>s</kbd> key on your keyboard to open the notes window.  

To enable speaker notes, set front-matter as:  
```yaml  
---
presentation:
  enableSpeakerNotes: true
---
```  
To add notes, simply set `data-notes` property:
```html
<!-- slide data-notes:"Write your note here" -->
```
check [Reveal.js Speaker Notes](https://github.com/hakimel/reveal.js#speaker-notes) section for more information.


<!-- slide -->
By default, all slides are aligned horizontally, but you can also create vertical slides by adding `vertical:true`.  
For example:  
```html
<!-- slide vertical:true -->
```  

<!-- slide vertical:true -->
You just discovered a vertical slide!

<!-- slide -->
You can set `id` and `class` for your slide like this:  
```html
<!-- slide id:"my-id" class:"my-class1 my-class2" -->
```

<!-- slide -->
You can set slide background very easily.   
For example:
```html
<!-- slide data-background-color:"#ff0000" -->
```

<!-- slide data-background-color:"#ffebcf"-->
Of course you can do more about slide background.  
**Image Background**
| Atribute | Default | Description |  
|---|---|---|  
| data-background-image	 |  | URL of the image to show. GIFs restart when the slide opens.|  
| data-background-size	| cover | See [background-size](https://developer.mozilla.org/docs/Web/CSS/background-size) on MDN.|  
| data-background-position| center |See [background-position](https://developer.mozilla.org/docs/Web/CSS/background-position) on MDN.|  
|data-background-repeat	|no-repeat	|See [background-repeat](https://developer.mozilla.org/docs/Web/CSS/background-repeat) on MDN.|    

<!-- slide -->
You can also set **video background** and **iframe background**.  
*Please note that video background doesn't work in preview*
| Attribute  | Default  | Description |
|---|---|---|
| data-background-video	  |   | A single video source, or a comma separated list of video sources. |
|data-background-video-loop|false|Flags if the video should play repeatedly.|
|data-background-video-muted|false|Flags if the audio should be muted.|
|data-background-iframe||Embeds a web page as a background. |

<!-- slide -->
For example, the markdown snippet below will generate slide like...  
```html
<!-- slide data-background-image:"http://ooo.0o0.ooo/2016/10/27/581167987ec08.jpg" data-transition:"zoom" -->
<p style="color: #fff;">国漫大法好！</p>
<p style="color: #fff;">国漫大法好！</p>
<p style="color: #fff;">国漫大法好！</p>
```

<!-- slide data-background-image:"http://ooo.0o0.ooo/2016/10/27/581167987ec08.jpg"
data-transition:"zoom"
-->
<p style="color: #fff;">国漫大法好！</p>
<p style="color: #fff;">国漫大法好！</p>
<p style="color: #fff;">国漫大法好！</p>

<!-- slide -->
It is also very easy to customize presentation css.  
Run `Markdown Preview Enhanced: Customize Css` command,   
then edit section:
```less
.preview-slides .slide,
&[data-presentation-mode] {
  // eg
  // background-color: #000;
}
```

<!-- slide -->
You can check your presentation in browser by   
right clicking at the preview, then choose `Open in Browser` option.  

<!-- slide -->
**Markdown Preview Enhanced** can also generate beautiful **HTML** or **PDF** files for your presentation.

<!-- slide -->  
#### Star this project if you like it ;)    
* Github Repository can be found [here](https://github.com/shd101wyy/markdown-preview-enhanced)
* Feel free to post issues and request new features [here](https://github.com/shd101wyy/markdown-preview-enhanced/issues)
* Source code of this presentation can be found [here](https://github.com/shd101wyy/markdown-preview-enhanced/blob/master/docs/presentation-intro.md), [raw](https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.md)  

<!-- slide data-background-image:"http://ooo.0o0.ooo/2016/07/18/578c66da6a5a3.jpg" -->
