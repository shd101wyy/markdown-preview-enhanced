import {MarkdownEngineConfig} from "@shd101wyy/mume"

export class MarkdownPreviewEnhancedConfig implements MarkdownEngineConfig {
  public static getCurrentConfig() {
    return new MarkdownPreviewEnhancedConfig()
  }

  /*
   * MarkdownEngineConfig properties
   */
  public readonly usePandocParser: boolean;
  public readonly breakOnSingleNewLine: boolean;
  public readonly enableTypographer: boolean;
  public readonly enableWikiLinkSyntax: boolean;
  public readonly wikiLinkFileExtension: string;
  public readonly protocolsWhiteList: string;
  public readonly mathRenderingOption: string;
  public readonly mathInlineDelimiters: string[][];
  public readonly mathBlockDelimiters: string[][];
  public readonly codeBlockTheme: string;
  public readonly previewTheme: string;
  public readonly revealjsTheme: string;
  public readonly mermaidTheme: string;
  public readonly frontMatterRenderingOption: string;
  public readonly imageFolderPath: string;
  public readonly printBackground: boolean;
  public readonly phantomPath: string;
  public readonly pandocPath: string;
  public readonly pandocMarkdownFlavor: string;
  public readonly pandocArguments: string[];

  /*
   * Extra config for mpe
   */

  public readonly fileExtension: string[]
  public readonly singlePreview: boolean
  public readonly scrollSync: boolean
  public readonly scrollDuration: number
  public readonly liveUpdate: boolean
  public readonly openPreviewPaneAutomatically: boolean
  public readonly automaticallyShowPreviewOfMarkdownBeingEdited: boolean
  public readonly closePreviewAutomatically: boolean
  public readonly enableZenMode: boolean
  public readonly imageUploader: string

  public constructor() {
    /*
     * MarkdownEngineConfig properties
     */
    this.usePandocParser = atom.config.get('markdown-preview-enhanced.usePandocParser')
    this.breakOnSingleNewLine = atom.config.get('markdown-preview-enhanced.breakOnSingleNewLine')
    this.enableTypographer = atom.config.get('markdown-preview-enhanced.enableTypographer')
    this.enableWikiLinkSyntax = atom.config.get('markdown-preview-enhanced.enableWikiLinkSyntax')
    this.wikiLinkFileExtension = atom.config.get('markdown-preview-enhanced.wikiLinkFileExtension')
    this.protocolsWhiteList = atom.config.get('markdown-preview-enhanced.protocolsWhiteList')
    this.mathRenderingOption = atom.config.get('markdown-preview-enhanced.mathRenderingOption')
    
    try {
      this.mathInlineDelimiters = JSON.parse(atom.config.get('markdown-preview-enhanced.mathInlineDelimiters'))
    } catch(error) {
      this.mathInlineDelimiters = [["$", "$"], ["\\(", "\\)"]]
    }
    try {
      this.mathBlockDelimiters = JSON.parse(atom.config.get('markdown-preview-enhanced.mathBlockDelimiters'))
    } catch(error) {
      this.mathBlockDelimiters = [["$$", "$$"], ["\\[", "\\]"]]
    }
    
    this.codeBlockTheme = atom.config.get('markdown-preview-enhanced.codeBlockTheme')
    this.previewTheme = atom.config.get('markdown-preview-enhanced.previewTheme')
    this.revealjsTheme = atom.config.get('markdown-preview-enhanced.revealjsTheme')
    this.mermaidTheme = atom.config.get('markdown-preview-enhanced.mermaidTheme')
    this.frontMatterRenderingOption = atom.config.get('markdown-preview-enhanced.frontMatterRenderingOption')
    this.imageFolderPath = atom.config.get('markdown-preview-enhanced.imageFolderPath')
    this.printBackground = atom.config.get('markdown-preview-enhanced.printBackground')
    this.phantomPath = atom.config.get('markdown-preview-enhanced.phantomPath')
    this.pandocPath = atom.config.get('markdown-preview-enhanced.pandocPath')
    this.pandocMarkdownFlavor = atom.config.get('markdown-preview-enhanced.pandocMarkdownFlavor')
    this.pandocArguments = atom.config.get('markdown-preview-enhanced.pandocArguments').split(',').map((x)=> x.trim()).filter((x)=>x.length) || []

    /*
     * Extra configs for mpe
     */
    this.fileExtension = atom.config.get('markdown-preview-enhanced.fileExtension').split(',').map((x)=>x.trim()).filter((x)=>x.length) || ['.md', '.mmark', '.markdown']
    this.singlePreview = atom.config.get('markdown-preview-enhanced.singlePreview')
    this.scrollSync = atom.config.get('markdown-preview-enhanced.scrollSync')
    this.scrollDuration = parseFloat(atom.config.get('markdown-preview-enhanced.scrollDuration')) || 120
    this.liveUpdate = atom.config.get('markdown-preview-enhanced.liveUpdate')
    this.openPreviewPaneAutomatically = atom.config.get('markdown-preview-enhanced.openPreviewPaneAutomatically')
    this.automaticallyShowPreviewOfMarkdownBeingEdited = atom.config.get('markdown-preview-enhanced.automaticallyShowPreviewOfMarkdownBeingEdited')
    this.closePreviewAutomatically = atom.config.get('markdown-preview-enhanced.closePreviewAutomatically')
    this.enableZenMode = atom.config.get('markdown-preview-enhanced.enableZenMode')
    this.imageUploader = atom.config.get('markdown-preview-enhanced.imageUploader')
  }

  public isEqualTo(otherConfig: MarkdownPreviewEnhancedConfig) {
    const json1 = JSON.stringify(this)
    const json2 = JSON.stringify(otherConfig)
    return json1 === json2
  }

  [key: string]: any
}
