# Les bases de Markdown

Cet article est une brève introduction à [l'écriture GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

## Qu'est-ce que Markdown ?

`Markdown` est une façon de styliser du texte sur le web. Vous contrôlez l'affichage du document ; mettre les mots en gras ou en italique, ajouter des images et créer des listes ne sont que quelques-unes des choses que nous pouvons faire avec Markdown. Le plus souvent, Markdown n'est que du texte ordinaire avec quelques caractères non alphabétiques, comme `#` ou `*`.

## Guide de syntaxe

### En-têtes

```markdown
# Ceci est une balise <h1>

## Ceci est une balise <h2>

### Ceci est une balise <h3>

#### Ceci est une balise <h4>

##### Ceci est une balise <h5>

###### Ceci est une balise <h6>
```

Si vous souhaitez ajouter un `id` et une `class` à l'en-tête, ajoutez simplement `{#id .class1 .class2}`. Par exemple :

```markdown
# Cet en-tête a 1 id {#my_id}

# Cet en-tête a 2 classes {.class1 .class2}
```

> Il s'agit d'une fonctionnalité étendue de MPE.

### Emphase

<!-- prettier-ignore -->
```markdown
*Ce texte sera en italique*
_Ceci sera également en italique_

**Ce texte sera en gras**
__Ceci sera également en gras__

_Vous **pouvez** les combiner_

~~Ce texte sera barré~~
```

### Listes

#### Liste non ordonnée

```markdown
- Élément 1
- Élément 2
  - Élément 2a
  - Élément 2b
```

#### Liste ordonnée

```markdown
1. Élément 1
1. Élément 2
1. Élément 3
   1. Élément 3a
   1. Élément 3b
```

### Images

```markdown
![Logo GitHub](/images/logo.png)
Format: ![Texte alternatif](url)
```

### Liens

```markdown
https://github.com - automatique !
[GitHub](https://github.com)
```

### Citation en bloc

```markdown
Comme disait Kanye West :

> Nous vivons le futur donc
> le présent est notre passé.

> [!NOTE]
> Ceci est une note en citation.

> [!WARNING]
> Ceci est un avertissement en citation.
```

### Règle horizontale

```markdown
Trois ou plus...

---

Traits d'union

---

Astérisques

---

Soulignements
```

### Code en ligne

```markdown
Je pense que vous devriez utiliser un
élément `<addr>` ici à la place.
```

### Bloc de code délimité

Vous pouvez créer des blocs de code délimités en plaçant des triples accents graves <code>\`\`\`</code> avant et après le bloc de code.

#### Coloration syntaxique

Vous pouvez ajouter un identifiant de langage optionnel pour activer la coloration syntaxique dans votre bloc de code délimité.

Par exemple, pour colorer du code Ruby :

    ```ruby
    require 'redcarpet'
    markdown = Redcarpet.new("Hello World!")
    puts markdown.to_html
    ```

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

#### Classe de bloc de code (fonctionnalité étendue MPE)

Vous pouvez définir une `class` pour vos blocs de code.

Par exemple, pour ajouter `class1 class2` à un bloc de code :

    ```javascript {.class1 .class}
    function add(x, y) {
      return x + y
    }
    ```

##### numéros de ligne

Vous pouvez activer les numéros de ligne pour un bloc de code en ajoutant la classe `line-numbers`.

Par exemple :

````markdown
```javascript {.line-numbers}
function add(x, y) {
  return x + y;
}
```
````

![screen shot 2017-07-14 at 1 20 27 am](https://user-images.githubusercontent.com/1908863/28200587-a8582b0a-6832-11e7-83a7-6c3bb011322f.png)

##### mise en surbrillance des lignes

Vous pouvez mettre en surbrillance des lignes en ajoutant l'attribut `highlight` :

````markdown
```javascript {highlight=10}
```

```javascript {highlight=10-20}
```

```javascript {highlight=[1-10,15,20-22]}
```
````

### Listes de tâches

```markdown
- [x] @mentions, #refs, [liens](), **formatage**, et <del>balises</del> supportés
- [x] syntaxe de liste requise (toute liste ordonnée ou non ordonnée acceptée)
- [x] ceci est un élément terminé
- [ ] ceci est un élément incomplet
```

### Tableaux

Vous pouvez créer des tableaux en assemblant une liste de mots et en les séparant par des tirets `-` (pour la première ligne), puis en séparant chaque colonne par une barre verticale `|` :

<!-- prettier-ignore -->
```markdown
Premier en-tête | Deuxième en-tête
------------ | -------------
Contenu de la cellule 1 | Contenu de la cellule 2
Contenu dans la première colonne | Contenu dans la deuxième colonne
```

## Syntaxe étendue

### Tableau

> Vous devez activer `enableExtendedTableSyntax` dans les paramètres de l'extension pour que cela fonctionne.

![screen shot 2017-07-15 at 8 16 45 pm](https://user-images.githubusercontent.com/1908863/28243710-945e3004-699a-11e7-9a5f-d74f6c944c3b.png)

### Emoji & Font-Awesome

> Cela ne fonctionne qu'avec le `parseur markdown-it` et non avec le `parseur pandoc`.  
> Activé par défaut. Vous pouvez le désactiver depuis les paramètres du paquet.

```
:smile:
:fa-car:
```

### Exposant

```markdown
30^ème^
```

### Indice

```markdown
H~2~O
```

### Notes de bas de page

```markdown
Contenu [^1]

[^1]: Bonjour ! Ceci est une note de bas de page
```

### Abréviation

```
*[HTML]: Hyper Text Markup Language
*[W3C]: World Wide Web Consortium
La spécification HTML
est maintenue par le W3C.
```

### Marquage

```markdown
==marqué==
```

### CriticMarkup

CriticMarkup est **désactivé** par défaut, mais vous pouvez l'activer depuis les paramètres du paquet.  
Pour plus d'informations sur CriticMarkup, consultez le [Guide de l'utilisateur CriticMarkup](https://criticmarkup.com/users-guide.php).

Il existe cinq types de marques Critic :

- Ajout `{++ ++}`
- Suppression `{-- --}`
- Substitution `{~~ ~> ~~}`
- Commentaire `{>> <<}`
- Mise en surbrillance `{== ==}{>> <<}`

> CriticMarkup ne fonctionne qu'avec le parseur markdown-it, et non avec le parseur pandoc.

### Admonition

```
!!! note Ceci est le titre de l'admonition
    Ceci est le corps de l'admonition
```

> Veuillez consulter plus d'informations sur https://squidfunk.github.io/mkdocs-material/reference/admonitions/

### Wikilinks

> Disponible depuis vscode-mpe 0.8.25 / crossnote 0.9.23. Liens entre notes au style Obsidian.

```markdown
[[Note]]                       <!-- lien vers Note (résolu vers Note.md par défaut) -->
[[Note|Texte affiché]]         <!-- lien avec texte d'affichage personnalisé -->
[[Note#Heading]]               <!-- lien vers un titre précis de Note -->
[[Note^block-id]]              <!-- lien vers un ^block-id précis de Note -->
[[Note#Heading^block-id]]      <!-- combinaison titre + référence de bloc -->
[[#Heading]]                   <!-- lien vers un titre dans la note courante -->
[[^block-id]]                  <!-- lien vers un bloc dans la note courante -->
```

Dans l'aperçu, cliquez sur n'importe quel wikilink pour naviguer. Dans l'éditeur, alt+clic (Ctrl+clic sur macOS) pour suivre le lien. Survolez un wikilink pour prévisualiser le contenu cible (début du fichier, section du titre, ou contenu du bloc — selon ce que pointe le lien).

Si vous cliquez `[[NewNote]]` et que `NewNote.md` n'existe pas encore, le fichier est créé avec une ébauche `# NewNote` puis ouvert — comportement identique au flux « cliquer pour créer » d'Obsidian.

Clés de configuration (notebook config) :

- `wikiLinkTargetFileExtension` (par défaut `.md`) — extension ajoutée quand le lien n'en a pas. À régler sur `.markdown` / `.mdx` / `.qmd` pour les notebooks non-`.md`.
- `useGitHubStylePipedLink` (par défaut `false`) — quand `true`, l'ordre est `[[affichage|lien]]` (style GitHub) ; quand `false`, `[[lien|affichage]]` (style Obsidian / Wikipedia).

### Intégration de notes (`![[…]]`)

Le préfixe `!` intègre le contenu cible directement à la position courante :

```markdown
![[Note]]                      <!-- intègre la note entière -->
![[Note#Heading]]              <!-- intègre seulement la section du titre -->
![[Note^block-id]]             <!-- intègre seulement ce bloc -->
![[Note|Titre à afficher]]     <!-- intègre avec un titre personnalisé -->
![[image.png]]                 <!-- intégration d'image standard (toute extension d'image) -->
```

La récursion est limitée à 3 niveaux — un cycle d'intégration ne fera pas exploser l'aperçu.

### Références de bloc (`^block-id`)

Ajoutez `^block-id` à la fin d'un paragraphe ou d'un élément de liste pour le marquer comme bloc référençable :

```markdown
Ce paragraphe peut être référencé. ^my-block

- Un élément de liste aussi. ^another-block
```

Référencez-le depuis n'importe quel endroit du workspace :

```markdown
Voir [[Note^my-block]] ou l'intégrer : ![[Note^my-block]]
```

La commande `Markdown Preview Enhanced: Copy Block Reference` (palette de commandes) génère un `^id` pour le paragraphe au curseur (ou réutilise l'existant) et copie un lien `[[Note#^id]]` prêt à coller dans le presse-papiers.

### Tags

Syntaxe `#tag-name` dans le texte :

```markdown
Cette pensée porte les tags #important et #project/q1.
```

- **Tags imbriqués** via `/` : `#parent/child`, et plus profond (`#a/b/c`).
- Les tags ne se déclenchent pas quand une ligne ne contient que des `#` (donc `# Titre`, `## Titre` etc. fonctionnent toujours).
- Cliquez sur un tag dans l'aperçu pour ouvrir une Quick Pick listant toutes les notes qui le mentionnent.
- Le réglage `enableTagSyntax` (par défaut `true`) active/désactive la fonctionnalité.

## Références

- [Maîtriser Markdown](https://guides.github.com/features/mastering-markdown/)
- [Daring Fireball : Les bases de Markdown](https://daringfireball.net/projects/markdown/basics)

[➔ Mathématiques](math.md)
