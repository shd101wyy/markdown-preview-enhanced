# 目次

**Markdown Preview Enhanced** は、markdown ファイルの `TOC` を作成できます。
<kbd>cmd-shift-p</kbd> を押してから、 `Markdown Preview Enhanced：Create Toc` を選択すると `TOC` を作成できます。
複数の目次を作成できます。
`TOC` から見出しを除外するには、見出しの**後に** `{ignore=true}` を追加します。

![screen shot 2018-03-14 at 12 03 00 pm](https://user-images.githubusercontent.com/1908863/37418218-bb624e62-277f-11e8-88f5-8747a1c2e012.png)

> markdown ファイルを保存すると、目次が更新されます。
> 目次を更新するには、プレビューを開いたままにする必要があります。

## 設定

- **orderedList**
  orderedList を使用するかどうか。
- **depthFrom**, **depthTo**
  `[1〜6]` のどの範囲の見出しを目次に含むか。
- **ignoreLink**
  `true`に設定すると、目次の各項目はハイパーリンクになりません。

## [TOC]

markdown ファイルに `[TOC]` を挿入して、`TOC` を作成することもできます。
例えば：

```markdown
[TOC]

# 見出し 1

## 見出し 2 {ignore=true}

見出し 2 は目次から無視されます。
```

ただし、**この方法では、目次はプレビューでのみ表示され**、エディターのコンテンツは変更されません。

## [TOC]およびサイドバー TOC 構成

フロントマターを書くことで `[TOC]` とサイドバー TOC を設定できます：

```markdown
---
toc:
  depth_from: 1
  depth_to: 6
  ordered: false
---
```

[➔ 外部 File の Imports](ja-jp/file-imports.md)
