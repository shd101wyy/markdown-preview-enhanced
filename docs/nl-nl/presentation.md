# Presentatieschrijver

![screen shot 2017-07-14 at 12 33 14 pm](https://user-images.githubusercontent.com/1908863/28223480-2c61461c-6891-11e7-9389-5adec0588c32.png)

Markdown Preview Enhanced gebruikt [reveal.js](https://github.com/hakimel/reveal.js) om mooie presentaties te renderen.

[Klik hier](https://rawgit.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.html) om de introductie te bekijken (**Aanbevolen**).

![presentation](https://user-images.githubusercontent.com/1908863/28202176-caf103c4-6839-11e7-8776-942679f3698b.gif)

## Presentatie Front-Matter

U kunt uw presentatie configureren door front-matter aan uw markdown-bestand toe te voegen.  
U moet uw instellingen schrijven onder de sectie `presentation`.  
Bijvoorbeeld:

```markdown
---
presentation:
  width: 800
  height: 600
---

<!-- slide -->

Uw dia's staan hier...
```

De bovenstaande presentatie heeft de grootte `800x600`.

### Instellingen

```yaml
---
presentation:
  # presentatiethema
  # === beschikbare thema's ===
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

  # De "normale" grootte van de presentatie, beeldverhouding wordt behouden
  # wanneer de presentatie wordt geschaald naar verschillende resoluties. Kan worden
  # opgegeven met percentages.
  width: 960
  height: 700

  # Factor van de weergavegrootte die leeg moet blijven rondom de inhoud
  margin: 0.1

  # Grenzen voor de kleinste/grootste schaal die op inhoud kan worden toegepast
  minScale: 0.2
  maxScale: 1.5

  # Besturingselementen weergeven in de rechteronderhoek
  controls: true

  # Een voortgangsbalk voor de presentatie weergeven
  progress: true

  # Het paginanummer van de huidige dia weergeven
  slideNumber: false

  # Elke diawijziging naar de browsergeschiedenis pushen
  history: false

  # Sneltoetsen voor navigatie inschakelen
  keyboard: true

  # De dia-overzichtsmodus inschakelen
  overview: true

  # Verticaal centreren van dia's
  center: true

  # Aanraaknav. inschakelen op apparaten met aanraakinvoer
  touch: true

  # De presentatie herhalen
  loop: false

  # De presentatierichting wijzigen naar RTL
  rtl: false

  # Willekeurige volgorde van dia's bij elke presentatielaad
  shuffle: false

  # Fragmenten globaal in- en uitschakelen
  fragments: true

  # Vlag of de presentatie wordt uitgevoerd in een ingesloten modus,
  # d.w.z. beperkt tot een beperkt deel van het scherm
  embedded: false

  # Vlag of we een helpoverlay moeten tonen wanneer de vraagteken-
  # toets wordt ingedrukt
  help: true

  # Vlag of sprekernotities zichtbaar moeten zijn voor alle kijkers
  showNotes: false

  # Aantal milliseconden tussen automatisch doorgaan naar de
  # volgende dia, uitgeschakeld wanneer ingesteld op 0, deze waarde kan worden overschreven
  # door een data-autoslide-attribuut op uw dia's te gebruiken
  autoSlide: 0

  # Stop automatisch schuiven na gebruikersinvoer
  autoSlideStoppable: true

  # Dianavigatie via muiswiel inschakelen
  mouseWheel: false

  # Verbergt de adresbalk op mobiele apparaten
  hideAddressBar: true

  # Opent koppelingen in een iframe-voorbeeldoverlay
  previewLinks: false

  # Overgansstijl
  transition: 'default' # none/fade/slide/convex/concave/zoom

  # Overgangssnelheid
  transitionSpeed: 'default' # default/fast/slow

  # Overgansstijl voor achtergronden van volledige paginadia's
  backgroundTransition: 'default' # none/fade/slide/convex/concave/zoom

  # Aantal dia's van de huidige dia af die zichtbaar zijn
  viewDistance: 3

  # Parallax-achtergrondafbeelding
  parallaxBackgroundImage: '' # bijv. "'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg'"

  # Parallax-achtergrondgrootte
  parallaxBackgroundSize: '' # CSS-syntaxis, bijv. "2100px 900px"

  # Aantal pixels om de parallax-achtergrond per dia te verplaatsen
  # - Automatisch berekend tenzij opgegeven
  # - Instellen op 0 om beweging langs een as uit te schakelen
  parallaxBackgroundHorizontal: null
  parallaxBackgroundVertical: null

  # Parallax-achtergrondafbeelding
  parallaxBackgroundImage: '' # bijv. "https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg"

  # Parallax-achtergrondgrootte
  parallaxBackgroundSize: '' # CSS-syntaxis, bijv. "2100px 900px" - momenteel worden alleen pixels ondersteund (gebruik geen % of auto)

  # Aantal pixels om de parallax-achtergrond per dia te verplaatsen
  # - Automatisch berekend tenzij opgegeven
  # - Instellen op 0 om beweging langs een as uit te schakelen
  parallaxBackgroundHorizontal: 200
  parallaxBackgroundVertical: 50

  # Sprekernotities inschakelen
  enableSpeakerNotes: false
---
```

## Diastijl aanpassen

U kunt `id` en `class` toevoegen aan een specifieke dia als volgt:

```markdown
<!-- slide id="my-id" class="my-class1 my-class2" -->
```

Of als u alleen de `n`-de dia wilt aanpassen, wijzig dan uw `less`-bestand als volgt:

```less
.markdown-preview.markdown-preview {
  // aangepaste presentatiestijl
  .reveal .slides {
    // alle dia's aanpassen
  }

  .slides > section:nth-child(1) {
    // dit past `de eerste dia` aan
  }
}
```

[➔ Pandoc](pandoc.md)
