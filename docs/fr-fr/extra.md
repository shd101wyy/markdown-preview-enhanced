# Extra

## Installer pdf2svg

[Le site officiel de pdf2svg](https://www.cityinthesky.co.uk/opensource/pdf2svg/)

- **Mac**

```bash
brew install pdf2svg
```

- **Windows**  
  Les binaires Windows sont disponibles sur [GitHub](https://github.com/jalios/pdf2svg-windows).  
  Vous devez également ajouter `pdf2svg.exe` à votre `$PATH`.

* **Linux**  
  `pdf2svg` est disponible pour diverses distributions Linux (dont Ubuntu et Fedora) via les différents gestionnaires de paquets.

## Installer une distribution LaTeX

Veuillez consulter le [site Get LaTeX](https://www.latex-project.org/get/).  
[TeX Live](https://www.tug.org/texlive/) est la distribution la plus recommandée pour travailler avec Markdown Preview Enhanced.

Pour les utilisateurs **Mac**, installez simplement [MacTex](https://www.tug.org/mactex) et c'est tout.

## Modifier ce site web

Ce site de documentation est propulsé par [docsify](https://docsify.js.org/#/).  
Pour modifier ce site web :

1. `git clone https://github.com/shd101wyy/markdown-preview-enhanced.git`
2. exécutez les commandes suivantes dans le terminal :

```bash
# installer docsify
npm i docsify-cli -g

cd path_to/markdown-preview-enhanced

docsify serve docs
```
