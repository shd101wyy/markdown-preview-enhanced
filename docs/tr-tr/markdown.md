# Markdown Olarak Kaydet

**Markdown Preview Enhanced**, **GitHub Flavored Markdown**'a derlemeyi destekler; böylece dışa aktarılan markdown dosyası tüm grafikleri (png görseli olarak), code chunk'ları (gizle ve yalnızca sonuçları dahil et), matematik dizgilerini (görsel olarak göster) vb. içerecek ve GitHub'da yayımlanabilecektir.

## Kullanım

Önizlemede sağ tıklayın, ardından `Save as Markdown` seçeneğini seçin.

## Yapılandırma

Front-matter ile görsel dizinini ve çıktı yolunu yapılandırabilirsiniz:

```yaml
---
markdown:
  image_dir: /assets
  path: output.md
  ignore_from_front_matter: true
  absolute_image_path: false
---

```

**image_dir** `isteğe bağlı`  
Oluşturulan görsellerin kaydedileceği yeri belirtir. Örneğin, `/assets` tüm görsellerin proje klasörü altındaki `assets` dizinine kaydedileceği anlamına gelir. **image_dir** verilmemişse, paket ayarlarındaki `Image folder path` kullanılacaktır. Varsayılan `/assets`'tir.

**path** `isteğe bağlı`  
Markdown dosyanızın çıktısını almak istediğiniz yeri belirtir. **path** belirtilmemişse, `filename_.md` hedef olarak kullanılacaktır.

**ignore_from_front_matter** `isteğe bağlı`  
`false` olarak ayarlanırsa, `markdown` alanı front-matter'a dahil edilecektir.

**absolute_image_path** `isteğe bağlı`  
Mutlak veya göreli görsel yolu kullanılıp kullanılmayacağını belirler.

## Kayıtta dışa aktar

Aşağıdaki gibi front-matter ekleyin:

```yaml
---
export_on_save:
  markdown: true
---

```

Böylece markdown kaynak dosyanızı her kaydettiğinizde markdown dosyası oluşturulacaktır.

## Bilinen Sorunlar

- `WaveDrom` henüz çalışmıyor.
- Matematik dizgisi görünümü hatalı olabilir.
- `latex` code chunk ile henüz çalışmıyor.
