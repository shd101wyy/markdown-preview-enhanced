# eBook-generatie

Geïnspireerd door _GitBook_  
**Markdown Preview Enhanced** kan inhoud uitvoeren als eBook (ePub, Mobi, PDF).

![Screen Shot 2016-09-08 at 9.42.43 PM](https://ooo.0o0.ooo/2016/09/09/57d221c0a618a.png)

Om een eBook te genereren, moet u `ebook-convert` geïnstalleerd hebben.

## ebook-convert installeren

**macOS**  
Download de [Calibre-applicatie](https://calibre-ebook.com/download). Na het verplaatsen van `calibre.app` naar uw map Programma's, maak een symbolische koppeling naar de tool `ebook-convert`:

```shell
$ sudo ln -s ~/Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin
```

**Windows**  
Download en installeer de [Calibre-applicatie](https://calibre-ebook.com/download).  
Voeg `ebook-convert` toe aan uw `$PATH`.

## eBook-voorbeeld

Een eBook-voorbeeldproject is [hier](https://github.com/shd101wyy/ebook-example) te vinden.

## Begin met het schrijven van een eBook

U kunt een eBook-configuratie instellen door eenvoudig `ebook front-matter` aan uw markdown-bestand toe te voegen.

```yaml
---
ebook:
  theme: github-light.css
  title: Mijn eBook
  authors: shd101wyy
---

```

---

## Demo

`SUMMARY.md` is een voorbeeld-invoerbestand. Het moet ook een TOC hebben om het boek te organiseren:

```markdown
---
ebook:
  theme: github-light.css
  title: Markdown Preview Enhanced
  author: shd101wyy
---

# Voorwoord

Dit is het voorwoord, maar niet verplicht.

# Inhoudsopgave

- [Hoofdstuk 1](/chapter1/README.md)
  - [Introductie van Markdown Preview Enhanced](/chapter1/intro.md)
  - [Functies](/chapter1/feature.md)
- [Hoofdstuk 2](/chapter2/README.md)
  - [Bekende problemen](/chapter2/issues.md)
```

De laatste lijst in het markdown-bestand wordt beschouwd als TOC.

De titel van de koppeling wordt gebruikt als de hoofdstuktitel, en het doel van de koppeling is een pad naar het bestand van dat hoofdstuk.

---

Om het eBook te exporteren, opent u `SUMMARY.md` met de geopende voorbeeldweergave. Klik vervolgens met de rechtermuisknop op de voorbeeldweergave, kies `Export to Disk` en kies vervolgens de optie `EBOOK`. U kunt dan uw eBook exporteren.

### Metadata

- **theme**
  Het te gebruiken thema voor het eBook, standaard wordt het voorbeeldthema gebruikt. De lijst met beschikbare thema's is te vinden in de sectie `previewTheme` in [deze documentatie](https://github.com/shd101wyy/crossnote/#notebook-configuration).
- **title**  
  Titel van uw boek
- **authors**  
  auteur1 & auteur2 & ...
- **cover**  
  https://pad-naar-afbeelding.png
- **comments**  
  Stel de eBook-beschrijving in
- **publisher**  
  Wie is de uitgever?
- **book-producer**  
  Wie is de boekproducent?
- **pubdate**  
  Publicatiedatum
- **language**  
  Stel de taal in
- **isbn**  
  ISBN van het boek
- **tags**  
  Stel de tags voor het boek in. Moet een door komma's gescheiden lijst zijn.
- **series**  
  Stel de serie in waartoe dit eBook behoort.
- **rating**  
  Stel de beoordeling in. Moet een getal zijn tussen 1 en 5.
- **include_toc**  
  `standaard: true` Of de TOC die u in uw invoerbestand heeft geschreven al dan niet moet worden opgenomen.

Bijvoorbeeld:

```yaml
ebook:
  title: Mijn eBook
  author: shd101wyy
  rating: 5
```

### Uiterlijk en stijl

De volgende opties zijn beschikbaar om de weergave van de uitvoer te bepalen:

- **asciiize** `[true/false]`  
  `standaard: false`, Translitereer unicode-tekens naar een ASCII-representatie. Gebruik voorzichtig omdat dit unicode-tekens vervangt door ASCII.
- **base-font-size** `[number]`  
  De basislettergrootte in punten. Alle lettergroottes in het geproduceerde boek worden herschaald op basis van deze grootte. Door een grotere grootte te kiezen, maakt u de lettertypen in de uitvoer groter en vice versa. Standaard wordt de basislettergrootte gekozen op basis van het gekozen uitvoerprofiel.
- **disable-font-rescaling** `[true/false]`  
  `standaard: false` Schakel alle herschaling van lettergroottes uit.
- **line-height** `[number]`  
  De regelhoogte in punten. Beheert de afstand tussen opeenvolgende regels tekst. Geldt alleen voor elementen die hun eigen regelhoogte niet definiëren. In de meeste gevallen is de optie voor minimale regelhoogte nuttiger. Standaard wordt geen regelhoogte-manipulatie uitgevoerd.
- **margin-top** `[number]`  
  `standaard: 72.0` Stel de bovenmarge in punten in. Standaard is 72. Als u dit instelt op minder dan nul, wordt er geen marge ingesteld (de margeinstelling in het originele document wordt behouden). Opmerking: 72 punten is gelijk aan 1 inch.
- **margin-right** `[number]`  
  `standaard: 72.0`
- **margin-bottom** `[number]`  
  `standaard: 72.0`
- **margin-left** `[number]`  
  `standaard: 72.0`
- **margin** `[number/array]`  
  `standaard: 72.0`  
  U kunt **marge boven/rechts/onder/links** tegelijk definiëren. Bijvoorbeeld:

```yaml
ebook:
  margin: 5 # margin-top = margin-right = margin-bottom = margin-left = 5
```

```yaml
ebook:
  margin: [4, 8] # margin-top = margin-bottom = 4, margin-left = margin-right = 8
```

```yaml
ebook:
  margin: [1, 2, 3, 4] # margin-top=1, margin-right=2, margin-bottom=3, margin-left=4
```

Bijvoorbeeld:

```yaml
ebook:
  title: Mijn eBook
  base-font-size: 8
  margin: 72
```

## Uitvoerformaten

Op dit moment kunt u eBooks uitvoeren in `ePub`-, `mobi`-, `pdf`- en `html`-formaat.

### ePub

Om `ePub`-uitvoer te configureren, voegt u eenvoudig `epub` na `ebook` toe.

```yaml
---
ebook:
  epub:
    no-default-epub-cover: true
    pretty-print: true
---

```

De volgende opties zijn beschikbaar:

- **no-default-epub-cover** `[true/false]`  
  Normaal gesproken, als het invoerbestand geen omslag heeft en u er geen opgeeft, wordt er een standaardomslag gegenereerd met de titel, auteurs, enz. Met deze optie wordt het genereren van deze omslag uitgeschakeld.
- **no-svg-cover** `[true/false]`  
  Gebruik geen SVG voor de boekomslag. Gebruik deze optie als uw EPUB gaat worden gebruikt op een apparaat dat geen SVG ondersteunt, zoals de iPhone of de JetBook Lite. Zonder deze optie zullen dergelijke apparaten de omslag als een lege pagina weergeven.
- **pretty-print** `[true/false]`  
  Indien opgegeven, probeert de uitvoer-plugin zo mensleesbaar mogelijke uitvoer te maken. Heeft mogelijk geen effect voor sommige uitvoer-plugins.

### PDF

Om `pdf`-uitvoer te configureren, voegt u eenvoudig `pdf` na `ebook` toe.

```yaml
ebook:
  pdf:
    paper-size: letter
    default-font-size: 12
    header-template: "<span> Geschreven door shd101wyy _PAGENUM_ </span>"
```

De volgende opties zijn beschikbaar:

- **paper-size**  
  De papiergrootte. Deze grootte wordt overschreven wanneer een niet-standaard uitvoerprofiel wordt gebruikt. Standaard is letter. Keuzes zijn `a0`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `b0`, `b1`, `b2`, `b3`, `b4`, `b5`, `b6`, `legal`, `letter`.
- **default-font-size** `[number]`  
  De standaard lettergrootte.
- **footer-template**  
  Een HTML-sjabloon dat wordt gebruikt om voetteksten op elke pagina te genereren. De tekenreeksen `_PAGENUM_`, `_TITLE_`, `_AUTHOR_` en `_SECTION_` worden vervangen door hun huidige waarden.
- **header-template**  
  Een HTML-sjabloon dat wordt gebruikt om kopteksten op elke pagina te genereren. De tekenreeksen `_PAGENUM_`, `_TITLE_`, `_AUTHOR_` en `_SECTION_` worden vervangen door hun huidige waarden.
- **page-numbers** `[true/false]`  
  `standaard: false`  
  Voeg paginanummers toe aan de onderkant van elke pagina in het gegenereerde PDF-bestand. Als u een voettekstsjabloon opgeeft, heeft dat voorrang op deze optie.
- **pretty-print** `[true/false]`  
  Indien opgegeven, probeert de uitvoer-plugin zo mensleesbaar mogelijke uitvoer te maken. Heeft mogelijk geen effect voor sommige uitvoer-plugins.

### HTML

Het exporteren van `.html` is niet afhankelijk van `ebook-convert`.  
Als u een `.html`-bestand exporteert, worden alle lokale afbeeldingen opgenomen als `base64`-gegevens in één `html`-bestand.  
Om `html`-uitvoer te configureren, voegt u eenvoudig `html` na `ebook` toe.

```yaml
ebook:
  html:
    cdn: true
```

- **cdn**  
  Laad css- en javascript-bestanden van `cdn.js`. Deze optie wordt alleen gebruikt bij het exporteren van `.html`-bestanden.

## ebook-convert-argumenten

Als er `ebook-convert`-functies zijn die u wilt gebruiken die geen equivalenten hebben in de hierboven beschreven YAML-opties, kunt u ze nog steeds gebruiken door aangepaste `args` door te geven. Bijvoorbeeld:

```yaml
---
ebook:
  title: Mijn eBook
  args: ["--embed-all-fonts", "--embed-font-family"]
---

```

U kunt een lijst met argumenten vinden in de [ebook-convert handleiding](https://manual.calibre-ebook.com/generated/en/ebook-convert.html).

## Exporteren bij opslaan

Voeg de front-matter toe zoals hieronder:

```yaml
---
export_on_save:
  ebook: true
  // of
  ebook: "epub"
  ebook: "pdf"
  ebook: "mobi"
  ebook: "html"
  ebook: ["pdf", ...]
---
```

Zodat de eBooks worden gegenereerd elke keer dat u uw markdown-bronbestand opslaat.

## Bekende problemen & beperkingen

- eBook-generatie is nog in ontwikkeling.
- Alle SVG-grafieken gegenereerd door `mermaid`, `PlantUML`, enz. werken niet in het gegenereerde eBook. Alleen `viz` werkt.
- Alleen **KaTeX** kan worden gebruikt voor wiskundige opmaak.  
  En het gegenereerde eBook-bestand rendert wiskundige expressies niet correct in **iBook**.
- **PDF**- en **Mobi**-generatie is foutgevoelig.
- **Code Chunk** werkt niet met eBook-generatie.
