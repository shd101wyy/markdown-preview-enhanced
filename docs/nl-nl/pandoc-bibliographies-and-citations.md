# Bibliografieën en citaten

## Bibliografieën

### Een bibliografie opgeven

[Pandoc](https://pandoc.org/MANUAL.html#citations) kan automatisch citaten en een bibliografie genereren in een aantal stijlen. Om deze functie te gebruiken, moet u een bibliografiebestand opgeven met het metadataveld `bibliography` in een YAML-metadatasectie. Bijvoorbeeld:

```yaml
---
title: "Voorbeelddocument"
output: pdf_document
bibliography: bibliography.bib
---

```

Als u meerdere bibliografiebestanden opneemt, kunt u ze als volgt definiëren:

```yaml
---
bibliography: [bibliography1.bib, bibliography2.bib]
---

```

De bibliografie kan een van de volgende formaten hebben:

| Formaat     | Bestandsextensie |
| ----------- | ---------------- |
| BibLaTeX    | .bib             |
| BibTeX      | .bibtex          |
| Copac       | .copac           |
| CSL JSON    | .json            |
| CSL YAML    | .yaml            |
| EndNote     | .enl             |
| EndNote XML | .xml             |
| ISI         | .wos             |
| MEDLINE     | .medline         |
| MODS        | .mods            |
| RIS         | .ris             |

### Inlineverwijzingen

Als alternatief kunt u een veld `references` gebruiken in de YAML-metadata van het document. Dit moet een reeks YAML-gecodeerde verwijzingen bevatten, bijvoorbeeld:

```yaml
---
references:
  - id: fenner2012a
    title: One-click science marketing
    author:
      - family: Fenner
        given: Martin
    container-title: Nature Materials
    volume: 11
    URL: "https://dx.doi.org/10.1038/nmat3283"
    DOI: 10.1038/nmat3283
    issue: 4
    publisher: Nature Publishing Group
    page: 261-263
    type: article-journal
    issued:
      year: 2012
      month: 3
---

```

### Plaatsing van de bibliografie

Bibliografieën worden aan het einde van het document geplaatst. Normaal gesproken wilt u uw document beëindigen met een passende kop:

```markdown
laatste alinea...

# Referenties
```

De bibliografie wordt na deze kop ingevoegd.

## Citaten

### Citatiesyntaxis

Citaten staan tussen vierkante haakjes en worden gescheiden door puntkomma's. Elk citaat moet een sleutel hebben, samengesteld uit '@' + de citatie-identificator uit de database, en kan optioneel een prefix, een locator en een suffix hebben. Hier zijn enkele voorbeelden:

```
Blah blah [zie @doe99, pp. 33-35; ook @smith04, hfd. 1].

Blah blah [@doe99, pp. 33-35, 38-39 en *passim*].

Blah blah [@smith04; @doe99].
```

Een minteken `(-)` voor het `@` onderdrukt de vermelding van de auteur in het citaat. Dit kan nuttig zijn wanneer de auteur al in de tekst wordt vermeld:

```
Smith zegt blah [-@smith04].
```

U kunt ook een intekstueel citaat schrijven, als volgt:

```
@smith04 zegt blah.

@smith04 [p. 33] zegt blah.
```

### Ongebruikte verwijzingen (nocite)

Als u items in de bibliografie wilt opnemen zonder ze daadwerkelijk in de hoofdtekst te citeren, kunt u een dummy `nocite`-metadataveld definiëren en de citaten daar plaatsen:

```
---
nocite: |
  @item1, @item2
...

@item3
```

In dit voorbeeld bevat het document alleen een citaat voor `item3`, maar de bibliografie bevat vermeldingen voor `item1`, `item2` en `item3`.

### Citatiestijlen

Standaard gebruikt pandoc de Chicago-auteur-datum-indeling voor citaten en verwijzingen. Om een andere stijl te gebruiken, moet u een CSL 1.0-stijlbestand opgeven in het metadataveld `csl`. Bijvoorbeeld:

```yaml
---
title: "Voorbeelddocument"
output: pdf_document
bibliography: bibliography.bib
csl: biomed-central.csl
---

```

Een inleiding tot het maken en wijzigen van CSL-stijlen is [hier](https://citationstyles.org/downloads/primer.html) te vinden. Een opslagplaats van CSL-stijlen is [hier](https://github.com/citation-style-language/styles) te vinden. Zie ook https://zotero.org/styles voor eenvoudig bladeren.

### Citaten voor PDF-uitvoer

Standaard worden citaten gegenereerd door het hulpprogramma pandoc-citeproc, en het werkt voor alle uitvoerformaten. Wanneer de uitvoer LaTeX/PDF is, kunt u ook LaTeX-pakketten gebruiken (bijv. natbib) om citaten te genereren; zie [PDF-documenten](pandoc-pdf.md) voor details.
