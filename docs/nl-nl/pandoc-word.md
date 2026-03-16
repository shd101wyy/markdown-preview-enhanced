# Word-document

## Overzicht

Om een Word-document te maken, moet u het uitvoerformaat word_document opgeven in de front-matter van uw document:

```yaml
---
title: "Gewoonten"
author: Jan Jansen
date: 22 maart 2005
output: word_document
---

```

## Exportpad

U kunt het exportpad van het document definiëren door de optie `path` op te geven. Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  word_document:
    path: /Exports/Gewoonten.docx
---

```

Als `path` niet is gedefinieerd, wordt het document gegenereerd in dezelfde map.

## Syntaxmarkering

U kunt de optie `highlight` gebruiken om het syntaxmarkeringsthema te bepalen. Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  word_document:
    highlight: "tango"
---

```

## Stijlreferentie

Gebruik het opgegeven bestand als stijlreferentie bij het produceren van een docx-bestand. Voor de beste resultaten moet de referentie-docx een gewijzigde versie zijn van een docx-bestand geproduceerd met pandoc. De inhoud van de referentie-docx wordt genegeerd, maar de stijlbladen en documenteigenschappen (inclusief marges, paginagrootte, koptekst en voettekst) worden gebruikt in de nieuwe docx. Als er geen referentie-docx op de opdrachtregel is opgegeven, zoekt pandoc naar een bestand `reference.docx` in de gebruikersdatamap (zie --data-dir). Als dit ook niet wordt gevonden, worden redelijke standaardwaarden gebruikt.

```yaml
---
title: "Gewoonten"
output:
  word_document:
    reference_docx: mystyles.docx
---

```

## Pandoc-argumenten

Als er pandoc-functies zijn die u wilt gebruiken die geen equivalenten hebben in de hierboven beschreven YAML-opties, kunt u ze nog steeds gebruiken door aangepaste `pandoc_args` door te geven. Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  word_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## Gedeelde opties

Als u een set standaardopties wilt opgeven die worden gedeeld door meerdere documenten in een map, kunt u een bestand met de naam `_output.yaml` in de map opnemen. Houd er rekening mee dat er geen YAML-scheidingstekens of omsluitend uitvoerobject in dit bestand worden gebruikt. Bijvoorbeeld:

**\_output.yaml**

```yaml
word_document:
  highlight: zenburn
```

Alle documenten in dezelfde map als `_output.yaml` nemen de opties over. Opties die expliciet in documenten zijn gedefinieerd, overschrijven die welke zijn opgegeven in het gedeelde optiesbestand.
