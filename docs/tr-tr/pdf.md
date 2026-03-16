# PDF Dışa Aktarma

> PDF dışa aktarmak için [Chrome (Puppeteer) kullanmanızı](puppeteer.md) öneririz.

## Kullanım

Önizlemede sağ tıklayın, ardından `Open in Browser` seçeneğini seçin.
Tarayıcıdan PDF olarak yazdırın.

![screen shot 2017-07-14 at 1 46 39 am](https://user-images.githubusercontent.com/1908863/28201366-536dbc0a-6836-11e7-866f-db9a5d12de16.png)

## CSS Özelleştirme

<kbd>cmd-shift-p</kbd> tuşlarına basın ve `Markdown Preview Enhanced: Customize Css` komutunu çalıştırarak `style.less` dosyasını açın, ardından aşağıdaki satırları ekleyin ve değiştirin:

```less
.markdown-preview.markdown-preview {
  @media print {
    // kodunuz buraya
  }
}
```

---

[puppeteer](puppeteer.md) veya [prince](prince.md) kullanarak da PDF dosyası oluşturabilirsiniz.
