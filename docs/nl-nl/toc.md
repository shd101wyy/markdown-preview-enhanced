# Inhoudsopgave

**Markdown Preview Enhanced** kan een `TOC` genereren voor uw markdown-bestand.
U kunt op <kbd>cmd-shift-p</kbd> drukken en vervolgens `Markdown Preview Enhanced: Create Toc` kiezen om een `TOC` te maken.
Er kunnen meerdere TOC's worden aangemaakt.
Om een kop uit te sluiten van de `TOC`, voegt u `{ignore=true}` **na** uw kop toe.

![screen shot 2018-03-14 at 12 03 00 pm](https://user-images.githubusercontent.com/1908863/37418218-bb624e62-277f-11e8-88f5-8747a1c2e012.png)

> De TOC wordt bijgewerkt wanneer u het markdown-bestand opslaat.
> U moet de voorbeeldweergave open houden om de TOC bijgewerkt te krijgen.

## Configuratie

- **orderedList**
  Al dan niet een geordende lijst gebruiken.
- **depthFrom**, **depthTo**
  `[1~6]` inclusief.
- **ignoreLink**
  Als ingesteld op `true`, zijn TOC-vermeldingen geen hyperlinks.

## [TOC]

U kunt ook een `TOC` maken door `[TOC]` in uw markdown-bestand in te voegen.
Bijvoorbeeld:

```markdown
[TOC]

# Kop 1

## Kop 2 {ignore=true}

Kop 2 wordt uitgesloten van de TOC.
```

Op deze manier wordt **de TOC echter alleen in de voorbeeldweergave weergegeven**, terwijl de editorinhoud ongewijzigd blijft.

## [TOC] en Zijbalk-TOC-configuratie

U kunt `[TOC]` en de zijbalk-TOC configureren door front-matter te schrijven:

```markdown
---
toc:
  depth_from: 1
  depth_to: 6
  ordered: false
---
```

[➔ Bestandsimport](file-imports.md)
