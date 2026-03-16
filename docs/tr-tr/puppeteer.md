# Chrome (Puppeteer) Dışa Aktarma

## Kurulum

[Chrome tarayıcısının](https://www.google.com/chrome/) kurulu olması gerekir.

> `chromePath` adlı bir uzantı ayarı, chrome çalıştırılabilir dosyasının yolunu belirtmenize olanak tanır. Varsayılan olarak değiştirmeniz gerekmez. MPE uzantısı yolu otomatik olarak bulacaktır.

## Kullanım

Önizlemede sağ tıklayın, ardından `Chrome (Puppeteer)` seçeneğini seçin.

## Puppeteer'ı yapılandırma

[PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions) ve [Ekran Görüntüsü](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions) dışa aktarma yapılandırmasını front-matter içinde yazabilirsiniz. Örneğin:

```yaml
---
puppeteer:
  landscape: true
  format: "A4"
  timeout: 3000 # <= Özel yapılandırma, 3000 ms bekle anlamına gelir
---

```

## Kayıtta dışa aktar

```yaml
---
export_on_save:
    puppeteer: true # kayıtta PDF dışa aktar
    puppeteer: ["pdf", "png"] # kayıtta PDF ve PNG dosyalarını dışa aktar
    puppeteer: ["png"] # kayıtta PNG dosyasını dışa aktar
---
```

## CSS Özelleştirme

<kbd>cmd-shift-p</kbd> tuşlarına basın ve `Markdown Preview Enhanced: Customize Css` komutunu çalıştırarak `style.less` dosyasını açın, ardından aşağıdaki satırları ekleyin ve değiştirin:

```less
.markdown-preview.markdown-preview {
  @media print {
    // kodunuz buraya
  }
}
```
