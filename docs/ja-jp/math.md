# 数式

**Markdown Preview Enhanced** は、[KaTeX](https://github.com/Khan/KaTeX) または[MathJax](https://github.com/mathjax/MathJax) を使用して数式をレンダリングします。

KaTeX は MathJax より高速ですが、MathJax の方が高機能です。 [KaTeX でサポートされている関数/記号](https://khan.github.io/KaTeX/function-support.html) を確認して下さい。

既定では：

- `$ ... $` または `\(... \)` 内の数式は行内の式(インライン)としてレンダリングされます。
- `$$ ... $$` または `\[... \]` または <code>```math</code> 内の式は別行の式(ブロック)でレンダリングされます。

![](https://cloud.githubusercontent.com/assets/1908863/14398210/0e408954-fda8-11e5-9eb4-562d7c0ca431.gif)

数式のレンダリング方法と数式の区切り文字を [パッケージ設定パネル](ja-jp/usages.md?id=package-settings) から変更できます。

<kbd>cmd-shift-p</kbd> で、`Markdown Preview Enhanced：Open Mathjax config` コマンドを選択し MathJax 設定を変更することもできます。

[➔ ダイアグラム](ja-jp/diagrams.md)
