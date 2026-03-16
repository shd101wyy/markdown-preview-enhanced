# RTF-document

## Overzicht

Om een RTF-document te maken vanuit R Markdown, geeft u het uitvoerformaat `rtf_document` op in de front-matter van uw document:

```yaml
---
title: "Gewoonten"
author: Jan Jansen
date: 22 maart 2005
output: rtf_document
---

```

## Exportpad

U kunt het exportpad van het document definiëren door de optie `path` op te geven. Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  rtf_document:
    path: /Exports/Gewoonten.rtf
---

```

Als `path` niet is gedefinieerd, wordt het document gegenereerd in dezelfde map.

## Inhoudsopgave

U kunt een inhoudsopgave toevoegen met de optie `toc` en de diepte van koppen opgeven waarop het van toepassing is met de optie `toc_depth`. Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  rtf_document:
    toc: true
    toc_depth: 2
---

```

Als de diepte van de inhoudsopgave niet expliciet is opgegeven, wordt standaard 3 gebruikt (wat betekent dat alle koppen van niveau 1, 2 en 3 worden opgenomen in de inhoudsopgave).

_Let op:_ deze TOC is anders dan de `<!-- toc -->` gegenereerd door **Markdown Preview Enhanced**.

## Pandoc-argumenten

Als er pandoc-functies zijn die u wilt gebruiken die geen equivalenten hebben in de hierboven beschreven YAML-opties, kunt u ze nog steeds gebruiken door aangepaste `pandoc_args` door te geven. Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  rtf_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## Gedeelde opties

Als u een set standaardopties wilt opgeven die worden gedeeld door meerdere documenten in een map, kunt u een bestand met de naam `_output.yaml` in de map opnemen. Houd er rekening mee dat er geen YAML-scheidingstekens of omsluitend uitvoerobject in dit bestand worden gebruikt. Bijvoorbeeld:

**\_output.yaml**

```yaml
rtf_document:
  toc: true
```

Alle documenten in dezelfde map als `_output.yaml` nemen de opties over. Opties die expliciet in documenten zijn gedefinieerd, overschrijven die welke zijn opgegeven in het gedeelde optiesbestand.
