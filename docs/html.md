# HTML Export

## Usage

Right click at the preview, click `HTML` tab.  
Then choose:

- `HTML (offline)`
  Choose this option if you are only going to use this html file locally.
- `HTML (cdn hosted)`
  Choose this option if you want to deploy your html file remotely.

![screen shot 2017-07-14 at 1 14 28 am](https://user-images.githubusercontent.com/1908863/28200455-d5a12d60-6831-11e7-8572-91d3845ce8cf.png)

## Configuration

Default values:

```yaml
---
html:
  embed_local_images: false
  embed_svg: true
  offline: false
  toc: undefined

print_background: false
---

```

If `embed_local_images` is set to `true`, then all local images will be embedded as `base64` format.

To generate sidebar TOC you need to set [enableScriptExecution](https://shd101wyy.github.io/markdown-preview-enhanced/#/code-chunk?id=code-chunk) in MPE settings of vscode or atom.

If `toc` is set to `false`, then the sidebar TOC will be disabled. If `toc` is set to `true`, then the sidebar TOC will be enabled and displayed. If `toc` is not specified, then the sidebar TOC will be enabled, but not displayed.

## Export on save

Add the front-matter like below:

```yaml
---
export_on_save:
  html: true
---

```

So the html file will be generated every time you save your markdown file.
