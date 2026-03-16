# Exportación PDF con Prince

**Markdown Preview Enhanced** admite la exportación PDF con [prince](https://www.princexml.com/).

## Instalación

Necesitas tener [prince](https://www.princexml.com/) instalado.
Para `macOS`, abre la terminal y ejecuta el siguiente comando:

```sh
brew install Caskroom/cask/prince
```

## Uso

Haz clic derecho en la vista previa, luego elige `PDF (prince)`.

![screen shot 2017-07-14 at 1 44 23 am](https://user-images.githubusercontent.com/1908863/28201287-fb5ea8d0-6835-11e7-9bdb-2afb458ee5cc.png)

## Personalizar CSS

<kbd>cmd-shift-p</kbd> luego ejecuta el comando `Markdown Preview Enhanced: Customize Css` para abrir el archivo `style.less`, luego añade y modifica las siguientes líneas:

```less
.markdown-preview.markdown-preview {
  &.prince {
    // tu CSS de prince aquí
  }
}
```

Por ejemplo, para cambiar el tamaño de página a `A4 horizontal`:

```less
.markdown-preview.markdown-preview {
  &.prince {
    @page {
      size: A4 landscape;
    }
  }
}
```

Más información se puede encontrar en la [guía de usuario de prince](https://www.princexml.com/doc/).
Especialmente en los [estilos de página](https://www.princexml.com/doc/paged/#page-styles).

## Exportar al guardar

Agrega el front-matter como se muestra a continuación:

```yaml
---
export_on_save:
  prince: true
---

```

Así, el archivo PDF se generará cada vez que guardes tu archivo Markdown de origen.

## Problemas conocidos

- No funciona con `KaTeX` ni `MathJax`.
