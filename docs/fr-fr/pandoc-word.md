# Document Word

## Vue d'ensemble

Pour créer un document Word, vous devez spécifier le format de sortie word_document dans le front-matter de votre document :

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: word_document
---

```

## Chemin d'exportation

Vous pouvez définir le chemin d'exportation du document en spécifiant l'option `path`. Par exemple :

```yaml
---
title: "Habits"
output:
  word_document:
    path: /Exports/Habits.docx
---

```

Si `path` n'est pas défini, le document sera généré dans le même répertoire.

## Coloration syntaxique

Vous pouvez utiliser l'option `highlight` pour contrôler le thème de coloration syntaxique. Par exemple :

```yaml
---
title: "Habits"
output:
  word_document:
    highlight: "tango"
---

```

## Référence de style

Utilisez le fichier spécifié comme référence de style lors de la production d'un fichier docx. Pour de meilleurs résultats, le docx de référence devrait être une version modifiée d'un fichier docx produit avec pandoc. Le contenu du docx de référence est ignoré, mais ses feuilles de style et propriétés de document (y compris les marges, la taille de page, l'en-tête et le pied de page) sont utilisés dans le nouveau docx. Si aucun docx de référence n'est spécifié sur la ligne de commande, pandoc cherchera un fichier `reference.docx` dans le répertoire de données utilisateur (voir --data-dir). Si celui-ci n'est pas trouvé non plus, des valeurs par défaut raisonnables seront utilisées.

```yaml
---
title: "Habits"
output:
  word_document:
    reference_docx: mystyles.docx
---

```

## Arguments Pandoc

S'il y a des fonctionnalités pandoc que vous souhaitez utiliser et qui n'ont pas d'équivalents dans les options YAML décrites ci-dessus, vous pouvez toujours les utiliser en passant des `pandoc_args` personnalisés. Par exemple :

```yaml
---
title: "Habits"
output:
  word_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## Options partagées

Si vous souhaitez spécifier un ensemble d'options par défaut à partager par plusieurs documents dans un répertoire, vous pouvez inclure un fichier nommé `_output.yaml` dans le répertoire. Notez qu'aucun délimiteur YAML ou objet de sortie englobant n'est utilisé dans ce fichier. Par exemple :

**\_output.yaml**

```yaml
word_document:
  highlight: zenburn
```

Tous les documents situés dans le même répertoire que `_output.yaml` hériteront de ses options. Les options définies explicitement dans les documents remplaceront celles spécifiées dans le fichier d'options partagées.
