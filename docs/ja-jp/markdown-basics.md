# Markdown の基本

この記事は、[GitHub Flavored Markdown writing](https://guides.github.com/features/mastering-markdown/) の簡単な紹介です。

## Markdown とは何か

`Markdown` は Web 上のテキストのスタイルを設定する方法です。ドキュメントの表示を制御します。単語を太字または斜体にフォーマットしたり、画像を追加したり、リストを作成したりすることは、Markdown で実行できることのほんの一部です。ほとんどの場合、Markdown は通常のテキストであり、 `＃` や `*` などのアルファベット以外の文字がいくつか含まれています。

## 構文ガイド

### 見出し

```markdown
# これは<h1>タグです

## これは<h2>タグです

### これは<h3>タグです

#### これは<h4>タグです

##### これは<h5>タグです

###### これは<h6>タグです
```

見出しに `id` と `class` を追加する場合は、単に `{#id .class1 .class2}` を追加します。例えば：

```markdown
# この見出しには 1 つの ID があります {#my_id}

# この見出しには 2 つのクラスがあります {.class1 .class2}
```

> これは MPE の拡張機能です。

### 強調

<!-- prettier-ignore -->
```markdown
*このテキストは斜体になります*
_これも斜体になります_

**このテキストは太字になります**
__これも太字になります__

_あなたはこれらを**組み合わせる**ことができます_

~~このテキストは取り消し線になります~~
```

### リスト

#### 順不同リスト

```markdown
- Item 1
- Item 2
  - Item 2a
  - Item 2b
```

#### 順序付きリスト

```markdown
1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b
```

### 画像

```markdown
![GitHub Logo](/images/logo.png)
Format: ![Alt Text](url)
```

### リンク

```markdown
https://github.com - 自動的にリンクになります
[GitHub](https://github.com)
```

### ブロック引用

```markdown
カニエ・ウェストは言った:

> We're living the future so
> the present is our past.
```

### 水平線

```markdown
3 つ以上の

---

ハイフン -

---

アスタリスク \*

---

アンダーバー \_
```

### インラインコード

```markdown
私はここで `<addr>` 要素を
代わりに使用すべきだと思います。
```

### フェンスド コード ブロック

コード ブロックの前後にバッククウォート 3 つ <code>\`\`\`</code> を配置することで、フェンスド コード ブロックを作成できます。

#### シンタックス ハイライト

オプションの言語識別子を追加して、フェンスド コード ブロックで構文の強調表示を有効にすることができます。

たとえば、Ruby コードをシンタックス ハイライトするには：

    ```ruby
    require 'redcarpet'
    markdown = Redcarpet.new("Hello World!")
    puts markdown.to_html
    ```

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

#### コード ブロック クラス（MPE 拡張機能）

コード ブロックに `class` を設定できます。

たとえば、 `class1 class2` をコード ブロックに追加するには

    ```javascript {.class1 .class}
    function add(x, y) {
      return x + y
    }
    ```

##### 行番号

`line-numbers` クラスを追加することで、コードブロックの行番号表示を有効にすることができます。

例えば：

````markdown
```javascript {.line-numbers}
function add(x, y) {
  return x + y;
}
```
````

![screen shot 2017-07-14 at 1 20 27 am](https://user-images.githubusercontent.com/1908863/28200587-a8582b0a-6832-11e7-83a7-6c3bb011322f.png)

##### 行を強調表示

`highlight` 属性を追加することで特定の行を強調表示できます：

````markdown
```javascript {highlight=10}
```

```javascript {highlight=10-20}
```

```javascript {highlight=[1-10,15,20-22]}
```
````

### タスク リスト

```markdown
- [x] @言及、#参照、[リンク]()、**強調**、および <del>tags</del> をサポートします
- [x] リスト構文が必要（順不同リストまたは順序付きリストがサポートされています）
- [x] これは完了したアイテムです
- [ ] これは未完了なアイテムです
```

### 表

単語のリストを組み立ててハイフン `-`（最初の行を）で分割し、各列をパイプ `|` で区切ることにより、表を作成できます。

<!-- prettier-ignore -->
```markdown
最初のヘッダー | 2番目のヘッダー
------------ | -------------
セル1のコンテンツ | セル2のコンテンツ
最初の列のコンテンツ | 2列目の内容
```

## 拡張構文

### 表

> 機能を有効にするには、拡張機能の設定で `enableExtendedTableSyntax` を有効にする必要があります。

![screen shot 2017-07-15 at 8 16 45 pm](https://user-images.githubusercontent.com/1908863/28243710-945e3004-699a-11e7-9a5f-d74f6c944c3b.png)

### 絵文字とフォント

> これは `markdown-it parser` でのみ機能し、`pandoc parser` では機能しません。
> デフォルトで有効。パッケージ設定から無効にできます。

```
:smile:
:fa-car:
```

### 上付き文字

```markdown
30^th^
```

### 下付き文字

```markdown
H~2~O
```

### 脚注

```markdown
内容 [^1]

[^1]: やあ! これは脚注です。
```

### 略語

```markdown
_[HTML]: Hyper Text Markup Language
_[W3C]: World Wide Web Consortium
HTML の仕様は W3C によって管理されています。
```

### Mark

```markdown
==marked==
```

### CriticMarkup

CriticMarkup は既定値で**無効**になっていますが、パッケージ設定から有効にすることができます。
CriticMarkup の詳細については、[CriticMarkup User's Guide](https://criticmarkup.com/users-guide.php) を確認してください。

Critic Mark には 5 つのタイプがあります。

- 追加 `{++ ++}`
- 削除 `{-- --}`
- 代入 `{~~ ~> ~~}`
- コメント `{>> <<}`
- ハイライト `{== ==}{>> <<}`

> CriticMarkup は markdown-it parser でのみ機能し、pandoc parser では機能しません。

### Admonition

```
!!! note This is the admonition title
    This is the admonition body
```

> 詳細については、https：//squidfunk.github.io/mkdocs-material/reference/admonitions/をご覧ください。

## リファレンス

- [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
- [Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)

[➔ 数式](ja-jp/math.md)
