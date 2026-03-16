# Exportation PDF

> Nous recommandons d'utiliser [Chrome (Puppeteer) pour exporter en PDF](puppeteer.md).

## Utilisation

Cliquez avec le bouton droit sur l'aperçu, puis choisissez `Open in Browser`.
Imprimez en PDF depuis le navigateur.

![screen shot 2017-07-14 at 1 46 39 am](https://user-images.githubusercontent.com/1908863/28201366-536dbc0a-6836-11e7-866f-db9a5d12de16.png)

## Personnaliser le CSS

<kbd>cmd-shift-p</kbd> puis exécutez la commande `Markdown Preview Enhanced: Customize Css` pour ouvrir le fichier `style.less`, puis ajoutez et modifiez les lignes suivantes :

```less
.markdown-preview.markdown-preview {
  @media print {
    // your code here
  }
}
```

---

Vous pouvez également générer un fichier PDF via [puppeteer](puppeteer.md) ou [prince](prince.md).
