# PDF Belgesi

## Genel Bakış

Bir PDF belgesi oluşturmak için belgenizin front-matter bölümünde `pdf_document` çıktı biçimini belirtmeniz gerekir:

```yaml
---
title: "Alışkanlıklar"
author: John Doe
date: 22 Mart 2005
output: pdf_document
---

```

## Dışa Aktarma Yolu

`path` seçeneğini belirterek belge dışa aktarma yolunu tanımlayabilirsiniz. Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  pdf_document:
    path: /Exports/Habits.pdf
---

```

`path` tanımlanmamışsa, belge aynı dizin altında oluşturulur.

## İçindekiler

`toc` seçeneğini kullanarak içindekiler tablosu ekleyebilir ve `toc_depth` seçeneğini kullanarak uygulanacağı başlık derinliğini belirtebilirsiniz. Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  pdf_document:
    toc: true
    toc_depth: 2
---

```

İçindekiler derinliği açıkça belirtilmezse, varsayılan olarak 3'tür (yani tüm 1, 2 ve 3. seviye başlıklar içindekiler tablosuna dahil edilir).

_Dikkat:_ Bu TOC, **Markdown Preview Enhanced** tarafından oluşturulan `<!-- toc -->`'dan farklıdır.

`number_sections` seçeneğini kullanarak başlıklara bölüm numaralandırması ekleyebilirsiniz:

```yaml
---
title: "Alışkanlıklar"
output:
  pdf_document:
    toc: true
    number_sections: true
---

```

## Sözdizimi Vurgulama

`highlight` seçeneği sözdizimi vurgulama stilini belirtir. Desteklenen stiller: "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn" ve "haddock" (sözdizimi vurgulamayı önlemek için null belirtin):

Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  pdf_document:
    highlight: tango
---

```

## LaTeX Seçenekleri

PDF belgeleri oluşturmak için kullanılan LaTeX şablonunun birçok yönü, üst düzey YAML meta verileri kullanılarak özelleştirilebilir (bu seçeneklerin `output` bölümünün altında değil, başlık, yazar vb. ile birlikte üst düzeyde göründüğüne dikkat edin). Örneğin:

```yaml
---
title: "Q3 2013 Ekin Analizi"
output: pdf_document
fontsize: 11pt
geometry: margin=1in
---

```

Mevcut meta veri değişkenleri:

| Değişken                       | Açıklama                                                                                  |
| ------------------------------ | ----------------------------------------------------------------------------------------- |
| papersize                      | kağıt boyutu, örn. `letter`, `A4`                                                         |
| lang                           | Belge dil kodu                                                                            |
| fontsize                       | Yazı tipi boyutu (örn. 10pt, 11pt, 12pt)                                                  |
| documentclass                  | LaTeX belge sınıfı (örn. article)                                                         |
| classoption                    | documentclass seçeneği (örn. oneside); tekrarlanabilir                                    |
| geometry                       | geometry sınıfı seçenekleri (örn. margin=1in); tekrarlanabilir                            |
| linkcolor, urlcolor, citecolor | İç, dış ve atıf bağlantıları için renk (red, green, magenta, cyan, blue, black)           |
| thanks                         | Belge başlığından sonraki teşekkür dipnotunun içeriğini belirtir.                         |

Daha fazla mevcut değişken [burada](https://pandoc.org/MANUAL.html#variables-for-latex) bulunabilir.

### Atıflar için LaTeX Paketleri

Varsayılan olarak, atıflar tüm çıktı biçimleri için çalışan `pandoc-citeproc` aracılığıyla işlenir. PDF çıktısı için bazen `natbib` veya `biblatex` gibi LaTeX paketlerini kullanmak daha iyi olabilir. Bu paketlerden birini kullanmak için `citation_package` seçeneğini `natbib` veya `biblatex` olarak ayarlayın:

```yaml
---
output:
  pdf_document:
    citation_package: natbib
---

```

## Gelişmiş Özelleştirme

### LaTeX Motoru

Varsayılan olarak PDF belgeler `pdflatex` kullanılarak işlenir. `latex_engine` seçeneğini kullanarak alternatif bir motor belirtebilirsiniz. Mevcut motorlar: "pdflatex", "xelatex" ve "lualatex". Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  pdf_document:
    latex_engine: xelatex
---

```

### Dahil Et

Ek LaTeX yönergeleri ve/veya içerik ekleyerek veya temel pandoc şablonunu tamamen değiştirerek PDF çıktısının daha gelişmiş özelleştirilmesini yapabilirsiniz. Belge başlığına veya belge gövdesinden önce/sonra içerik eklemek için `includes` seçeneğini şu şekilde kullanın:

```yaml
---
title: "Alışkanlıklar"
output:
  pdf_document:
    includes:
      in_header: header.tex
      before_body: doc_prefix.tex
      after_body: doc_suffix.tex
---

```

### Özel Şablonlar

`template` seçeneğini kullanarak temel pandoc şablonunu da değiştirebilirsiniz:

```yaml
---
title: "Alışkanlıklar"
output:
  pdf_document:
    template: quarterly_report.tex
---

```

Şablonlar hakkında daha fazla ayrıntı için [pandoc şablonları](https://pandoc.org/README.html#templates) belgelerine bakın. Ayrıca örnek olarak [varsayılan LaTeX şablonunu](https://github.com/jgm/pandoc-templates/blob/master/default.latex) inceleyebilirsiniz.

### Pandoc Argümanları

Yukarıda açıklanan YAML seçeneklerinde karşılığı olmayan pandoc özelliklerini kullanmak istiyorsanız özel `pandoc_args` ileterek bunları kullanabilirsiniz. Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  pdf_document:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Paylaşılan Seçenekler

Bir dizin içindeki birden fazla belge tarafından paylaşılacak varsayılan seçenekler belirtmek istiyorsanız, dizin içine `_output.yaml` adlı bir dosya ekleyebilirsiniz. Bu dosyada YAML sınırlayıcı veya çevreleyici output nesnesi kullanılmadığına dikkat edin. Örneğin:

**\_output.yaml**

```yaml
pdf_document:
  toc: true
  highlight: zenburn
```

`_output.yaml` ile aynı dizinde bulunan tüm belgeler seçeneklerini devralır. Belgeler içinde açıkça tanımlanan seçenekler, paylaşılan seçenekler dosyasında belirtilenleri geçersiz kılar.
