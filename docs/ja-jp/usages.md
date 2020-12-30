# 使い方

## コマンド

エディタで<kbd>cmd-shift-p</kbd>を押すと、<strong>Command Palette</strong>に切り替えることができます。

> _Windows_ の<kbd>cmd</kbd>キーは<kbd>ctrl</kbd>です。

_Markdown_

- <strong>Markdown Preview Enhanced: Toggle</strong>  
  <kbd>ctrl-shift-m</kbd>  
  Markdown ファイルの preview を切り替えます。

- <strong>Markdown Preview Enhanced: Toggle Zen Mode </strong>  
  Zen Mode を切り替えます。

- <strong>Markdown Preview Enhanced: Customize Css</strong>  
  プレビューページの CSS をカスタマイズします。
  ここに簡単な[チュートリアル](ja-jp/customize-css.md) があります。

- <strong>Markdown Preview Enhanced: Create Toc </strong>  
  目次を生成します(プレビューを切り替える必要があります)。[ドキュメントはこちら](ja-jp/toc.md)。

- <strong>Markdown Preview Enhanced: Toggle Scroll Sync </strong>  
  プレビューのスクロール同期を有効/無効にします。

- <strong>Markdown Preview Enhanced: Sync Source </strong>  
  <kbd>ctrl-shift-s</kbd>  
  markdown のカーソル位置に一致するようにプレビューをスクロールします。

- <strong>Markdown Preview Enhanced: Toggle Live Update </strong>  
   プレビュー用のライブ更新を有効/無効にします。
  無効にすると、ファイルが保存されたときにのみプレビューがレンダリングされます。

- <strong>Markdown Preview Enhanced: Toggle Break On Single Newline </strong>  
  単一の改行文字での改行を有効/無効にします。

- <strong>Markdown Preview Enhanced: Insert New Slide </strong>  
  新しいスライドを挿入し、[プレゼンテーションモード](ja-jp/presentation.md) に入ります

- <strong>Markdown Preview Enhanced: Insert Table </strong>  
  表を挿入します。

- <strong>Markdown Preview Enhanced: Insert Page Break </strong>  
  改ページを挿入します。

- <strong> Markdown Preview Enhanced: Open Mermaid Config</strong>  
  `mermaid` の初期化設定を編集します。

- <strong> Markdown Preview Enhanced: Open Mathjax Config </strong>  
   `MathJax` の初期化設定を編集します。

- <strong>Markdown Preview Enhanced: Image Helper</strong>  
  詳細については、[このドキュメント](ja-jp/image-helper.md) を確認してください。
  Image helper は、[imgur](https://imgur.com/) および [sm.ms](https://sm.ms/) による画像 URL のクイック挿入、画像貼り付け、および画像アップロードをサポートしています。
  ![screen shot 2017-06-06 at 3 42 31 pm](https://user-images.githubusercontent.com/1908863/26850896-c43be8e2-4ace-11e7-802d-6a7b51bf3130.png)

- <strong>Markdown Preview Enhanced: Show Uploaded Images</strong>  
  アップロードした画像情報が保存されている `image_history.md` を開きます。
  `image_history.md` ファイルは自由に変更できます。

- <strong>Markdown Preview Enhanced: Run Code Chunk </strong>  
  <kbd>shift-enter</kbd>  
  単一の [コード チャンク](ja-jp/code-chunk.md) を実行します。

- <strong>Markdown Preview Enhanced: Run All Code Chunks </strong>  
  <kbd>ctrl-shift-enter</kbd>  
  すべての [コード チャンク](ja-jp/code-chunk.md) を実行します。

- <strong>Markdown Preview Enhanced: Extend Parser</strong>  
  [Markdown Parser の拡張](ja-jp/extend-parser.md).

---

_プレビュー_

プレビューで**右クリック**して、コンテキストメニューを開きます:

![screen shot 2017-07-14 at 12 30 54 am](https://user-images.githubusercontent.com/1908863/28199502-b9ba39c6-682b-11e7-8bb9-89661100389e.png)

- <kbd>cmd-=</kbd> or <kbd>cmd-shift-=</kbd>.  
  プレビューを拡大します。

- <kbd>cmd--</kbd> or <kbd>cmd-shift-\_</kbd>.  
  プレビューを縮小します。

- <kbd>cmd-0</kbd>  
  ズームをリセットします。

- <kbd>cmd-shift-s</kbd>  
  エディターをスクロールして、プレビューの位置に合わせます。

- <kbd>esc</kbd>  
  サイドバーの目次表示を切り替えます。

## キーボードショートカット

| キーバインド                                    | 機能                              |
| ----------------------------------------------- | --------------------------------- |
| <kbd>ctrl-shift-m</kbd>                         | プレビューを切り替える            |
| <kbd>cmd-k v</kbd>                              | プレビューを開く `VSCodeのみ`     |
| <kbd>ctrl-shift-s</kbd>                         | プレビューと同期 / エディタと同期 |
| <kbd>shift-enter</kbd>                          | コード チャンクを実行             |
| <kbd>ctrl-shift-enter</kbd>                     | 全てのコード チャンクを実行       |
| <kbd>cmd-=</kbd> または <kbd>cmd-shift-=</kbd>  | プレビューを拡大する in           |
| <kbd>cmd--</kbd> または <kbd>cmd-shift-\_</kbd> | プレビューを縮小する out          |
| <kbd>cmd-0</kbd>                                | プレビューのズームをリセットする  |
| <kbd>esc</kbd>                                  | サイドバーの目次表示を切り替える  |

## パッケージ設定

### Atom

パッケージ設定を開くには、<kbd>cmd-shift-p</kbd> を押し、`Settings View: Open` を選択して、`Packages` をクリックします。

`Installed Packages` の下で `markdown-preview-enhanced` を検索します。
![screen shot 2017-06-06 at 3 57 22 pm](https://user-images.githubusercontent.com/1908863/26851561-d6b1ca30-4ad0-11e7-96fd-6e436b5de45b.png)

`Settings` ボタンをクリックします。

![screen shot 2017-07-14 at 12 35 13 am](https://user-images.githubusercontent.com/1908863/28199574-50595dbc-682c-11e7-9d94-264e46387da8.png)

### VS Code

`Preferences: Open User Settings` コマンドを実行してから、`markdown-preview-enhanced` を検索します。

![screen shot 2017-07-14 at 12 34 04 am](https://user-images.githubusercontent.com/1908863/28199551-2719acb8-682c-11e7-8163-e064ad8fe41c.png)
