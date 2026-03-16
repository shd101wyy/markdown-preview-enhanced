# Pandoc

**Markdown Preview Enhanced** prend en charge la fonctionnalité d'exportation de documents via `pandoc`, qui fonctionne de manière similaire à `RStudio Markdown`.  
Pour utiliser cette fonctionnalité, vous devez avoir [pandoc](https://pandoc.org/) installé.  
Les instructions d'installation de pandoc peuvent être trouvées [ici](https://pandoc.org/installing.html).  
Vous pouvez utiliser l'exportation de documents via `pandoc` en cliquant avec le bouton droit sur l'aperçu, puis vous le verrez dans le menu contextuel.

---

## Parseur Pandoc

Par défaut, **Markdown Preview Enhanced** utilise [markdown-it](https://github.com/markdown-it/markdown-it) pour analyser le Markdown.  
Vous pouvez également le configurer pour utiliser le parseur `pandoc` depuis les paramètres du paquet.

![Screen Shot 2017-03-07 at 10.05.25 PM](https://i.imgur.com/NdCJBgR.png)

Vous pouvez également définir les arguments pandoc pour des fichiers individuels en écrivant un front-matter

```markdown
---
pandoc_args: ["--toc", "--toc-depth=2"]
---
```

Veuillez noter que `--filter=pandoc-citeproc` sera automatiquement ajouté s'il y a `references` ou `bibliography` dans votre front-matter.

**Attention** : Cette fonctionnalité est encore expérimentale. N'hésitez pas à poster des problèmes ou des suggestions.  
**Problèmes connus et limitations** :

1. L'exportation `ebook` présente des problèmes.
2. Le `Code Chunk` est parfois instable.

## Front-Matter

L'exportation de documents via `pandoc` nécessite d'écrire un `front-matter`.  
Plus d'informations et un tutoriel sur la façon d'écrire un `front-matter` peuvent être trouvés [ici](https://jekyllrb.com/docs/frontmatter/).

## Exporter

Vous n'êtes pas obligé d'utiliser le `Parseur Pandoc` mentionné ci-dessus pour exporter des fichiers.

Les formats suivants sont actuellement pris en charge, **d'autres formats seront pris en charge à l'avenir.**  
(Certains exemples sont tirés de [RStudio Markdown](https://rmarkdown.rstudio.com/formats.html))  
Cliquez sur le lien ci-dessous pour voir le format de document que vous souhaitez exporter.

- [PDF](pandoc-pdf.md)
- [Word](pandoc-word.md)
- [RTF](pandoc-rtf.md)
- [Beamer](pandoc-beamer.md)

Vous pouvez également définir votre propre document personnalisé :

- [Personnalisé](pandoc-custom.md)

## Exporter à la sauvegarde

Ajoutez le front-matter comme ci-dessous :

```yaml
---
export_on_save:
  pandoc: true
---

```

Ainsi, pandoc s'exécutera à chaque fois que vous sauvegardez votre fichier source Markdown.

## Articles

- [Bibliographies et citations](pandoc-bibliographies-and-citations.md)

## Attention

`mermaid, wavedrom` ne fonctionneront pas avec l'exportation de documents `pandoc`.  
Le [Code Chunk](code-chunk.md) est partiellement compatible avec l'exportation de documents `pandoc`.
