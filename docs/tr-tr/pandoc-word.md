# Word Belgesi

## Genel Bakış

Bir Word belgesi oluşturmak için belgenizin front-matter bölümünde word_document çıktı biçimini belirtmeniz gerekir:

```yaml
---
title: "Alışkanlıklar"
author: John Doe
date: 22 Mart 2005
output: word_document
---

```

## Dışa Aktarma Yolu

`path` seçeneğini belirterek belge dışa aktarma yolunu tanımlayabilirsiniz. Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  word_document:
    path: /Exports/Habits.docx
---

```

`path` tanımlanmamışsa, belge aynı dizin altında oluşturulur.

## Sözdizimi Vurgulama

Sözdizimi vurgulama temasını kontrol etmek için `highlight` seçeneğini kullanabilirsiniz. Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  word_document:
    highlight: "tango"
---

```

## Stil Referansı

Bir docx dosyası üretirken belirtilen dosyayı stil referansı olarak kullanın. En iyi sonuçlar için, referans docx, pandoc kullanılarak üretilmiş bir docx dosyasının değiştirilmiş bir sürümü olmalıdır. Referans docx'un içeriği göz ardı edilir, ancak stil sayfaları ve belge özellikleri (kenar boşlukları, sayfa boyutu, üstbilgi ve altbilgi dahil) yeni docx'ta kullanılır. Komut satırında hiçbir referans docx belirtilmemişse, pandoc kullanıcı veri dizininde `reference.docx` adlı bir dosya arar (--data-dir bölümüne bakın). Bu da bulunamazsa, makul varsayılanlar kullanılır.

```yaml
---
title: "Alışkanlıklar"
output:
  word_document:
    reference_docx: mystyles.docx
---

```

## Pandoc Argümanları

Yukarıda açıklanan YAML seçeneklerinde karşılığı olmayan pandoc özelliklerini kullanmak istiyorsanız özel `pandoc_args` ileterek bunları kullanabilirsiniz. Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  word_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## Paylaşılan Seçenekler

Bir dizin içindeki birden fazla belge tarafından paylaşılacak varsayılan seçenekler belirtmek istiyorsanız, dizin içine `_output.yaml` adlı bir dosya ekleyebilirsiniz. Bu dosyada YAML sınırlayıcı veya çevreleyici output nesnesi kullanılmadığına dikkat edin. Örneğin:

**\_output.yaml**

```yaml
word_document:
  highlight: zenburn
```

`_output.yaml` ile aynı dizinde bulunan tüm belgeler seçeneklerini devralır. Belgeler içinde açıkça tanımlanan seçenekler, paylaşılan seçenekler dosyasında belirtilenleri geçersiz kılar.
