# Markdown Temelleri

Bu makale, [GitHub Flavored Markdown yazımına](https://guides.github.com/features/mastering-markdown/) kısa bir giriş niteliğindedir.

## Markdown Nedir?

`Markdown`, web üzerinde metin biçimlendirme yöntemidir. Belgenin görünümünü siz kontrol edersiniz; kelimeleri kalın veya italik yapmak, görsel eklemek ve liste oluşturmak Markdown ile yapabileceklerinizden yalnızca birkaçıdır. Çoğunlukla Markdown, `#` veya `*` gibi birkaç alfabetik olmayan karakter içeren düz metinden ibarettir.

## Sözdizimi Kılavuzu

### Başlıklar

```markdown
# Bu bir <h1> etiketidir

## Bu bir <h2> etiketidir

### Bu bir <h3> etiketidir

#### Bu bir <h4> etiketidir

##### Bu bir <h5> etiketidir

###### Bu bir <h6> etiketidir
```

Başlığa `id` ve `class` eklemek istiyorsanız, `{#id .class1 .class2}` ifadesini başlığın sonuna ekleyin. Örneğin:

```markdown
# Bu başlığın 1 id'si var {#my_id}

# Bu başlığın 2 sınıfı var {.class1 .class2}
```

> Bu bir MPE genişletilmiş özelliğidir.

### Vurgu

<!-- prettier-ignore -->
```markdown
*Bu metin italik olacak*
_Bu da italik olacak_

**Bu metin kalın olacak**
__Bu da kalın olacak__

_Bunları **birleştirebilirsiniz**_

~~Bu metin üzeri çizili olacak~~
```

### Listeler

#### Sırasız Liste

```markdown
- Öğe 1
- Öğe 2
  - Öğe 2a
  - Öğe 2b
```

#### Sıralı Liste

```markdown
1. Öğe 1
1. Öğe 2
1. Öğe 3
   1. Öğe 3a
   1. Öğe 3b
```

### Görseller

```markdown
![GitHub Logosu](/images/logo.png)
Biçim: ![Alternatif Metin](url)
```

### Bağlantılar

```markdown
https://github.com - otomatik!
[GitHub](https://github.com)
```

### Alıntı

```markdown
Kanye West dedi ki:

> Geleceği yaşıyoruz
> bu yüzden şimdi geçmişimiz.

> [!NOTE]
> Bu bir not alıntısıdır.

> [!WARNING]
> Bu bir uyarı alıntısıdır.
```

### Yatay Çizgi

```markdown
Üç veya daha fazla...

---

Tireler

---

Yıldız işaretleri

---

Alt çizgiler
```

### Satır içi kod

```markdown
Burada
`<addr>` elementi kullanmanız gerektiğini düşünüyorum.
```

### Çitlenmiş kod bloğu

Kod bloğunun önüne ve arkasına üç ters tırnak işareti <code>\`\`\`</code> koyarak çitlenmiş kod bloğu oluşturabilirsiniz.

#### Sözdizimi Vurgulama

Çitlenmiş kod bloğunuzda sözdizimi vurgulamayı etkinleştirmek için isteğe bağlı bir dil tanımlayıcısı ekleyebilirsiniz.

Örneğin, Ruby kodunu sözdizimi vurgulamak için:

    ```ruby
    require 'redcarpet'
    markdown = Redcarpet.new("Hello World!")
    puts markdown.to_html
    ```

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

#### Kod bloğu sınıfı (MPE genişletilmiş özelliği)

Kod bloklarınıza `class` atayabilirsiniz.

Örneğin, bir kod bloğuna `class1 class2` eklemek için:

    ```javascript {.class1 .class}
    function add(x, y) {
      return x + y
    }
    ```

##### satır numaraları

`line-numbers` sınıfını ekleyerek kod bloğu için satır numarasını etkinleştirebilirsiniz.

Örneğin:

````markdown
```javascript {.line-numbers}
function add(x, y) {
  return x + y;
}
```
````

![screen shot 2017-07-14 at 1 20 27 am](https://user-images.githubusercontent.com/1908863/28200587-a8582b0a-6832-11e7-83a7-6c3bb011322f.png)

##### satır vurgulama

`highlight` özniteliği ekleyerek satırları vurgulayabilirsiniz:

````markdown
```javascript {highlight=10}
```

```javascript {highlight=10-20}
```

```javascript {highlight=[1-10,15,20-22]}
```
````

### Görev Listeleri

```markdown
- [x] @mentions, #refs, [bağlantılar](), **biçimlendirme** ve <del>etiketler</del> desteklenir
- [x] liste sözdizimi gerekli (herhangi bir sıralı veya sırasız liste desteklenir)
- [x] bu tamamlanmış bir öğedir
- [ ] bu tamamlanmamış bir öğedir
```

### Tablolar

Kelimeleri bir liste halinde sıralayıp tireler `-` (ilk satır için) ile bölerek ve her sütunu boru `|` işaretiyle ayırarak tablo oluşturabilirsiniz:

<!-- prettier-ignore -->
```markdown
İlk Başlık | İkinci Başlık
------------ | -------------
Hücre 1 içeriği | Hücre 2 içeriği
Birinci sütun içeriği | İkinci sütun içeriği
```

## Genişletilmiş Sözdizimi

### Tablo

> Çalışması için uzantı ayarlarında `enableExtendedTableSyntax` özelliğinin etkinleştirilmesi gerekir.

![screen shot 2017-07-15 at 8 16 45 pm](https://user-images.githubusercontent.com/1908863/28243710-945e3004-699a-11e7-9a5f-d74f6c944c3b.png)

### Emoji & Font-Awesome

> Bu yalnızca `markdown-it ayrıştırıcısı` için çalışır, `pandoc ayrıştırıcısı` için değil.  
> Varsayılan olarak etkindir. Paket ayarlarından devre dışı bırakabilirsiniz.

```
:smile:
:fa-car:
```

### Üst Simge

```markdown
30^th^
```

### Alt Simge

```markdown
H~2~O
```

### Dipnotlar

```markdown
İçerik [^1]

[^1]: Merhaba! Bu bir dipnottur
```

### Kısaltma

```
*[HTML]: Hiper Metin İşaretleme Dili
*[W3C]: Dünya Çapında Web Konsorsiyumu
HTML spesifikasyonu
W3C tarafından yönetilmektedir.
```

### İşaretleme

```markdown
==işaretlendi==
```

### CriticMarkup

CriticMarkup varsayılan olarak **devre dışıdır**, ancak paket ayarlarından etkinleştirebilirsiniz.  
CriticMarkup hakkında daha fazla bilgi için [CriticMarkup Kullanıcı Kılavuzu](https://criticmarkup.com/users-guide.php)'na bakın.

Beş tür Critic işareti vardır:

- Ekleme `{++ ++}`
- Silme `{-- --}`
- Değiştirme `{~~ ~> ~~}`
- Yorum `{>> <<}`
- Vurgulama `{== ==}{>> <<}`

> CriticMarkup yalnızca markdown-it ayrıştırıcısıyla çalışır, pandoc ayrıştırıcısıyla değil.

### Uyarı Kutusu

```
!!! note Bu uyarı kutusunun başlığı
    Bu uyarı kutusunun gövdesi
```

> Daha fazla bilgi için lütfen https://squidfunk.github.io/mkdocs-material/reference/admonitions/ adresine bakın.

## Kaynaklar

- [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
- [Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)

[➔ Matematik](math.md)
