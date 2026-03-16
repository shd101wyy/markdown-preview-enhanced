# RTF Belgesi

## Genel Bakış

R Markdown'dan bir RTF belgesi oluşturmak için belgenizin front-matter bölümünde `rtf_document` çıktı biçimini belirtmeniz gerekir:

```yaml
---
title: "Alışkanlıklar"
author: John Doe
date: 22 Mart 2005
output: rtf_document
---

```

## Dışa Aktarma Yolu

`path` seçeneğini belirterek belge dışa aktarma yolunu tanımlayabilirsiniz. Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  rtf_document:
    path: /Exports/Habits.rtf
---

```

`path` tanımlanmamışsa, belge aynı dizin altında oluşturulur.

## İçindekiler

`toc` seçeneğini kullanarak içindekiler tablosu ekleyebilir ve `toc_depth` seçeneğini kullanarak uygulanacağı başlık derinliğini belirtebilirsiniz. Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  rtf_document:
    toc: true
    toc_depth: 2
---

```

İçindekiler derinliği açıkça belirtilmezse, varsayılan olarak 3'tür (yani tüm 1, 2 ve 3. seviye başlıklar içindekiler tablosuna dahil edilir).

_Dikkat:_ Bu TOC, **Markdown Preview Enhanced** tarafından oluşturulan `<!-- toc -->`'dan farklıdır.

## Pandoc Argümanları

Yukarıda açıklanan YAML seçeneklerinde karşılığı olmayan pandoc özelliklerini kullanmak istiyorsanız özel `pandoc_args` ileterek bunları kullanabilirsiniz. Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  rtf_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## Paylaşılan Seçenekler

Bir dizin içindeki birden fazla belge tarafından paylaşılacak varsayılan seçenekler belirtmek istiyorsanız, dizin içine `_output.yaml` adlı bir dosya ekleyebilirsiniz. Bu dosyada YAML sınırlayıcı veya çevreleyici output nesnesi kullanılmadığına dikkat edin. Örneğin:

**\_output.yaml**

```yaml
rtf_document:
  toc: true
```

`_output.yaml` ile aynı dizinde bulunan tüm belgeler seçeneklerini devralır. Belgeler içinde açıkça tanımlanan seçenekler, paylaşılan seçenekler dosyasında belirtilenleri geçersiz kılar.
