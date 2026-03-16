# Extra

## Instalar pdf2svg

[O site oficial do pdf2svg](https://www.cityinthesky.co.uk/opensource/pdf2svg/)

- **Mac**

```bash
brew install pdf2svg
```

- **Windows**  
  Binários para Windows estão disponíveis no [GitHub](https://github.com/jalios/pdf2svg-windows).  
  Você também precisa adicionar o `pdf2svg.exe` ao seu `$PATH`.

* **Linux**  
  `pdf2svg` está empacotado para várias distribuições Linux (incluindo Ubuntu e Fedora) e está disponível através dos diferentes gerenciadores de pacotes.

## Instalar distribuição LaTeX

Por favor, consulte o [site Get LaTeX](https://www.latex-project.org/get/).  
[TeX Live](https://www.tug.org/texlive/) é o mais recomendado para usar com Markdown Preview Enhanced.

Para usuários **Mac**, basta instalar o [MacTex](https://www.tug.org/mactex/) e pronto.

## Modificar este site

Este site de documentação é alimentado pelo [docsify](https://docsify.js.org/#/).  
Para modificar este site:

1. `git clone https://github.com/shd101wyy/markdown-preview-enhanced.git`
2. Execute os seguintes comandos no terminal:

```bash
# instalar docsify
npm i docsify-cli -g

cd path_to/markdown-preview-enhanced

docsify serve docs
```
