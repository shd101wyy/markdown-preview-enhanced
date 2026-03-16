# Pandoc

**Markdown Preview Enhanced**, `RStudio Markdown`'a benzer şekilde çalışan `pandoc belge dışa aktarma` özelliğini destekler.  
Bu özelliği kullanmak için [pandoc](https://pandoc.org/)'un kurulu olması gerekir.  
Pandoc kurulum talimatları [burada](https://pandoc.org/installing.html) bulunabilir.  
Önizlemede sağ tıklayarak `pandoc belge dışa aktarma` özelliğini kullanabilir, bağlam menüsünde görebilirsiniz.

---

## Pandoc Ayrıştırıcısı

Varsayılan olarak **Markdown Preview Enhanced**, markdown'ı ayrıştırmak için [markdown-it](https://github.com/markdown-it/markdown-it) kullanır.  
Paket ayarlarından `pandoc` ayrıştırıcısına da geçebilirsiniz.

![Screen Shot 2017-03-07 at 10.05.25 PM](https://i.imgur.com/NdCJBgR.png)

Front-matter yazarak bireysel dosyalar için pandoc argümanları da ayarlayabilirsiniz:

```markdown
---
pandoc_args: ["--toc", "--toc-depth=2"]
---
```

Front-matter'da `references` veya `bibliography` varsa `--filter=pandoc-citeproc` otomatik olarak eklenecektir.

**Dikkat**: Bu özellik hâlâ deneyseldir. Sorun veya öneri bildirmekten çekinmeyin.  
**Bilinen Sorunlar ve Sınırlamalar**:

1. `ebook` dışa aktarımında sorun var.
2. `Code Chunk` zaman zaman hatalı davranıyor.

## Front-Matter

`pandoc belge dışa aktarma`, `front-matter` yazılmasını gerektirir.  
`front-matter` yazımı hakkında daha fazla bilgi ve eğitim [burada](https://jekyllrb.com/docs/frontmatter/) bulunabilir.

## Dışa Aktarma

Dosyaları dışa aktarmak için yukarıda bahsettiğim `Pandoc Ayrıştırıcısı`'nı kullanmak zorunda değilsiniz.

Aşağıdaki biçimler şu anda desteklenmektedir; **gelecekte daha fazla biçim desteklenecektir.**  
(Bazı örnekler [RStudio Markdown](https://rmarkdown.rstudio.com/formats.html)'dan alınmıştır)  
Dışa aktarmak istediğiniz belge biçimini görmek için aşağıdaki bağlantıya tıklayın.

- [PDF](pandoc-pdf.md)
- [Word](pandoc-word.md)
- [RTF](pandoc-rtf.md)
- [Beamer](pandoc-beamer.md)

Kendi özel belgenizi de tanımlayabilirsiniz:

- [özel](pandoc-custom.md)

## Kayıtta dışa aktar

Aşağıdaki gibi front-matter ekleyin:

```yaml
---
export_on_save:
  pandoc: true
---

```

Böylece markdown kaynak dosyanızı her kaydettiğinizde pandoc çalışacaktır.

## Makaleler

- [Kaynakça ve Atıflar](pandoc-bibliographies-and-citations.md)

## Dikkat

`mermaid, wavedrom`, `pandoc belge dışa aktarma` ile çalışmayacaktır.  
[code chunk](code-chunk.md), `pandoc belge dışa aktarma` ile kısmen uyumludur.
