# HTML 出力

## 使い方

プレビューで右クリックし、[HTML]タブをクリックします。
次にオプションを選択します:

- `HTML (offline)`
  この html ファイルをローカルでのみ使用する場合は、このオプションを選択します。
- `HTML (cdn hosted)`
  HTML ファイルをリモートでデプロイする場合は、このオプションを選択します。

![screen shot 2017-07-14 at 1 14 28 am](https://user-images.githubusercontent.com/1908863/28200455-d5a12d60-6831-11e7-8572-91d3845ce8cf.png)

## 設定

既定値：

```yaml
---
html:
  embed_local_images: false
  embed_svg: true
  offline: false
  toc: undefined

print_background: false
---

```

`embed_local_images` が `true` に設定されている場合、すべてのローカル画像は `base64` 形式として埋め込まれます。

`toc` が `false` に設定されている場合、サイドバーの目次は無効になります。 `toc` が `true` に設定されている場合、サイドバーの目次が有効になり、表示されます。 `toc` が指定されていない場合、サイドバーの目次は有効になりますが、表示されません。

## 保存時に出力する

以下のようにフロントマターを追加します。

```yaml
---
export_on_save:
  html: true
---

```

このように設定すると、markdown ファイルを保存するたびに html ファイルが生成されます。
