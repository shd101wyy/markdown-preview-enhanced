# Save as Markdown
**Markdown Preview Enhanced** supports compilation into **GitHub Flavored Markdown** so that the exported markdown file will include all graphs (as png images), code chunks (hide and only include results), math typesettings (show as image) etc and can be published on GitHub.

## Usage
Right click at the preview, then choose `Save as Markdown (GFM)`.

## Configurations
You can configure the image directory and output path by front-matter
```yaml
---
markdown:
  image_dir: /assets
  path: output.md
  absolute_image_path: true

  front_matter:
    your_front_matter_here: blablabla
---
```

**image_dir** `optional`   
specifies where you want to save generated images. For example, `/assets` means all images will be saved into `assets` directory under project folder. If **image_dir** is not provided, the `Image save folder path` in package settings will be used. Default is `/assets`.

**path** `optional`   
specifies where you want to output your markdown file. If **path** is not specified, `filename_.md` will be used as destination.

**absolute_image_path** `optional`   
determines whether to use absolute or relative image path. Default is `false`.

**front_matter** `optional`   
the front matter that you want to keep after export.

## Known issues
* `WaveDrom` doesn't work yet.
* Math typesettings display might be incorrect.  
* Doesn't work with `latex` code chunk yet.  