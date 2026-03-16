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
