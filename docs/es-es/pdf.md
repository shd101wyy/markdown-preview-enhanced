# Exportación a PDF

> Recomendamos usar [Chrome (Puppeteer) para exportar PDF](puppeteer.md).

## Uso

Haz clic derecho en la vista previa, luego elige `Open in Browser`.
Imprime como PDF desde el navegador.

![screen shot 2017-07-14 at 1 46 39 am](https://user-images.githubusercontent.com/1908863/28201366-536dbc0a-6836-11e7-866f-db9a5d12de16.png)

## Personalizar CSS

<kbd>cmd-shift-p</kbd> luego ejecuta el comando `Markdown Preview Enhanced: Customize Css` para abrir el archivo `style.less`, luego añade y modifica las siguientes líneas:

```less
.markdown-preview.markdown-preview {
  @media print {
    // tu código aquí
  }
}
```

---

También puedes generar el archivo PDF con [puppeteer](puppeteer.md) o [prince](prince.md).
