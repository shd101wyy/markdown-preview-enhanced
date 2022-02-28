# 기타

## pdf2svg 설치

[pdf2svg 공식 홈페이지](https://www.cityinthesky.co.uk/opensource/pdf2svg/)

- **Mac**

```bash
brew install pdf2svg
```

- **Windows**  
  Windows 바이너리 파일은 [GitHub](https://github.com/jalios/pdf2svg-windows) 에서 다운로드 받을 수 있다.  
  또한 사용자는 `pdf2svg.exe`을 시스템 변수 `$PATH`에 필수로 추가해야 된다.

* **Linux**  
  `pdf2svg` 는 다양한 리눅스 배포판(우분투 및 페도라를 포함)에서 패키지로 제공되며 다양한 패키지 관리자를 통해 사용할 수 있습니다.

## LaTeX distribution 설치

[Get LaTeX website](https://www.latex-project.org/get/) 를 확인한다.  
[TeX Live](https://www.tug.org/texlive/) 는 Markdown Preview Enhanced로 작업이 용이하여 추천한다.
**Mac** 사용자의 경우, [MacTex](https://www.tug.org/mactex) 를 설치하면 간단하다.

## 해당 웹사이트 수정

이 웹사이트는 [docsify](https://docsify.js.org/#/) 에 의해 구동된다.

이 웹사이트를 수정하기 위해서는:

1. `git clone https://github.com/shd101wyy/markdown-preview-enhanced.git` 으로 git에 클론한다.
2. 터미널에 아래의 명령어를 입력한다. :

```bash
# install docsify
npm i docsify-cli -g

cd path_to/markdown-preview-enhanced

docsify serve docs
```