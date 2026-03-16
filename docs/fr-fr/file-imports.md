# Importer des fichiers externes

![doc-imports](https://cloud.githubusercontent.com/assets/1908863/22716507/f352a4b6-ed5b-11e6-9bac-88837f111de0.gif)

## Comment utiliser ?

Simplement

`@import "your_file"`

facile, non :)

`<!-- @import "your_file" -->` est également valide.

Ou

```markdown
- syntaxe similaire aux images
  ![](file/path/to/your_file)

- syntaxe similaire aux wikilinks
  ![[ file/path/to/your_file ]]
  ![[ my_file ]]
```

## Bouton de rafraîchissement

Un bouton de rafraîchissement a été ajouté dans le coin droit de l'aperçu.
En cliquant dessus, le cache des fichiers sera effacé et l'aperçu sera actualisé.
Cela peut être utile si vous souhaitez effacer le cache des images. [#144](https://github.com/shd101wyy/markdown-preview-enhanced/issues/144) [#249](https://github.com/shd101wyy/markdown-preview-enhanced/issues/249)

![screen shot 2017-02-07 at 5 48 52 pm](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Types de fichiers pris en charge

- Les fichiers `.jpeg(.jpg), .gif, .png, .apng, .svg, .bmp` seront traités comme des images Markdown.
- Le fichier `.csv` sera converti en tableau Markdown.
- Le fichier `.mermaid` sera rendu par mermaid.
- Le fichier `.dot` sera rendu par viz.js (graphviz).
- Le fichier `.plantuml(.puml)` sera rendu par PlantUML.
- Le fichier `.html` sera intégré directement.
- Le fichier `.js` sera inclus en tant que `<script src="your_js"></script>`.
- Les fichiers `.less` et `.css` seront inclus comme styles. Seul le fichier `less` local est actuellement pris en charge. Le fichier `.css` sera inclus en tant que `<link rel="stylesheet" href="your_css">`.
- Le fichier `.pdf` sera converti en fichiers `svg` par `pdf2svg` puis inclus.
- Le fichier `markdown` sera analysé et intégré directement.
- Tous les autres fichiers seront rendus comme blocs de code.

## Configurer les images

```markdown
@import "test.png" {width="300px" height="200px" title="my title" alt="my alt"}

![](test.png){width="300px" height="200px"}

![[ test.png ]]{width="300px" height="200px"}
```

## Importer des fichiers en ligne

Par exemple :

```markdown
@import "https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/LICENSE.md"
```

## Importer un fichier PDF

Pour importer un fichier PDF, vous devez avoir [pdf2svg](extra.md) installé.
Markdown Preview Enhanced prend en charge l'importation de fichiers PDF locaux et en ligne.
Cependant, il n'est pas recommandé d'importer de grands fichiers PDF.
Par exemple :

```markdown
@import "test.pdf"
```

### Configuration PDF

- **page_no**
  Afficher la `nième` page du PDF. Indexation à partir de 1. Par exemple, `{page_no=1}` affichera la 1ère page du PDF.
- **page_begin**, **page_end**
  Inclus. Par exemple, `{page_begin=2 page_end=4}` affichera les pages numéro 2, 3 et 4.

## Forcer le rendu en bloc de code

```markdown
@import "test.puml" {code_block=true class="line-numbers"}
@import "test.py" {class="line-numbers"}
```

## En tant que bloc de code

```markdown
@import "test.json" {as="vega-lite"}
```

## Importer certaines lignes

```markdown
@import "test.md" {line_begin=2}
@import "test.md" {line_begin=2 line_end=10}
@import "test.md" {line_end=-4}
```

## Importer un fichier comme Code Chunk

```markdown
@import "test.py" {cmd="python3"}
```

[➔ Code Chunk](code-chunk.md)
