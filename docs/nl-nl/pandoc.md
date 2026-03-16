# Pandoc

**Markdown Preview Enhanced** ondersteunt de functie `pandoc document export` die op dezelfde manier werkt als `RStudio Markdown`.  
Om deze functie te gebruiken, moet u [pandoc](https://pandoc.org/) geïnstalleerd hebben.  
Installatie-instructies voor pandoc zijn te vinden [hier](https://pandoc.org/installing.html).  
U kunt `pandoc document export` gebruiken door met de rechtermuisknop op de voorbeeldweergave te klikken, waarna u het in het contextmenu ziet.

---

## Pandoc-parser

Standaard gebruikt **Markdown Preview Enhanced** [markdown-it](https://github.com/markdown-it/markdown-it) om markdown te parseren.  
U kunt het ook instellen op de `pandoc`-parser via de pakketinstellingen.

![Screen Shot 2017-03-07 at 10.05.25 PM](https://i.imgur.com/NdCJBgR.png)

U kunt ook pandoc-argumenten instellen voor individuele bestanden door front-matter te schrijven:

```markdown
---
pandoc_args: ["--toc", "--toc-depth=2"]
---
```

Houd er rekening mee dat `--filter=pandoc-citeproc` automatisch wordt toegevoegd als er `references` of `bibliography` in uw front-matter staat.

**Let op**: Deze functie is nog experimenteel. Stel gerust problemen of suggesties in.  
**Bekende problemen & beperkingen**:

1. `ebook`-export heeft problemen.
2. `Code Chunk` is soms foutgevoelig.

## Front-Matter

`pandoc document export` vereist het schrijven van `front-matter`.  
Meer informatie en een handleiding over hoe u `front-matter` kunt schrijven, zijn [hier](https://jekyllrb.com/docs/frontmatter/) te vinden.

## Exporteren

U hoeft de `Pandoc Parser` die hierboven is vermeld niet te gebruiken om bestanden te exporteren.

De volgende formaten worden momenteel ondersteund, **meer formaten worden in de toekomst ondersteund.**  
(Sommige voorbeelden zijn ontleend aan [RStudio Markdown](https://rmarkdown.rstudio.com/formats.html))  
Klik op de onderstaande koppeling om het documentformaat te zien dat u wilt exporteren.

- [PDF](pandoc-pdf.md)
- [Word](pandoc-word.md)
- [RTF](pandoc-rtf.md)
- [Beamer](pandoc-beamer.md)

U kunt ook uw eigen aangepaste document definiëren:

- [Aangepast](pandoc-custom.md)

## Exporteren bij opslaan

Voeg de front-matter toe zoals hieronder:

```yaml
---
export_on_save:
  pandoc: true
---

```

Zodat pandoc wordt uitgevoerd elke keer dat u uw markdown-bronbestand opslaat.

## Artikelen

- [Bibliografieën en citaten](pandoc-bibliographies-and-citations.md)

## Let op

`mermaid, wavedrom` werkt niet met `pandoc document export`.  
[code chunk](code-chunk.md) is gedeeltelijk compatibel met `pandoc document export`.
