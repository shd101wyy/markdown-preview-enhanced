# Table des matières

**Markdown Preview Enhanced** peut créer une `TOC` pour votre fichier Markdown.
Vous pouvez appuyer sur <kbd>cmd-shift-p</kbd> puis choisir `Markdown Preview Enhanced: Create Toc` pour créer une `TOC`.
Plusieurs TOC peuvent être créées.
Pour exclure un en-tête de la `TOC`, ajoutez `{ignore=true}` **après** votre en-tête.

![screen shot 2018-03-14 at 12 03 00 pm](https://user-images.githubusercontent.com/1908863/37418218-bb624e62-277f-11e8-88f5-8747a1c2e012.png)

> La TOC sera mise à jour lorsque vous sauvegardez le fichier Markdown.
> Vous devez garder l'aperçu ouvert pour que la TOC soit mise à jour.

## Configuration

- **orderedList**
  Utiliser ou non une liste ordonnée.
- **depthFrom**, **depthTo**
  `[1~6]` inclus.
- **ignoreLink**
  Si défini sur `true`, les entrées de la TOC ne seront pas des hyperliens.

## [TOC]

Vous pouvez également créer une `TOC` en insérant `[TOC]` dans votre fichier Markdown.
Par exemple :

```markdown
[TOC]

# En-tête 1

## En-tête 2 {ignore=true}

L'en-tête 2 sera ignoré de la TOC.
```

Cependant, **cette méthode n'affichera la TOC que dans l'aperçu**, sans modifier le contenu de l'éditeur.

## Configuration de [TOC] et de la TOC dans la barre latérale

Vous pouvez configurer `[TOC]` et la TOC dans la barre latérale en écrivant un front-matter :

```markdown
---
toc:
  depth_from: 1
  depth_to: 6
  ordered: false
---
```

[➔ Importation de fichiers](file-imports.md)
