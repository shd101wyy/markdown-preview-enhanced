# FAQ

1. **このパッケージが atom で見つからないのですが?**
   パッケージ名を全て入力して検索してください。`markdown-preview-enhanced`
2. **html ファイルをエクスポートし、自分のリモートサーバーにデプロイしたいと考えています。しかし、数式の組版(MathJax または KaTeX)が機能しません。どうすればよいですか？**
   エクスポートするときに `Use CDN hosted resources` がオンになっていることを確認してください。
3. **プレゼンテーション html ファイルをエクスポートし、Github ページに配置するか、リモートにデプロイしたいのですが？**
   最後の質問を確認してください。
4. **ダークスタイルのプレビューに設定するにはどうすればよいですか？**
   プレビューのスタイルを atom と一致させるには、このパッケージの設定に移動し、`Preview Theme` を変更します。
   または、`Markdown Preview Enhanced：Customize Css` コマンドを実行してから、`style.less` ファイルを変更できます。 [＃68](https://github.com/shd101wyy/markdown-preview-enhanced/issues/68), [＃89](https://github.com/shd101wyy/markdown-preview-enhanced/issues/89)
5. **プレビューがめちゃ重いのですが?**
   これは、markdown ファイルが大きすぎる場合、または数式やグラフを大量に記述している場合に発生する可能性があります。
   このような場合、`Live Update` 機能を無効にすることをお勧めします。
   `Markdown Preview Enhanced：Toggle Live Update` を実行すると機能を無効にすることができます。
6. **キーボードショートカットが機能しないのですが?**
   <kbd>cmd-shift-p</kbd> を実行し、`Key Binding Resolver: Toggle` を選択します。キーバインドの競合がないかを確認し、GitHub に issue を投稿してください。
