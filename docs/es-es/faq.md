# Preguntas frecuentes

1. **No puedo encontrar este paquete en Atom.**  
   Por favor busca el nombre completo del paquete: `markdown-preview-enhanced`

2. **Exporté un archivo HTML y quiero desplegarlo en mi propio servidor remoto. Pero la composición matemática (MathJax o KaTeX) no funciona. ¿Qué debo hacer?**  
   Asegúrate de tener marcado `Use CDN hosted resources` al exportar.
3. **Exporté un archivo HTML de presentación y quiero ponerlo en mi GitHub Page o desplegarlo de forma remota.**  
   Por favor consulta la pregunta anterior.
4. **¿Cómo obtengo el estilo de vista previa oscuro?**  
   Si deseas que el estilo de la vista previa sea consistente con tu editor de Atom, ve a la configuración de este paquete y cambia el `Preview Theme`.  
   O puedes ejecutar el comando `Markdown Preview Enhanced: Customize Css`, luego modificar el archivo `style.less`. [#68](https://github.com/shd101wyy/markdown-preview-enhanced/issues/68), [#89](https://github.com/shd101wyy/markdown-preview-enhanced/issues/89).
5. **¿La vista previa va muy lenta?**  
   Esto puede ocurrir cuando tu archivo Markdown es muy grande, o estás escribiendo muchas expresiones matemáticas o gráficos.  
   Por eso te recomendaría deshabilitar la funcionalidad `Live Update`.  
   Puedes ejecutar `Markdown Preview Enhanced: Toggle Live Update` para deshabilitarla.
6. **¿Los atajos de teclado no funcionan?**  
   <kbd>cmd-shift-p</kbd> y luego elige `Key Binding Resolver: Toggle`. Comprueba si hay conflictos de atajos de teclado, o publica un issue en GitHub.
