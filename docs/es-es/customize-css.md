# Personalizar CSS

## style.less

Para personalizar el CSS de tu archivo Markdown, presiona <kbd>cmd-shift-p</kbd> y luego ejecuta el comando `Markdown Preview Enhanced: Customize CSS (Global)` o `Markdown Preview Enhanced: Customize CSS (Workspace)`.

Se abrirá el archivo `style.less`, donde puedes anular estilos existentes de la siguiente forma:

```less
.markdown-preview.markdown-preview {
  // escribe tu estilo personalizado aquí
  // ej:
  //  color: blue;          // cambiar color de fuente
  //  font-size: 14px;      // cambiar tamaño de fuente
  // estilo personalizado para salida PDF
  @media print {
  }

  // estilo personalizado para exportación PDF con prince
  &.prince {
  }

  // estilo personalizado para presentación
  .reveal .slides {
    // modificar todas las diapositivas
  }

  .slides > section:nth-child(1) {
    // esto modificará `la primera diapositiva`
  }
}

.md-sidebar-toc.md-sidebar-toc {
  // estilo del TOC en la barra lateral
}
```

## Estilo local

Markdown Preview Enhanced también te permite definir diferentes estilos para diferentes archivos Markdown.  
`id` y `class` se pueden configurar en el front-matter.
Puedes [importar](file-imports.md) fácilmente un archivo `less` o `css` en tu archivo Markdown:

```markdown
---
id: "my-id"
class: "my-class1 my-class2"
---

@import "my-style.less"

# Encabezado1
```

el archivo `my-style.less` podría verse así:

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

Cada vez que cambies tu archivo `less`, puedes hacer clic en el botón de actualización en la esquina superior derecha de la vista previa para recompilar less a css.

![](https://cloud.githubusercontent.com/assets/1908863/22716917/c7088ae0-ed5d-11e6-8db9-e1ab035a3a2b.png)

## Cambiar la familia de fuentes

Para cambiar la familia de fuentes de la vista previa, primero necesitas descargar el archivo de fuente `(.ttf)`, luego modifica `style.less` de la siguiente forma:

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

> Sin embargo, se recomienda usar fuentes en línea como las de Google Fonts.
