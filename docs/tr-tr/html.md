# HTML Dışa Aktarma

## Kullanım

Önizlemede sağ tıklayın, `HTML` sekmesine tıklayın.  
Ardından seçin:

- `HTML (offline)`
  Bu HTML dosyasını yalnızca yerel olarak kullanacaksanız bu seçeneği tercih edin.
- `HTML (cdn hosted)`
  HTML dosyanızı uzaktan dağıtmak istiyorsanız bu seçeneği tercih edin.

![screen shot 2017-07-14 at 1 14 28 am](https://user-images.githubusercontent.com/1908863/28200455-d5a12d60-6831-11e7-8572-91d3845ce8cf.png)

## Yapılandırma

Varsayılan değerler:

```yaml
---
html:
  embed_local_images: false
  embed_svg: true
  offline: false
  toc: undefined

print_background: false
---

```

`embed_local_images` `true` olarak ayarlanırsa, tüm yerel görseller `base64` biçiminde gömülecektir.

Kenar çubuğu TOC oluşturmak için vscode veya atom MPE ayarlarında [enableScriptExecution](https://shd101wyy.github.io/markdown-preview-enhanced/#/code-chunk?id=code-chunk) ayarını etkinleştirmeniz gerekir.

`toc` `false` olarak ayarlanırsa, kenar çubuğu TOC devre dışı bırakılacaktır. `toc` `true` olarak ayarlanırsa, kenar çubuğu TOC etkinleştirilecek ve görüntülenecektir. `toc` belirtilmezse, kenar çubuğu TOC etkinleştirilecek ancak görüntülenmeyecektir.

## Kayıtta dışa aktar

Aşağıdaki gibi front-matter ekleyin:

```yaml
---
export_on_save:
  html: true
---

```

Böylece markdown dosyanızı her kaydettiğinizde html dosyası oluşturulacaktır.
