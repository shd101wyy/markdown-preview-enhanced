# Extra
## Install svg2pdf
[The official website of svg2pdf](http://www.cityinthesky.co.uk/opensource/pdf2svg/)  
* **Mac**  
```bash
brew install pdf2svg
```  
* **Windows**  
Windows binaries are available from [GitHub](https://github.com/jalios/pdf2svg-windows).  
You also need to set the `pdf2svg.exe` to your system path.  


* **Linux**   
`pdf2svg` is packaged for various Linux distributions (including Ubuntu and Fedora) and is available via the different package managers.

## Install LaTeX distribution  
Please check [Get LaTeX website](https://www.latex-project.org/get/).  
[TeX Live](http://www.tug.org/texlive/) is the best recommended to work with Markdown Preview Enhanced.   

For **Mac** user, simply install [MacTex](https://www.tug.org/mactex) and you are done.   


## Modify this website  
This documentation website is powered by [docsify](https://docsify.js.org/#/).   
To modify this website:   

1. `git clone https://github.com/shd101wyy/markdown-preview-enhanced.git`  
2. run the following commands in terminal:   

```bash
# install docsify  
npm i docsify-cli -g

cd path_to/markdown-preview-enhanced  

docsify serve docs  
```

