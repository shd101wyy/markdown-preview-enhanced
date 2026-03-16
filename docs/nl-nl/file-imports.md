# Externe bestanden importeren

![doc-imports](https://cloud.githubusercontent.com/assets/1908863/22716507/f352a4b6-ed5b-11e6-9bac-88837f111de0.gif)

## Hoe te gebruiken?

gewoon

`@import "your_file"`

gemakkelijk toch :)

`<!-- @import "your_file" -->` is ook geldig.

Of

```markdown
- afbeeldingssyntaxis
  ![](file/path/to/your_file)

- wikilink-syntaxis
  ![[ file/path/to/your_file ]]
  ![[ my_file ]]
```

## Vernieuwingsknop

Er is nu een vernieuwingsknop toegevoegd aan de rechterhoek van de voorbeeldweergave.
Door erop te klikken worden bestandscaches gewist en de voorbeeldweergave vernieuwd.
Dit kan handig zijn als u de afbeeldingscache wilt wissen. [#144](https://github.com/shd101wyy/markdown-preview-enhanced/issues/144) [#249](https://github.com/shd101wyy/markdown-preview-enhanced/issues/249)

![screen shot 2017-02-07 at 5 48 52 pm](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Ondersteunde bestandstypen

- `.jpeg(.jpg), .gif, .png, .apng, .svg, .bmp`-bestanden worden behandeld als markdown-afbeeldingen.
- `.csv`-bestanden worden geconverteerd naar markdown-tabellen.
- `.mermaid`-bestanden worden gerenderd door mermaid.
- `.dot`-bestanden worden gerenderd door viz.js (graphviz).
- `.plantuml(.puml)`-bestanden worden gerenderd door PlantUML.
- `.html`-bestanden worden direct ingesloten.
- `.js`-bestanden worden opgenomen als `<script src="your_js"></script>`.
- `.less`- en `.css`-bestanden worden opgenomen als stijl. Alleen lokale `less`-bestanden worden momenteel ondersteund. `.css`-bestanden worden opgenomen als `<link rel="stylesheet" href="your_css">`.
- `.pdf`-bestanden worden geconverteerd naar `svg`-bestanden door `pdf2svg` en vervolgens ingesloten.
- `markdown`-bestanden worden geparseerd en direct ingesloten.
- Alle andere bestanden worden weergegeven als codeblok.

## Afbeeldingen configureren

```markdown
@import "test.png" {width="300px" height="200px" title="mijn titel" alt="mijn alt"}

![](test.png){width="300px" height="200px"}

![[ test.png ]]{width="300px" height="200px"}
```

## Online bestanden importeren

Bijvoorbeeld:

```markdown
@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"
```

## PDF-bestand importeren

Om een PDF-bestand te importeren, moet u [pdf2svg](extra.md) geïnstalleerd hebben.
Markdown Preview Enhanced ondersteunt het importeren van zowel lokale als online PDF-bestanden.
Het wordt echter niet aanbevolen om grote PDF-bestanden te importeren.
Bijvoorbeeld:

```markdown
@import "test.pdf"
```

### PDF-configuratie

- **page_no**
  Toont de `n`-de pagina van de PDF. 1-gebaseerde indexering. Bijvoorbeeld `{page_no=1}` toont de eerste pagina van de PDF.
- **page_begin**, **page_end**
  Inclusief. Bijvoorbeeld `{page_begin=2 page_end=4}` toont de pagina's 2, 3 en 4.

## Forceer als codeblok

```markdown
@import "test.puml" {code_block=true class="line-numbers"}
@import "test.py" {class="line-numbers"}
```

## Als codeblok

```markdown
@import "test.json" {as="vega-lite"}
```

## Specifieke regels importeren

```markdown
@import "test.md" {line_begin=2}
@import "test.md" {line_begin=2 line_end=10}
@import "test.md" {line_end=-4}
```

## Bestand importeren als Code Chunk

```markdown
@import "test.py" {cmd="python3"}
```

[➔ Code Chunk](code-chunk.md)
