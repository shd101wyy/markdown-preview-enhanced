# Document Beamer

## Vue d'ensemble

Pour créer une présentation Beamer à partir de **Markdown Preview Enhanced**, vous spécifiez le format de sortie `beamer_presentation` dans le front-matter de votre document.  
Vous pouvez créer un diaporama divisé en sections en utilisant les balises d'en-tête `#` et `##` (vous pouvez également créer une nouvelle diapositive sans en-tête en utilisant une règle horizontale (`----`).  
Voici par exemple un diaporama simple :

```markdown
---
title: "Habits"
author: John Doe
date: March 22, 2005
output: beamer_presentation
---

# Le matin

## Se lever

- Éteindre le réveil
- Sortir du lit

## Petit-déjeuner

- Manger des œufs
- Boire du café

# Le soir

## Dîner

- Manger des spaghettis
- Boire du vin

---

![photo de spaghettis](images/spaghetti.jpg)

## Aller dormir

- Se mettre au lit
- Compter les moutons
```

## Chemin d'exportation

Vous pouvez définir le chemin d'exportation du document en spécifiant l'option `path`. Par exemple :

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    path: /Exports/Habits.pdf
---

```

Si `path` n'est pas défini, le document sera généré dans le même répertoire.

## Puces incrémentielles

Vous pouvez rendre les puces de manière incrémentielle en ajoutant l'option `incremental` :

```yaml
---
output:
  beamer_presentation:
    incremental: true
---

```

Si vous souhaitez rendre les puces de manière incrémentielle pour certaines diapositives mais pas d'autres, vous pouvez utiliser cette syntaxe :

```markdown
> - Manger des œufs
> - Boire du café
```

## Thèmes

Vous pouvez spécifier des thèmes Beamer en utilisant les options `theme`, `colortheme` et `fonttheme` :

```yaml
---
output:
  beamer_presentation:
    theme: "AnnArbor"
    colortheme: "dolphin"
    fonttheme: "structurebold"
---

```

## Table des matières

L'option `toc` spécifie qu'une table des matières doit être incluse au début de la présentation (seuls les en-têtes de niveau 1 seront inclus dans la table des matières). Par exemple :

```yaml
---
output:
  beamer_presentation:
    toc: true
---

```

## Niveau de diapositive

L'option `slide_level` définit le niveau d'en-tête qui définit les diapositives individuelles. Par défaut, c'est le niveau d'en-tête le plus élevé dans la hiérarchie qui est immédiatement suivi de contenu, et non d'un autre en-tête, quelque part dans le document. Cette valeur par défaut peut être remplacée en spécifiant un `slide_level` explicite :

```yaml
---
output:
  beamer_presentation:
    slide_level: 2
---

```

## Coloration syntaxique

L'option `highlight` spécifie le style de coloration syntaxique. Les styles pris en charge comprennent "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn" et "haddock" (spécifiez null pour empêcher la coloration syntaxique) :

Par exemple :

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    highlight: tango
---

```

## Arguments Pandoc

S'il y a des fonctionnalités pandoc que vous souhaitez utiliser et qui n'ont pas d'équivalents dans les options YAML décrites ci-dessus, vous pouvez toujours les utiliser en passant des `pandoc_args` personnalisés. Par exemple :

```yaml
---
title: "Habits"
output:
  beamer_presentation:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Options partagées

Si vous souhaitez spécifier un ensemble d'options par défaut à partager par plusieurs documents dans un répertoire, vous pouvez inclure un fichier nommé `_output.yaml` dans le répertoire. Notez qu'aucun délimiteur YAML ou objet de sortie englobant n'est utilisé dans ce fichier. Par exemple :

**\_output.yaml**

```yaml
beamer_presentation:
  toc: true
```

Tous les documents situés dans le même répertoire que `_output.yaml` hériteront de ses options. Les options définies explicitement dans les documents remplaceront celles spécifiées dans le fichier d'options partagées.
