# Code Chunk

**Gelecekte değişiklikler olabilir.**

**Markdown Preview Enhanced**, kod çıktısını belgelere işlemenize olanak tanır.

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

> ⚠️ **Betik çalıştırma varsayılan olarak kapalıdır ve Atom paketi / VSCode uzantısı tercihlerinde açıkça etkinleştirilmesi gerekir**
>
> Bu özelliği dikkatli kullanın çünkü güvenliğinizi tehlikeye atabilir!
> Betik çalıştırma etkinken birileri sizi kötü niyetli kod içeren bir markdown dosyası açmaya yönlendirirse makineniz saldırıya uğrayabilir.
>
> Seçenek adı: `enableScriptExecution`

## Komutlar ve Klavye Kısayolları

- `Markdown Preview Enhanced: Run Code Chunk` veya <kbd>shift-enter</kbd>
  İmlecin bulunduğu tek bir code chunk'ı çalıştırır.
- `Markdown Preview Enhanced: Run All Code Chunks` veya <kbd>ctrl-shift-enter</kbd>
  Tüm code chunk'ları çalıştırır.

## Biçim

Code chunk seçeneklerini <code>\`\`\`lang {cmd=your_cmd opt1=value1 opt2=value2 ...}</code> biçiminde yapılandırabilirsiniz.
Bir özniteliğin değeri `true` olduğunda atlanabilir (örn. `{cmd hide}`, `{cmd=true hide=true}` ile aynıdır).

**lang**
Kod bloğunun vurgulaması gereken dilbilgisi.
En öne konulmalıdır.

## Temel Seçenekler

**cmd**
Çalıştırılacak komut.
`cmd` verilmezse, `lang` komut olarak kabul edilir.

örnek:

    ```python {cmd="/usr/local/bin/python3"}
    print("Bu python3 programını çalıştıracak")
    ```

**output**
`html`, `markdown`, `text`, `png`, `none`

Kod çıktısının nasıl işleneceğini tanımlar.
`html` çıktıyı html olarak ekler.
`markdown` çıktıyı markdown olarak ayrıştırır. (Bu durumda MathJax ve grafikler desteklenmez, ancak KaTeX çalışır)
`text` çıktıyı bir `pre` bloğuna ekler.
`png` çıktıyı `base64` görsel olarak ekler.
`none` çıktıyı gizler.

örnek:

    ```gnuplot {cmd=true output="html"}
    set terminal svg
    set title "Simple Plots" font ",20"
    set key left box
    set samples 50
    set style data points

    plot [-10:10] sin(x),atan(x),cos(atan(x))
    ```

![screen shot 2017-07-28 at 7 14 24 am](https://user-images.githubusercontent.com/1908863/28716734-66142a5e-7364-11e7-83dc-a66df61971dc.png)

**args**
Komuta eklenen argümanlar. örnek:

    ```python {cmd=true args=["-v"]}
    print("Verbose önce yazdırılacak")
    ```

    ```erd {cmd=true args=["-i", "$input_file", "-f", "svg"] output="html"}
      # svg biçiminde çıktı ver ve html sonucu olarak ekle.
    ```

**stdin**
`stdin` true olarak ayarlanırsa, kod dosya yerine stdin olarak iletilir.

**hide**
`hide` code chunk'ı gizler ancak yalnızca çıktıyı görünür bırakır. Varsayılan: `false`
örnek:

    ```python {hide=true}
    print('bu çıktı mesajını görebilirsiniz, ancak bu kodu göremezsiniz')
    ```

**continue**
`continue=true` olarak ayarlanırsa, bu code chunk son code chunk'tan devam eder.
`continue=id` olarak ayarlanırsa, bu code chunk id'li code chunk'tan devam eder.
örnek:

    ```python {cmd=true id="izdlk700"}
    x = 1
    ```

    ```python {cmd=true id="izdlkdim"}
    x = 2
    ```

    ```python {cmd=true continue="izdlk700" id="izdlkhso"}
    print(x) # 1 yazdıracak
    ```

**class**
`class="class1 class2"` olarak ayarlanırsa, code chunk'a `class1 class2` eklenir.

- `line-numbers` sınıfı, code chunk'ta satır numaralarını gösterir.

**element**
Sonrasına eklemek istediğiniz öğe.
Aşağıdaki **Plotly** örneğine bakın.

**run_on_save** `boolean`
Markdown dosyası kaydedildiğinde code chunk'ı çalıştırır. Varsayılan `false`.

**modify_source** `boolean`
Code chunk çıktısını doğrudan markdown kaynak dosyasına ekler. Varsayılan `false`.

**id**
Code chunk'ın `id`'si. Bu seçenek `continue` kullanılıyorsa yararlıdır.

## Makro

- **input_file**
  `input_file`, markdown dosyanızla aynı dizinde otomatik olarak oluşturulur ve `input_file`'a kopyalanan kodu çalıştırdıktan sonra silinir.
  Varsayılan olarak, program argümanlarının en sonuna eklenir.
  Ancak, `$input_file` makrosunu kullanarak `args` seçeneğinizdeki `input_file` konumunu ayarlayabilirsiniz. örnek:

      ```program {cmd=true args=["-i", "$input_file", "-o", "./output.png"]}
      ...kodunuz buraya
      ```

## Matplotlib

`matplotlib=true` olarak ayarlanırsa, python code chunk grafikleri önizlemede satır içi olarak çizer.
örnek:

    ```python {cmd=true matplotlib=true}
    import matplotlib.pyplot as plt
    plt.plot([1,2,3, 4])
    plt.show() # şekli göster
    ```

![screen shot 2017-07-28 at 7 12 50 am](https://user-images.githubusercontent.com/1908863/28716704-4009d43a-7364-11e7-9e46-889f961e5afd.png)

## LaTeX

Markdown Preview Enhanced ayrıca `LaTeX` derlemeyi de destekler.
Bu özelliği kullanmadan önce [pdf2svg](extra.md?id=install-svg2pdf) ve [LaTeX motoru](extra.md?id=install-latex-distribution) kurulu olmalıdır.
Ardından LaTeX'i code chunk'a şu şekilde yazabilirsiniz:

    ```latex {cmd=true}
    \documentclass{standalone}
    \begin{document}
      Hello world!
    \end{document}
    ```

![screen shot 2017-07-28 at 7 15 16 am](https://user-images.githubusercontent.com/1908863/28716762-8686d980-7364-11e7-9669-71138cb2e6e7.png)

### LaTeX çıktı yapılandırması

**latex_zoom**
`latex_zoom=num` olarak ayarlanırsa, sonuç `num` kez ölçeklendirilir.

**latex_width**
Sonucun genişliği.

**latex_height**
Sonucun yüksekliği.

**latex_engine**
`tex` dosyasını derlemek için kullanılan latex motoru. Varsayılan olarak `pdflatex` kullanılır.

### TikZ örneği

`tikz` grafikleri çizerken `standalone` kullanılması önerilir.
![screen shot 2017-07-14 at 11 27 56 am](https://user-images.githubusercontent.com/1908863/28221069-8113a5b0-6887-11e7-82fa-23dd68f2be82.png)

## Plotly

Markdown Preview Enhanced, [Plotly](https://plot.ly/) çizmeyi kolaylaştırır.
Örneğin:
![screen shot 2017-10-20 at 10 41 25 am](https://user-images.githubusercontent.com/1908863/31829580-526a0c06-b583-11e7-82f2-09ea7a0b9672.png)

- İlk satır `@import "https://cdn.plot.ly/plotly-latest.min.js"`, `plotly-latest.min.js` dosyasını içe aktarmak için [dosya içe aktarma](file-imports.md) işlevini kullanır.
  Ancak daha iyi performans için js dosyasını yerel diske indirmeniz önerilir.
- Ardından bir `javascript` code chunk oluşturduk.

## Demo

Bu demo, [erd](https://github.com/BurntSushi/erd) kütüphanesini kullanarak varlık-ilişki diyagramı işlemeyi gösterir.

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

- `erd` kullandığımız program. (_önce programın kurulu olması gerekir_)
- `output="html"` çalışma sonucunu `html` olarak ekleyeceğiz.
- `args` alanı kullanacağımız argümanları gösterir.

Ardından kodu çalıştırmak için önizlemedeki `run` düğmesine tıklayabiliriz.

![erd](https://user-images.githubusercontent.com/1908863/28221395-bcd0bd76-6888-11e7-8c6e-925e228d02cc.gif)

## Vitrinler (güncel değil)

**bash**
![Screen Shot 2016-09-24 at 1.41.06 AM](https://i.imgur.com/v5Y7juh.png)

**svg çıktılı gnuplot**
![Screen Shot 2016-09-24 at 1.44.14 AM](https://i.imgur.com/S93g7Tk.png)

## Sınırlamalar

- `ebook` ile henüz çalışmıyor.
- `pandoc belge dışa aktarma` kullanıldığında hatalı davranabilir.

[➔ Sunum](presentation.md)
