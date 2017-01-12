# Save as Markdown
After version `0.9.0`, **Markdown-Preview-Enhanced** supports compilation into markdown so that the exported markdown file will include all graphs (as png images), code chunks (hide and only include results), math typesettings (show as image) etc and can be published on GitHub.

## Usage
Right click at the preview, then choose `Save as Markdown`.

## Configurations
You can configure the image directory and output path by front-matter
```yaml
---
markdown:
  image_dir: /images
  path: output.md
  absolute_image_path: true
---
```

**image_dir** specifies where you want to save generated images. For example, `/images` means all images will be saved into `images` directory under project folder. If **image_dir** is not provided, the `Image save folder path` in package settings will be used.  

**path** specifies where you want to output your markdown file. If **path** is not specified, `filename_.md` will be used as destination.

**absolute_image_path** determines whether to use absolute or relative image path. Default is `true`

## Limits
* `WaveDrom` doesn't work yet.
* Math typesettings display might be incorrect.  