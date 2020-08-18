# Atom へのインストール

> 公式の `markdown-preview` パッケージが無効になっていることを確認してください。

このパッケージをインストール方法はいくつかあります。

## Atom からインストール(推奨)

**atom** エディターを開き、`Settings` を開いて `Install` をクリックし、 `markdown-preview-enhanced` を検索します。
インストール後、atom を**再起動する必要があります**。
このパッケージをインストールした後、組み込みの `markdown-preview` パッケージを無効にすることをお勧めします。

![screen shot 2017-03-19 at 4 07 16 pm](https://cloud.githubusercontent.com/assets/1908863/24084798/260a9fee-0cbf-11e7-83e6-bf17fa9aca77.png)

## ターミナルからインストール

ターミナルを開き、次のコマンドを実行します。

```bash
apm install markdown-preview-enhanced
```

## GitHub からインストール

- このプロジェクトを **Clone** します。
- ダウンロードした **markdown-preview-enhanced** フォルダーに `cd` します。
- `yarn install` コマンドを実行します。次に、`apm link` コマンドを実行します。

```bash
cd the_path_to_folder/markdown-preview-enhanced
yarn install
apm link # <- This will copy markdown-preview-enhanced folder to ~/.atom/packages
```

> `npm` コマンドがない場合は、最初に [node.js](https://nodejs.org/en/) をインストールする必要があります。
> [node.js](https://nodejs.org/en/) を自分でインストールしたくない場合は、`apm link` の後に、atom エディターを開きます。キーボード <kbd>cmd-shift-p</kbd> を押し、`Update Package Dependencies: Update` コマンドを選択します。

## 開発者の方へ

```bash
apm develop markdown-preview-enhanced
```

- **Atom** で **View-> Developer-> Open in Dev Mode ...** から**markdown-preview-enhanced** フォルダーを開きます。
- コードを変更できます。
  コードを変更した後に更新を確認するには、毎回 <kbd>cmd-shift-p</kbd> を実行し、`Window: Reload` を選択してパッケージを再読み込みする必要があります。

[➔ 使い方](ja-jp/usages.md)
