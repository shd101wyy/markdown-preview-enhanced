# 额外

## 安装 pdf2svg

[pdf2svg 官网](https://www.cityinthesky.co.uk/opensource/pdf2svg/)

- **Mac**

```bash
brew install pdf2svg
```

- **Windows**  
  Windows 下的可执行文件可以在 [GitHub](https://github.com/jalios/pdf2svg-windows) 找到。  
  你需要添加 `pdf2svg.exe` 到你的系统路径。

* **Linux**  
  很多 Linux 下的包管理工具都提供 `pdf2svg` 的安装。

## 安装 LaTeX distribution

请查看 [Get LaTeX 网站](https://www.latex-project.org/get/)。  
[TeX Live](https://www.tug.org/texlive/) 是推荐的。

对于 **Mac** 用户，直接安装 [MacTex](https://www.tug.org/mactex) 然后你就没事儿了。

## 修改这个网站

这个网站基于 [docsify](https://docsify.js.org/#/)。  
要修改这个网站：

1. `git clone https://github.com/shd101wyy/markdown-preview-enhanced.git`
2. 在终端中运行以下的命令。

```bash
# 安装 docsify
npm i docsify-cli -g

cd path_to/markdown-preview-enhanced

docsify serve docs
```
