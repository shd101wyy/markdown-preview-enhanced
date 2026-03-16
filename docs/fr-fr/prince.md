# Exportation PDF avec Prince

**Markdown Preview Enhanced** prend en charge l'exportation PDF via [prince](https://www.princexml.com/).

## Installation

Vous devez avoir [prince](https://www.princexml.com/) installé.
Pour `macOS`, ouvrez le terminal et exécutez la commande suivante :

```sh
brew install Caskroom/cask/prince
```

## Utilisation

Cliquez avec le bouton droit sur l'aperçu, puis choisissez `PDF (prince)`.

![screen shot 2017-07-14 at 1 44 23 am](https://user-images.githubusercontent.com/1908863/28201287-fb5ea8d0-6835-11e7-9bdb-2afb458ee5cc.png)

## Personnaliser le CSS

<kbd>cmd-shift-p</kbd> puis exécutez la commande `Markdown Preview Enhanced: Customize Css` pour ouvrir le fichier `style.less`, puis ajoutez et modifiez les lignes suivantes :

```less
.markdown-preview.markdown-preview {
  &.prince {
    // your prince css here
  }
}
```

Par exemple, pour changer le format de page en `A4 paysage` :

```less
.markdown-preview.markdown-preview {
  &.prince {
    @page {
      size: A4 landscape;
    }
  }
}
```

Plus d'informations peuvent être trouvées dans le [guide de l'utilisateur de prince](https://www.princexml.com/doc/).
En particulier les [styles de page](https://www.princexml.com/doc/paged/#page-styles).

## Exporter à la sauvegarde

Ajoutez le front-matter comme ci-dessous :

```yaml
---
export_on_save:
  prince: true
---

```

Ainsi, le fichier PDF sera généré à chaque fois que vous sauvegardez votre fichier source Markdown.

## Problèmes connus

- Ne fonctionne pas avec `KaTeX` et `MathJax`.
