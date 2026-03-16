# Prince PDF Dışa Aktarma

**Markdown Preview Enhanced**, [prince](https://www.princexml.com/) ile pdf dışa aktarmayı destekler.

## Kurulum

[prince](https://www.princexml.com/)'in kurulu olması gerekir.
`macOS` için terminali açın ve aşağıdaki komutu çalıştırın:

```sh
brew install Caskroom/cask/prince
```

## Kullanım

Önizlemede sağ tıklayın, ardından `PDF (prince)` seçeneğini seçin.

![screen shot 2017-07-14 at 1 44 23 am](https://user-images.githubusercontent.com/1908863/28201287-fb5ea8d0-6835-11e7-9bdb-2afb458ee5cc.png)

## CSS Özelleştirme

<kbd>cmd-shift-p</kbd> tuşlarına basın ve `Markdown Preview Enhanced: Customize Css` komutunu çalıştırarak `style.less` dosyasını açın, ardından aşağıdaki satırları ekleyin ve değiştirin:

```less
.markdown-preview.markdown-preview {
  &.prince {
    // prince css'iniz buraya
  }
}
```

Örneğin, sayfa boyutunu `A4 yatay` olarak değiştirmek için:

```less
.markdown-preview.markdown-preview {
  &.prince {
    @page {
      size: A4 landscape;
    }
  }
}
```

Daha fazla bilgi [prince kullanıcı kılavuzunda](https://www.princexml.com/doc/) bulunabilir.
Özellikle [sayfa stilleri](https://www.princexml.com/doc/paged/#page-styles) bölümüne bakın.

## Kayıtta dışa aktar

Aşağıdaki gibi front-matter ekleyin:

```yaml
---
export_on_save:
  prince: true
---

```

Böylece markdown kaynak dosyanızı her kaydettiğinizde PDF dosyası oluşturulacaktır.

## Bilinen Sorunlar

- `KaTeX` ve `MathJax` ile çalışmıyor.
