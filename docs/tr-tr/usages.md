# Kullanım

## Komutlar

Atom editöründe <kbd>cmd-shift-p</kbd> tuşlarına basarak <strong>Komut Paleti</strong>'ni açabilirsiniz.

> _Windows_ için <kbd>cmd</kbd> tuşu <kbd>ctrl</kbd>'dir.

_Markdown Kaynağı_

- <strong>Markdown Preview Enhanced: Toggle</strong>  
  <kbd>ctrl-shift-m</kbd>  
  Markdown dosyası önizlemesini aç/kapat.

- <strong>Markdown Preview Enhanced: Toggle Zen Mode </strong>  
  Dikkat dağıtıcı unsurlardan uzak yazma modunu aç/kapat.

- <strong>Markdown Preview Enhanced: Customize Css</strong>  
  Önizleme sayfası CSS'ini özelleştir.  
  Kısa bir [eğitim](customize-css.md) burada bulunabilir.

- <strong>Markdown Preview Enhanced: Create Toc </strong>  
  TOC oluştur (önizlemenin açık olması gerekir). [Belge burada](toc.md).

- <strong>Markdown Preview Enhanced: Toggle Scroll Sync </strong>  
  Önizleme için kaydırma eşitlemeyi etkinleştir/devre dışı bırak.

- <strong>Markdown Preview Enhanced: Sync Source </strong>  
  <kbd>ctrl-shift-s</kbd>  
  Önizlemeyi markdown kaynağındaki imleç konumuyla eşitle.

- <strong>Markdown Preview Enhanced: Toggle Live Update </strong>  
   Önizleme için canlı güncellemeyi etkinleştir/devre dışı bırak.  
   Devre dışı bırakılırsa, önizleme yalnızca dosya kaydedildiğinde işlenecektir.

- <strong>Markdown Preview Enhanced: Toggle Break On Single Newline </strong>  
  Tek satır sonu üzerinde satır kırma özelliğini etkinleştir/devre dışı bırak.

- <strong>Markdown Preview Enhanced: Insert New Slide </strong>  
  Yeni bir slayt ekle ve [sunum moduna](presentation.md) gir.

- <strong>Markdown Preview Enhanced: Insert Table </strong>  
  Bir markdown tablosu ekle.

- <strong>Markdown Preview Enhanced: Insert Page Break </strong>  
  Sayfa sonu ekle.

- <strong> Markdown Preview Enhanced: Open Mermaid Config</strong>  
  `mermaid` başlangıç yapılandırmasını düzenle.

- <strong> Markdown Preview Enhanced: Open Mathjax Config </strong>  
   `MathJax` başlangıç yapılandırmasını düzenle.

- <strong>Markdown Preview Enhanced: Image Helper</strong>  
  Daha fazla bilgi için [bu belgeye](image-helper.md) bakın.  
   Görsel Yardımcısı; görsel URL'si hızlı eklemeyi, görsel yapıştırmayı ve [imgur](https://imgur.com/) ile [sm.ms](https://sm.ms/) destekli görsel yüklemeyi destekler.  
  ![screen shot 2017-06-06 at 3 42 31 pm](https://user-images.githubusercontent.com/1908863/26850896-c43be8e2-4ace-11e7-802d-6a7b51bf3130.png)

- <strong>Markdown Preview Enhanced: Show Uploaded Images</strong>  
  Yüklenen görsel bilgilerini saklayan `image_history.md` dosyasını açar.  
  `image_history.md` dosyasını serbestçe düzenleyebilirsiniz.

- <strong>Markdown Preview Enhanced: Run Code Chunk </strong>  
  <kbd>shift-enter</kbd>  
  Tek bir [Code Chunk](code-chunk.md) çalıştır.

- <strong>Markdown Preview Enhanced: Run All Code Chunks </strong>  
  <kbd>ctrl-shift-enter</kbd>  
  Tüm [Code Chunk](code-chunk.md)'ları çalıştır.

- <strong>Markdown Preview Enhanced: Extend Parser</strong>  
  [Markdown Ayrıştırıcıyı Genişlet](extend-parser.md).

---

_Önizleme_

Bağlam menüsünü açmak için önizlemede **sağ tıklayın**:

![screen shot 2017-07-14 at 12 30 54 am](https://user-images.githubusercontent.com/1908863/28199502-b9ba39c6-682b-11e7-8bb9-89661100389e.png)

- <kbd>cmd-=</kbd> veya <kbd>cmd-shift-=</kbd>.  
  Önizlemeyi yakınlaştır.

- <kbd>cmd--</kbd> veya <kbd>cmd-shift-\_</kbd>.  
  Önizlemeyi uzaklaştır.

- <kbd>cmd-0</kbd>  
  Yakınlaştırmayı sıfırla.

- <kbd>cmd-shift-s</kbd>  
  Markdown editörünü önizlemenin konumuyla eşitle.

- <kbd>esc</kbd>  
  Kenar çubuğu TOC'unu aç/kapat.

## Klavye Kısayolları

| Kısayollar                                  | İşlev                      |
| ------------------------------------------- | -------------------------- |
| <kbd>ctrl-shift-m</kbd>                     | Önizlemeyi aç/kapat        |
| <kbd>cmd-k v</kbd>                          | Önizlemeyi aç `Yalnızca VSCode` |
| <kbd>ctrl-shift-s</kbd>                     | Önizlemeyi eşitle / Kaynağı eşitle |
| <kbd>shift-enter</kbd>                      | Code Chunk çalıştır        |
| <kbd>ctrl-shift-enter</kbd>                 | Tüm Code Chunk'ları çalıştır |
| <kbd>cmd-=</kbd> veya <kbd>cmd-shift-=</kbd>  | Önizlemeyi yakınlaştır     |
| <kbd>cmd--</kbd> veya <kbd>cmd-shift-\_</kbd> | Önizlemeyi uzaklaştır      |
| <kbd>cmd-0</kbd>                            | Önizleme yakınlaştırmayı sıfırla |
| <kbd>esc</kbd>                              | Kenar çubuğu TOC'unu aç/kapat |

## Paket Ayarları

### Atom

Paket ayarlarını açmak için <kbd>cmd-shift-p</kbd> tuşlarına basın, ardından `Settings View: Open` seçeneğini seçin ve `Packages` sekmesine tıklayın.

`Installed Packages` altında `markdown-preview-enhanced` arayın:  
![screen shot 2017-06-06 at 3 57 22 pm](https://user-images.githubusercontent.com/1908863/26851561-d6b1ca30-4ad0-11e7-96fd-6e436b5de45b.png)

`Settings` düğmesine tıklayın:

![screen shot 2017-07-14 at 12 35 13 am](https://user-images.githubusercontent.com/1908863/28199574-50595dbc-682c-11e7-9d94-264e46387da8.png)

### VS Code

`Preferences: Open User Settings` komutunu çalıştırın, ardından `markdown-preview-enhanced` arayın.

![screen shot 2017-07-14 at 12 34 04 am](https://user-images.githubusercontent.com/1908863/28199551-2719acb8-682c-11e7-8163-e064ad8fe41c.png)
