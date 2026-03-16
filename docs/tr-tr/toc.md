# İçindekiler Tablosu

**Markdown Preview Enhanced**, markdown dosyanız için `TOC` oluşturabilir.
<kbd>cmd-shift-p</kbd> tuşlarına basıp `Markdown Preview Enhanced: Create Toc` seçeneğini seçerek `TOC` oluşturabilirsiniz.
Birden fazla TOC oluşturulabilir.
Bir başlığı `TOC`'tan hariç tutmak için başlığınızın **sonuna** `{ignore=true}` ekleyin.

![screen shot 2018-03-14 at 12 03 00 pm](https://user-images.githubusercontent.com/1908863/37418218-bb624e62-277f-11e8-88f5-8747a1c2e012.png)

> TOC, markdown dosyasını kaydettiğinizde güncellenecektir.
> TOC'un güncellenmesi için önizlemenin açık kalması gerekir.

## Yapılandırma

- **orderedList**
  Sıralı liste kullanılıp kullanılmayacağı.
- **depthFrom**, **depthTo**
  `[1~6]` dahil.
- **ignoreLink**
  `true` olarak ayarlanırsa, TOC girdileri köprü bağlantısı olmayacaktır.

## [TOC]

Markdown dosyanıza `[TOC]` ekleyerek de `TOC` oluşturabilirsiniz.
Örneğin:

```markdown
[TOC]

# Başlık 1

## Başlık 2 {ignore=true}

Başlık 2, TOC'tan hariç tutulacaktır.
```

Ancak, **bu yöntem TOC'u yalnızca önizlemede gösterir**, editör içeriği değişmeden kalır.

## [TOC] ve Kenar Çubuğu TOC Yapılandırması

`[TOC]` ve kenar çubuğu TOC'u front-matter yazarak yapılandırabilirsiniz:

```markdown
---
toc:
  depth_from: 1
  depth_to: 6
  ordered: false
---
```

[➔ Dosya İçe Aktarma](file-imports.md)
