# CSS Özelleştirme

## style.less

Markdown dosyanız için CSS'i özelleştirmek için <kbd>cmd-shift-p</kbd> tuşlarına basın ve `Markdown Preview Enhanced: Customize CSS (Global)` veya `Markdown Preview Enhanced: Customize CSS (Workspace)` komutunu çalıştırın.

`style.less` dosyası açılacak ve mevcut stili şu şekilde geçersiz kılabilirsiniz:

```less
.markdown-preview.markdown-preview {
  // lütfen özel stilinizi buraya yazın
  // örnek:
  //  color: blue;          // yazı tipi rengini değiştir
  //  font-size: 14px;      // yazı tipi boyutunu değiştir
  // özel pdf çıktısı stili
  @media print {
  }

  // özel prince pdf dışa aktarma stili
  &.prince {
  }

  // özel sunum stili
  .reveal .slides {
    // tüm slaytları değiştir
  }

  .slides > section:nth-child(1) {
    // bu `birinci slaydı` değiştirecek
  }
}

.md-sidebar-toc.md-sidebar-toc {
  // kenar çubuğu TOC stili
}
```

## Yerel Stil

Markdown Preview Enhanced ayrıca farklı markdown dosyaları için farklı stiller tanımlamanıza da olanak tanır.  
`id` ve `class`, front-matter içinde yapılandırılabilir.
Markdown dosyanıza kolayca `less` veya `css` dosyası [içe aktarabilirsiniz](file-imports.md):

```markdown
---
id: "my-id"
class: "my-class1 my-class2"
---

@import "my-style.less"

# Başlık1
```

`my-style.less` şu şekilde görünebilir:

```less
#my-id {
  background-color: #222;
  color: #fff;

  h1,
  h2,
  h3,
  h4,
  h5,
  h6 {
    color: #fff;
  }
}
```

`less` dosyanızı her değiştirdiğinizde, less'i css'e yeniden derlemek için önizlemenin sağ üst köşesindeki yenile düğmesine tıklayabilirsiniz.

![](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Yazı Tipi Ailesini Değiştirme

Önizlemenin yazı tipi ailesini değiştirmek için önce yazı tipi dosyasını `(.ttf)` indirmeniz, ardından `style.less`'i aşağıdaki gibi değiştirmeniz gerekir:

```less
@font-face {
  font-family: "your-font-family";
  src: url("your-font-file-url");
}

.markdown-preview.markdown-preview {
  font-family: "your-font-family", sans-serif;

  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  pre,
  code {
    font-family: "your-font-family", sans-serif;
  }
}
```

> Ancak Google Fonts gibi çevrimiçi yazı tipleri kullanmanız önerilir.
