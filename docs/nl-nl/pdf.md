# PDF-export

> Wij raden aan [Chrome (Puppeteer) te gebruiken om PDF te exporteren](puppeteer.md).

## Gebruik

Klik met de rechtermuisknop op de voorbeeldweergave en kies vervolgens `Open in Browser`.
Druk vanuit de browser af als PDF.

![screen shot 2017-07-14 at 1 46 39 am](https://user-images.githubusercontent.com/1908863/28201366-536dbc0a-6836-11e7-866f-db9a5d12de16.png)

## CSS aanpassen

<kbd>cmd-shift-p</kbd> en voer vervolgens de opdracht `Markdown Preview Enhanced: Customize Css` uit om het bestand `style.less` te openen, voeg dan de volgende regels toe en pas ze aan:

```less
.markdown-preview.markdown-preview {
  @media print {
    // uw code hier
  }
}
```

---

U kunt ook een PDF-bestand genereren via [puppeteer](puppeteer.md) of [prince](prince.md).
