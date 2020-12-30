# Extra

## pdf2svg のインストール

[pdf2svg の公式サ ​​ イト](https://www.cityinthesky.co.uk/opensource/pdf2svg/)

- **Mac**

```bash
brew install pdf2svg
```

- **Windows**  
  Windows 向けバイナリは [GitHub](https://github.com/jalios/pdf2svg-windows) から入手できます。
  `pdf2svg.exe` に `$PATH` を通す必要があります。

- **Linux**  
  `pdf2svg` はさまざまな Linux ディストリビューション(Ubuntu や Fedora を含む)用にパッケージ化されており、さまざまなパッケージマネージャーから入手できます。

## LaTeX ディストリビューションのインストール

[LaTeX 配布サイト](https://www.latex-project.org/get/) を確認してください。
[TeX Live](https://www.tug.org/texlive/) は、Markdown Preview Enhanced での作業に最適です。

**Mac** ユーザーの場合、[MacTex](https://www.tug.org/mactex) をインストールするだけで完了です。

## この Web サイトを変更する方法

このドキュメントは、[docsify](https://docsify.js.org/#/) によって生成されています。
この Web サイトを変更するには:

1. `git clone https://github.com/shd101wyy/markdown-preview-enhanced.git`
2. ターミナルで次のコマンドを実行します：

```bash
# install docsify
npm i docsify-cli -g

cd path_to/markdown-preview-enhanced

docsify serve docs
```
