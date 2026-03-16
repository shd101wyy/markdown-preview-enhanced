# Kaynakça ve Atıflar

## Kaynakça

### Kaynakça Dosyası Belirtme

[Pandoc](https://pandoc.org/MANUAL.html#citations), çeşitli stillerde atıfları ve kaynakçayı otomatik olarak oluşturabilir. Bu özelliği kullanmak için YAML meta veri bölümünde `bibliography` meta veri alanını kullanarak bir kaynakça dosyası belirtmeniz gerekir. Örneğin:

```yaml
---
title: "Örnek Belge"
output: pdf_document
bibliography: bibliography.bib
---

```

Birden fazla kaynakça dosyası ekliyorsanız şu şekilde tanımlayabilirsiniz:

```yaml
---
bibliography: [bibliography1.bib, bibliography2.bib]
---

```

Kaynakça şu biçimlerde olabilir:

| Biçim       | Dosya uzantısı |
| ----------- | -------------- |
| BibLaTeX    | .bib           |
| BibTeX      | .bibtex        |
| Copac       | .copac         |
| CSL JSON    | .json          |
| CSL YAML    | .yaml          |
| EndNote     | .enl           |
| EndNote XML | .xml           |
| ISI         | .wos           |
| MEDLINE     | .medline       |
| MODS        | .mods          |
| RIS         | .ris           |

### Satır İçi Referanslar

Alternatif olarak, belgenin YAML meta verilerinde bir `references` alanı kullanabilirsiniz. Bu, YAML kodlu referanslardan oluşan bir dizi içermelidir. Örneğin:

```yaml
---
references:
  - id: fenner2012a
    title: One-click science marketing
    author:
      - family: Fenner
        given: Martin
    container-title: Nature Materials
    volume: 11
    URL: "https://dx.doi.org/10.1038/nmat3283"
    DOI: 10.1038/nmat3283
    issue: 4
    publisher: Nature Publishing Group
    page: 261-263
    type: article-journal
    issued:
      year: 2012
      month: 3
---

```

### Kaynakça Yerleşimi

Kaynakçalar belgenin sonuna yerleştirilecektir. Normalde, belgenizi uygun bir başlıkla sonlandırmak istersiniz:

```markdown
son paragraf...

# Kaynakça
```

Kaynakça bu başlığın ardına eklenecektir.

## Atıflar

### Atıf Sözdizimi

Atıflar köşeli parantezlerin içine girer ve noktalı virgülle ayrılır. Her atıfın veritabanından '@' + atıf tanımlayıcısından oluşan bir anahtarı olmalı ve isteğe bağlı olarak önek, bulucu ve sonek içerebilir. İşte bazı örnekler:

```
Blah blah [bkz. @doe99, ss. 33-35; ayrıca @smith04, böl. 1].

Blah blah [@doe99, ss. 33-35, 38-39 ve *passim*].

Blah blah [@smith04; @doe99].
```

`@`'dan önce eksi işareti `(-)` atıftaki yazar adından bahsedilmesini engeller. Bu, yazar zaten metinde belirtilmişse kullanışlı olabilir:

```
Smith diyor ki [-@smith04].
```

Ayrıca metinde atıf da yazabilirsiniz:

```
@smith04 diyor ki blah.

@smith04 [s. 33] diyor ki blah.
```

### Kullanılmayan Referanslar (nocite)

Belge gövdesinde gerçekte atıf yapmadan kaynakçaya öğe eklemek istiyorsanız, sahte bir `nocite` meta veri alanı tanımlayıp atıfları oraya koyabilirsiniz:

```
---
nocite: |
  @item1, @item2
...

@item3
```

Bu örnekte, belge yalnızca `item3` için bir atıf içerecek, ancak kaynakça `item1`, `item2` ve `item3` için girişler içerecektir.

### Atıf Stilleri

Varsayılan olarak pandoc, atıflar ve referanslar için Chicago yazar-tarih biçimini kullanır. Başka bir stil kullanmak için `csl` meta veri alanında bir CSL 1.0 stil dosyası belirtmeniz gerekir. Örneğin:

```yaml
---
title: "Örnek Belge"
output: pdf_document
bibliography: bibliography.bib
csl: biomed-central.csl
---

```

CSL stilleri oluşturma ve değiştirme hakkında bir rehber [burada](https://citationstyles.org/downloads/primer.html) bulunabilir. CSL stillerinin bir deposu [burada](https://github.com/citation-style-language/styles) bulunabilir. Kolay göz atma için https://zotero.org/styles adresine de bakın.

### PDF Çıktısı için Atıflar

Varsayılan olarak, atıflar pandoc-citeproc yardımcı programı tarafından oluşturulur ve tüm çıktı biçimleri için çalışır. Çıktı LaTeX/PDF olduğunda, atıflar oluşturmak için LaTeX paketlerini (örn. natbib) de kullanabilirsiniz; ayrıntılar için [PDF belgelerine](pandoc-pdf.md) bakın.
