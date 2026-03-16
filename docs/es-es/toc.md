# Tabla de Contenidos

**Markdown Preview Enhanced** puede crear un `TOC` para tu archivo Markdown.
Puedes presionar <kbd>cmd-shift-p</kbd> y luego elegir `Markdown Preview Enhanced: Create Toc` para crear el `TOC`.
Se pueden crear múltiples TOC.
Para excluir un encabezado del `TOC`, agrega `{ignore=true}` **después** del encabezado.

![screen shot 2018-03-14 at 12 03 00 pm](https://user-images.githubusercontent.com/1908863/37418218-bb624e62-277f-11e8-88f5-8747a1c2e012.png)

> El TOC se actualizará cuando guardes el archivo Markdown.
> Necesitas mantener la vista previa abierta para que el TOC se actualice.

## Configuración

- **orderedList**
  Usar o no lista ordenada.
- **depthFrom**, **depthTo**
  `[1~6]` inclusive.
- **ignoreLink**
  Si se establece en `true`, las entradas del TOC no serán hipervínculos.

## [TOC]

También puedes crear un `TOC` insertando `[TOC]` en tu archivo Markdown.
Por ejemplo:

```markdown
[TOC]

# Encabezado 1

## Encabezado 2 {ignore=true}

El Encabezado 2 será ignorado en el TOC.
```

Sin embargo, **esta forma solo mostrará el TOC en la vista previa**, sin modificar el contenido del editor.

## Configuración de [TOC] y TOC en la barra lateral

Puedes configurar `[TOC]` y el TOC de la barra lateral escribiendo el front-matter:

```markdown
---
toc:
  depth_from: 1
  depth_to: 6
  ordered: false
---
```

[➔ Importar archivos](file-imports.md)
