# Editor de Presentaciones

![screen shot 2017-07-14 at 12 33 14 pm](https://user-images.githubusercontent.com/1908863/28223480-2c61461c-6891-11e7-9389-5adec0588c32.png)

Markdown Preview Enhanced usa [reveal.js](https://github.com/hakimel/reveal.js) para renderizar hermosas presentaciones.

[Haz clic aquí](https://rawgit.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.html) para ver la introducción (**Recomendado**).

![presentation](https://user-images.githubusercontent.com/1908863/28202176-caf103c4-6839-11e7-8776-942679f3698b.gif)

## Front-Matter de la presentación

Puedes configurar tu presentación añadiendo front-matter a tu archivo Markdown.  
Debes escribir tu configuración bajo la sección `presentation`.  
Por ejemplo:

```markdown
---
presentation:
  width: 800
  height: 600
---

<!-- slide -->

Tus diapositivas van aquí...
```

La presentación anterior tendrá un tamaño de `800x600`

### Configuración

```yaml
---
presentation:
  # tema de la presentación
  # === temas disponibles ===
  # "beige.css"
  # "black.css"
  # "blood.css"
  # "league.css"
  # "moon.css"
  # "night.css"
  # "serif.css"
  # "simple.css"
  # "sky.css"
  # "solarized.css"
  # "white.css"
  # "none.css"
  theme: white.css

  # El tamaño "normal" de la presentación; la relación de aspecto se preservará
  # cuando la presentación se escale para ajustarse a diferentes resoluciones. Se puede
  # especificar usando unidades de porcentaje.
  width: 960
  height: 700

  # Factor del tamaño de pantalla que debe permanecer vacío alrededor del contenido
  margin: 0.1

  # Límites para la escala mínima/máxima que se puede aplicar al contenido
  minScale: 0.2
  maxScale: 1.5

  # Mostrar controles en la esquina inferior derecha
  controls: true

  # Mostrar una barra de progreso de la presentación
  progress: true

  # Mostrar el número de página de la diapositiva actual
  slideNumber: false

  # Registrar cada cambio de diapositiva en el historial del navegador
  history: false

  # Habilitar atajos de teclado para la navegación
  keyboard: true

  # Habilitar el modo de vista general de diapositivas
  overview: true

  # Centrado vertical de las diapositivas
  center: true

  # Habilitar la navegación táctil en dispositivos con entrada táctil
  touch: true

  # Repetir la presentación en bucle
  loop: false

  # Cambiar la dirección de la presentación a RTL
  rtl: false

  # Aleatorizar el orden de las diapositivas cada vez que se carga la presentación
  shuffle: false

  # Activar o desactivar fragmentos globalmente
  fragments: true

  # Indica si la presentación se ejecuta en modo incrustado,
  # es decir, contenida dentro de una porción limitada de la pantalla
  embedded: false

  # Indica si se debe mostrar una superposición de ayuda cuando se presiona
  # la tecla de interrogación
  help: true

  # Indica si las notas del presentador deben ser visibles para todos los espectadores
  showNotes: false

  # Número de milisegundos entre avances automáticos a la
  # siguiente diapositiva, desactivado cuando es 0, este valor puede ser sobreescrito
  # usando un atributo data-autoslide en tus diapositivas
  autoSlide: 0

  # Detener el avance automático después de la entrada del usuario
  autoSlideStoppable: true

  # Habilitar la navegación por diapositivas mediante la rueda del mouse
  mouseWheel: false

  # Ocultar la barra de direcciones en dispositivos móviles
  hideAddressBar: true

  # Abrir enlaces en una superposición de vista previa en iframe
  previewLinks: false

  # Estilo de transición
  transition: 'default' # none/fade/slide/convex/concave/zoom

  # Velocidad de transición
  transitionSpeed: 'default' # default/fast/slow

  # Estilo de transición para fondos de diapositiva a página completa
  backgroundTransition: 'default' # none/fade/slide/convex/concave/zoom

  # Número de diapositivas alejadas de la actual que son visibles
  viewDistance: 3

  # Imagen de fondo de Parallax
  parallaxBackgroundImage: '' # ej. "'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg'"

  # Tamaño de la imagen de fondo de Parallax
  parallaxBackgroundSize: '' # Sintaxis CSS, ej. "2100px 900px"

  # Número de píxeles para mover el fondo de Parallax por diapositiva
  # - Se calcula automáticamente a menos que se especifique
  # - Establecer en 0 para deshabilitar el movimiento en un eje
  parallaxBackgroundHorizontal: null
  parallaxBackgroundVertical: null

  # Imagen de fondo de Parallax
  parallaxBackgroundImage: '' # ej. "https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg"

  # Tamaño de la imagen de fondo de Parallax
  parallaxBackgroundSize: '' # Sintaxis CSS, ej. "2100px 900px" - actualmente solo se admiten píxeles (no uses % o auto)

  # Número de píxeles para mover el fondo de Parallax por diapositiva
  # - Se calcula automáticamente a menos que se especifique
  # - Establecer en 0 para deshabilitar el movimiento en un eje
  parallaxBackgroundHorizontal: 200
  parallaxBackgroundVertical: 50

  # Habilitar notas del presentador
  enableSpeakerNotes: false
---
```

## Personalizar el estilo de las diapositivas

Puedes agregar `id` y `class` a una diapositiva específica de la siguiente forma:

```markdown
<!-- slide id="my-id" class="my-class1 my-class2" -->
```

O si solo quieres personalizar la diapositiva número `n`, modifica tu archivo `less` de la siguiente forma:

```less
.markdown-preview.markdown-preview {
  // estilo personalizado de la presentación
  .reveal .slides {
    // modificar todas las diapositivas
  }

  .slides > section:nth-child(1) {
    // esto modificará `la primera diapositiva`
  }
}
```

[➔ Pandoc](pandoc.md)
