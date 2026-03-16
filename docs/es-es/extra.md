# Extra

## Instalar pdf2svg

[El sitio web oficial de pdf2svg](https://www.cityinthesky.co.uk/opensource/pdf2svg/)

- **Mac**

```bash
brew install pdf2svg
```

- **Windows**  
  Los binarios para Windows están disponibles en [GitHub](https://github.com/jalios/pdf2svg-windows).  
  También necesitas añadir `pdf2svg.exe` a tu `$PATH`.

* **Linux**  
  `pdf2svg` está empaquetado para varias distribuciones Linux (incluyendo Ubuntu y Fedora) y está disponible a través de los diferentes gestores de paquetes.

## Instalar distribución LaTeX

Por favor consulta el [sitio web Get LaTeX](https://www.latex-project.org/get/).  
Se recomienda [TeX Live](https://www.tug.org/texlive/) para trabajar con Markdown Preview Enhanced.

Para usuarios de **Mac**, simplemente instala [MacTex](https://www.tug.org/mactex) y listo.

## Modificar este sitio web

Este sitio web de documentación está impulsado por [docsify](https://docsify.js.org/#/).  
Para modificar este sitio web:

1. `git clone https://github.com/shd101wyy/markdown-preview-enhanced.git`
2. Ejecuta los siguientes comandos en la terminal:

```bash
# instalar docsify
npm i docsify-cli -g

cd path_to/markdown-preview-enhanced

docsify serve docs
```
