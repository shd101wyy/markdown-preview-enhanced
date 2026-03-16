# Code Chunk

**Puede haber cambios en el futuro.**

**Markdown Preview Enhanced** te permite renderizar la salida de código en los documentos.

    ```bash {cmd}
    ls .
    ```

    ```bash {cmd=true}
    ls .
    ```

    ```javascript {cmd="node"}
    const date = Date.now()
    console.log(date.toString())
    ```

> ⚠️ **La ejecución de scripts está desactivada por defecto y debe habilitarse explícitamente en las preferencias del paquete Atom / extensión VSCode**
>
> Por favor, usa esta función con precaución ya que puede poner en riesgo tu seguridad.
> Tu máquina puede ser hackeada si alguien te hace abrir un archivo Markdown con código malicioso mientras la ejecución de scripts está habilitada.
>
> Nombre de la opción: `enableScriptExecution`

## Comandos y atajos de teclado

- `Markdown Preview Enhanced: Run Code Chunk` o <kbd>shift-enter</kbd>
  Ejecuta el Code Chunk individual donde está el cursor.
- `Markdown Preview Enhanced: Run All Code Chunks` o <kbd>ctrl-shift-enter</kbd>
  Ejecuta todos los Code Chunks.

## Formato

Puedes configurar las opciones del Code Chunk en el formato <code>\`\`\`lang {cmd=your_cmd opt1=value1 opt2=value2 ...}</code>.
Cuando el valor de un atributo es `true`, puede omitirse (por ejemplo, `{cmd hide}` es idéntico a `{cmd=true hide=true}`).

**lang**
La gramática con la que debe resaltarse el bloque de código.
Debe colocarse al principio.

## Opciones básicas

**cmd**
El comando a ejecutar.
Si no se proporciona `cmd`, entonces `lang` se utilizará como comando.

Por ejemplo:

    ```python {cmd="/usr/local/bin/python3"}
    print("Esto ejecutará el programa python3")
    ```

**output**
`html`, `markdown`, `text`, `png`, `none`

Define cómo renderizar la salida del código.
`html` añadirá la salida como HTML.
`markdown` analizará la salida como Markdown. (MathJax y los gráficos no serán compatibles en este caso, pero KaTeX funciona)
`text` añadirá la salida a un bloque `pre`.
`png` añadirá la salida como imagen en `base64`.
`none` ocultará la salida.

Por ejemplo:

    ```gnuplot {cmd=true output="html"}
    set terminal svg
    set title "Simple Plots" font ",20"
    set key left box
    set samples 50
    set style data points

    plot [-10:10] sin(x),atan(x),cos(atan(x))
    ```

![screen shot 2017-07-28 at 7 14 24 am](https://user-images.githubusercontent.com/1908863/28716734-66142a5e-7364-11e7-83dc-a66df61971dc.png)

**args**
Argumentos que se añaden al comando. Por ejemplo:

    ```python {cmd=true args=["-v"]}
    print("Verbose will be printed first")
    ```

    ```erd {cmd=true args=["-i", "$input_file", "-f", "svg"] output="html"}
      # output svg format and append as html result.
    ```

**stdin**
Si `stdin` se establece en true, el código se pasará como stdin en lugar de como archivo.

**hide**
`hide` ocultará el Code Chunk pero solo dejará visible la salida. Valor predeterminado: `false`
Por ejemplo:

    ```python {hide=true}
    print('puedes ver este mensaje de salida, pero no este código')
    ```

**continue**
Si se establece `continue=true`, este Code Chunk continuará desde el último Code Chunk.
Si se establece `continue=id`, este Code Chunk continuará desde el Code Chunk con ese id.
Por ejemplo:

    ```python {cmd=true id="izdlk700"}
    x = 1
    ```

    ```python {cmd=true id="izdlkdim"}
    x = 2
    ```

    ```python {cmd=true continue="izdlk700" id="izdlkhso"}
    print(x) # imprimirá 1
    ```

**class**
Si se establece `class="class1 class2"`, entonces `class1 class2` se añadirá al Code Chunk.

- La clase `line-numbers` mostrará números de línea en el Code Chunk.

**element**
El elemento que quieres añadir después.
Consulta el ejemplo de **Plotly** a continuación.

**run_on_save** `boolean`
Ejecutar el Code Chunk cuando se guarda el archivo Markdown. Valor predeterminado: `false`.

**modify_source** `boolean`
Insertar la salida del Code Chunk directamente en el archivo fuente Markdown. Valor predeterminado: `false`.

**id**
El `id` del Code Chunk. Esta opción es útil si se usa `continue`.

## Macro

- **input_file**
  `input_file` se genera automáticamente en el mismo directorio que tu archivo Markdown y se eliminará después de ejecutar el código que se copió en `input_file`.
  Por defecto, se añade al final de los argumentos del programa.
  Sin embargo, puedes establecer la posición de `input_file` en tu opción `args` usando la macro `$input_file`. Por ejemplo:

      ```program {cmd=true args=["-i", "$input_file", "-o", "./output.png"]}
      ...tu código aquí
      ```

## Matplotlib

Si se establece `matplotlib=true`, el bloque de código Python graficará en línea en la vista previa.
Por ejemplo:

    ```python {cmd=true matplotlib=true}
    import matplotlib.pyplot as plt
    plt.plot([1,2,3, 4])
    plt.show() # muestra la figura
    ```

![screen shot 2017-07-28 at 7 12 50 am](https://user-images.githubusercontent.com/1908863/28716704-4009d43a-7364-11e7-9e46-889f961e5afd.png)

## LaTeX

Markdown Preview Enhanced también admite la compilación de `LaTeX`.
Antes de usar esta función, necesitas tener [pdf2svg](extra.md?id=install-svg2pdf) y el [motor LaTeX](extra.md?id=install-latex-distribution) instalados.
Luego puedes simplemente escribir LaTeX en el Code Chunk de la siguiente forma:

    ```latex {cmd=true}
    \documentclass{standalone}
    \begin{document}
      Hello world!
    \end{document}
    ```

![screen shot 2017-07-28 at 7 15 16 am](https://user-images.githubusercontent.com/1908863/28716762-8686d980-7364-11e7-9669-71138cb2e6e7.png)

### Configuración de salida LaTeX

**latex_zoom**
Si se establece `latex_zoom=num`, el resultado se escalará `num` veces.

**latex_width**
El ancho del resultado.

**latex_height**
La altura del resultado.

**latex_engine**
El motor latex utilizado para compilar el archivo `tex`. Por defecto se usa `pdflatex`.

### Ejemplo de TikZ

Se recomienda usar `standalone` al dibujar gráficos `tikz`.
![screen shot 2017-07-14 at 11 27 56 am](https://user-images.githubusercontent.com/1908863/28221069-8113a5b0-6887-11e7-82fa-23dd68f2be82.png)

## Plotly

Markdown Preview Enhanced te permite crear gráficos con [Plotly](https://plot.ly/) fácilmente.
Por ejemplo:
![screen shot 2017-10-20 at 10 41 25 am](https://user-images.githubusercontent.com/1908863/31829580-526a0c06-b583-11e7-82f2-09ea7a0b9672.png)

- La primera línea `@import "https://cdn.plot.ly/plotly-latest.min.js"` usa la función de [importación de archivos](file-imports.md) para importar el archivo `plotly-latest.min.js`.
  Sin embargo, se recomienda descargar el archivo js al disco local para un mejor rendimiento.
- Luego se creó un Code Chunk de `javascript`.

## Demo

Este demo muestra cómo renderizar un diagrama entidad-relación usando la librería [erd](https://github.com/BurntSushi/erd).

    ```erd {cmd=true output="html" args=["-i", "$input_file" "-f", "svg"]}

    [Person]
    *name
    height
    weight
    +birth_location_id

    [Location]
    *id
    city
    state
    country

    Person *--1 Location
    ```

`erd {cmd=true output="html" args=["-i", "$input_file", "-f", "svg"]}`

- `erd` es el programa que estamos usando. (_necesitas tenerlo instalado primero_)
- `output="html"` añadirá el resultado de la ejecución como `html`.
- El campo `args` muestra los argumentos que usaremos.

Luego podemos hacer clic en el botón `run` en la vista previa para ejecutar nuestro código.

![erd](https://user-images.githubusercontent.com/1908863/28221395-bcd0bd76-6888-11e7-8c6e-925e228d02cc.gif)

## Ejemplos (desactualizados)

**bash**
![Screen Shot 2016-09-24 at 1.41.06 AM](https://i.imgur.com/v5Y7juh.png)

**gnuplot con salida svg**
![Screen Shot 2016-09-24 at 1.44.14 AM](https://i.imgur.com/S93g7Tk.png)

## Limitaciones

- Aún no funciona con `ebook`.
- Puede tener errores al usar `pandoc document export`

[➔ Presentación](presentation.md)
