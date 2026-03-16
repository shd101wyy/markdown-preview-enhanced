# Document RTF

## Vue d'ensemble

Pour créer un document RTF à partir de R Markdown, spécifiez le format de sortie `rtf_document` dans le front-matter de votre document :

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: rtf_document
---

```

## Chemin d'exportation

Vous pouvez définir le chemin d'exportation du document en spécifiant l'option `path`. Par exemple :

```yaml
---
title: "Habits"
output:
  rtf_document:
    path: /Exports/Habits.rtf
---

```

Si `path` n'est pas défini, le document sera généré dans le même répertoire.

## Table des matières

Vous pouvez ajouter une table des matières en utilisant l'option `toc` et spécifier la profondeur des en-têtes auxquels elle s'applique avec l'option `toc_depth`. Par exemple :

```yaml
---
title: "Habits"
output:
  rtf_document:
    toc: true
    toc_depth: 2
---

```

Si la profondeur de la table des matières n'est pas explicitement spécifiée, elle est par défaut de 3 (ce qui signifie que tous les en-têtes de niveau 1, 2 et 3 seront inclus dans la table des matières).

_Attention :_ cette TOC est différente de la `<!-- toc -->` générée par **Markdown Preview Enhanced**.

## Arguments Pandoc

S'il y a des fonctionnalités pandoc que vous souhaitez utiliser et qui n'ont pas d'équivalents dans les options YAML décrites ci-dessus, vous pouvez toujours les utiliser en passant des `pandoc_args` personnalisés. Par exemple :

```yaml
---
title: "Habits"
output:
  rtf_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## Options partagées

Si vous souhaitez spécifier un ensemble d'options par défaut à partager par plusieurs documents dans un répertoire, vous pouvez inclure un fichier nommé `_output.yaml` dans le répertoire. Notez qu'aucun délimiteur YAML ou objet de sortie englobant n'est utilisé dans ce fichier. Par exemple :

**\_output.yaml**

```yaml
rtf_document:
  toc: true
```

Tous les documents situés dans le même répertoire que `_output.yaml` hériteront de ses options. Les options définies explicitement dans les documents remplaceront celles spécifiées dans le fichier d'options partagées.
