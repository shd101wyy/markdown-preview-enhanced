# eBook Oluşturma

_GitBook_'tan ilham alınmıştır.  
**Markdown Preview Enhanced**, içeriği e-kitap (ePub, Mobi, PDF) olarak çıktı alabilir.

![Screen Shot 2016-09-08 at 9.42.43 PM](https://ooo.0o0.ooo/2016/09/09/57d221c0a618a.png)

E-kitap oluşturmak için `ebook-convert` kurulu olmalıdır.

## ebook-convert Kurulumu

**macOS**  
[Calibre Uygulamasını](https://calibre-ebook.com/download) indirin. `calibre.app` dosyasını Uygulamalar klasörünüze taşıdıktan sonra `ebook-convert` aracına sembolik bağlantı oluşturun:

```shell
$ sudo ln -s ~/Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin
```

**Windows**  
[Calibre Uygulamasını](https://calibre-ebook.com/download) indirin ve kurun.  
`ebook-convert`'i `$PATH`'inize ekleyin.

## eBook Örneği

Bir e-kitap örnek projesi [burada](https://github.com/shd101wyy/ebook-example) bulunabilir.

## e-Kitap Yazmaya Başlama

Markdown dosyanıza `ebook front-matter` ekleyerek e-kitap yapılandırması kurabilirsiniz.

```yaml
---
ebook:
  theme: github-light.css
  title: Benim e-Kitabım
  authors: shd101wyy
---

```

---

## Demo

`SUMMARY.md` örnek bir giriş dosyasıdır. Kitabı düzenlemeye yardımcı olacak bir TOC içermelidir:

```markdown
---
ebook:
  theme: github-light.css
  title: Markdown Preview Enhanced
  author: shd101wyy
---

# Önsöz

Bu önsözdür, zorunlu değildir.

# İçindekiler

- [Bölüm 1](/chapter1/README.md)
  - [Markdown Preview Enhanced Tanıtımı](/chapter1/intro.md)
  - [Özellikler](/chapter1/feature.md)
- [Bölüm 2](/chapter2/README.md)
  - [Bilinen sorunlar](/chapter2/issues.md)
```

Markdown dosyasındaki son liste TOC olarak kabul edilir.

Bağlantının başlığı, bölümün başlığı olarak kullanılır ve bağlantının hedefi ilgili bölüm dosyasının yoludur.

---

E-kitabı dışa aktarmak için önizleme açıkken `SUMMARY.md`'yi açın. Ardından önizlemede sağ tıklayın, `Export to Disk` seçeneğini ve ardından `EBOOK` seçeneğini seçin. E-kitabınızı dışa aktarabilirsiniz.

### Meta Veriler

- **theme**
  e-Kitap için kullanılacak tema, varsayılan olarak önizleme teması kullanılır. Mevcut temaların listesi [bu belgede](https://github.com/shd101wyy/crossnote/#notebook-configuration) `previewTheme` bölümünde bulunabilir.
- **title**  
  kitabınızın başlığı
- **authors**  
  yazar1 & yazar2 & ...
- **cover**  
  https://path-to-image.png
- **comments**  
  e-kitap açıklamasını ayarlar
- **publisher**  
  yayıncı kim?
- **book-producer**  
  kitap üreticisi kim?
- **pubdate**  
  yayın tarihi
- **language**  
  Dili ayarlar
- **isbn**  
  Kitabın ISBN'si
- **tags**  
  Kitap etiketlerini ayarlar. Virgülle ayrılmış liste olmalıdır.
- **series**  
  Bu e-kitabın ait olduğu seriyi ayarlar.
- **rating**  
  Puanı ayarlar. 1 ile 5 arasında bir sayı olmalıdır.
- **include_toc**  
  `varsayılan: true` Giriş dosyanızda yazdığınız TOC'un dahil edilip edilmeyeceği.

Örneğin:

```yaml
ebook:
  title: Benim e-Kitabım
  author: shd101wyy
  rating: 5
```

### Görünüm ve His

Çıktının görünümünü ve hissini kontrol etmeye yardımcı olmak için aşağıdaki seçenekler sunulmaktadır:

- **asciiize** `[true/false]`  
  `varsayılan: false`, Unicode karakterleri ASCII gösterimine dönüştürür. Dikkatli kullanın çünkü bu unicode karakterleri ASCII ile değiştirecektir.
- **base-font-size** `[number]`  
  Punto cinsinden temel yazı tipi boyutu. Üretilen kitaptaki tüm yazı tipi boyutları bu boyuta göre yeniden ölçeklendirilir. Daha büyük bir boyut seçerek çıktıdaki yazı tiplerini büyütebilir ve tam tersini yapabilirsiniz. Varsayılan olarak, temel yazı tipi boyutu seçtiğiniz çıktı profiline göre belirlenir.
- **disable-font-rescaling** `[true/false]`  
  `varsayılan: false` Yazı tipi boyutlarının tüm yeniden ölçeklendirmesini devre dışı bırakır.
- **line-height** `[number]`  
  Punto cinsinden satır yüksekliği. Ardışık metin satırları arasındaki aralığı kontrol eder. Yalnızca kendi satır yüksekliğini tanımlamayan öğelere uygulanır. Çoğu durumda, minimum satır yüksekliği seçeneği daha kullanışlıdır. Varsayılan olarak satır yüksekliği manipülasyonu yapılmaz.
- **margin-top** `[number]`  
  `varsayılan: 72.0` Punto cinsinden üst kenar boşluğunu ayarlar. Varsayılan 72'dir. Bunu sıfırdan küçük bir değere ayarlamak kenar boşluğunun ayarlanmamasına neden olur (orijinal belgedeki kenar boşluğu ayarı korunacaktır). Not: 72 punto 1 inç'e eşittir.
- **margin-right** `[number]`  
  `varsayılan: 72.0`
- **margin-bottom** `[number]`  
  `varsayılan: 72.0`
- **margin-left** `[number]`  
  `varsayılan: 72.0`
- **margin** `[number/array]`  
  `varsayılan: 72.0`  
  **margin top/right/bottom/left** değerlerini aynı anda tanımlayabilirsiniz. Örneğin:

```yaml
ebook:
  margin: 5 # margin-top = margin-right = margin-bottom = margin-left = 5
```

```yaml
ebook:
  margin: [4, 8] # margin-top = margin-bottom = 4, margin-left = margin-right = 8
```

```yaml
ebook:
  margin: [1, 2, 3, 4] # margin-top=1, margin-right=2, margin-bottom=3, margin-left=4
```

Örneğin:

```yaml
ebook:
  title: Benim e-Kitabım
  base-font-size: 8
  margin: 72
```

## Çıktı Biçimleri

Şu anda e-kitabı `ePub`, `mobi`, `pdf`, `html` biçimlerinde çıktı alabilirsiniz.

### ePub

`ePub` çıktısını yapılandırmak için `ebook`'un ardından `epub` ekleyin.

```yaml
---
ebook:
  epub:
    no-default-epub-cover: true
    pretty-print: true
---

```

aşağıdaki seçenekler sunulmaktadır:

- **no-default-epub-cover** `[true/false]`  
  Normalde, giriş dosyasının kapağı yoksa ve siz belirtmezseniz, başlık, yazarlar vb. içeren varsayılan bir kapak oluşturulur. Bu seçenek bu kapağın oluşturulmasını devre dışı bırakır.
- **no-svg-cover** `[true/false]`  
  Kitap kapağı için SVG kullanmayın. Bu seçeneği, EPUB'unuzun iPhone veya JetBook Lite gibi SVG'yi desteklemeyen bir cihazda kullanılacak olması durumunda kullanın. Bu seçenek olmadan, bu cihazlar kapağı boş sayfa olarak görüntüler.
- **pretty-print** `[true/false]`  
  Belirtilirse, çıktı eklentisi mümkün olduğunca insan tarafından okunabilir çıktı oluşturmaya çalışır. Bazı çıktı eklentileri için hiçbir etkisi olmayabilir.

### PDF

`pdf` çıktısını yapılandırmak için `ebook`'un ardından `pdf` ekleyin.

```yaml
ebook:
  pdf:
    paper-size: letter
    default-font-size: 12
    header-template: "<span> Written by shd101wyy _PAGENUM_ </span>"
```

aşağıdaki seçenekler sunulmaktadır:

- **paper-size**  
  Kağıt boyutu. Bu boyut, varsayılan olmayan bir çıktı profili kullanıldığında geçersiz kılınır. Varsayılan letter'dır. Seçenekler: `a0`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `b0`, `b1`, `b2`, `b3`, `b4`, `b5`, `b6`, `legal`, `letter`.
- **default-font-size** `[number]`  
  Varsayılan yazı tipi boyutu.
- **footer-template**  
  Her sayfada altbilgi oluşturmak için kullanılan HTML şablonu. `_PAGENUM_`, `_TITLE_`, `_AUTHOR_` ve `_SECTION_` dizeleri mevcut değerleriyle değiştirilecektir.
- **header-template**  
  Her sayfada üstbilgi oluşturmak için kullanılan HTML şablonu. `_PAGENUM_`, `_TITLE_`, `_AUTHOR_` ve `_SECTION_` dizeleri mevcut değerleriyle değiştirilecektir.
- **page-numbers** `[true/false]`  
  `varsayılan: false`  
  Oluşturulan PDF dosyasındaki her sayfanın altına sayfa numaraları ekler. Bir altbilgi şablonu belirtirseniz, bu seçeneğe göre öncelikli olur.
- **pretty-print** `[true/false]`  
  Belirtilirse, çıktı eklentisi mümkün olduğunca insan tarafından okunabilir çıktı oluşturmaya çalışır. Bazı çıktı eklentileri için hiçbir etkisi olmayabilir.

### HTML

`.html` dışa aktarımı `ebook-convert`'e bağlı değildir.  
`.html` dosyası dışa aktarıyorsanız, tüm yerel görseller tek bir `html` dosyası içinde `base64` verisi olarak dahil edilecektir.  
`html` çıktısını yapılandırmak için `ebook`'un ardından `html` ekleyin.

```yaml
ebook:
  html:
    cdn: true
```

- **cdn**  
  CSS ve JavaScript dosyalarını `cdn.js`'den yükler. Bu seçenek yalnızca `.html` dosyası dışa aktarılırken kullanılır.

## ebook-convert Argümanları

Yukarıda açıklanan YAML seçeneklerinde karşılığı olmayan `ebook-convert` özelliklerini kullanmak istiyorsanız özel `args` ileterek bunları kullanabilirsiniz. Örneğin:

```yaml
---
ebook:
  title: Benim e-Kitabım
  args: ["--embed-all-fonts", "--embed-font-family"]
---

```

Argümanların listesini [ebook-convert kılavuzunda](https://manual.calibre-ebook.com/generated/en/ebook-convert.html) bulabilirsiniz.

## Kayıtta dışa aktar

Aşağıdaki gibi front-matter ekleyin:

```yaml
---
export_on_save:
  ebook: true
  // veya
  ebook: "epub"
  ebook: "pdf"
  ebook: "mobi"
  ebook: "html"
  ebook: ["pdf", ...]
---
```

Böylece markdown kaynak dosyanızı her kaydettiğinizde e-kitaplar oluşturulacaktır.

## Bilinen Sorunlar ve Sınırlamalar

- eBook oluşturma hâlâ geliştirme aşamasındadır.
- `mermaid`, `PlantUML` vb. tarafından oluşturulan tüm SVG grafikleri, oluşturulan e-kitapta çalışmayacaktır. Yalnızca `viz` çalışır.
- Matematik Dizgisi için yalnızca **KaTeX** kullanılabilir.  
  Oluşturulan e-kitap dosyası **iBook**'ta matematik ifadelerini düzgün işlemiyor.
- **PDF** ve **Mobi** oluşturma hatalı davranıyor.
- **Code Chunk**, eBook oluşturmayla çalışmıyor.
