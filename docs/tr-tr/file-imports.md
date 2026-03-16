# Harici Dosyaları İçe Aktarma

![doc-imports](https://cloud.githubusercontent.com/assets/1908863/22716507/f352a4b6-ed5b-11e6-9bac-88837f111de0.gif)

## Nasıl kullanılır?

Sadece

`@import "your_file"`

kolay, değil mi :)

`<!-- @import "your_file" -->` da geçerlidir.

Ya da

```markdown
- görsel benzeri sözdizimi
  ![](file/path/to/your_file)

- wikilink benzeri sözdizimi
  ![[ file/path/to/your_file ]]
  ![[ my_file ]]
```

## Yenile Düğmesi

Yenile düğmesi artık önizlemenin sağ köşesine eklenmiştir.
Tıklandığında dosya önbelleklerini temizler ve önizlemeyi yeniler.
Görsel önbelleğini temizlemek istediğinizde kullanışlı olabilir. [#144](https://github.com/shd101wyy/markdown-preview-enhanced/issues/144) [#249](https://github.com/shd101wyy/markdown-preview-enhanced/issues/249)

![screen shot 2017-02-07 at 5 48 52 pm](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Desteklenen Dosya Türleri

- `.jpeg(.jpg), .gif, .png, .apng, .svg, .bmp` dosyaları markdown görseli olarak işlenecektir.
- `.csv` dosyaları markdown tablosuna dönüştürülecektir.
- `.mermaid` dosyaları mermaid tarafından işlenecektir.
- `.dot` dosyaları viz.js (graphviz) tarafından işlenecektir.
- `.plantuml(.puml)` dosyaları PlantUML tarafından işlenecektir.
- `.html` dosyaları doğrudan gömülecektir.
- `.js` dosyaları `<script src="your_js"></script>` olarak eklenecektir.
- `.less` ve `.css` dosyaları stil olarak eklenecektir. Şu anda yalnızca yerel `less` dosyası desteklenmektedir. `.css` dosyası `<link rel="stylesheet" href="your_css">` olarak eklenecektir.
- `.pdf` dosyaları `pdf2svg` tarafından `svg` dosyalarına dönüştürülecek ve ardından eklenecektir.
- `markdown` dosyaları ayrıştırılarak doğrudan gömülecektir.
- Diğer tüm dosyalar kod bloğu olarak işlenecektir.

## Görselleri Yapılandırma

```markdown
@import "test.png" {width="300px" height="200px" title="my title" alt="my alt"}

![](test.png){width="300px" height="200px"}

![[ test.png ]]{width="300px" height="200px"}
```

## Çevrimiçi Dosyaları İçe Aktarma

Örneğin:

```markdown
@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"
```

## PDF Dosyasını İçe Aktarma

PDF dosyasını içe aktarmak için [pdf2svg](extra.md)'nin kurulu olması gerekir.
Markdown Preview Enhanced hem yerel hem de çevrimiçi PDF dosyalarını içe aktarmayı destekler.
Ancak büyük PDF dosyalarını içe aktarmanız önerilmez.
Örneğin:

```markdown
@import "test.pdf"
```

### PDF yapılandırması

- **page_no**
  PDF'nin `n.` sayfasını görüntüler. 1 tabanlı dizinleme. Örneğin `{page_no=1}` pdf'nin 1. sayfasını görüntüler.
- **page_begin**, **page_end**
  Dahil. Örneğin `{page_begin=2 page_end=4}`, 2, 3, 4 numaralı sayfaları görüntüler.

## Kod Bloğu Olarak Zorla

```markdown
@import "test.puml" {code_block=true class="line-numbers"}
@import "test.py" {class="line-numbers"}
```

## Kod Bloğu Olarak

```markdown
@import "test.json" {as="vega-lite"}
```

## Belirli Satırları İçe Aktarma

```markdown
@import "test.md" {line_begin=2}
@import "test.md" {line_begin=2 line_end=10}
@import "test.md" {line_end=-4}
```

## Dosyayı Code Chunk Olarak İçe Aktarma

```markdown
@import "test.py" {cmd="python3"}
```

[➔ Code Chunk](code-chunk.md)
