# Prince PDF-export

**Markdown Preview Enhanced** ondersteunt [prince](https://www.princexml.com/) PDF-export.

## Installatie

U moet [prince](https://www.princexml.com/) geïnstalleerd hebben.
Voor `macOS` opent u een terminal en voert u de volgende opdracht uit:

```sh
brew install Caskroom/cask/prince
```

## Gebruik

Klik met de rechtermuisknop op de voorbeeldweergave en kies vervolgens `PDF (prince)`.

![screen shot 2017-07-14 at 1 44 23 am](https://user-images.githubusercontent.com/1908863/28201287-fb5ea8d0-6835-11e7-9bdb-2afb458ee5cc.png)

## CSS aanpassen

<kbd>cmd-shift-p</kbd> en voer vervolgens de opdracht `Markdown Preview Enhanced: Customize Css` uit om het bestand `style.less` te openen, voeg dan de volgende regels toe en pas ze aan:

```less
.markdown-preview.markdown-preview {
  &.prince {
    // uw prince css hier
  }
}
```

Bijvoorbeeld, om de paginagrootte te wijzigen naar `A4 liggend`:

```less
.markdown-preview.markdown-preview {
  &.prince {
    @page {
      size: A4 landscape;
    }
  }
}
```

Meer informatie is te vinden in de [prince-gebruikershandleiding](https://www.princexml.com/doc/).
Vooral [paginastijlen](https://www.princexml.com/doc/paged/#page-styles).

## Exporteren bij opslaan

Voeg de front-matter toe zoals hieronder:

```yaml
---
export_on_save:
  prince: true
---

```

Zodat het PDF-bestand wordt gegenereerd elke keer dat u uw markdown-bronbestand opslaat.

## Bekende problemen

- Werkt niet met `KaTeX` en `MathJax`.
