# Exportación HTML

## Uso

Haz clic derecho en la vista previa, haz clic en la pestaña `HTML`.  
Luego elige:

- `HTML (offline)`
  Elige esta opción si solo vas a usar este archivo HTML localmente.
- `HTML (cdn hosted)`
  Elige esta opción si deseas desplegar tu archivo HTML de forma remota.

![screen shot 2017-07-14 at 1 14 28 am](https://user-images.githubusercontent.com/1908863/28200455-d5a12d60-6831-11e7-8572-91d3845ce8cf.png)

## Configuración

Valores predeterminados:

```yaml
---
html:
  embed_local_images: false
  embed_svg: true
  offline: false
  toc: undefined

print_background: false
---

```

Si `embed_local_images` se establece en `true`, todas las imágenes locales se incrustarán en formato `base64`.

Para generar el TOC en la barra lateral necesitas habilitar [enableScriptExecution](https://shd101wyy.github.io/markdown-preview-enhanced/#/code-chunk?id=code-chunk) en la configuración de MPE de vscode o atom.

Si `toc` se establece en `false`, el TOC de la barra lateral estará desactivado. Si `toc` se establece en `true`, el TOC de la barra lateral estará habilitado y visible. Si `toc` no se especifica, el TOC de la barra lateral estará habilitado pero no visible.

## Exportar al guardar

Agrega el front-matter como se muestra a continuación:

```yaml
---
export_on_save:
  html: true
---

```

Así, el archivo HTML se generará cada vez que guardes tu archivo Markdown.
