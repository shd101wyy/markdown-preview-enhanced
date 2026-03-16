# Generación de eBook

Inspirado en _GitBook_  
**Markdown Preview Enhanced** puede generar contenido como ebook (ePub, Mobi, PDF).

![Screen Shot 2016-09-08 at 9.42.43 PM](https://ooo.0o0.ooo/2016/09/09/57d221c0a618a.png)

Para generar un ebook, necesitas tener `ebook-convert` instalado.

## Instalar ebook-convert

**macOS**  
Descarga la [aplicación Calibre](https://calibre-ebook.com/download). Después de mover `calibre.app` a tu carpeta de Aplicaciones, crea un enlace simbólico a la herramienta `ebook-convert`:

```shell
$ sudo ln -s ~/Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin
```

**Windows**  
Descarga e instala la [aplicación Calibre](https://calibre-ebook.com/download).  
Añade `ebook-convert` a tu `$PATH`.

## Ejemplo de eBook

Un proyecto de ejemplo de eBook se puede encontrar [aquí](https://github.com/shd101wyy/ebook-example).

## Empezar a escribir un eBook

Puedes configurar un ebook añadiendo el `front-matter de ebook` a tu archivo Markdown.

```yaml
---
ebook:
  theme: github-light.css
  title: Mi eBook
  authors: shd101wyy
---

```

---

## Demo

`SUMMARY.md` es un archivo de entrada de ejemplo. También debe tener un TOC para organizar el libro:

```markdown
---
ebook:
  theme: github-light.css
  title: Markdown Preview Enhanced
  author: shd101wyy
---

# Prefacio

Este es el prefacio, pero no es obligatorio.

# Tabla de Contenidos

- [Capítulo 1](/chapter1/README.md)
  - [Introducción a Markdown Preview Enhanced](/chapter1/intro.md)
  - [Características](/chapter1/feature.md)
- [Capítulo 2](/chapter2/README.md)
  - [Problemas conocidos](/chapter2/issues.md)
```

La última lista en el archivo Markdown se considera como TOC.

El título del enlace se usa como título del capítulo, y el destino del enlace es la ruta a ese archivo del capítulo.

---

Para exportar el ebook, abre `SUMMARY.md` con la vista previa activa. Luego haz clic derecho en la vista previa, elige `Export to Disk`, y luego elige la opción `EBOOK`. Podrás entonces exportar tu ebook.

### Metadatos

- **theme**
  El tema a usar para el eBook. Por defecto usa el tema de la vista previa. La lista de temas disponibles se puede encontrar en la sección `previewTheme` en [este documento](https://github.com/shd101wyy/crossnote/#notebook-configuration).
- **title**  
  Título de tu libro
- **authors**  
  autor1 & autor2 & ...
- **cover**  
  https://ruta-a-imagen.png
- **comments**  
  Establece la descripción del ebook
- **publisher**  
  ¿Quién es el editor?
- **book-producer**  
  ¿Quién es el productor del libro?
- **pubdate**  
  Fecha de publicación
- **language**  
  Establece el idioma
- **isbn**  
  ISBN del libro
- **tags**  
  Establece las etiquetas para el libro. Debe ser una lista separada por comas.
- **series**  
  Establece la serie a la que pertenece este ebook.
- **rating**  
  Establece la valoración. Debe ser un número entre 1 y 5.
- **include_toc**  
  `predeterminado: true` Si se incluye o no el TOC que escribiste en tu archivo de entrada.

Por ejemplo:

```yaml
ebook:
  title: Mi eBook
  author: shd101wyy
  rating: 5
```

### Aspecto y apariencia

Se proporcionan las siguientes opciones para controlar el aspecto y la apariencia de la salida:

- **asciiize** `[true/false]`  
  `predeterminado: false` Transliterar caracteres unicode a una representación ASCII. Úsalo con precaución ya que esto reemplazará los caracteres unicode por ASCII.
- **base-font-size** `[number]`  
  El tamaño de fuente base en puntos. Todos los tamaños de fuente en el libro producido se recalcularán basándose en este tamaño. Al elegir un tamaño mayor puedes hacer las fuentes más grandes y viceversa. Por defecto, el tamaño de fuente base se elige según el perfil de salida que hayas elegido.
- **disable-font-rescaling** `[true/false]`  
  `predeterminado: false` Deshabilitar todo el reescalado de tamaños de fuente.
- **line-height** `[number]`  
  La altura de línea en puntos. Controla el espacio entre líneas consecutivas de texto. Solo se aplica a elementos que no definen su propia altura de línea. En la mayoría de los casos, la opción de altura de línea mínima es más útil. Por defecto no se realiza ninguna manipulación de altura de línea.
- **margin-top** `[number]`  
  `predeterminado: 72.0` Establece el margen superior en puntos. El valor predeterminado es 72. Si se establece en menos de cero, no se establecerá ningún margen (se preservará la configuración de margen del documento original). Nota: 72 pt equivale a 1 pulgada.
- **margin-right** `[number]`  
  `predeterminado: 72.0`
- **margin-bottom** `[number]`  
  `predeterminado: 72.0`
- **margin-left** `[number]`  
  `predeterminado: 72.0`
- **margin** `[number/array]`  
  `predeterminado: 72.0`  
  Puedes definir los **márgenes superior/derecho/inferior/izquierdo** al mismo tiempo. Por ejemplo:

```yaml
ebook:
  margin: 5 # margin-top = margin-right = margin-bottom = margin-left = 5
```

```yaml
ebook:
  margin: [4, 8] # margin-top = margin-bottom = 4, margin-left = margin-right = 8
```

```yaml
ebook:
  margin: [1, 2, 3, 4] # margin-top=1, margin-right=2, margin-bottom=3, margin-left=4
```

Por ejemplo:

```yaml
ebook:
  title: Mi eBook
  base-font-size: 8
  margin: 72
```

## Formatos de salida

Actualmente puedes generar ebook en formato `ePub`, `mobi`, `pdf`, `html`.

### ePub

Para configurar la salida `ePub`, simplemente añade `epub` después de `ebook`.

```yaml
---
ebook:
  epub:
    no-default-epub-cover: true
    pretty-print: true
---

```

Se proporcionan las siguientes opciones:

- **no-default-epub-cover** `[true/false]`  
  Normalmente, si el archivo de entrada no tiene portada y no especificas una, se genera una portada predeterminada con el título, los autores, etc. Esta opción deshabilita la generación de dicha portada.
- **no-svg-cover** `[true/false]`  
  No usar SVG para la portada del libro. Usa esta opción si tu EPUB se va a usar en un dispositivo que no admite SVG, como el iPhone o el JetBook Lite. Sin esta opción, dichos dispositivos mostrarán la portada como una página en blanco.
- **pretty-print** `[true/false]`  
  Si se especifica, el plugin de salida intentará crear una salida lo más legible posible para los humanos. Puede no tener efecto en algunos plugins de salida.

### PDF

Para configurar la salida `pdf`, simplemente añade `pdf` después de `ebook`.

```yaml
ebook:
  pdf:
    paper-size: letter
    default-font-size: 12
    header-template: "<span> Escrito por shd101wyy _PAGENUM_ </span>"
```

Se proporcionan las siguientes opciones:

- **paper-size**  
  El tamaño del papel. Este tamaño se anulará cuando se use un perfil de salida no predeterminado. El valor predeterminado es letter. Las opciones son `a0`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `b0`, `b1`, `b2`, `b3`, `b4`, `b5`, `b6`, `legal`, `letter`.
- **default-font-size** `[number]`  
  El tamaño de fuente predeterminado
- **footer-template**  
  Una plantilla HTML para generar pies de página en cada página. Las cadenas `_PAGENUM_`, `_TITLE_`, `_AUTHOR_` y `_SECTION_` serán reemplazadas por sus valores actuales.
- **header-template**  
  Una plantilla HTML para generar encabezados en cada página. Las cadenas `_PAGENUM_`, `_TITLE_`, `_AUTHOR_` y `_SECTION_` serán reemplazadas por sus valores actuales.
- **page-numbers** `[true/false]`  
  `predeterminado: false`  
  Añadir números de página al final de cada página en el archivo PDF generado. Si especificas una plantilla de pie de página, tendrá prioridad sobre esta opción.
- **pretty-print** `[true/false]`  
  Si se especifica, el plugin de salida intentará crear una salida lo más legible posible para los humanos. Puede no tener efecto en algunos plugins de salida.

### HTML

La exportación a `.html` no depende de `ebook-convert`.  
Si exportas un archivo `.html`, todas las imágenes locales se incluirán como datos `base64` dentro de un único archivo `html`.  
Para configurar la salida `html`, simplemente añade `html` después de `ebook`.

```yaml
ebook:
  html:
    cdn: true
```

- **cdn**  
  Cargar archivos CSS y JavaScript desde `cdn.js`. Esta opción solo se usa al exportar un archivo `.html`.

## Argumentos de ebook-convert

Si hay funciones de `ebook-convert` que deseas usar y que no tienen equivalentes en las opciones YAML descritas anteriormente, aún puedes usarlas pasando `args` personalizados. Por ejemplo:

```yaml
---
ebook:
  title: Mi eBook
  args: ["--embed-all-fonts", "--embed-font-family"]
---

```

Puedes encontrar una lista de argumentos en el [manual de ebook-convert](https://manual.calibre-ebook.com/generated/en/ebook-convert.html).

## Exportar al guardar

Agrega el front-matter como se muestra a continuación:

```yaml
---
export_on_save:
  ebook: true
  // o
  ebook: "epub"
  ebook: "pdf"
  ebook: "mobi"
  ebook: "html"
  ebook: ["pdf", ...]
---
```

Así, los ebooks se generarán cada vez que guardes tu archivo Markdown de origen.

## Problemas conocidos y limitaciones

- La generación de eBook aún está en desarrollo.
- Todos los gráficos SVG generados por `mermaid`, `PlantUML`, etc. no funcionarán en el ebook generado. Solo `viz` funciona.
- Solo se puede usar **KaTeX** para la composición tipográfica matemática.  
  Y el archivo ebook generado no renderiza expresiones matemáticas correctamente en **iBook**.
- La generación de **PDF** y **Mobi** tiene errores.
- **Code Chunk** no funciona con la generación de eBook.
