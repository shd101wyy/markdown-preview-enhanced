import { MarkdownEngineConfig } from "@shd101wyy/mume";
import { MathRenderingOption } from "@shd101wyy/mume/out/src/markdown-engine-config";
import { CompositeDisposable } from "atom";

const copyValue = (v) => v;
const parseJsonOrDefault = (def: any) => (raw: any) => {
  try {
    return JSON.parse(raw);
  } catch (error) {
    return def;
  }
};

const parseListOrDefault = (def: any) => (raw: any) => {
  return (
    raw
      .split(",")
      .map((x) => x.trim())
      .filter((x) => x.length) || def
  );
};

const ConfigSettings: { [key: string]: (val: any) => any } = {
  configPath: copyValue,
  usePandocParser: copyValue,
  breakOnSingleNewLine: copyValue,
  enableTypographer: copyValue,
  enableLinkify: copyValue,
  enableWikiLinkSyntax: copyValue,
  enableEmojiSyntax: copyValue,
  enableExtendedTableSyntax: copyValue,
  enableCriticMarkupSyntax: copyValue,
  useGitHubStylePipedLink: copyValue,
  wikiLinkFileExtension: copyValue,
  protocolsWhiteList: copyValue,
  mathRenderingOption: copyValue,
  mathRenderingOnlineService: copyValue,
  codeBlockTheme: copyValue,
  previewTheme: copyValue,
  revealjsTheme: copyValue,
  mermaidTheme: copyValue,
  frontMatterRenderingOption: copyValue,
  imageFolderPath: copyValue,
  printBackground: copyValue,
  chromePath: copyValue,
  imageMagickPath: copyValue,
  pandocPath: copyValue,
  pandocMarkdownFlavor: copyValue,
  enableHTML5Embed: copyValue,
  HTML5EmbedUseImageSyntax: copyValue,
  HTML5EmbedUseLinkSyntax: copyValue,
  HTML5EmbedIsAllowedHttp: copyValue,
  HTML5EmbedAudioAttributes: copyValue,
  HTML5EmbedVideoAttributes: copyValue,
  puppeteerWaitForTimeout: (v) => {
    return parseInt(v, 10) || 0;
  },
  usePuppeteerCore: copyValue,

  scrollSync: copyValue,
  liveUpdate: copyValue,
  previewPanePosition: copyValue,
  openPreviewPaneAutomatically: copyValue,
  automaticallyShowPreviewOfMarkdownBeingEdited: copyValue,
  closePreviewAutomatically: copyValue,
  imageUploader: copyValue,
  latexEngine: copyValue,
  enableScriptExecution: copyValue,
  singlePreview: copyValue,
  mathInlineDelimiters: parseJsonOrDefault([
    ["$", "$"],
    ["\\(", "\\)"],
  ]),
  mathBlockDelimiters: parseJsonOrDefault([
    ["$$", "$$"],
    ["\\[", "\\]"],
  ]),
  pandocArguments: parseListOrDefault([]),
  fileExtension: parseListOrDefault([".md", ".mmark", ".markdown"]),
  puppeteerArgs: parseListOrDefault([]),
  plantumlServer: copyValue,
};

export class MarkdownPreviewEnhancedConfig implements MarkdownEngineConfig {
  public static getCurrentConfig() {
    return new MarkdownPreviewEnhancedConfig();
  }

  /*
   * MarkdownEngineConfig properties
   */
  public configPath: string;
  public usePandocParser: boolean;
  public breakOnSingleNewLine: boolean;
  public enableTypographer: boolean;
  public enableLinkify: boolean;
  public enableWikiLinkSyntax: boolean;
  public useGitHubStylePipedLink: boolean;
  public wikiLinkFileExtension: string;
  public enableEmojiSyntax: boolean;
  public enableExtendedTableSyntax: boolean;
  public enableCriticMarkupSyntax: boolean;
  public protocolsWhiteList: string;
  public mathRenderingOption: MathRenderingOption;
  public mathInlineDelimiters: string[][];
  public mathBlockDelimiters: string[][];
  public mathRenderingOnlineService: string;
  public codeBlockTheme: string;
  public previewTheme: string;
  public revealjsTheme: string;
  public mermaidTheme: string;
  public frontMatterRenderingOption: string;
  public imageFolderPath: string;
  public printBackground: boolean;
  public chromePath: string;
  public imageMagickPath: string;
  public pandocPath: string;
  public pandocMarkdownFlavor: string;
  public pandocArguments: string[];
  public latexEngine: string;
  public enableScriptExecution: boolean;
  public enableHTML5Embed: boolean;
  public HTML5EmbedUseImageSyntax: boolean;
  public HTML5EmbedUseLinkSyntax: boolean;
  public HTML5EmbedIsAllowedHttp: boolean;
  public HTML5EmbedAudioAttributes: string;
  public HTML5EmbedVideoAttributes: string;
  public puppeteerWaitForTimeout: number;
  public usePuppeteerCore: boolean;
  public puppeteerArgs: string[];
  public plantumlServer: string;

  /*
   * Extra config for mpe
   */

  public fileExtension: string[];
  public singlePreview: boolean;
  public scrollSync: boolean;
  public liveUpdate: boolean;
  public previewPanePosition: string;
  public openPreviewPaneAutomatically: boolean;
  public automaticallyShowPreviewOfMarkdownBeingEdited: boolean;
  public closePreviewAutomatically: boolean;
  // public enableZenMode: boolean
  public imageUploader: string;
  public imageDropAction: string;

  public constructor() {
    for (const name in ConfigSettings) {
      if (ConfigSettings.hasOwnProperty(name)) {
        const transform = ConfigSettings[name];
        const rawValue = atom.config.get(`markdown-preview-enhanced.${name}`);
        this[name] = transform(rawValue);
      }
    }
  }

  public onDidChange(subscriptions: CompositeDisposable, callback) {
    for (const name in ConfigSettings) {
      if (ConfigSettings.hasOwnProperty(name)) {
        const transform = ConfigSettings[name];
        const subscription = atom.config.onDidChange(
          `markdown-preview-enhanced.${name}`,
          ({ newValue }) => {
            this[name] = transform(newValue);
            callback();
          },
        );
        subscriptions.add(subscription);
      }
    }
  }

  [key: string]: any;
}
