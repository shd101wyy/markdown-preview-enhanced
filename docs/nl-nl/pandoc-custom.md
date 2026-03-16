# Aangepast document

## Overzicht

**Aangepast document** biedt u de mogelijkheid om de volledige kracht van `pandoc` te benutten.  
Om een aangepast document te maken, moet u het uitvoerformaat `custom_document` opgeven in de front-matter van uw document, **en** `path` **moet worden gedefinieerd**.

Het onderstaande codevoorbeeld gedraagt zich vergelijkbaar als een [pdf-document](pdf.md).

```yaml
---
title: "Gewoonten"
author: Jan Jansen
date: 22 maart 2005
output:
  custom_document:
    path: /Exports/test.pdf
    toc: true
---

```

Het onderstaande codevoorbeeld gedraagt zich vergelijkbaar als een [beamer-presentatie](pandoc-beamer.md).

```yaml
---
title: "Gewoonten"
author: Jan Jansen
date: 22 maart 2005
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["-t", "beamer"]
---

```

## Pandoc-argumenten

Als er pandoc-functies zijn die u wilt gebruiken die geen equivalenten hebben in de hierboven beschreven YAML-opties, kunt u ze nog steeds gebruiken door aangepaste `pandoc_args` door te geven. Bijvoorbeeld:

```yaml
---
title: "Gewoonten"
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Gedeelde opties

Als u een set standaardopties wilt opgeven die worden gedeeld door meerdere documenten in een map, kunt u een bestand met de naam `_output.yaml` in de map opnemen. Houd er rekening mee dat er geen YAML-scheidingstekens of omsluitend uitvoerobject in dit bestand worden gebruikt. Bijvoorbeeld:

**\_output.yaml**

```yaml
custom_document:
  toc: true
  highlight: zenburn
```

Alle documenten in dezelfde map als `_output.yaml` nemen de opties over. Opties die expliciet in documenten zijn gedefinieerd, overschrijven die welke zijn opgegeven in het gedeelde optiesbestand.
