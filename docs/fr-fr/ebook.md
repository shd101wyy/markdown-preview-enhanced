# Génération d'eBook

Inspiré par _GitBook_  
**Markdown Preview Enhanced** peut exporter du contenu sous forme de livre électronique (ePub, Mobi, PDF).

![Screen Shot 2016-09-08 at 9.42.43 PM](https://ooo.0o0.ooo/2016/09/09/57d221c0a618a.png)

Pour générer un livre électronique, vous devez avoir `ebook-convert` installé.

## Installer ebook-convert

**macOS**  
Téléchargez l'[application Calibre](https://calibre-ebook.com/download). Après avoir déplacé `calibre.app` dans votre dossier Applications, créez un lien symbolique vers l'outil `ebook-convert` :

```shell
$ sudo ln -s ~/Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin
```

**Windows**  
Téléchargez et installez l'[application Calibre](https://calibre-ebook.com/download).  
Ajoutez `ebook-convert` à votre `$PATH`.

## Exemple d'eBook

Un exemple de projet eBook peut être trouvé [ici](https://github.com/shd101wyy/ebook-example).

## Commencer à écrire un eBook

Vous pouvez configurer un livre électronique en ajoutant simplement un `front-matter ebook` dans votre fichier Markdown.

```yaml
---
ebook:
  theme: github-light.css
  title: My eBook
  authors: shd101wyy
---

```

---

## Démonstration

`SUMMARY.md` est un exemple de fichier d'entrée. Il doit également avoir une TOC pour aider à organiser le livre :

```markdown
---
ebook:
  theme: github-light.css
  title: Markdown Preview Enhanced
  author: shd101wyy
---

# Préface

Ceci est la préface, mais pas obligatoire.

# Table des matières

- [Chapitre 1](/chapter1/README.md)
  - [Introduction de Markdown Preview Enhanced](/chapter1/intro.md)
  - [Fonctionnalités](/chapter1/feature.md)
- [Chapitre 2](/chapter2/README.md)
  - [Problèmes connus](/chapter2/issues.md)
```

La dernière liste dans le fichier Markdown est considérée comme la TOC.

Le titre du lien est utilisé comme titre du chapitre, et la cible du lien est un chemin vers le fichier de ce chapitre.

---

Pour exporter un livre électronique, ouvrez `SUMMARY.md` avec l'aperçu ouvert. Puis cliquez avec le bouton droit sur l'aperçu, choisissez `Export to Disk`, puis choisissez l'option `EBOOK`. Vous pouvez ensuite exporter votre livre électronique.

### Métadonnées

- **theme**
  le thème à utiliser pour l'eBook, par défaut il utilisera le thème d'aperçu. La liste des thèmes disponibles peut être trouvée dans la section `previewTheme` de [cette documentation](https://github.com/shd101wyy/crossnote/#notebook-configuration).
- **title**  
  titre de votre livre
- **authors**  
  auteur1 & auteur2 & ...
- **cover**  
  https://path-to-image.png
- **comments**  
  Définir la description du livre électronique
- **publisher**  
  qui est l'éditeur ?
- **book-producer**  
  qui est le producteur du livre
- **pubdate**  
  date de publication
- **language**  
  Définir la langue
- **isbn**  
  ISBN du livre
- **tags**  
  Définir les étiquettes du livre. Doit être une liste séparée par des virgules.
- **series**  
  Définir la série à laquelle appartient ce livre électronique.
- **rating**  
  Définir la note. Doit être un nombre entre 1 et 5.
- **include_toc**  
  `par défaut: true` Inclure ou non la TOC que vous avez écrite dans votre fichier d'entrée.

Par exemple :

```yaml
ebook:
  title: My eBook
  author: shd101wyy
  rating: 5
```

### Apparence

Les options suivantes sont fournies pour aider à contrôler l'apparence de la sortie

- **asciiize** `[true/false]`  
  `par défaut: false`, Translittérer les caractères unicode en une représentation ASCII. À utiliser avec précaution car cela remplacera les caractères unicode par des caractères ASCII
- **base-font-size** `[number]`  
  La taille de base de la police en pts. Toutes les tailles de polices dans le livre produit seront redimensionnées en fonction de cette taille. En choisissant une taille plus grande, vous pouvez agrandir les polices dans la sortie et vice versa. Par défaut, la taille de base de la police est choisie en fonction du profil de sortie que vous avez choisi.
- **disable-font-rescaling** `[true/false]`  
  `par défaut: false` Désactiver tout redimensionnement des tailles de polices.
- **line-height** `[number]`  
  La hauteur de ligne en pts. Contrôle l'espacement entre les lignes consécutives de texte. S'applique uniquement aux éléments qui ne définissent pas leur propre hauteur de ligne. Dans la plupart des cas, l'option de hauteur de ligne minimale est plus utile. Par défaut, aucune manipulation de la hauteur de ligne n'est effectuée.
- **margin-top** `[number]`  
  `par défaut: 72.0` Définir la marge supérieure en pts. La valeur par défaut est 72. La définir à moins de zéro ne définira aucune marge (le paramètre de marge dans le document original sera préservé). Note : 72 pts équivaut à 1 pouce
- **margin-right** `[number]`  
  `par défaut: 72.0`
- **margin-bottom** `[number]`  
  `par défaut: 72.0`
- **margin-left** `[number]`  
  `par défaut: 72.0`
- **margin** `[number/array]`  
  `par défaut: 72.0`  
  Vous pouvez définir **margin top/right/bottom/left** en même temps. Par exemple :

```yaml
ebook:
  margin: 5 # margin-top = margin-right = margin-bottom = margin-left = 5
```

```yaml
ebook:
  margin: [4, 8] # margin-top = margin-bottom = 4, margin-left = margin-right = 8
```

```yaml
ebook:
  margin: [1, 2, 3, 4] # margin-top=1, margin-right=2, margin-bottom=3, margin-left=4
```

Par exemple :

```yaml
ebook:
  title: My eBook
  base-font-size: 8
  margin: 72
```

## Formats de sortie

Pour l'instant, vous pouvez exporter un livre électronique au format `ePub`, `mobi`, `pdf`, `html`.

### ePub

Pour configurer la sortie `ePub`, ajoutez simplement `epub` après `ebook`.

```yaml
---
ebook:
  epub:
    no-default-epub-cover: true
    pretty-print: true
---

```

les options suivantes sont fournies :

- **no-default-epub-cover** `[true/false]`  
  Normalement, si le fichier d'entrée n'a pas de couverture et que vous n'en spécifiez pas une, une couverture par défaut est générée avec le titre, les auteurs, etc. Cette option désactive la génération de cette couverture.
- **no-svg-cover** `[true/false]`  
  Ne pas utiliser SVG pour la couverture du livre. Utilisez cette option si votre EPUB va être utilisé sur un appareil ne prenant pas en charge SVG, comme l'iPhone ou le JetBook Lite. Sans cette option, ces appareils afficheraient la couverture comme une page vierge.
- **pretty-print** `[true/false]`  
  Si spécifié, le plugin de sortie essaiera de créer une sortie aussi lisible que possible. Peut ne pas avoir d'effet pour certains plugins de sortie.

### PDF

Pour configurer la sortie `pdf`, ajoutez simplement `pdf` après `ebook`.

```yaml
ebook:
  pdf:
    paper-size: letter
    default-font-size: 12
    header-template: "<span> Written by shd101wyy _PAGENUM_ </span>"
```

les options suivantes sont fournies :

- **paper-size**  
  La taille du papier. Cette taille sera remplacée lorsqu'un profil de sortie non par défaut est utilisé. La valeur par défaut est letter. Les choix sont `a0`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `b0`, `b1`, `b2`, `b3`, `b4`, `b5`, `b6`, `legal`, `letter`
- **default-font-size** `[number]`  
  La taille de police par défaut
- **footer-template**  
  Un modèle HTML utilisé pour générer des pieds de page sur chaque page. Les chaînes `_PAGENUM_`, `_TITLE_`, `_AUTHOR_` et `_SECTION_` seront remplacées par leurs valeurs actuelles.
- **header-template**  
  Un modèle HTML utilisé pour générer des en-têtes sur chaque page. Les chaînes `_PAGENUM_`, `_TITLE_`, `_AUTHOR_` et `_SECTION_` seront remplacées par leurs valeurs actuelles.
- **page-numbers** `[true/false]`  
  `par défaut: false`  
  Ajouter des numéros de page en bas de chaque page dans le fichier PDF généré. Si vous spécifiez un modèle de pied de page, il aura la priorité sur cette option.
- **pretty-print** `[true/false]`  
  Si spécifié, le plugin de sortie essaiera de créer une sortie aussi lisible que possible. Peut ne pas avoir d'effet pour certains plugins de sortie.

### HTML

L'exportation `.html` ne dépend pas de `ebook-convert`.  
Si vous exportez un fichier `.html`, toutes les images locales seront incluses en tant que données `base64` dans un seul fichier `html`.  
Pour configurer la sortie `html`, ajoutez simplement `html` après `ebook`.

```yaml
ebook:
  html:
    cdn: true
```

- **cdn**  
  Charger les fichiers CSS et JavaScript depuis `cdn.js`. Cette option n'est utilisée que lors de l'exportation d'un fichier `.html`.

## Arguments ebook-convert

S'il y a des fonctionnalités `ebook-convert` que vous souhaitez utiliser et qui n'ont pas d'équivalents dans les options YAML décrites ci-dessus, vous pouvez toujours les utiliser en passant des `args` personnalisés. Par exemple :

```yaml
---
ebook:
  title: My eBook
  args: ["--embed-all-fonts", "--embed-font-family"]
---

```

Vous pouvez trouver une liste d'arguments dans le [manuel ebook-convert](https://manual.calibre-ebook.com/generated/en/ebook-convert.html).

## Exporter à la sauvegarde

Ajoutez le front-matter comme ci-dessous :

```yaml
---
export_on_save:
  ebook: true
  // ou
  ebook: "epub"
  ebook: "pdf"
  ebook: "mobi"
  ebook: "html"
  ebook: ["pdf", ...]
---
```

Ainsi, les livres électroniques seront générés à chaque fois que vous sauvegardez votre fichier source Markdown.

## Problèmes connus et limitations

- La génération d'eBook est encore en développement.
- Tous les graphiques SVG générés par `mermaid`, `PlantUML`, etc. ne fonctionneront pas dans le livre électronique généré. Seul `viz` fonctionne.
- Seul **KaTeX** peut être utilisé pour la composition mathématique.  
  Et le fichier de livre électronique généré ne rend pas correctement les expressions mathématiques dans **iBook**.
- La génération de **PDF** et **Mobi** est instable.
- Le **Code Chunk** ne fonctionne pas avec la génération d'eBook.
