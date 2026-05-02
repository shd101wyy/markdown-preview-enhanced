# Diyagramlar

**Markdown Preview Enhanced**, `akış şemaları`, `sıra diyagramları`, `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz`, `Vega & Vega-lite`, `Ditaa` diyagramlarını işlemeyi destekler.
[Code Chunk](code-chunk.md) kullanarak `TikZ`, `Python Matplotlib`, `Plotly` ve diğer grafik ve diyagram türlerini de işleyebilirsiniz.

> Bazı diyagramların PDF, pandoc gibi dosya dışa aktarma işlemleriyle iyi çalışmadığını unutmayın.

## Mermaid

Markdown Preview Enhanced, akış şemaları ve sıra diyagramları işlemek için [mermaid](https://github.com/knsv/mermaid) kullanır.

- `mermaid` notasyonlu kod bloğu [mermaid](https://github.com/knsv/mermaid) tarafından işlenecektir.
- Akış şeması ve sıra diyagramı oluşturma hakkında daha fazla bilgi için [mermaid belgelerine](https://mermaid-js.github.io/mermaid) bakın.
  ![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

Üç mermaid teması sunulmaktadır; temayı [paket ayarlarından](usages.md?id=package-settings) seçebilirsiniz:

- `mermaid.css`
- `mermaid.dark.css`
- `mermaid.forest.css`
  ![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

`Markdown Preview Enhanced: Open Mermaid Config` komutunu çalıştırarak mermaid başlangıç yapılandırmasını da düzenleyebilirsiniz.

Ayrıca, aşağıdaki gibi head.html dosyasına (`Markdown Preview Enhanced: Customize Preview Html Head` komutuyla açılır) simge logolarını kaydedebilirsiniz:

```html
<script type="text/javascript">
  const configureMermaidIconPacks = () => {
    window["mermaid"].registerIconPacks([
      {
        name: "logos",
        loader: () =>
          fetch("https://unpkg.com/@iconify-json/logos/icons.json").then(
            (res) => res.json()
          ),
      },
    ]);
  };

  if (document.readyState !== 'loading') {
    configureMermaidIconPacks();
  } else {
    document.addEventListener("DOMContentLoaded", () => {
      configureMermaidIconPacks();
    });
  }
</script>
```

## PlantUML

Markdown Preview Enhanced, birçok grafik türü oluşturmak için [PlantUML](https://plantuml.com/) kullanır. (**Java** kurulu olması gerekir)

- Tüm diyagram türlerini oluşturmak için [Graphviz](https://www.graphviz.org/) kurabilirsiniz (zorunlu değil).
- `puml` veya `plantuml` notasyonlu kod bloğu [PlantUML](https://plantuml.com/) tarafından işlenecektir.

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

`@start...` bulunamazsa, otomatik olarak `@startuml ... @enduml` eklenecektir.

## WaveDrom

Markdown Preview Enhanced, dijital zamanlama diyagramları oluşturmak için [WaveDrom](https://wavedrom.com/) kullanır.

- `wavedrom` notasyonlu kod bloğu [WaveDrom](https://github.com/drom/wavedrom) tarafından işlenecektir.

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

[Bitfield](https://github.com/wavedrom/bitfield) diyagramları da desteklenmektedir. Dil tanımlayıcısı olarak `bitfield` kullanın.

## GraphViz

Markdown Preview Enhanced, [dot dili](https://tinyurl.com/kjoouup) diyagramlarını işlemek için [Viz.js](https://github.com/mdaines/viz.js) kullanır.

- `viz` veya `dot` notasyonlu kod bloğu [Viz.js](https://github.com/mdaines/viz.js) tarafından işlenecektir.
- `{engine="..."}` belirterek farklı motorlar seçebilirsiniz. Desteklenen motorlar: `circo`, `dot`, `neato`, `osage` veya `twopi`. Varsayılan motor `dot`'tur.

![screen shot 2018-03-18 at 3 18 17 pm](https://user-images.githubusercontent.com/1908863/37570596-a565306e-2abf-11e8-8904-d73306f675ec.png)

## D2

Markdown Preview Enhanced, diyagramları işlemek için [D2](https://d2lang.com/) kullanır. D2, metni diyagramlara dönüştüren bildirimsel bir diyagramlama dilidir.

- [D2](https://d2lang.com/) kurulu olmalı ve `PATH`'inizde bulunmalıdır (veya ayarlarda `d2Path` ile yapılandırılabilir).
- `d2` notasyonlu kod bloğu [D2](https://d2lang.com/) tarafından işlenecektir.
- Tam söz dizimi referansı için [D2 belgelerine](https://d2lang.com/tour/intro/) bakın.

Her kod bloğu için düzen motorunu, temayı ve çizim stilini geçersiz kılabilirsiniz:
![d2-test](https://github.com/user-attachments/assets/809cc0e7-e7a0-4637-9a4d-3992edab725d)

| Öznitelik | Açıklama                                                       | Varsayılan |
| --------- | -------------------------------------------------------------- | ---------- |
| `layout`  | Düzen motoru: `dagre`, `elk`, `tala`                           | `dagre`    |
| `theme`   | Tema ID numarası ([D2 temaları](https://d2lang.com/tour/themes/)na bakın) | `0` |
| `sketch`  | Elle çizilmiş / karakalem stilinde işleme                      | `false`    |

Genel varsayılanlar [paket ayarları](usages.md?id=package-settings) içinde yapılandırılabilir:

| Ayar       | Açıklama                        | Varsayılan |
| ---------- | ------------------------------- | ---------- |
| `d2Path`   | `d2` yürütülebilir dosyasının yolu | `d2`     |
| `d2Layout` | Varsayılan düzen motoru         | `dagre`    |
| `d2Theme`  | Varsayılan tema ID'si           | `0`        |
| `d2Sketch` | Varsayılan karakalem modu       | `false`    |

> **Not:** D2 işleme, makinenizde `d2` CLI'nin kurulu olmasını gerektirir. Bulunamazsa, kod bloğu düz metin olarak görüntülenecektir. Kurulum talimatları için [D2 kurulum kılavuzuna](https://d2lang.com/tour/install/) bakın.

## TikZ

Markdown Preview Enhanced, `tikz` çitli kod blokları aracılığıyla [TikZ](https://tikz.dev/) diyagramlarının işlenmesini destekler.

- Node.js'de (masaüstü VS Code): [node-tikzjax](https://github.com/prinsss/node-tikzjax) kullanarak TikZ'yi sunucu tarafında SVG'ye dönüştürür ve önbelleğe alır.
- Web'de (VS Code web uzantısı) ve HTML dışa aktarmada: [tikzjax.com](https://tikzjax.com) aracılığıyla istemci tarafı işlemeye geri döner.
- Kodda `\begin{document}...\end{document}` yoksa otomatik olarak eklenir.
- Temel TeX paketlerini otomatik yükler: `amsmath`, `amssymb`, `amsfonts`, `amstext`, `array`.
- Özel paketleri otomatik algılar ve yükler: `tikz-cd` (`\begin{tikzcd}` için), `pgfplots` (`\begin{axis}` için), `circuitikz` (`\begin{circuitikz}` için), `chemfig` (`\chemfig` için), `tikz-3dplot` (`\tdplotsetmaincoords` için).

Çit bilgi dizesinde desteklenen blok başına seçenekler:

| Seçenek | Açıklama | Kabul edilen değerler |
| ------ | ----------- | --------------- |
| `texPackages` / `tex_packages` | Yüklenecek ek TeX paketleri | Virgülle ayrılmış liste |
| `tikzLibraries` / `tikz_libraries` | Yüklenecek TikZ kütüphaneleri | Virgülle ayrılmış liste |
| `addToPreamble` / `add_to_preamble` | Ön bölüme eklenecek özel LaTeX kodu | LaTeX dizesi |
| `showConsole` / `show_console` | Konsol çıktısını göster | `true` / `false` |
| `embedFontCss` / `embed_font_css` | Yazı tipi CSS'ini göm | `true` / `false` |
| `fontCssUrl` / `font_css_url` | Özel yazı tipi CSS URL'si | URL dizesi |

> **Not:** TikZ işleme, istemci tarafı işleme (tikzjax.com) için ağ erişimi gerektirir. node-tikzjax ile sunucu tarafı işleme, ilk kurulumdan sonra çevrimdışı çalışır.

## WebSequenceDiagrams

Markdown Preview Enhanced, `wsd` çitli kod blokları aracılığıyla [WebSequenceDiagrams](https://www.websequencediagrams.com/) işlenmesini destekler.

- `wsd` notasyonlu kod bloğu [WebSequenceDiagrams](https://www.websequencediagrams.com/) tarafından işlenecektir.
- İsteğe bağlı bir API anahtarı [paket ayarları](usages.md?id=package-settings) içinde yapılandırılabilir.

> **Not:** WebSequenceDiagrams işleme, websequencediagrams.com'a ağ erişimi gerektirir.

## Vega ve Vega-lite

Markdown Preview Enhanced, [vega](https://vega.github.io/vega/) ve [vega-lite](https://vega.github.io/vega-lite/) **statik** diyagramlarını destekler.

- `vega` notasyonlu kod bloğu [vega](https://vega.github.io/vega/) tarafından işlenecektir.
- `vega-lite` notasyonlu kod bloğu [vega-lite](https://vega.github.io/vega-lite/) tarafından işlenecektir.
- Hem `JSON` hem de `YAML` girişleri desteklenmektedir.

![screen shot 2017-07-28 at 7 59 58 am](https://user-images.githubusercontent.com/1908863/28718265-d023e1c2-736a-11e7-8678-a29704f3a23c.png)

Ayrıca `JSON` veya `YAML` dosyalarını `vega` diyagramı olarak [@import](file-imports.md) ile içe aktarabilirsiniz:

```markdown
@import "your_vega_source.json" {as="vega"}
@import "your_vega_lite_source.json" {as="vega-lite"}
```

## Kroki

Markdown Preview Enhanced, farklı diyagram türlerini destekleyen [Kroki](https://kroki.io/)'yi destekler. Etkinleştirmek için kod bloğu özniteliklerinde `kroki=true` veya `kroki=DIAGRAM_TYPE` ayarlayın.

````markdown
```blockdiag {kroki=true}
blockdiag {
  Kroki -> generates -> "Block diagrams";
  Kroki -> is -> "very easy!";

  Kroki [color = "greenyellow"];
  "Block diagrams" [color = "pink"];
  "very easy!" [color = "orange"];
}
```

```javascript {kroki="wavedrom"}
{
  signal: [
    { name: "clk", wave: "p.....|..." },
    {
      name: "Data",
      wave: "x.345x|=.x",
      data: ["head", "body", "tail", "data"],
    },
    { name: "Request", wave: "0.1..0|1.0" },
    {},
    { name: "Acknowledge", wave: "1.....|01." },
  ]
}
```
````

---

Grafikleri işlemek yerine yalnızca kod bloğunu göstermek istiyorsanız, aşağıdaki gibi `{code_block=true}` ekleyebilirsiniz:

    ```mermaid {code_block=true}
    // mermaid kodunuz buraya
    ```

---

Diyagram kabı için öznitelikler ayarlayabilirsiniz.
Örneğin:

    ```puml {align="center"}
    a->b
    ```

puml diyagramını önizlemede ortaya hizalayacaktır.

---

Markdown dosyanızı [GFM Markdown](markdown.md)'a dışa aktardığınızda, diyagramlar paket ayarlarında tanımladığınız `imageFolderPath` dizinine png görsel olarak kaydedilecektir.
`{filename="your_file_name.png"}` bildirerek dışa aktarılan görsel dosya adını kontrol edebilirsiniz.

Örneğin:

    ```mermaid {filename="my_mermaid.png"}
    ...
    ```

[➔ TOC](toc.md)
