# 開発者の方へ

## Atom 向けパッケージの開発

pull request、issues の報告、新機能の追加要望はどうぞお気軽に!

**markdown-preview-enhanced** の修正、開発には [local installation](installation.md?id=install-from-github) が必要です。

パッケージのインストールが完了したら、順番に実行して下さい:

- **markdown-preview-enhanced** フォルダーを **Atom Editor** で **View->Developer->Open in Dev Mode...** から開く。
- コードを修正する。
  修正したコードの更新内容を確認するには <kbd>cmd-shift-p</kbd> から `Window: Reload` を実行する必要があります。

> Atom 版は TypeScript で書かれているので、パッケージ開発のために `atom-typescript` をインストールすることをお勧めします。
> 実をいうと... VS Code を使って Atom 版を開発しました。

## VS Code 向けパッケージの開発

[vscode-markdown-preview-enhanced](https://github.com/shd101wyy/vscode-markdown-preview-enhanced)をクローンし、`yarn`し、**VS Code** で開いたらデバッグを開始できます。
