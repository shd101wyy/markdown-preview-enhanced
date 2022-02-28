## 0.15.0

- mume 업그레이드 버전 [0.2.4](https://github.com/shd101wyy/mume/blob/master/CHANGELOG.md).
- 수정 <kbd>shift-enter</kbd> 키맵 버그.

## 0.14.11

- mume 업그레이드 버전 [0.2.3](https://github.com/shd101wyy/mume/blob/master/CHANGELOG.md).
- 옵션 `enableEmojiSyntax` 추가.
- 옵션 `imageDropAction` 추가.

## 0.14.10

- mume 업그레이드 버전 [0.2.2](https://github.com/shd101wyy/mume/blob/master/CHANGELOG.md).
  - 옵션 `enableCriticMarkupSyntax` 추가. [Syntax guide](https://criticmarkup.com/users-guide.php).
  - `toc` 설정 front-matter `[TOC]` 와 sidebar TOC 추가 [#606](https://github.com/shd101wyy/markdown-preview-enhanced/issues/606).
  - TODO 박스 목록 버그 수정 [#592](https://github.com/shd101wyy/markdown-preview-enhanced/issues/592).
  - `KaTeX` 버전을 `0.8.3`으로 업그레이드.
  - `MathJax`의 CDN url 변경.
  - 수식 내보내기 이슈 수정 [#601](https://github.com/shd101wyy/markdown-preview-enhanced/issues/601).
- 단축키 `ctrl-shift-i` 제거.

## 0.14.9

- 목차의 `ignoreLink` 옵션 추가 [#583](https://github.com/shd101wyy/markdown-preview-enhanced/issues/583).
- 이슈 수정 [#584](https://github.com/shd101wyy/markdown-preview-enhanced/issues/584), [#585](https://github.com/shd101wyy/markdown-preview-enhanced/issues/585), [#586](https://github.com/shd101wyy/markdown-preview-enhanced/issues/585).

## 0.14.8

- `Welcome Page` 삭제.
- revealjs `fragment` 지원 [#559](https://github.com/shd101wyy/markdown-preview-enhanced/issues/559).
- Puppeteer 내보내기 지원 (Headless Chrome).

## 0.14.7

- revealjs html 내보내기 스타일 버그 수정.
- diagram의 설정 속성 **containers** 지원.
  예제:

          ```puml {.center}
          // your code here
          ```
      will add `class="center"` to the container.

- 기본값으로, 모든 내보내기 파일은 `github-light.css` 스타일 사용. 미리보기 테마를 내보내기에 사용하려면 `printBackground` 설정을 `true`로 지정하거나 `print_background:true` 를 front-matter에 추가.

## 0.14.6

- Supported quick image upload. Just drop your image file to markdown editor (not preview).
- 빠른 이지미 업로드 지원. (프리뷰 화면이 아님) markdown editor에 이미지 파일을 드래그앤 드롭 

![upload](https://i.loli.net/2017/08/07/5987db34cb33c.gif)

- HTML 내보내기 스타일 버그 수정.

## 0.14.5

- 이전에 지원하였던 [WaveDrom diagram](https://shd101wyy.github.io/markdown-preview-enhanced/#/diagrams?id=wavedrom) 기능을 다시 지원.
- 사용자 정의 css 문서 업데이트 [check it here](https://shd101wyy.github.io/markdown-preview-enhanced/#/customize-css).
- Sidebar TOC가 HTML 내보내기에서 지원. 기본적으로 활성화 되어 있음.
  ![screen shot 2017-08-05 at 8 50 16 pm](https://user-images.githubusercontent.com/1908863/28999904-c40b56b6-7a1f-11e7-9a9e-ab2e19a82b41.png)

  sidebar TOC 를 front-matter를 통해서 설정할 수 있음. 상세 정보는 [this doc](https://shd101wyy.github.io/markdown-preview-enhanced/#/html?id=configuration).

- [mume](https://github.com/shd101wyy/mume) 업그레이드 버전 [0.1.7](https://github.com/shd101wyy/mume/blob/master/CHANGELOG.md).

## 0.14.4

- 속성을 정의하는 이전 방식을 삭제 (아직 지원하지만, 사용하지 않기를 권함) [#529](https://github.com/shd101wyy/markdown-preview-enhanced/issues/529). 지금 부터 속성은 다음과 같은 순서로 정의하여 pandoc parsor와 호환성을 유지하도록 한다:

        {#identifier .class .class key=value key=value}

  몇가지 변경된 사례:

        # Hi {#id .class1 .class2}

        Show `line-numbers`
        ```javascript {.line-numbers}
        x = 1
        ```

        ```python {cmd=true output="markdown"}
        print("**Hi there**")
        ```

        <!-- slide vertical=true .slide-class1 .slide-class2 #slide-id -->

        \@import "test.png" {width=50% height=30%}

- 미리보기 테마 추가. 
- [vega](https://vega.github.io/vega/) 와 [vega-lite](https://vega.github.io/vega-lite/) 지원. [#524](https://github.com/shd101wyy/markdown-preview-enhanced/issues/524).

  - `vega` 형식의 코드 블럭 렌더링이 가능 [vega](https://vega.github.io/vega/).
  - `vega-lite` 형식의 코드 블럭 렌더링이 가능  [vega-lite](https://vega.github.io/vega-lite/).
  - `JSON` 과 `YAML` 입력을 지원.

  ![screen shot 2017-07-28 at 7 59 58 am](https://user-images.githubusercontent.com/1908863/28718265-d023e1c2-736a-11e7-8678-a29704f3a23c.png)

  파일 가져오기에서 [@import](https://shd101wyy.github.io/markdown-preview-enhanced/#/file-imports) `JSON` 또는 `YAML` 파일을 `vega` 그림으로 가져올 수 있음, 예:

<pre>
    \@import "your_vega_source.json" {as="vega"}
    \@import "your_vega_lite_source.json" {as="vega-lite"}
</pre>

- [ditaa](https://github.com/stathissideris/ditaa) 지원.
  ditaa 를 이용하여 도표를 ascii art로 그릴 수 있음 ('drawings' 그림의 선들은 미슷한 문자로 대체됨 | / - ). (**Java** 가 사전에 설치되어 있어야 함)

  `ditaa`가 [code chunk](https://shd101wyy.github.io/markdown-preview-enhanced/#/code-chunk)와 통합됨. 예:

  <pre>
    ```ditaa {cmd=true args=["-E"]}
    +--------+   +-------+    +-------+
    |        | --+ ditaa +--> |       |
    |  Text  |   +-------+    |diagram|
    |Document|   |!magic!|    |       |
    |     {d}|   |       |    |       |
    +---+----+   +-------+    +-------+
        :                         ^
        |       Lots of work      |
        +-------------------------+
    ```
  </pre>

> <kbd>shift-enter</kbd> 로 code chunk 실행.
> `{hide=true}` 설정하여 code block 숨기기.
> `{run_on_save=true}` 설정하여  markdown 파일을 저장할때 ditaa를 렌더링.

![screen shot 2017-07-28 at 8 11 15 am](https://user-images.githubusercontent.com/1908863/28718626-633fa18e-736c-11e7-8a4a-915858dafff6.png)

## 0.14.3

- 업그레이드 [mume](https://github.com/shd101wyy/mume) 버전 `0.1.4`.
  - 수정 header id 버그 [#516](https://github.com/shd101wyy/markdown-preview-enhanced/issues/516).
  - 수정 `enableExtendedTableSyntax` 버그.
  - 수정 `MathJax` 초기화 에러 [#28](https://github.com/shd101wyy/vscode-markdown-preview-enhanced/issues/28), [#504](https://github.com/shd101wyy/markdown-preview-enhanced/issues/504).
  - 수정 일반 코드 블록의 폰트 크기 이슈.
  - 수정 `transformMarkdown` 함수의 `Maximum call stack size exceeded` 이슈 [515](https://github.com/shd101wyy/markdown-preview-enhanced/issues/515), [#517](https://github.com/shd101wyy/markdown-preview-enhanced/issues/517).

## 0.14.2

- 업그레이드 [mume](https://github.com/shd101wyy/mume) 버전 `0.1.3`.

  - Windows에서 pandoc 내보내기 버그 수정.
  - markdown 내보내기 버그 수정. `ignore_from_front_matter` 옵션이 `markdown` 필드에 추가됨. `front_matter`가 `markdown` 필드에서 삭제됨.
  - `latexEngine` 와 `enableExtendedTableSyntax` 설정 옵션이 추가됨. 표의 셀 합치기가 지원됨. (초기값은 비활성. 사용하려면 설정에서 활성화 해야 함).
    [#479](https://github.com/shd101wyy/markdown-preview-enhanced/issues/479), [#133](https://github.com/shd101wyy/markdown-preview-enhanced/issues/133).

  ![screen shot 2017-07-15 at 8 16 45 pm](https://user-images.githubusercontent.com/1908863/28243710-945e3004-699a-11e7-9a5f-d74f6c944c3b.png)

  - `export_on_save` front-matter를 지원하여 markdown 파일을 저장할때 동시에 파일 내보내기 지원. 하지만, `phantomjs`, `prince`, `pandoc`, `ebook` 에서는 `export_on_save` 사용하면 너무 느려지는 단점이 있음.

  eg:

  ```javascript
  ---
  export_on_save:
      html: true
      markdown: true
      prince: true
      phantomjs: true // or "pdf" | "jpeg" | "png" | ["pdf", ...]
      pandoc: true
      ebook: true // or "epub" | "mobi" | "html" | "pdf" | array
  ---
  ```

  - HTML 내보내기에 `embed_svg` front-matter 옵션 추가. 기본적으로 활성화 되어 있음.

* 미리보기가 electron `webview`를 사용하여 렌더링 됨. 더이상 `iframe` 사용되지 않음. 이슈 수정 [#500](https://github.com/shd101wyy/markdown-preview-enhanced/issues/500).

## 0.14.1

- [mume](https://github.com/shd101wyy/mume) 업그레이드 버전 `0.1.2`.
  - 기본 마크다운 파서를 `remarkable` 에서 `markdown-it`로 변경.
  - pandoc 내보내기에서 front-matter 포함한되는 버그 수정.
  - `bash` language highlighting 버그 수정.
  - phantomjs 작업 리스트 내보내기 버그 수정.
  - `webview.ts` 스크립트 업그레이드. Atom 과 VS Code 동일한 디스플레이 로직 사용.
  - 중복된 의존성 제거.

## 0.14.0

- TypeScript로 전체를 다시 작성하여 잠재적인 버그가 감소될 것으로 예상됨. 
- [Mume](https://github.com/shd101wyy/mume) 프로젝트의 지원을 받음. Atom 버전과 vscode 버전이 동일한 코어를 사용.
- 여러개의 미리보기 테마와 코드 블럭 테마를 지원.

  - Github Light
    ![screen shot 2017-07-14 at 12 58 37 pm](https://user-images.githubusercontent.com/1908863/28224323-4899d896-6894-11e7-823a-233ee433d832.png)
  - Night
    ![screen shot 2017-07-14 at 12 59 04 pm](https://user-images.githubusercontent.com/1908863/28224327-4b0f77a2-6894-11e7-8133-99a2d04172a4.png)

- 새로운 프레젠테이션 모드 디자인, 모든 reaveal.js 공식 테마가 지원됨.

![screen shot 2017-07-14 at 12 33 14 pm](https://user-images.githubusercontent.com/1908863/28223480-2c61461c-6891-11e7-9389-5adec0588c32.png)

- 사용자 지정 css 사용하기 쉽도록 변경. `.markdown-preview-enhanced.markdown-preview-enhanced` 기능은 삭제되고, 단지 `html body`에 스타일을 작성할 수 있음.
  [Customize CSS Tutorial](https://shd101wyy.github.io/markdown-preview-enhanced/#/customize-css).

- Code chunk의 문법 변경, code chunk를 적절하게 선언하기 위해서는 `cmd` 정의가 필요하며, `id`는 더이상 필요하지 않음. 새로운 문법 예제:

      ```python {cmd:true}
      print("Hi There")
      ```

- 상세한 정보는 [project website](https://shd101wyy.github.io/markdown-preview-enhanced).
