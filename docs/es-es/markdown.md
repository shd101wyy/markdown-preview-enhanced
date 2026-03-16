# Guardar como Markdown

**Markdown Preview Enhanced** admite la compilación a **GitHub Flavored Markdown** para que el archivo Markdown exportado incluya todos los gráficos (como imágenes png), bloques de código (ocultos y solo con los resultados), composición matemática (mostrada como imagen), etc., y pueda publicarse en GitHub.

## Uso

Haz clic derecho en la vista previa, luego elige `Save as Markdown`.

## Configuraciones

Puedes configurar el directorio de imágenes y la ruta de salida mediante el front-matter:

```yaml
---
markdown:
  image_dir: /assets
  path: output.md
  ignore_from_front_matter: true
  absolute_image_path: false
---

```

**image_dir** `opcional`  
Especifica dónde guardar las imágenes generadas. Por ejemplo, `/assets` significa que todas las imágenes se guardarán en el directorio `assets` bajo la carpeta del proyecto. Si **image_dir** no se proporciona, se usará la `Image folder path` de la configuración del paquete. El valor predeterminado es `/assets`.

**path** `opcional`  
Especifica dónde quieres generar tu archivo Markdown. Si **path** no se especifica, se usará `filename_.md` como destino.

**ignore_from_front_matter** `opcional`  
Si se establece en `false`, el campo `markdown` se incluirá en el front-matter.

**absolute_image_path** `opcional`  
Determina si usar ruta de imagen absoluta o relativa.

## Exportar al guardar

Agrega el front-matter como se muestra a continuación:

```yaml
---
export_on_save:
  markdown: true
---

```

Así, el archivo Markdown se generará cada vez que guardes tu archivo Markdown de origen.

## Problemas conocidos

- `WaveDrom` aún no funciona.
- La visualización de composición matemática puede ser incorrecta.
- Aún no funciona con bloques de código `latex`.
