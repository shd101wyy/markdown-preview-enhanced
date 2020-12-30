# コード チャンク

**将来的に仕様が変更される可能性があります。**

**Markdown Preview Enhanced** はコードの出力をドキュメントに埋め込むことができます。

    ```bash {cmd}
    ls .
    ```

    ```bash {cmd=true}
    ls .
    ```

    ```javascript {cmd="node"}
    const date = Date.now()
    console.log(date.toString())
    ```

> ⚠️ **スクリプトの実行は既定で無効になっており、Atom package、または VSCode の拡張機能から明示的に有効にする必要があります。**
>
> セキュリティを危険にさらす可能性があるので、注意してこの機能を使用してください。
> スクリプトの実行が有効になっている間に、誰かが悪意のあるコードでマークダウンを開かせた場合、マシンがハッキングされる可能性があります。
>
> 設定名: `enableScriptExecution`

## コマンドとキーボードショットカット

- `Markdown Preview Enhanced: Run Code Chunk` または <kbd>shift-enter</kbd>
  カーソルがあるコード チャンクを実行します。
- `Markdown Preview Enhanced: Run All Code Chunks` または <kbd>ctrl-shift-enter</kbd>
  全てのコード チャンクを実行します。

## 構文

コード チャンクのオプションは、<code>\`\`\`lang {cmd=your_cmd opt1=value1 opt2=value2 ...}</code>の形式で設定することができます。
属性の値が `true` の場合は、省略することができます (例: `{cmd hide}` は `{cmd=true hide=true}` と同じです)。

**言語名**
コード ブロックの言語名は一番最初に記載してください。

## 基本的なオプション

**cmd**
実行するコマンド。
`cmd` が指定されなかった場合、 `lang` をコマンドとして使用します。

例:

    ```python {cmd="/usr/local/bin/python3"}
    print("This will run python3 program")
    ```

**出力**
`html`, `markdown`, `text`, `png`, `none`

どのような形式で出力結果を描画するかを設定します。
`html` は HTML として出力を追加します。
`markdown` は markdown として出力します。(MathJax と graphs はサポートされません。一方、KaTex はサポートされます。)
`text` は出力を `pre` ブロックに追加します。
`png` は出力を `base64` 画像として追加します。
`none` は出力を表示せず隠します。

例:

    ```gnuplot {cmd=true output="html"}
    set terminal svg
    set title "Simple Plots" font ",20"
    set key left box
    set samples 50
    set style data points

    plot [-10:10] sin(x),atan(x),cos(atan(x))
    ```

![screen shot 2017-07-28 at 7 14 24 am](https://user-images.githubusercontent.com/1908863/28716734-66142a5e-7364-11e7-83dc-a66df61971dc.png)

**引数**
args が引数としてコマンドに渡されます。
例:

    ```python {cmd=true args=["-v"]}
    print("Verbose will be printed first")
    ```

    ```erd {cmd=true args=["-i", "$input_file", "-f", "svg"] output="html"}
      # output svg format and append as html result.
    ```

**標準入力**
`stdin` が true に設定されている場合、コードはファイルではなく標準入力として渡されます。

**hide**
`hide` はコード チャンクを隠しますが、出力結果は表示します。既定値: `false`
例:

    ```python {hide=true}
    print('you can see this output message, but not this code')
    ```

**continue**
`continue=true`に設定されているコード チャンクは前のコード チャンクの続きとして実行されます。
`continue=id`が設定されている場合、このコード チャンクは同じ id が設定されているコード チャンクの続きとして実行されます。
例:

    ```python {cmd=true id="izdlk700"}
    x = 1
    ```

    ```python {cmd=true id="izdlkdim"}
    x = 2
    ```

    ```python {cmd=true continue="izdlk700" id="izdlkhso"}
    print(x) # will print 1
    ```

**class**
`class="class1 class2"`が設定されている場合、`class1 class2` がコード チャンクに設定されます。

- `line-numbers` クラスが設定されているコード チャンクには行番号が表示されます。

**element**
エレメントを追加したい場合は下記の **Plotly** の例を参照してください。

**run_on_save** `boolean`
markdown ファイルが保存されるときにコード チャンクを実行します。既定値: `false`

**modify_source** `boolean`
markdown ファイルにコード チャンクの出力結果を直接挿入します。既定値: `false`

**id**
コード チャンクの`id`。このオプションは `continue` を使用するときに役に立ちます。

## マクロ

- **input_file**
  `input_file` は markdown ファイルと同じディレクトリに自動的に生成され、`input_file` にコピーされたコードの実行が完了すると自動的に削除されます。
  既定では、プログラムの引数の一番最後に追加されます。
  しかし、 `input_file` マクロにより引数内で `input_file` の場所を設定することもできます。
  例:

      ```program {cmd=true args=["-i", "$input_file", "-o", "./output.png"]}
      ...your code here
      ```

## Matplotlib

`matplotlib=true`の場合、python コード チャンクはプレビュー内にグラフとしてプロットされます。
例:

    ```python {cmd=true matplotlib=true}
    import matplotlib.pyplot as plt
    plt.plot([1,2,3, 4])
    plt.show() # show figure
    ```

![screen shot 2017-07-28 at 7 12 50 am](https://user-images.githubusercontent.com/1908863/28716704-4009d43a-7364-11e7-9e46-889f961e5afd.png)

## LaTeX

Markdown Preview Enhanced は `LaTeX` のコンパイルもサポートします。
この機能を利用する前に、[pdf2svg](extra.md?id=install-svg2pdf) と [LaTeX engine](extra.md?id=install-latex-distribution) をインストールする必要があります。
LaTex コード チャンクは以下のように書くことができます:

    ```latex {cmd=true}
    \documentclass{standalone}
    \begin{document}
      Hello world!
    \end{document}
    ```

![screen shot 2017-07-28 at 7 15 16 am](https://user-images.githubusercontent.com/1908863/28716762-8686d980-7364-11e7-9669-71138cb2e6e7.png)

### LaTeX 出力設定

**latex_zoom**
`latex_zoom=num`が設定されている場合、出力結果は `num` 倍に表示されます。

**latex_width**
出力結果の幅を設定します。

**latex_height**
出力結果の高さを設定します。

**latex_engine**
`tex` ファイルをコンパイルするのに使用する latex engine を設定します。既定では、 `pdflatex` を使用します。

### TikZ の例

`tikz` グラフを描画する場合、 `standalone` を使用することを推奨します。
![screen shot 2017-07-14 at 11 27 56 am](https://user-images.githubusercontent.com/1908863/28221069-8113a5b0-6887-11e7-82fa-23dd68f2be82.png)

## Plotly

Markdown Preview Enhanced で [Plotly](https://plot.ly/) を容易に描画できます。
例:
![screen shot 2017-10-20 at 10 41 25 am](https://user-images.githubusercontent.com/1908863/31829580-526a0c06-b583-11e7-82f2-09ea7a0b9672.png)

- 最初の行の `@import "https://cdn.plot.ly/plotly-latest.min.js"` は [file import](ja-jp/file-imports.md) 関数を `plotly-latest.min.js` ファイルを import するために使用しています。
  しかし、パフォーマンスの点からローカルディスクに js ファイルをダウンロードすることを推奨します。。
- あとは `javascript` コード チャンクを書くだけです。

## ERD のデモ

ER 図を [erd](https://github.com/BurntSushi/erd) ライブラリによって描画する方法のデモです。

    ```erd {cmd=true output="html" args=["-i", "$input_file" "-f", "svg"]}

    [Person]
    *name
    height
    weight
    +birth_location_id

    [Location]
    *id
    city
    state
    country

    Person *--1 Location
    ```

`erd {cmd=true output="html" args=["-i", "$input_file", "-f", "svg"]}`

- `erd` 使用するプログラム(_最初にプログラムをインストールする必要があります。_)
- `output="html"` `html`として出力結果を追加します
- `args` フィールドは使用する引数を指定します

プレビュー上の `run` ボタンをクリックするとコードを実行することができます。

![erd](https://user-images.githubusercontent.com/1908863/28221395-bcd0bd76-6888-11e7-8c6e-925e228d02cc.gif)

## Showcases (旧情報)

**bash**
![Screen Shot 2016-09-24 at 1.41.06 AM](https://i.imgur.com/v5Y7juh.png)

**gnuplot with svg output**
![Screen Shot 2016-09-24 at 1.44.14 AM](https://i.imgur.com/S93g7Tk.png)

## 制限

- `ebook` 出力ではまだ動作しません
- `pandoc document export` 出力にはバグがありそうです

[➔ プレゼンテーション](ja-jp/presentation.md)
