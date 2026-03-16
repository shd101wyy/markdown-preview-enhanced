# Personnaliser le CSS

## style.less

Pour personnaliser le CSS de votre fichier Markdown, appuyez sur <kbd>cmd-shift-p</kbd> puis exécutez la commande `Markdown Preview Enhanced: Customize CSS (Global)` ou `Markdown Preview Enhanced: Customize CSS (Workspace)`.

Le fichier `style.less` s'ouvrira, et vous pouvez remplacer le style existant comme ceci :

```less
.markdown-preview.markdown-preview {
  // veuillez écrire votre style personnalisé ici
  // ex :
  //  color: blue;          // changer la couleur de la police
  //  font-size: 14px;      // changer la taille de la police
  // style d'impression PDF personnalisé
  @media print {
  }

  // style d'exportation PDF prince personnalisé
  &.prince {
  }

  // style de présentation personnalisé
  .reveal .slides {
    // modifier toutes les diapositives
  }

  .slides > section:nth-child(1) {
    // ceci modifiera `la première diapositive`
  }
}

.md-sidebar-toc.md-sidebar-toc {
  // style de la TOC dans la barre latérale
}
```

## Style local

Markdown Preview Enhanced vous permet également de définir des styles différents pour différents fichiers Markdown.  
`id` et `class` peuvent être configurés dans le front-matter.
Vous pouvez facilement [importer](file-imports.md) un fichier `less` ou `css` dans votre fichier Markdown :

```markdown
---
id: "my-id"
class: "my-class1 my-class2"
---

@import "my-style.less"

# Titre 1
```

le fichier `my-style.less` pourrait ressembler à ceci :

```less
#my-id {
  background-color: #222;
  color: #fff;

  h1,
  h2,
  h3,
  h4,
  h5,
  h6 {
    color: #fff;
  }
}
```

À chaque fois que vous modifiez votre fichier `less`, vous pouvez cliquer sur le bouton de rafraîchissement dans le coin supérieur droit de l'aperçu pour recompiler less en css.

![](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Changer la famille de polices

Pour changer la famille de polices de l'aperçu, vous devez d'abord télécharger le fichier de police `(.ttf)`, puis modifier `style.less` comme ci-dessous :

```less
@font-face {
  font-family: "your-font-family";
  src: url("your-font-file-url");
}

.markdown-preview.markdown-preview {
  font-family: "your-font-family", sans-serif;

  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  pre,
  code {
    font-family: "your-font-family", sans-serif;
  }
}
```

> Il est cependant recommandé d'utiliser des polices en ligne comme Google Fonts.
