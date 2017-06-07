syntaxThemes = atom.packages.getAvailablePackageMetadata() or []
syntaxThemes = syntaxThemes.filter (s)-> s.theme == 'syntax'
syntaxThemes = syntaxThemes.map (s)-> s.name
if !syntaxThemes.length
  syntaxThemes = ['atom-dark-syntax', 'atom-light-syntax', 'one-dark-syntax', 'one-light-syntax', 'solarized-dark-syntax', 'solarized-light-syntax', 'base16-tomorrow-dark-theme', 'base16-tomorrow-light-theme']

syntaxThemes.push('mpe-github-syntax')

module.exports =
    fileExtension:
      type: "string"
      default: ".md, .mmark, .markdown"
      description: "You may need restart Atom after making changes here."
      order: 0
    previewTheme:
      title: "Preview Theme"
      type: "string"
      default: 'mpe-github-syntax'
      enum: syntaxThemes
      order: 1
    whiteBackground:
      title: "White Background"
      type: "boolean"
      default: false
      description: "Use white background color for preview."
      order: 2
    singlePreview:
      title: "Open Only One Preview"
      type: "boolean"
      default: true,
      order: 3
    openPreviewPaneAutomatically:
      title: "Open preview pane automatically when opening a markdown file"
      type: "boolean"
      default: true
      order: 4
    automaticallyShowPreviewOfMarkdownBeingEdited:
      title: "Automatically show preview of markdown being edited"
      type: "boolean"
      default: true,
      order: 5
    closePreviewAutomatically:
      title: "Automatically close preview when closing a markdown file"
      description: "This option only works if `Open Only One Preview` is unchecked."
      type: "boolean"
      default: true
      order: 6
    breakOnSingleNewline:
      type: "boolean"
      default: true
      description: "In Markdown, a single newline character doesn't cause a line break in the generated HTML. In GitHub Flavored Markdown, that is not true. Enable this config option to insert line breaks in rendered HTML for single newlines in Markdown source."
      order: 10
    enableTypographer:
      type: "boolean"
      default: false
      description: "Enable smartypants and other sweet transforms."
      order: 11
    enableZenMode:
      title: "Zen Mode"
      type: "boolean"
      default: false
      description: "Distraction free writing."
      order: 13
    protocolsWhiteList:
      title: "Protocols Whitelist"
      type: "string"
      default: "http, https, atom, file"
      description: "Accepted protocols followed by `://` for links. `(Restart is required to take effect)`"
      order: 15
    usePandocParser:
      title: "Use Pandoc Parser"
      type: "boolean"
      default: false,
      description: "Enable this option will render markdown by pandoc instead of remarkable. Live update will be disabled automatically if this option is enabled."
      order: 16
    pandocPath:
      title: "Pandoc Options: Path"
      type: "string"
      default: "pandoc"
      description: "Please specify the correct path to your pandoc executable"
      order: 17
    pandocArguments:
      title: "Pandoc Options: Commandline Arguments"
      type: "string",
      default: "",
      description: "Comma separated pandoc arguments e.g. `--smart, --filter=/bin/exe`. Please use long argument names."
      order: 18
    pandocMarkdownFlavor:
      type: 'string'
      default: 'markdown-raw_tex+tex_math_single_backslash' # 'markdown-raw_tex+tex_math_dollars'
      title: 'Pandoc Options: Markdown Flavor'
      description: 'Enter the pandoc markdown flavor you want'
      order: 19
    mathRenderingOption:
      type: "string"
      default: "KaTeX"
      description: "Choose the Math expression rendering method here. You can also disable math rendering if you want by choosing 'None'."
      enum: [
        "KaTeX",
        "MathJax",
        "None"
      ]
      order: 20
    indicatorForMathRenderingInline:
      title: "Inline Indicator"
      type: "string"
      default: "[[\"$\", \"$\"], [\"\\\\(\", \"\\\\)\"]]"
      description: "Use customized Math expression inline indicator. By default it is '[[\"$\", \"$\"]]', which means content within '**$**' and '**$**' will be rendered in inline mode. You can also define multiple indicators separated by comma. For example, '[[\"$\", \"$\"], [\"\\\\\\\\(\", \"\\\\\\\\)\"]]' will render inline math expression within '**$**' and '**$**', '**\\\\(**' and '**\\\\)**'. `(Restart is required to take effect)`"
      order: 21
    indicatorForMathRenderingBlock:
      title: "Block Indicator"
      type: "string"
      default: "[[\"$$\", \"$$\"], [\"\\\\[\", \"\\\\]\"]]"
      description: "Use customized Math expression block indicator. By default it is [[\"$$\", \"$$\"]]. `(Restart is required to take effect)`"
      order: 22
    latexEngine:
      title: "LaTeX Engine"
      type: "string"
      default: "pdflatex" # TODO: different default latex engine for different OS
      description: "The LaTeX engine you want to you to run latex code chunk."
      order: 25
    enableWikiLinkSyntax:
      title: "Enable Wiki Link syntax"
      type: "boolean"
      default: true
      description: "Enable Wiki Link syntax support. More information can be found at https://help.github.com/articles/adding-links-to-wikis/"
      order: 30
    wikiLinkFileExtension:
      title: "Wiki Link file extension"
      type: "string"
      default: ".md"
      description: "By default, [[test]] will direct to file path `test.md`."
      order: 31
    liveUpdate:
      type: "boolean"
      default: true
      description: "Re-render the preview as the contents of the source changes, without requiring the source buffer to be saved. If disabled, the preview is re-rendered only when the buffer is saved to disk. Disable live update will also disable scroll sync."
      order: 60
    frontMatterRenderingOption:
      title: "Front Matter rendering option"
      type: "string"
      description: "You can choose how to render front matter here. 'none' option will hide front matter."
      default: "table"
      enum: [
        "table",
        "code block",
        "none"
      ],
      order: 70
    scrollSync:
      type: "boolean"
      default: true
      description: "2 way scroll sync. Sync both markdown source and markdown preview when scrolling."
      order: 75
    scrollDuration:
      type: "string"
      default: "120"
      description: "Scroll duration is defined in milliseconds. Lower value indicates faster scrolling speed. Default is 120ms"
      order: 76
    documentExportPath:
      title: "Document Export Folder Path"
      description: "When exporting document to disk, by default the document will be generated at the root path './'"
      type: "string"
      default: "./"
      order: 77
    exportPDFPageFormat:
      title: "Pdf Page Format"
      type: "string"
      default: "Letter"
      enum: [
        "A3",
        "A4",
        "A5",
        "Legal",
        "Letter",
        "Tabloid"
      ]
      order: 80
    orientation:
      title: "Pdf Page Orientation"
      type: "string"
      default: "portrait"
      enum: [
        "portrait",
        "landscape"
      ]
      order: 90
    marginsType:
      title: "Pdf Margin type"
      type: "string"
      default: "default margin"
      enum: [
        "default margin",
        "no margin",
        "minimum margin"
      ]
      order: 100
    printBackground:
      title: "Print Background when generating pdf"
      type: "boolean"
      default: true
      description: "Include background color when generating pdf."
      order: 110
    pdfUseGithub:
      title: "Use Github style when generating pdf"
      type: "boolean"
      default: true
      description: "If you enabled this option, then the pdf will be generated using Github Style. I add this option because if the markdown preview has black color background, then the generated pdf may also have black color background (if you enabled Print Background), which may affect the appearance of the generated pdf."
      order: 120
    pdfOpenAutomatically:
      title: "Open pdf file immediately after it is generated"
      type: "boolean"
      default: true
      description: "If you enabled this option, then when pdf is generated, it will be opened by pdf viewer. For example, on Mac OS X, it will be opened by Preview."
      order: 130
    phantomJSExportFileType:
      title: "PhantomJS export file type"
      type: "string"
      default: "pdf"
      enum: [
        "pdf",
        "png",
        "jpeg"
      ],
      order: 131
    phantomJSMargin:
      title: "PhantomJS margins"
      description: "Default is 0, units: mm, cm, in, px. You can also define 'top, right, bottom, left' margins in order like '1cm, 1cm, 1cm, 1cm' separated by comma ','."
      type: "string"
      default: "1cm"
      order: 132
    imageFolderPath:
      title: "Image save folder path"
      description: "When using Image Helper to copy images, by default images will be copied to root image folder path '/assets'"
      type: "string"
      default: "/assets"
      order: 150
    imageUploader:
      title: "Image Uploader"
      description: "you can choose different image uploader to upload image."
      type: "string"
      default: "imgur"
      enum: [
        "imgur",
        "sm.ms"
      ]
      order: 160
    mermaidTheme:
      title: "Mermaid Theme"
      type: "string"
      default: "mermaid.css"
      enum: [
        "mermaid.css",
        "mermaid.dark.css",
        "mermaid.forest.css"
      ]
      order: 170
