# Exportation Chrome (Puppeteer)

## Installation

Vous devez avoir le [navigateur Chrome](https://www.google.com/chrome/) installé.

> Il existe un paramètre d'extension nommé `chromePath` qui vous permet de spécifier le chemin vers l'exécutable Chrome. Par défaut, vous n'avez pas besoin de le modifier. L'extension MPE recherchera automatiquement le chemin.

## Utilisation

Cliquez avec le bouton droit sur l'aperçu, puis choisissez `Chrome (Puppeteer)`.

## Configurer puppeteer

Vous pouvez écrire la configuration d'exportation [PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions) et [Capture d'écran](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions) dans le front-matter. Par exemple :

```yaml
---
puppeteer:
  landscape: true
  format: "A4"
  timeout: 3000 # <= Configuration spéciale, signifie waitFor 3000 ms
---

```

## Exporter à la sauvegarde

```yaml
---
export_on_save:
    puppeteer: true # exporter PDF à la sauvegarde
    puppeteer: ["pdf", "png"] # exporter les fichiers PDF et PNG à la sauvegarde
    puppeteer: ["png"] # exporter le fichier PNG à la sauvegarde
---
```

## Personnaliser le CSS

<kbd>cmd-shift-p</kbd> puis exécutez la commande `Markdown Preview Enhanced: Customize Css` pour ouvrir le fichier `style.less`, puis ajoutez et modifiez les lignes suivantes :

```less
.markdown-preview.markdown-preview {
  @media print {
    // your code here
  }
}
```
