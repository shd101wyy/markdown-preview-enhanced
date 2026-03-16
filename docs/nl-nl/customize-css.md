# CSS aanpassen

## style.less

Om CSS voor uw markdown-bestand aan te passen, drukt u op <kbd>cmd-shift-p</kbd> en voert u vervolgens de opdracht `Markdown Preview Enhanced: Customize CSS (Global)` of `Markdown Preview Enhanced: Customize CSS (Workspace)` uit.

Het bestand `style.less` wordt geopend en u kunt bestaande stijlen als volgt overschrijven:

```less
.markdown-preview.markdown-preview {
  // schrijf uw aangepaste stijl hier
  // bijv.:
  //  color: blue;          // letterkleur wijzigen
  //  font-size: 14px;      // lettergrootte wijzigen
  // aangepaste pdf-uitvoerstijl
  @media print {
  }

  // aangepaste prince pdf-exportstijl
  &.prince {
  }

  // aangepaste presentatiestijl
  .reveal .slides {
    // alle dia's aanpassen
  }

  .slides > section:nth-child(1) {
    // dit past `de eerste dia` aan
  }
}

.md-sidebar-toc.md-sidebar-toc {
  // zijbalk-TOC-stijl
}
```

## Lokale stijl

Markdown Preview Enhanced biedt u ook de mogelijkheid om verschillende stijlen te definiëren voor verschillende markdown-bestanden.  
`id` en `class` kunnen worden geconfigureerd in front-matter.
U kunt eenvoudig een `less`- of `css`-bestand [importeren](file-imports.md) in uw markdown-bestand:

```markdown
---
id: "my-id"
class: "my-class1 my-class2"
---

@import "my-style.less"

# Kop1
```

Het `my-style.less`-bestand kan er als volgt uitzien:

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

Elke keer dat u uw `less`-bestand heeft gewijzigd, kunt u op de vernieuwknop in de rechterbovenhoek van de voorbeeldweergave klikken om less opnieuw te compileren naar css.

![](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Het lettertype wijzigen

Om het lettertype van de voorbeeldweergave te wijzigen, moet u eerst het lettertypebestand `(.ttf)` downloaden en vervolgens `style.less` als volgt wijzigen:

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

> Het wordt echter aanbevolen om online lettertypen zoals Google Fonts te gebruiken.
