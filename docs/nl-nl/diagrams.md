# Diagrammen

**Markdown Preview Enhanced** ondersteunt het renderen van `stroomdiagrammen`, `sequentiediagrammen`, `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz`, `Vega & Vega-lite` en `Ditaa`-diagrammen.
U kunt ook `TikZ`, `Python Matplotlib`, `Plotly` en allerlei andere grafieken en diagrammen renderen met behulp van [Code Chunk](code-chunk.md).

> Houd er rekening mee dat sommige diagrammen niet goed werken bij bestandsexports zoals PDF, pandoc, enz.

## Mermaid

Markdown Preview Enhanced gebruikt [mermaid](https://github.com/knsv/mermaid) om stroomdiagrammen en sequentiediagrammen te renderen.

- Een codeblok met `mermaid`-notatie wordt gerenderd door [mermaid](https://github.com/knsv/mermaid).
- Raadpleeg de [mermaid-documentatie](https://mermaid-js.github.io/mermaid) voor meer informatie over hoe u stroomdiagrammen en sequentiediagrammen kunt maken.
  ![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

Er zijn drie mermaid-thema's beschikbaar, en u kunt een thema kiezen via [pakketinstellingen](usages.md?id=package-settings):

- `mermaid.css`
- `mermaid.dark.css`
- `mermaid.forest.css`
  ![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

U kunt ook de mermaid-initialisatieconfiguratie bewerken door de opdracht `Markdown Preview Enhanced: Open Mermaid Config` uit te voeren.

Bovendien kunt u pictogramlogo's registreren in head.html (geopend via de opdracht `Markdown Preview Enhanced: Customize Preview Html Head`) als volgt:

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

Markdown Preview Enhanced gebruikt [PlantUML](https://plantuml.com/) om meerdere soorten grafieken te maken. (**Java** moet geïnstalleerd zijn)

- U kunt [Graphviz](https://www.graphviz.org/) installeren (niet verplicht) om alle diagramtypen te genereren.
- Een codeblok met `puml`- of `plantuml`-notatie wordt gerenderd door [PlantUML](https://plantuml.com/).

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

Als `@start...` niet wordt gevonden, wordt `@startuml ... @enduml` automatisch ingevoegd.

## WaveDrom

Markdown Preview Enhanced gebruikt [WaveDrom](https://wavedrom.com/) om digitale timingdiagrammen te maken.

- Een codeblok met `wavedrom`-notatie wordt gerenderd door [WaveDrom](https://github.com/drom/wavedrom).

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

[Bitfield](https://github.com/wavedrom/bitfield)-diagrammen worden ook ondersteund. Gebruik `bitfield` als taalidentifier.

## GraphViz

Markdown Preview Enhanced gebruikt [Viz.js](https://github.com/mdaines/viz.js) om [dot-taaldiagrammen](https://tinyurl.com/kjoouup) te renderen.

- Een codeblok met `viz`- of `dot`-notatie wordt gerenderd door [Viz.js](https://github.com/mdaines/viz.js).
- U kunt verschillende engines kiezen door `{engine="..."}` op te geven. De engines `circo`, `dot`, `neato`, `osage` of `twopi` worden ondersteund. De standaard engine is `dot`.

![screen shot 2018-03-18 at 3 18 17 pm](https://user-images.githubusercontent.com/1908863/37570596-a565306e-2abf-11e8-8904-d73306f675ec.png)

## D2

Markdown Preview Enhanced gebruikt [D2](https://d2lang.com/) om diagrammen te renderen. D2 is een declaratieve diagramtaal die tekst omzet in diagrammen.

- [D2](https://d2lang.com/) moet geïnstalleerd zijn en beschikbaar in uw `PATH` (of geconfigureerd via `d2Path` in de instellingen).
- Een codeblok met `d2`-notatie wordt gerenderd door [D2](https://d2lang.com/).
- Raadpleeg de [D2-documentatie](https://d2lang.com/tour/intro/) voor de volledige syntaxreferentie.

U kunt de lay-outengine, het thema en de schetsstijl per codeblok overschrijven:
![d2-test](https://github.com/user-attachments/assets/809cc0e7-e7a0-4637-9a4d-3992edab725d)

| Attribuut  | Beschrijving                                                     | Standaard |
| ---------- | ---------------------------------------------------------------- | --------- |
| `layout`   | Lay-outengine: `dagre`, `elk`, `tala`                            | `dagre`   |
| `theme`    | Thema ID-nummer (zie [D2-thema's](https://d2lang.com/tour/themes/)) | `0`     |
| `sketch`   | Renderen in handgetekende / schetsstijl                          | `false`   |

Globale standaardwaarden kunnen worden geconfigureerd in [pakketinstellingen](usages.md?id=package-settings):

| Instelling  | Beschrijving                      | Standaard |
| ----------- | --------------------------------- | --------- |
| `d2Path`    | Pad naar het `d2` uitvoerbare bestand | `d2`    |
| `d2Layout`  | Standaard lay-outengine           | `dagre`   |
| `d2Theme`   | Standaard thema ID                | `0`       |
| `d2Sketch`  | Standaard schetsmodus             | `false`   |

> **Opmerking:** D2-rendering vereist dat de `d2` CLI op uw machine is geïnstalleerd. Als deze niet wordt gevonden, wordt het codeblok weergegeven als platte tekst. Zie de [D2-installatiegids](https://d2lang.com/tour/install/) voor instructies.

## TikZ

Markdown Preview Enhanced ondersteunt het renderen van [TikZ](https://tikz.dev/)-diagrammen via `tikz`-afgebakende codeblokken.

- In Node.js (desktop VS Code): rendert TikZ naar SVG aan de serverzijde met behulp van [node-tikzjax](https://github.com/prinsss/node-tikzjax), met caching.
- In web (VS Code web-extensie) en HTML-export: valt terug op client-side rendering via [tikzjax.com](https://tikzjax.com).
- Als `\begin{document}...\end{document}` niet aanwezig is, wordt dit automatisch toegevoegd.
- Laadt automatisch de basis-TeX-pakketten: `amsmath`, `amssymb`, `amsfonts`, `amstext`, `array`.
- Detecteert en laadt automatisch gespecialiseerde pakketten: `tikz-cd` (voor `\begin{tikzcd}`), `pgfplots` (voor `\begin{axis}`), `circuitikz` (voor `\begin{circuitikz}`), `chemfig` (voor `\chemfig`), `tikz-3dplot` (voor `\tdplotsetmaincoords`).

Per-blok opties ondersteund in de afbakeningsinformatietekenreeks:

| Optie | Beschrijving | Geaccepteerde waarden |
| ------ | ----------- | --------------- |
| `texPackages` / `tex_packages` | Aanvullende TeX-pakketten om te laden | Door komma's gescheiden lijst |
| `tikzLibraries` / `tikz_libraries` | TikZ-bibliotheken om te laden | Door komma's gescheiden lijst |
| `addToPreamble` / `add_to_preamble` | Aangepaste LaTeX-code om aan de preambule toe te voegen | LaTeX-tekenreeks |
| `showConsole` / `show_console` | Console-uitvoer weergeven | `true` / `false` |
| `embedFontCss` / `embed_font_css` | Lettertype-CSS insluiten | `true` / `false` |
| `fontCssUrl` / `font_css_url` | Aangepaste lettertype-CSS-URL | URL-tekenreeks |

> **Opmerking:** TikZ-rendering vereist netwerktoegang voor client-side rendering (tikzjax.com). Server-side rendering met node-tikzjax werkt offline na de initiële installatie.

## WebSequenceDiagrams

Markdown Preview Enhanced ondersteunt het renderen van [WebSequenceDiagrams](https://www.websequencediagrams.com/) via `wsd`-afgebakende codeblokken.

- Een codeblok met `wsd`-notatie wordt gerenderd door [WebSequenceDiagrams](https://www.websequencediagrams.com/).
- Een optionele API-sleutel kan worden geconfigureerd in [pakketinstellingen](usages.md?id=package-settings).

> **Opmerking:** WebSequenceDiagrams-rendering vereist netwerktoegang tot websequencediagrams.com.

## Vega en Vega-lite

Markdown Preview Enhanced ondersteunt **statische** [vega](https://vega.github.io/vega/)- en [vega-lite](https://vega.github.io/vega-lite/)-diagrammen.

- Een codeblok met `vega`-notatie wordt gerenderd door [vega](https://vega.github.io/vega/).
- Een codeblok met `vega-lite`-notatie wordt gerenderd door [vega-lite](https://vega.github.io/vega-lite/).
- Zowel `JSON`- als `YAML`-invoer worden ondersteund.

![screen shot 2017-07-28 at 7 59 58 am](https://user-images.githubusercontent.com/1908863/28718265-d023e1c2-736a-11e7-8678-a29704f3a23c.png)

U kunt ook een `JSON`- of `YAML`-bestand [@importeren](file-imports.md) als `vega`-diagram, bijvoorbeeld:

```markdown
@import "your_vega_source.json" {as="vega"}
@import "your_vega_lite_source.json" {as="vega-lite"}
```

## Kroki

Markdown Preview Enhanced ondersteunt [Kroki](https://kroki.io/), dat verschillende soorten diagrammen ondersteunt. Stel gewoon `kroki=true` of `kroki=DIAGRAM_TYPE` in de codeblokattributen in om het te activeren.

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

Als u grafieken niet wilt renderen maar alleen het codeblok wilt weergeven, kunt u `{code_block=true}` toevoegen zoals hieronder:

    ```mermaid {code_block=true}
    // uw mermaid-code hier
    ```

---

U kunt attributen instellen voor de container van het diagram.
Bijvoorbeeld:

    ```puml {align="center"}
    a->b
    ```

hiermee wordt het puml-diagram in het midden van de voorbeeldweergave geplaatst.

---

Wanneer u uw markdown-bestand exporteert naar [GFM Markdown](markdown.md), worden de diagrammen opgeslagen als png-afbeeldingen in uw `imageFolderPath` die is gedefinieerd in de pakketinstellingen.
U kunt de naam van het geëxporteerde afbeeldingsbestand bepalen door `{filename="your_file_name.png"}` te declareren.

Bijvoorbeeld:

    ```mermaid {filename="my_mermaid.png"}
    ...
    ```

[➔ TOC](toc.md)
