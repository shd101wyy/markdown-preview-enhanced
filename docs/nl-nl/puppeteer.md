# Chrome (Puppeteer)-export

## Installatie

U moet de [Chrome-browser](https://www.google.com/chrome/) geïnstalleerd hebben.

> Er is een extensie-instelling met de naam `chromePath` waarmee u het pad naar de Chrome-uitvoerbare kunt opgeven. Standaard hoeft u dit niet te wijzigen. De MPE-extensie zoekt automatisch naar het pad.

## Gebruik

Klik met de rechtermuisknop op de voorbeeldweergave en kies vervolgens `Chrome (Puppeteer)`.

## Puppeteer configureren

U kunt [PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions)- en [Screenshot](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions)-exportconfiguratie schrijven in front-matter. Bijvoorbeeld:

```yaml
---
puppeteer:
  landscape: true
  format: "A4"
  timeout: 3000 # <= Speciale configuratie, wat betekent waitFor 3000 ms
---

```

## Exporteren bij opslaan

```yaml
---
export_on_save:
    puppeteer: true # exporteer PDF bij opslaan
    puppeteer: ["pdf", "png"] # exporteer PDF- en PNG-bestanden bij opslaan
    puppeteer: ["png"] # exporteer PNG-bestand bij opslaan
---
```

## CSS aanpassen

<kbd>cmd-shift-p</kbd> en voer vervolgens de opdracht `Markdown Preview Enhanced: Customize Css` uit om het bestand `style.less` te openen, voeg dan de volgende regels toe en pas ze aan:

```less
.markdown-preview.markdown-preview {
  @media print {
    // uw code hier
  }
}
```
