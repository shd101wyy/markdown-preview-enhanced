# PDF-document

## Overzicht

Om een PDF-document te maken, moet u het uitvoerformaat `pdf_document` opgeven in de front-matter van uw document:

```yaml
---
title: "Gewoonten"
author: Jan Jansen
date: 22 maart 2005
output: pdf_document
---

```

## Exportpad

U kunt het exportpad van het document definiëren door de optie `path` op te geven. Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  pdf_document:
    path: /Exports/Gewoonten.pdf
---

```

Als `path` niet is gedefinieerd, wordt het document gegenereerd in dezelfde map.

## Inhoudsopgave

U kunt een inhoudsopgave toevoegen met de optie `toc` en de diepte van koppen opgeven waarop het van toepassing is met de optie `toc_depth`. Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  pdf_document:
    toc: true
    toc_depth: 2
---

```

Als de diepte van de inhoudsopgave niet expliciet is opgegeven, wordt standaard 3 gebruikt (wat betekent dat alle koppen van niveau 1, 2 en 3 worden opgenomen in de inhoudsopgave).

_Let op:_ deze TOC is anders dan de `<!-- toc -->` gegenereerd door **Markdown Preview Enhanced**.

U kunt sectienummering aan koppen toevoegen met de optie `number_sections`:

```yaml
---
title: "Gewoonten"
output:
  pdf_document:
    toc: true
    number_sections: true
---

```

## Syntaxmarkering

De optie `highlight` geeft de syntaxmarkeringsstijl aan. Ondersteunde stijlen zijn "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn" en "haddock" (geef null op om syntaxmarkering te voorkomen):

Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  pdf_document:
    highlight: tango
---

```

## LaTeX-opties

Veel aspecten van de LaTeX-sjabloon die wordt gebruikt om PDF-documenten te maken, kunnen worden aangepast met behulp van YAML-metadata op het hoogste niveau (houd er rekening mee dat deze opties niet onder de sectie `output` staan, maar op het hoogste niveau samen met titel, auteur, enz.). Bijvoorbeeld:

```yaml
---
title: "Gewasanalyse Q3 2013"
output: pdf_document
fontsize: 11pt
geometry: margin=1in
---

```

Beschikbare metadatavariabelen zijn:

| Variabele                      | Beschrijving                                                                              |
| ------------------------------ | ----------------------------------------------------------------------------------------- |
| papersize                      | Papiergrootte, bijv. `letter`, `A4`                                                       |
| lang                           | Documenttaalcode                                                                          |
| fontsize                       | Lettergrootte (bijv. 10pt, 11pt, 12pt)                                                    |
| documentclass                  | LaTeX-documentklasse (bijv. article)                                                      |
| classoption                    | Optie voor documentclass (bijv. oneside); kan worden herhaald                             |
| geometry                       | Opties voor geometrieklasse (bijv. margin=1in); kan worden herhaald                       |
| linkcolor, urlcolor, citecolor | Kleur voor interne, externe en citatiekoppelingen (red, green, magenta, cyan, blue, black)|
| thanks                         | Specificeert de inhoud van de voetnoot voor dankbetuigingen na de documenttitel.          |

Meer beschikbare variabelen zijn [hier](https://pandoc.org/MANUAL.html#variables-for-latex) te vinden.

### LaTeX-pakketten voor citaten

Standaard worden citaten verwerkt via `pandoc-citeproc`, wat voor alle uitvoerformaten werkt. Voor PDF-uitvoer is het soms beter om LaTeX-pakketten te gebruiken om citaten te verwerken, zoals `natbib` of `biblatex`. Om een van deze pakketten te gebruiken, stelt u eenvoudig de optie `citation_package` in op `natbib` of `biblatex`, bijv.

```yaml
---
output:
  pdf_document:
    citation_package: natbib
---

```

## Geavanceerde aanpassing

### LaTeX-engine

Standaard worden PDF-documenten gerenderd met `pdflatex`. U kunt een alternatieve engine opgeven met de optie `latex_engine`. Beschikbare engines zijn "pdflatex", "xelatex" en "lualatex". Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  pdf_document:
    latex_engine: xelatex
---

```

### Insluiten

U kunt meer geavanceerde aanpassing van PDF-uitvoer doen door aanvullende LaTeX-instructies en/of inhoud in te sluiten of door de kern pandoc-sjabloon volledig te vervangen. Om inhoud in de documentkoptekst of voor/na de documenttekst in te sluiten, gebruikt u de optie `includes` als volgt:

```yaml
---
title: "Gewoonten"
output:
  pdf_document:
    includes:
      in_header: header.tex
      before_body: doc_prefix.tex
      after_body: doc_suffix.tex
---

```

### Aangepaste sjablonen

U kunt ook de onderliggende pandoc-sjabloon vervangen met de optie `template`:

```yaml
---
title: "Gewoonten"
output:
  pdf_document:
    template: quarterly_report.tex
---

```

Raadpleeg de documentatie over [pandoc-sjablonen](https://pandoc.org/README.html#templates) voor meer informatie over sjablonen. U kunt ook de [standaard LaTeX-sjabloon](https://github.com/jgm/pandoc-templates/blob/master/default.latex) als voorbeeld bestuderen.

### Pandoc-argumenten

Als er pandoc-functies zijn die u wilt gebruiken die geen equivalenten hebben in de hierboven beschreven YAML-opties, kunt u ze nog steeds gebruiken door aangepaste `pandoc_args` door te geven. Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  pdf_document:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Gedeelde opties

Als u een set standaardopties wilt opgeven die worden gedeeld door meerdere documenten in een map, kunt u een bestand met de naam `_output.yaml` in de map opnemen. Houd er rekening mee dat er geen YAML-scheidingstekens of omsluitend uitvoerobject in dit bestand worden gebruikt. Bijvoorbeeld:

**\_output.yaml**

```yaml
pdf_document:
  toc: true
  highlight: zenburn
```

Alle documenten in dezelfde map als `_output.yaml` nemen de opties over. Opties die expliciet in documenten zijn gedefinieerd, overschrijven die welke zijn opgegeven in het gedeelde optiesbestand.
