# Beamer-document

## Overzicht

Om een Beamer-presentatie te maken vanuit **Markdown Preview Enhanced**, geeft u het uitvoerformaat `beamer_presentation` op in de front-matter van uw document.  
U kunt een diavoorstelling maken die is opgedeeld in secties door de koplaabels `#` en `##` te gebruiken (u kunt ook een nieuwe dia maken zonder kop met een horizontale lijn (`----`).  
Hier is een eenvoudige diavoorstelling:

```markdown
---
title: "Gewoonten"
author: Jan Jansen
date: 22 maart 2005
output: beamer_presentation
---

# 's Ochtends

## Opstaan

- Wekker uitzetten
- Uit bed komen

## Ontbijt

- Eieren eten
- Koffie drinken

# 's Avonds

## Avondeten

- Spaghetti eten
- Wijn drinken

---

![foto van spaghetti](images/spaghetti.jpg)

## Gaan slapen

- In bed gaan
- Schapen tellen
```

## Exportpad

U kunt het exportpad van het document definiëren door de optie `path` op te geven. Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  beamer_presentation:
    path: /Exports/Gewoonten.pdf
---

```

Als `path` niet is gedefinieerd, wordt het document gegenereerd in dezelfde map.

## Incrementele opsommingstekens

U kunt opsommingstekens incrementeel renderen door de optie `incremental` toe te voegen:

```yaml
---
output:
  beamer_presentation:
    incremental: true
---

```

Als u opsommingstekens incrementeel wilt renderen voor sommige dia's maar niet voor andere, kunt u deze syntaxis gebruiken:

```markdown
> - Eieren eten
> - Koffie drinken
```

## Thema's

U kunt Beamer-thema's opgeven met de opties `theme`, `colortheme` en `fonttheme`:

```yaml
---
output:
  beamer_presentation:
    theme: "AnnArbor"
    colortheme: "dolphin"
    fonttheme: "structurebold"
---

```

## Inhoudsopgave

De optie `toc` geeft aan dat er een inhoudsopgave moet worden opgenomen aan het begin van de presentatie (alleen koppen van niveau 1 worden opgenomen in de inhoudsopgave). Bijvoorbeeld:

```yaml
---
output:
  beamer_presentation:
    toc: true
---

```

## Dianiveau

De optie `slide_level` definieert het kopniveau dat individuele dia's definieert. Standaard is dit het hoogste kopniveau in de hiërarchie dat direct wordt gevolgd door inhoud en niet door een andere kop, ergens in het document. Deze standaardwaarde kan worden overschreven door een expliciet `slide_level` op te geven:

```yaml
---
output:
  beamer_presentation:
    slide_level: 2
---

```

## Syntaxmarkering

De optie `highlight` geeft de syntaxmarkeringsstijl aan. Ondersteunde stijlen zijn "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn" en "haddock" (geef null op om syntaxmarkering te voorkomen):

Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  beamer_presentation:
    highlight: tango
---

```

## Pandoc-argumenten

Als er pandoc-functies zijn die u wilt gebruiken die geen equivalenten hebben in de hierboven beschreven YAML-opties, kunt u ze nog steeds gebruiken door aangepaste `pandoc_args` door te geven. Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  beamer_presentation:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Gedeelde opties

Als u een set standaardopties wilt opgeven die worden gedeeld door meerdere documenten in een map, kunt u een bestand met de naam `_output.yaml` in de map opnemen. Houd er rekening mee dat er geen YAML-scheidingstekens of omsluitend uitvoerobject in dit bestand worden gebruikt. Bijvoorbeeld:

**\_output.yaml**

```yaml
beamer_presentation:
  toc: true
```

Alle documenten in dezelfde map als `_output.yaml` nemen de opties over. Opties die expliciet in documenten zijn gedefinieerd, overschrijven die welke zijn opgegeven in het gedeelde optiesbestand.
