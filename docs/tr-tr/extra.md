# Ekstra

## pdf2svg Kurulumu

[pdf2svg'nin resmi web sitesi](https://www.cityinthesky.co.uk/opensource/pdf2svg/)

- **Mac**

```bash
brew install pdf2svg
```

- **Windows**  
  Windows ikilileri [GitHub](https://github.com/jalios/pdf2svg-windows)'dan indirilebilir.  
  Ayrıca `pdf2svg.exe`'yi `$PATH`'inize eklemeniz gerekir.

* **Linux**  
  `pdf2svg`, çeşitli Linux dağıtımları için (Ubuntu ve Fedora dahil) paketlenmiştir ve farklı paket yöneticileri aracılığıyla kullanılabilir.

## LaTeX Dağıtımı Kurulumu

Lütfen [Get LaTeX web sitesine](https://www.latex-project.org/get/) bakın.  
[TeX Live](https://www.tug.org/texlive/), Markdown Preview Enhanced ile çalışmak için en iyi önerilenidir.

**Mac** kullanıcıları için sadece [MacTex](https://www.tug.org/mactex)'i kurun ve işlem tamamdır.

## Bu Web Sitesini Değiştirme

Bu belgeleme web sitesi [docsify](https://docsify.js.org/#/) tarafından desteklenmektedir.  
Bu web sitesini değiştirmek için:

1. `git clone https://github.com/shd101wyy/markdown-preview-enhanced.git`
2. Terminalde aşağıdaki komutları çalıştırın:

```bash
# docsify kur
npm i docsify-cli -g

cd path_to/markdown-preview-enhanced

docsify serve docs
```
