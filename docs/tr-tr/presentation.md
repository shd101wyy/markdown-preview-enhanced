# Sunum Yazarı

![screen shot 2017-07-14 at 12 33 14 pm](https://user-images.githubusercontent.com/1908863/28223480-2c61461c-6891-11e7-9389-5adec0588c32.png)

Markdown Preview Enhanced, güzel sunumlar oluşturmak için [reveal.js](https://github.com/hakimel/reveal.js) kullanır.

Tanıtımı görmek için [buraya tıklayın](https://rawgit.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.html) (**Önerilen**).

![presentation](https://user-images.githubusercontent.com/1908863/28202176-caf103c4-6839-11e7-8776-942679f3698b.gif)

## Sunum Front-Matter

Markdown dosyanıza front-matter ekleyerek sunumunuzu yapılandırabilirsiniz.  
Ayarlarınızı `presentation` bölümü altında yazmanız gerekir.  
Örneğin:

```markdown
---
presentation:
  width: 800
  height: 600
---

<!-- slide -->

Slaytlarınız buraya gelir...
```

Yukarıdaki sunum `800x600` boyutunda olacaktır.

### Ayarlar

```yaml
---
presentation:
  # sunum teması
  # === mevcut temalar ===
  # "beige.css"
  # "black.css"
  # "blood.css"
  # "league.css"
  # "moon.css"
  # "night.css"
  # "serif.css"
  # "simple.css"
  # "sky.css"
  # "solarized.css"
  # "white.css"
  # "none.css"
  theme: white.css

  # Sunumun "normal" boyutu, sunum farklı çözünürlüklere
  # ölçeklendirildiğinde en-boy oranı korunacaktır. Yüzde
  # birimleri kullanılarak belirtilebilir.
  width: 960
  height: 700

  # İçeriğin etrafında boş kalması gereken görüntü boyutu faktörü
  margin: 0.1

  # İçeriğe uygulanacak en küçük/en büyük olası ölçek sınırları
  minScale: 0.2
  maxScale: 1.5

  # Sağ alt köşede denetimleri göster
  controls: true

  # Sunum ilerleme çubuğunu göster
  progress: true

  # Geçerli slaydın sayfa numarasını göster
  slideNumber: false

  # Her slayt değişikliğini tarayıcı geçmişine aktar
  history: false

  # Navigasyon için klavye kısayollarını etkinleştir
  keyboard: true

  # Slayt genel görünümü modunu etkinleştir
  overview: true

  # Slaytları dikey olarak ortala
  center: true

  # Dokunmatik giriş olan cihazlarda dokunmatik navigasyonu etkinleştir
  touch: true

  # Sunumu döngüye al
  loop: false

  # Sunum yönünü RTL olarak değiştir
  rtl: false

  # Sunum her yüklendiğinde slayt sırasını rastgele belirler
  shuffle: false

  # Parçaları genel olarak açar ve kapatır
  fragments: true

  # Sunumun gömülü modda çalışıp çalışmadığını belirtir,
  # yani ekranın sınırlı bir bölümünde yer alır
  embedded: false

  # Soru işareti tuşuna basıldığında yardım katmanının
  # gösterilip gösterilmeyeceğini belirtir
  help: true

  # Konuşmacı notlarının tüm izleyicilere görünür olup
  # olmayacağını belirtir
  showNotes: false

  # Otomatik olarak bir sonraki slayta geçmeden önce
  # geçen milisaniye sayısı, 0'a ayarlandığında devre dışı,
  # slaytlarınızda data-autoslide özniteliği kullanılarak
  # bu değer geçersiz kılınabilir
  autoSlide: 0

  # Kullanıcı girişinden sonra otomatik kaydırmayı durdur
  autoSlideStoppable: true

  # Fare tekerleği aracılığıyla slayt navigasyonunu etkinleştir
  mouseWheel: false

  # Mobil cihazlarda adres çubuğunu gizler
  hideAddressBar: true

  # Bağlantıları iframe önizleme katmanında açar
  previewLinks: false

  # Geçiş stili
  transition: 'default' # none/fade/slide/convex/concave/zoom

  # Geçiş hızı
  transitionSpeed: 'default' # default/fast/slow

  # Tam sayfa slayt arka planları için geçiş stili
  backgroundTransition: 'default' # none/fade/slide/convex/concave/zoom

  # Geçerli konumdan görünür slayt sayısı
  viewDistance: 3

  # Parallax arka plan görseli
  parallaxBackgroundImage: '' # örn. "'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg'"

  # Parallax arka plan boyutu
  parallaxBackgroundSize: '' # CSS sözdizimi, örn. "2100px 900px"

  # Slayt başına parallax arka planın taşınacağı piksel sayısı
  # - Belirtilmediğinde otomatik hesaplanır
  # - Bir eksen boyunca hareketi devre dışı bırakmak için 0 olarak ayarlayın
  parallaxBackgroundHorizontal: null
  parallaxBackgroundVertical: null

  # Parallax arka plan görseli
  parallaxBackgroundImage: '' # örn. "https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg"

  # Parallax arka plan boyutu
  parallaxBackgroundSize: '' # CSS sözdizimi, örn. "2100px 900px" - şu anda yalnızca piksel desteklenmektedir (% veya auto kullanmayın)

  # Slayt başına parallax arka planın taşınacağı piksel sayısı
  # - Belirtilmediğinde otomatik hesaplanır
  # - Bir eksen boyunca hareketi devre dışı bırakmak için 0 olarak ayarlayın
  parallaxBackgroundHorizontal: 200
  parallaxBackgroundVertical: 50

  # Konuşmacı Notlarını etkinleştir
  enableSpeakerNotes: false
---
```

## Slayt Stilini Özelleştirme

Belirli bir slayta şu şekilde `id` ve `class` ekleyebilirsiniz:

```markdown
<!-- slide id="my-id" class="my-class1 my-class2" -->
```

Ya da yalnızca `n.` slaydı özelleştirmek istiyorsanız, `less` dosyanızı şu şekilde değiştirin:

```less
.markdown-preview.markdown-preview {
  // özel sunum stili
  .reveal .slides {
    // tüm slaytları değiştir
  }

  .slides > section:nth-child(1) {
    // bu `birinci slaydı` değiştirecek
  }
}
```

[➔ Pandoc](pandoc.md)
