# プレゼンテーション出力

![screen shot 2017-07-14 at 12 33 14 pm](https://user-images.githubusercontent.com/1908863/28223480-2c61461c-6891-11e7-9389-5adec0588c32.png)

**Markdown Preview Enhanced** は、[reveal.js](https://github.com/hakimel/reveal.js) を使用して美しいプレゼンテーションをレンダリングします。

[ここをクリック](https://rawgit.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.html) して、概要(英語)を確認してください（**推奨**）。

![presentation](https://user-images.githubusercontent.com/1908863/28202176-caf103c4-6839-11e7-8776-942679f3698b.gif)

## プレゼンテーションのフロントマター

markdown ファイルにフロントマターを追加して、プレゼンテーションを構成できます。
`presentation` セクションに設定を書いてください。
例えば：

```markdown
---
presentation:
  width: 800
  height: 600
---

<!-- slide -->

ここにスライドを書く
```

上記のプレゼンテーションのサイズは `800x600` です

### 設定

```yaml
---
presentation:
  # プレゼンテーションのテーマ
  # === 使用可能なテーマ ===
  # "beige.css"
  # "black.css"
  # "blood.css"
  # "league.css"
  # "moon.css"
  # "night.css"
  # "serif.css"
  # "simple.css"
  # "sky.css"
  # "solarized.css"
  # "white.css"
  # "none.css"
  theme: white.css

  # プレゼンテーションの「通常の」サイズ、アスペクト比は、
  # プレゼンテーションが異なる解像度に合うように拡大縮小されたときに
  # 保持されます。パーセント単位で指定できます。
  width: 960
  height: 700

  # コンテンツの周りで空のままにしておくべきディスプレイサイズの係数
  margin: 0.1

  # コンテンツに適用できる最小/最大の拡大倍率
  minScale: 0.2
  maxScale: 1.5

  # 右下隅にコントロールを表示
  controls: true

  # プレゼンテーションの進行状況バーを表示する
  progress: true

  # 現在のスライドのページ番号を表示
  slideNumber: false

  # スライドの各変更をブラウザの履歴にプッシュする
  history: false

  # ナビゲーションのキーボードショートカットを有効にする
  keyboard: true

  # スライド概要モードを有効にする
  overview: true

  # スライドの垂直方向の中央揃え
  center: true

  # タッチ入力を備えたデバイスでタッチナビゲーションを有効にする
  touch: true

  # プレゼンテーションをループする
  loop: false

  # 文字方向を右から左(RTL)に変更する
  rtl: false

  # プレゼンテーションが読み込まれるたびにスライドの順序をランダム化する
  shuffle: false

  # フラグメントをグローバルにオン/オフにします
  fragments: true

  # プレゼンテーションが埋め込みモードで実行する、
  # 例: 画面の限られた部分に埋め込む
  embedded: false

  # ?キーが押されたときにヘルプオーバーレイを表示する
  help: true

  # スピーカーノートをすべての視聴者に表示するかどうか
  showNotes: false

  # 次のスライドに自動的に進むまでのミリ秒。
  # 0に設定すると無効になります。
  # この値はスライドのdata-autoslide属性を使用して上書きできます
  autoSlide: 0

  # ユーザー入力後に自動スライドを停止する
  autoSlideStoppable: true

  # マウスホイールによるスライドナビゲーションを有効にする
  mouseWheel: false

  # モバイルデバイスのアドレスバーを非表示にする
  hideAddressBar: true

  # iframeプレビューオーバーレイでリンクを開く
  previewLinks: false

  # 遷移スタイル
  transition: "default" # none/fade/slide/convex/concave/zoom

  # 遷移速度
  transitionSpeed: "default" # default/fast/slow

  # ページ全体のスライドの背景の遷移スタイル
  backgroundTransition: "default" # none/fade/slide/convex/concave/zoom

  # 現在のスライドから表示するスライドの数
  viewDistance: 3

  # 視差背景画像
  parallaxBackgroundImage: "" # 例: "'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg'"

  # 視差背景サイズ
  parallaxBackgroundSize: "" # CSS構文, 例: "2100px 900px" - 現在のところ、Pixelのみサポートされています。(%とautoは使用しないでください)

  # スライドごとに視差背景を移動するピクセル数
  # - 指定されない限り自動的に計算されます
  # - 軸に沿った移動を無効にするには0に設定します
  parallaxBackgroundHorizontal: 200
  parallaxBackgroundVertical: 50

  # スピーカーノートを有効にする
  enableSpeakerNotes: false
---

```

## スライドスタイルのカスタマイズ

次のように、`id` と `class` を特定のスライドに追加できます。

```markdown
<!-- slide id="my-id" class="my-class1 my-class2" -->
```

または、n 番目のスライドのみをカスタマイズする場合、次のように `less` ファイルを変更します。

```less
.markdown-preview.markdown-preview {
  // custom presentation style
  .reveal .slides {
    // modify all slides
  }

  .slides > section:nth-child(1) {
    // this will modify `the first slide`
  }
}
```

[➔ Pandoc](ja-jp/pandoc.md)
