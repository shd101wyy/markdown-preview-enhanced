# Document personnalisé

## Vue d'ensemble

Le **Document personnalisé** vous donne la possibilité d'utiliser pleinement la puissance de `pandoc`.  
Pour créer un document personnalisé, vous devez spécifier le format de sortie `custom_document` dans le front-matter de votre document, **et** `path` **doit être défini**.

L'exemple de code ci-dessous se comportera de manière similaire au [document pdf](pdf.md).

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output:
  custom_document:
    path: /Exports/test.pdf
    toc: true
---

```

L'exemple de code ci-dessous se comportera de manière similaire à la [présentation beamer](pandoc-beamer.md).

```yaml
---
title: "Habits"
author: John Doe
date: March 22, 2005
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["-t", "beamer"]
---

```

## Arguments Pandoc

S'il y a des fonctionnalités pandoc que vous souhaitez utiliser et qui n'ont pas d'équivalents dans les options YAML décrites ci-dessus, vous pouvez toujours les utiliser en passant des `pandoc_args` personnalisés. Par exemple :

```yaml
---
title: "Habits"
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Options partagées

Si vous souhaitez spécifier un ensemble d'options par défaut à partager par plusieurs documents dans un répertoire, vous pouvez inclure un fichier nommé `_output.yaml` dans le répertoire. Notez qu'aucun délimiteur YAML ou objet de sortie englobant n'est utilisé dans ce fichier. Par exemple :

**\_output.yaml**

```yaml
custom_document:
  toc: true
  highlight: zenburn
```

Tous les documents situés dans le même répertoire que `_output.yaml` hériteront de ses options. Les options définies explicitement dans les documents remplaceront celles spécifiées dans le fichier d'options partagées.
