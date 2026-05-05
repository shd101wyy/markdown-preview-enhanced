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

### Wiki Bağlantıları (Wikilinks)

> vscode-mpe 0.8.25 / crossnote 0.9.23 sürümünden itibaren kullanılabilir. Obsidian tarzı not bağlantıları.

```markdown
[[Note]]                       <!-- Note 'a bağlantı (varsayılan olarak Note.md olarak çözülür) -->
[[Note|Görüntülenen metin]]    <!-- özel görüntü metni olan bağlantı -->
[[Note#Heading]]               <!-- Note içindeki belirli bir başlığa bağlantı -->
[[Note^block-id]]              <!-- Note içindeki belirli bir ^block-id 'ye bağlantı -->
[[Note#Heading^block-id]]      <!-- başlık + blok referansı birleşimi -->
[[#Heading]]                   <!-- mevcut notta bir başlığa bağlantı -->
[[^block-id]]                  <!-- mevcut notta bir bloğa bağlantı -->
```

Önizlemede gezinmek için herhangi bir wiki bağlantısına tıklayın. Düzenleyicide bağlantıyı takip etmek için alt+tıklayın (macOS'ta Ctrl+tıklayın). Bir wiki bağlantısının üzerine geldiğinizde hedefin içeriği (dosya başı, başlık bölümü veya blok gövdesi — bağlantının işaret ettiği şeye göre) önizlenir.

`[[NewNote]]` 'a tıkladığınızda `NewNote.md` henüz mevcut değilse, dosya `# NewNote` iskeletiyle oluşturulup açılır — Obsidian'ın "tıkla ve oluştur" akışıyla aynı davranış.

Yapılandırma anahtarları (notebook config):

- `wikiLinkTargetFileExtension` (varsayılan `.md`) — bağlantıda uzantı yokken eklenen uzantı. `.md` dışındaki notebook'lar için `.markdown` / `.mdx` / `.qmd` olarak ayarlayın.
- `useGitHubStylePipedLink` (varsayılan `false`) — `true` olduğunda sıralama `[[gösterilen|bağlantı]]` (GitHub tarzı); `false` olduğunda `[[bağlantı|gösterilen]]` (Obsidian / Wikipedia tarzı).

### Not Gömme (`![[…]]`)

`!` öneki, hedefin içeriğini olduğu yere gömer:

```markdown
![[Note]]                      <!-- notun tamamını göm -->
![[Note#Heading]]              <!-- yalnızca o başlık bölümünü göm -->
![[Note^block-id]]             <!-- yalnızca o bloğu göm -->
![[Note|Gösterilecek başlık]]  <!-- özel başlıkla göm -->
![[image.png]]                 <!-- standart görüntü gömme (herhangi bir görüntü uzantısı) -->
```

Özyineleme 3 düzeyde sınırlandırılmıştır — bir gömme döngüsü önizlemeyi şişirmez.

### Blok Referansları (`^block-id`)

Bir paragrafın veya liste öğesinin sonuna `^block-id` ekleyerek onu referans verilebilir bir blok olarak işaretleyin:

```markdown
Bu paragraf referans verilebilir. ^my-block

- Bir liste öğesi de. ^another-block
```

Workspace'in herhangi bir yerinden referans verin:

```markdown
[[Note^my-block]] 'a bakın veya gömün: ![[Note^my-block]]
```

`Markdown Preview Enhanced: Copy Block Reference` komutu (Komut Paleti), imlecin bulunduğu paragraf için bir `^id` üretir (veya mevcut olanı yeniden kullanır) ve panonuza yapıştırmaya hazır bir `[[Note#^id]]` bağlantısı kopyalar.

### Etiketler (Tags)

Gövde metninde `#tag-name` sözdizimi:

```markdown
Bu düşünce #important ve #project/q1 etiketleriyle işaretlenmiştir.
```

- `/` ile **iç içe etiketler**: `#parent/child` ve daha derini (`#a/b/c`).
- Bir satır yalnızca `#` 'lerden oluştuğunda etiketler tetiklenmez (yani `# Başlık`, `## Başlık` vb. çalışmaya devam eder).
- Önizlemede bir etikete tıklayarak o etiketten bahseden tüm notları listeleyen bir Quick Pick açılır.
- `enableTagSyntax` ayarı (varsayılan `true`) özelliği açar/kapar.

## Kaynaklar

- [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
- [Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)

[➔ Matematik](math.md)
