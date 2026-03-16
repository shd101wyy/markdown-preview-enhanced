# Bibliographies et citations

## Bibliographies

### Spécifier une bibliographie

[Pandoc](https://pandoc.org/MANUAL.html#citations) peut générer automatiquement des citations et une bibliographie dans de nombreux styles. Pour utiliser cette fonctionnalité, vous devrez spécifier un fichier de bibliographie en utilisant le champ de métadonnées `bibliography` dans une section de métadonnées YAML. Par exemple :

```yaml
---
title: "Sample Document"
output: pdf_document
bibliography: bibliography.bib
---

```

Si vous incluez plusieurs fichiers de bibliographie, vous pouvez les définir comme suit :

```yaml
---
bibliography: [bibliography1.bib, bibliography2.bib]
---

```

La bibliographie peut avoir l'un de ces formats :

| Format      | Extension de fichier |
| ----------- | -------------------- |
| BibLaTeX    | .bib                 |
| BibTeX      | .bibtex              |
| Copac       | .copac               |
| CSL JSON    | .json                |
| CSL YAML    | .yaml                |
| EndNote     | .enl                 |
| EndNote XML | .xml                 |
| ISI         | .wos                 |
| MEDLINE     | .medline             |
| MODS        | .mods                |
| RIS         | .ris                 |

### Références en ligne

Alternativement, vous pouvez utiliser un champ `references` dans les métadonnées YAML du document. Cela devrait inclure un tableau de références encodées en YAML, par exemple :

```yaml
---
references:
  - id: fenner2012a
    title: One-click science marketing
    author:
      - family: Fenner
        given: Martin
    container-title: Nature Materials
    volume: 11
    URL: "https://dx.doi.org/10.1038/nmat3283"
    DOI: 10.1038/nmat3283
    issue: 4
    publisher: Nature Publishing Group
    page: 261-263
    type: article-journal
    issued:
      year: 2012
      month: 3
---

```

### Placement de la bibliographie

Les bibliographies seront placées à la fin du document. Normalement, vous voudrez terminer votre document avec un en-tête approprié :

```markdown
dernier paragraphe...

# Références
```

La bibliographie sera insérée après cet en-tête.

## Citations

### Syntaxe des citations

Les citations se mettent entre crochets et sont séparées par des points-virgules. Chaque citation doit avoir une clé, composée de '@' + l'identifiant de citation dans la base de données, et peut optionnellement avoir un préfixe, un localisateur et un suffixe. Voici quelques exemples :

```
Blah blah [see @doe99, pp. 33-35; also @smith04, ch. 1].

Blah blah [@doe99, pp. 33-35, 38-39 and *passim*].

Blah blah [@smith04; @doe99].
```

Un signe moins `(-)` avant le `@` supprimera la mention de l'auteur dans la citation. Cela peut être utile lorsque l'auteur est déjà mentionné dans le texte :

```
Smith says blah [-@smith04].
```

Vous pouvez également écrire une citation dans le texte, comme suit :

```
@smith04 says blah.

@smith04 [p. 33] says blah.
```

### Références non utilisées (nocite)

Si vous souhaitez inclure des éléments dans la bibliographie sans les citer réellement dans le corps du texte, vous pouvez définir un champ de métadonnées `nocite` fictif et y mettre les citations :

```
---
nocite: |
  @item1, @item2
...

@item3
```

Dans cet exemple, le document contiendra une citation pour `item3` uniquement, mais la bibliographie contiendra des entrées pour `item1`, `item2` et `item3`.

### Styles de citation

Par défaut, pandoc utilisera un format auteur-date de Chicago pour les citations et les références. Pour utiliser un autre style, vous devrez spécifier un fichier de style CSL 1.0 dans le champ de métadonnées `csl`. Par exemple :

```yaml
---
title: "Sample Document"
output: pdf_document
bibliography: bibliography.bib
csl: biomed-central.csl
---

```

Un guide pour créer et modifier des styles CSL peut être trouvé [ici](https://citationstyles.org/downloads/primer.html). Un référentiel de styles CSL peut être trouvé [ici](https://github.com/citation-style-language/styles). Voir aussi https://zotero.org/styles pour une navigation facile.

### Citations pour la sortie PDF

Par défaut, les citations sont générées par l'utilitaire pandoc-citeproc, et cela fonctionne pour tous les formats de sortie. Lorsque la sortie est LaTeX/PDF, vous pouvez également utiliser des paquets LaTeX (par exemple natbib) pour générer des citations ; voir [Documents PDF](pandoc-pdf.md) pour plus de détails.
