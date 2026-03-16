# Conceptos básicos de Markdown

Este artículo es una breve introducción a la [escritura en GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

## ¿Qué es Markdown?

`Markdown` es una forma de dar estilo al texto en la web. Tú controlas la presentación del documento; dar formato a las palabras como negrita o cursiva, agregar imágenes y crear listas son solo algunas de las cosas que podemos hacer con Markdown. En su mayor parte, Markdown es simplemente texto normal con algunos caracteres no alfabéticos, como `#` o `*`.

## Guía de sintaxis

### Encabezados

```markdown
# Esto es una etiqueta <h1>

## Esto es una etiqueta <h2>

### Esto es una etiqueta <h3>

#### Esto es una etiqueta <h4>

##### Esto es una etiqueta <h5>

###### Esto es una etiqueta <h6>
```

Si quieres añadir `id` y `class` al encabezado, simplemente agrega `{#id .class1 .class2}` al final. Por ejemplo:

```markdown
# Este encabezado tiene 1 id {#my_id}

# Este encabezado tiene 2 clases {.class1 .class2}
```

> Esta es una característica extendida de MPE.

### Énfasis

<!-- prettier-ignore -->
```markdown
*Este texto estará en cursiva*
_Este también estará en cursiva_

**Este texto estará en negrita**
__Este también estará en negrita__

_Puedes **combinarlos**_

~~Este texto estará tachado~~
```

### Listas

#### Lista desordenada

```markdown
- Elemento 1
- Elemento 2
  - Elemento 2a
  - Elemento 2b
```

#### Lista ordenada

```markdown
1. Elemento 1
1. Elemento 2
1. Elemento 3
   1. Elemento 3a
   1. Elemento 3b
```

### Imágenes

```markdown
![Logo de GitHub](/images/logo.png)
Formato: ![Texto alternativo](url)
```

### Enlaces

```markdown
https://github.com - ¡automático!
[GitHub](https://github.com)
```

### Cita en bloque

```markdown
Como dijo Kanye West:

> Vivimos el futuro por lo que
> el presente es nuestro pasado.

> [!NOTE]
> Esto es una cita de nota.

> [!WARNING]
> Esto es una cita de advertencia.
```

### Línea horizontal

```markdown
Tres o más...

---

Guiones

---

Asteriscos

---

Guiones bajos
```

### Código en línea

```markdown
Creo que deberías usar un
elemento `<addr>` aquí en su lugar.
```

### Bloque de código delimitado

Puedes crear bloques de código delimitados colocando tres comillas invertidas <code>\`\`\`</code> antes y después del bloque de código.

#### Resaltado de sintaxis

Puedes añadir un identificador de lenguaje opcional para habilitar el resaltado de sintaxis en tu bloque de código delimitado.

Por ejemplo, para resaltar la sintaxis de código Ruby:

    ```ruby
    require 'redcarpet'
    markdown = Redcarpet.new("Hello World!")
    puts markdown.to_html
    ```

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

#### Clase del bloque de código (característica extendida de MPE)

Puedes establecer `class` para tus bloques de código.

Por ejemplo, para añadir `class1 class2` a un bloque de código:

    ```javascript {.class1 .class}
    function add(x, y) {
      return x + y
    }
    ```

##### line-numbers

Puedes habilitar los números de línea para un bloque de código añadiendo la clase `line-numbers`.

Por ejemplo:

````markdown
```javascript {.line-numbers}
function add(x, y) {
  return x + y;
}
```
````

![screen shot 2017-07-14 at 1 20 27 am](https://user-images.githubusercontent.com/1908863/28200587-a8582b0a-6832-11e7-83a7-6c3bb011322f.png)

##### resaltar filas

Puedes resaltar filas añadiendo el atributo `highlight`:

````markdown
```javascript {highlight=10}
```

```javascript {highlight=10-20}
```

```javascript {highlight=[1-10,15,20-22]}
```
````

### Listas de tareas

```markdown
- [x] Se admiten @menciones, #refs, [enlaces](), **formato** y <del>etiquetas</del>
- [x] se requiere sintaxis de lista (se admite cualquier lista ordenada o desordenada)
- [x] este es un elemento completado
- [ ] este es un elemento incompleto
```

### Tablas

Puedes crear tablas ensamblando una lista de palabras y dividiéndolas con guiones `-` (para la primera fila) y luego separando cada columna con una barra vertical `|`:

<!-- prettier-ignore -->
```markdown
Primer encabezado | Segundo encabezado
------------ | -------------
Contenido de la celda 1 | Contenido de la celda 2
Contenido de la primera columna | Contenido de la segunda columna
```

## Sintaxis extendida

### Tabla

> Necesitas habilitar `enableExtendedTableSyntax` en la configuración de la extensión para que funcione.

![screen shot 2017-07-15 at 8 16 45 pm](https://user-images.githubusercontent.com/1908863/28243710-945e3004-699a-11e7-9a5f-d74f6c944c3b.png)

### Emoji y Font-Awesome

> Esto solo funciona con el `analizador markdown-it` pero no con el `analizador pandoc`.  
> Habilitado por defecto. Puedes deshabilitarlo desde la configuración del paquete.

```
:smile:
:fa-car:
```

### Superíndice

```markdown
30^th^
```

### Subíndice

```markdown
H~2~O
```

### Notas al pie

```markdown
Contenido [^1]

[^1]: ¡Hola! Esta es una nota al pie
```

### Abreviatura

```
*[HTML]: Hyper Text Markup Language
*[W3C]: World Wide Web Consortium
La especificación HTML
es mantenida por el W3C.
```

### Marcado

```markdown
==marcado==
```

### CriticMarkup

CriticMarkup está **deshabilitado** por defecto, pero puedes habilitarlo desde la configuración del paquete.  
Para más información sobre CriticMarkup, consulta la [Guía de usuario de CriticMarkup](https://criticmarkup.com/users-guide.php).

Hay cinco tipos de marcas CriticMarkup:

- Adición `{++ ++}`
- Eliminación `{-- --}`
- Sustitución `{~~ ~> ~~}`
- Comentario `{>> <<}`
- Resaltado `{== ==}{>> <<}`

> CriticMarkup solo funciona con el analizador markdown-it, no con el analizador pandoc.

### Admonición

```
!!! note Este es el título de la admonición
    Este es el cuerpo de la admonición
```

> Consulta más información en https://squidfunk.github.io/mkdocs-material/reference/admonitions/

## Referencias

- [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
- [Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)

[➔ Matemáticas](math.md)
