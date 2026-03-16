# Özel Belge

## Genel Bakış

**Özel Belge**, `pandoc`'un tüm gücünden yararlanmanızı sağlar.  
Özel bir belge oluşturmak için belgenizin front-matter bölümünde `custom_document` çıktı biçimini belirtmeniz ve **`path` tanımlanmış olması** gerekir.

Aşağıdaki kod örneği [pdf belgesi](pdf.md)'ne benzer şekilde davranacaktır.

```yaml
---
title: "Alışkanlıklar"
author: John Doe
date: 22 Mart 2005
output:
  custom_document:
    path: /Exports/test.pdf
    toc: true
---

```

Aşağıdaki kod örneği [beamer sunumu](pandoc-beamer.md)'na benzer şekilde davranacaktır.

```yaml
---
title: "Alışkanlıklar"
author: John Doe
date: 22 Mart 2005
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["-t", "beamer"]
---

```

## Pandoc Argümanları

Yukarıda açıklanan YAML seçeneklerinde karşılığı olmayan pandoc özelliklerini kullanmak istiyorsanız özel `pandoc_args` ileterek bunları kullanabilirsiniz. Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Paylaşılan Seçenekler

Bir dizin içindeki birden fazla belge tarafından paylaşılacak varsayılan seçenekler belirtmek istiyorsanız, dizin içine `_output.yaml` adlı bir dosya ekleyebilirsiniz. Bu dosyada YAML sınırlayıcı veya çevreleyici output nesnesi kullanılmadığına dikkat edin. Örneğin:

**\_output.yaml**

```yaml
custom_document:
  toc: true
  highlight: zenburn
```

`_output.yaml` ile aynı dizinde bulunan tüm belgeler seçeneklerini devralır. Belgeler içinde açıkça tanımlanan seçenekler, paylaşılan seçenekler dosyasında belirtilenleri geçersiz kılar.
