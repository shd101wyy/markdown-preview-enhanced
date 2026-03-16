# Document PDF

## Vue d'ensemble

Pour créer un document PDF, vous devez spécifier le format de sortie `pdf_document` dans le front-matter de votre document :

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: pdf_document
---

```

## Chemin d'exportation

Vous pouvez définir le chemin d'exportation du document en spécifiant l'option `path`. Par exemple :

```yaml
---
title: "Habits"
output:
  pdf_document:
    path: /Exports/Habits.pdf
---

```

Si `path` n'est pas défini, le document sera généré dans le même répertoire.

## Table des matières

Vous pouvez ajouter une table des matières en utilisant l'option `toc` et spécifier la profondeur des en-têtes auxquels elle s'applique avec l'option `toc_depth`. Par exemple :

```yaml
---
title: "Habits"
output:
  pdf_document:
    toc: true
    toc_depth: 2
---

```

Si la profondeur de la table des matières n'est pas explicitement spécifiée, elle est par défaut de 3 (ce qui signifie que tous les en-têtes de niveau 1, 2 et 3 seront inclus dans la table des matières).

_Attention :_ cette TOC est différente de la `<!-- toc -->` générée par **Markdown Preview Enhanced**.

Vous pouvez ajouter une numérotation de section aux en-têtes en utilisant l'option `number_sections` :

```yaml
---
title: "Habits"
output:
  pdf_document:
    toc: true
    number_sections: true
---

```

## Coloration syntaxique

L'option `highlight` spécifie le style de coloration syntaxique. Les styles pris en charge comprennent "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn" et "haddock" (spécifiez null pour empêcher la coloration syntaxique) :

Par exemple :

```yaml
---
title: "Habits"
output:
  pdf_document:
    highlight: tango
---

```

## Options LaTeX

De nombreux aspects du modèle LaTeX utilisé pour créer des documents PDF peuvent être personnalisés en utilisant des métadonnées YAML de niveau supérieur (notez que ces options n'apparaissent pas sous la section `output` mais apparaissent au niveau supérieur avec le titre, l'auteur, etc.). Par exemple :

```yaml
---
title: "Crop Analysis Q3 2013"
output: pdf_document
fontsize: 11pt
geometry: margin=1in
---

```

Les variables de métadonnées disponibles comprennent :

| Variable                       | Description                                                                                    |
| ------------------------------ | ---------------------------------------------------------------------------------------------- |
| papersize                      | taille du papier, ex. `letter`, `A4`                                                           |
| lang                           | Code de langue du document                                                                     |
| fontsize                       | Taille de police (ex. 10pt, 11pt, 12pt)                                                        |
| documentclass                  | Classe de document LaTeX (ex. article)                                                         |
| classoption                    | Option pour documentclass (ex. oneside) ; peut être répété                                     |
| geometry                       | Options pour la classe geometry (ex. margin=1in) ; peut être répété                            |
| linkcolor, urlcolor, citecolor | Couleur pour les liens internes, externes et de citation (red, green, magenta, cyan, blue, black) |
| thanks                         | spécifie le contenu de la note de bas de page de remerciements après le titre du document.     |

Plus de variables disponibles peuvent être trouvées [ici](https://pandoc.org/MANUAL.html#variables-for-latex).

### Paquets LaTeX pour les citations

Par défaut, les citations sont traitées via `pandoc-citeproc`, qui fonctionne pour tous les formats de sortie. Pour la sortie PDF, il est parfois préférable d'utiliser des paquets LaTeX pour traiter les citations, comme `natbib` ou `biblatex`. Pour utiliser l'un de ces paquets, définissez simplement l'option `citation_package` sur `natbib` ou `biblatex`, par exemple :

```yaml
---
output:
  pdf_document:
    citation_package: natbib
---

```

## Personnalisation avancée

### Moteur LaTeX

Par défaut, les documents PDF sont rendus en utilisant `pdflatex`. Vous pouvez spécifier un moteur alternatif en utilisant l'option `latex_engine`. Les moteurs disponibles sont "pdflatex", "xelatex" et "lualatex". Par exemple :

```yaml
---
title: "Habits"
output:
  pdf_document:
    latex_engine: xelatex
---

```

### Inclure

Vous pouvez effectuer une personnalisation plus avancée de la sortie PDF en incluant des directives LaTeX supplémentaires et/ou du contenu, ou en remplaçant entièrement le modèle pandoc de base. Pour inclure du contenu dans l'en-tête du document ou avant/après le corps du document, utilisez l'option `includes` comme suit :

```yaml
---
title: "Habits"
output:
  pdf_document:
    includes:
      in_header: header.tex
      before_body: doc_prefix.tex
      after_body: doc_suffix.tex
---

```

### Modèles personnalisés

Vous pouvez également remplacer le modèle pandoc sous-jacent en utilisant l'option `template` :

```yaml
---
title: "Habits"
output:
  pdf_document:
    template: quarterly_report.tex
---

```

Consultez la documentation sur les [modèles pandoc](https://pandoc.org/README.html#templates) pour plus de détails sur les modèles. Vous pouvez également étudier le [modèle LaTeX par défaut](https://github.com/jgm/pandoc-templates/blob/master/default.latex) comme exemple.

### Arguments Pandoc

S'il y a des fonctionnalités pandoc que vous souhaitez utiliser et qui n'ont pas d'équivalents dans les options YAML décrites ci-dessus, vous pouvez toujours les utiliser en passant des `pandoc_args` personnalisés. Par exemple :

```yaml
---
title: "Habits"
output:
  pdf_document:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Options partagées

Si vous souhaitez spécifier un ensemble d'options par défaut à partager par plusieurs documents dans un répertoire, vous pouvez inclure un fichier nommé `_output.yaml` dans le répertoire. Notez qu'aucun délimiteur YAML ou objet de sortie englobant n'est utilisé dans ce fichier. Par exemple :

**\_output.yaml**

```yaml
pdf_document:
  toc: true
  highlight: zenburn
```

Tous les documents situés dans le même répertoire que `_output.yaml` hériteront de ses options. Les options définies explicitement dans les documents remplaceront celles spécifiées dans le fichier d'options partagées.
