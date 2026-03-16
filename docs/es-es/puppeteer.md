# Exportación con Chrome (Puppeteer)

## Instalación

Necesitas tener el [navegador Chrome](https://www.google.com/chrome/) instalado.

> Hay una configuración de extensión llamada `chromePath` que te permite especificar la ruta al ejecutable de Chrome. Por defecto no necesitas modificarla. La extensión MPE buscará la ruta automáticamente.

## Uso

Haz clic derecho en la vista previa, luego elige `Chrome (Puppeteer)`.

## Configurar Puppeteer

Puedes escribir la configuración de exportación [PDF](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagepdfoptions) y [Screenshot](https://github.com/GoogleChrome/puppeteer/blob/v1.9.0/docs/api.md#pagescreenshotoptions) dentro del front-matter. Por ejemplo:

```yaml
---
puppeteer:
  landscape: true
  format: "A4"
  timeout: 3000 # <= Configuración especial, que significa esperar 3000 ms
---

```

## Exportar al guardar

```yaml
---
export_on_save:
    puppeteer: true # exportar PDF al guardar
    puppeteer: ["pdf", "png"] # exportar archivos PDF y PNG al guardar
    puppeteer: ["png"] # exportar archivo PNG al guardar
---
```

## Personalizar CSS

<kbd>cmd-shift-p</kbd> luego ejecuta el comando `Markdown Preview Enhanced: Customize Css` para abrir el archivo `style.less`, luego añade y modifica las siguientes líneas:

```less
.markdown-preview.markdown-preview {
  @media print {
    // tu código aquí
  }
}
```
