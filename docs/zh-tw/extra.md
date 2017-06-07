# 額外
## 安裝 svg2pdf
[svg2pdf 官網](http://www.cityinthesky.co.uk/opensource/pdf2svg/)  
* **Mac**  
```bash
brew install pdf2svg
```  
* **Windows**  
Windows 下的可執行文件可以在 [GitHub](https://github.com/jalios/pdf2svg-windows) 找到。  
你需要添加 `pdf2svg.exe` 到你的系統路徑。    


* **Linux**   
很多 Linux 下的包管理工具都提供 `pdf2svg` 的安裝。  

## 安裝 LaTeX distribution  
請查看 [Get LaTeX 網站](https://www.latex-project.org/get/)。  
[TeX Live](http://www.tug.org/texlive/) 是推薦的。  

對於 **Mac** 用戶，直接安裝 [MacTex](https://www.tug.org/mactex) 然後你就沒事兒了。     


## 修改這個網站  
這個網站基於 [docsify](https://docsify.js.org/#/)。     
要修改這個網站：  

1. `git clone https://github.com/shd101wyy/markdown-preview-enhanced.git`  
2. 在終端中運行以下的命令。   

```bash
# 安裝 docsify  
npm i docsify-cli -g

cd path_to/markdown-preview-enhanced  

docsify serve docs  
```

