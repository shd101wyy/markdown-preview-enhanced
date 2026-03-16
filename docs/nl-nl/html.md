# HTML-export

## Gebruik

Klik met de rechtermuisknop op de voorbeeldweergave en klik op het tabblad `HTML`.  
Kies vervolgens:

- `HTML (offline)`
  Kies deze optie als u dit html-bestand alleen lokaal gaat gebruiken.
- `HTML (cdn hosted)`
  Kies deze optie als u uw html-bestand extern wilt implementeren.

![screen shot 2017-07-14 at 1 14 28 am](https://user-images.githubusercontent.com/1908863/28200455-d5a12d60-6831-11e7-8572-91d3845ce8cf.png)

## Configuratie

Standaardwaarden:

```yaml
---
html:
  embed_local_images: false
  embed_svg: true
  offline: false
  toc: undefined

print_background: false
---

```

Als `embed_local_images` is ingesteld op `true`, worden alle lokale afbeeldingen ingesloten als `base64`-formaat.

Om een zijbalk-TOC te genereren, moet u [enableScriptExecution](https://shd101wyy.github.io/markdown-preview-enhanced/#/code-chunk?id=code-chunk) inschakelen in de MPE-instellingen van vscode of atom.

Als `toc` is ingesteld op `false`, wordt de zijbalk-TOC uitgeschakeld. Als `toc` is ingesteld op `true`, wordt de zijbalk-TOC ingeschakeld en weergegeven. Als `toc` niet is opgegeven, wordt de zijbalk-TOC ingeschakeld, maar niet weergegeven.

## Exporteren bij opslaan

Voeg de front-matter toe zoals hieronder:

```yaml
---
export_on_save:
  html: true
---

```

Zodat het html-bestand wordt gegenereerd elke keer dat u uw markdown-bestand opslaat.
