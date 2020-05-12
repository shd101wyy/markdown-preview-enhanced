# Save as Markdown

**Markdown Preview Enhanced** supports compilation into **GitHub Flavored Markdown** so that the exported markdown file will include all graphs (as png images), code chunks (hide and only include results), math typesettings (show as image) etc and can be published on GitHub.

## Usage

Right click at the preview, then choose `Save as Markdown`.

## Configurations

You can configure the image directory and output path by front-matter

```yaml
---
markdown:
  image_dir: /assets
  path: output.md
  ignore_from_front_matter: true
  absolute_image_path: false
---

```

**image_dir** `optional`  
Specifies where you want to save generated images. For example, `/assets` means all images will be saved into `assets` directory under project folder. If **image_dir** is not provided, the `Image folder path` in package settings will be used. Default is `/assets`.

**path** `optional`  
Specifies where you want to output your markdown file. If **path** is not specified, `filename_.md` will be used as destination.

**ignore_from_front_matter** `optional`  
If set to `false`, then the `markdown` field will be included in the front-matter.

**absolute_image_path** `optional`  
Determines whether to use absolute or relative image path.

## Export on save

Add the front-matter like below:

```yaml
---
export_on_save:
  markdown: true
---

```

So the markdown file will be generated every time you save your markdown source file.

## Known issues

- `WaveDrom` doesn't work yet.
- Math typesettings display might be incorrect.
- Doesn't work with `latex` code chunk yet.
