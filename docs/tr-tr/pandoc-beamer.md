# Beamer Belgesi

## Genel Bakış

**Markdown Preview Enhanced**'dan bir Beamer sunumu oluşturmak için belgenizin front-matter bölümünde `beamer_presentation` çıktı biçimini belirtirsiniz.  
`#` ve `##` başlık etiketlerini kullanarak bölümlere ayrılmış bir slayt gösterisi oluşturabilirsiniz (ayrıca yatay çizgi (`----`) kullanarak başlıksız yeni bir slayt oluşturabilirsiniz).  
Örneğin, işte basit bir slayt gösterisi:

```markdown
---
title: "Alışkanlıklar"
author: John Doe
date: 22 Mart 2005
output: beamer_presentation
---

# Sabahleyin

## Kalkmak

- Alarmı kapat
- Yataktan çık

## Kahvaltı

- Yumurta ye
- Kahve iç

# Akşamüzeri

## Akşam Yemeği

- Spagetti ye
- Şarap iç

---

![spagetti resmi](images/spaghetti.jpg)

## Uyumaya Gitmek

- Yatağa gir
- Koyun say
```

## Dışa Aktarma Yolu

`path` seçeneğini belirterek belge dışa aktarma yolunu tanımlayabilirsiniz. Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  beamer_presentation:
    path: /Exports/Habits.pdf
---

```

`path` tanımlanmamışsa, belge aynı dizin altında oluşturulur.

## Aşamalı Maddeler

`incremental` seçeneğini ekleyerek maddeleri aşamalı olarak işleyebilirsiniz:

```yaml
---
output:
  beamer_presentation:
    incremental: true
---

```

Bazı slaytlar için maddeleri aşamalı, diğerleri için değil olarak işlemek istiyorsanız şu sözdizimini kullanabilirsiniz:

```markdown
> - Yumurta ye
> - Kahve iç
```

## Temalar

`theme`, `colortheme` ve `fonttheme` seçeneklerini kullanarak Beamer temalarını belirtebilirsiniz:

```yaml
---
output:
  beamer_presentation:
    theme: "AnnArbor"
    colortheme: "dolphin"
    fonttheme: "structurebold"
---

```

## İçindekiler

`toc` seçeneği, sunumun başında bir içindekiler tablosunun dahil edilmesi gerektiğini belirtir (yalnızca 1. seviye başlıklar içindekiler tablosuna dahil edilecektir). Örneğin:

```yaml
---
output:
  beamer_presentation:
    toc: true
---

```

## Slayt Seviyesi

`slide_level` seçeneği, bireysel slaytları tanımlayan başlık seviyesini belirler. Varsayılan olarak bu, belgede bir yerde içerik ile hemen takip edilen ve başka bir başlık ile değil, hiyerarşideki en yüksek başlık seviyesidir. Bu varsayılan, açık bir `slide_level` belirterek geçersiz kılınabilir:

```yaml
---
output:
  beamer_presentation:
    slide_level: 2
---

```

## Sözdizimi Vurgulama

`highlight` seçeneği sözdizimi vurgulama stilini belirtir. Desteklenen stiller: "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn" ve "haddock" (sözdizimi vurgulamayı önlemek için null belirtin):

Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  beamer_presentation:
    highlight: tango
---

```

## Pandoc Argümanları

Yukarıda açıklanan YAML seçeneklerinde karşılığı olmayan pandoc özelliklerini kullanmak istiyorsanız özel `pandoc_args` ileterek bunları kullanabilirsiniz. Örneğin:

```yaml
---
title: "Alışkanlıklar"
output:
  beamer_presentation:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Paylaşılan Seçenekler

Bir dizin içindeki birden fazla belge tarafından paylaşılacak varsayılan seçenekler belirtmek istiyorsanız, dizin içine `_output.yaml` adlı bir dosya ekleyebilirsiniz. Bu dosyada YAML sınırlayıcı veya çevreleyici output nesnesi kullanılmadığına dikkat edin. Örneğin:

**\_output.yaml**

```yaml
beamer_presentation:
  toc: true
```

`_output.yaml` ile aynı dizinde bulunan tüm belgeler seçeneklerini devralır. Belgeler içinde açıkça tanımlanan seçenekler, paylaşılan seçenekler dosyasında belirtilenleri geçersiz kılar.
