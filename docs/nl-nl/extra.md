# Extra

## pdf2svg installeren

[De officiële website van pdf2svg](https://www.cityinthesky.co.uk/opensource/pdf2svg/)

- **Mac**

```bash
brew install pdf2svg
```

- **Windows**  
  Windows-binaries zijn beschikbaar via [GitHub](https://github.com/jalios/pdf2svg-windows).  
  U moet ook `pdf2svg.exe` toevoegen aan uw `$PATH`.

* **Linux**  
  `pdf2svg` is verpakt voor verschillende Linux-distributies (waaronder Ubuntu en Fedora) en is beschikbaar via de verschillende pakketbeheerders.

## LaTeX-distributie installeren

Raadpleeg de [Get LaTeX-website](https://www.latex-project.org/get/).  
[TeX Live](https://www.tug.org/texlive/) wordt het beste aanbevolen voor gebruik met Markdown Preview Enhanced.

Voor **Mac**-gebruikers: installeer gewoon [MacTex](https://www.tug.org/mactex) en u bent klaar.

## Deze website aanpassen

Deze documentatiewebsite wordt aangedreven door [docsify](https://docsify.js.org/#/).  
Om deze website te wijzigen:

1. `git clone https://github.com/shd101wyy/markdown-preview-enhanced.git`
2. Voer de volgende opdrachten uit in de terminal:

```bash
# installeer docsify
npm i docsify-cli -g

cd path_to/markdown-preview-enhanced

docsify serve docs
```
