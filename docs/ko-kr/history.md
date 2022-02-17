## 0.13.0

- [x] `LaTeX` 코드 청크를 지원한다. [pdf2svg](https://shd101wyy.github.io/markdown-preview-enhanced/#/extra) 와 [LaTeX engine](https://shd101wyy.github.io/markdown-preview-enhanced/#/extra)가 요구된다. 아래 내용 참조.
- [x] `향상된 미리보기 : 업로드한 이미지를 표시합니다`가 추가된다. 이제 이미지를 업로드할때마다 내역에 저장한다.
- [x] `@import` PDF 파일을 지원한다. 예시 `@import "test.pdf"`. [pdf2svg](https://shd101wyy.github.io/markdown-preview-enhanced/#/extra) 가 요구된다.
- [x] `@import` JavaScript 파일을 지원한다. 자바스크립트는 node.js가 아닌 window 범위에서 평가한다.
- [x] **주의:** <code>\`\`\`@mermaid</code> 는 사용되지 않는다. 이제부턴 오직 <code>\`\`\`mermaid</code>가 지원됩니다. `PlantUML`, `viz.js`, 와 `WaveDrom`도 동일하게 적용된다. 더 많은 정보는,[이 문서](https://shd101wyy.github.io/markdown-preview-enhanced/#/graphs)를 확인하세요.
- [x] GitHub 페이지로 문서 마이그레이션 하는 방법 [docsify](https://docsify.js.org/#/). [Project website is here](https://shd101wyy.github.io/markdown-preview-enhanced/#/). 문서 번역을 도울 의향이 있으면 연락하세요. :)
- [ ] 키 바인딩 문제를 해결하기 위해 노력했지만 해결되었는지 알 수 없습니다.
- [x] eBook 생성 문제를 수정합니다. `include_toc` 옵션을 추가합니다.
- [x] 다중 미리보기에 대한 지원 [#435](https://github.com/shd101wyy/markdown-preview-enhanced/issues/435).
- [x] `sm.ms` 이미지 업로드 API 문제 수정 [#390](https://github.com/shd101wyy/markdown-preview-enhanced/issues/390).
- [x] 이슈 수정 [#436](https://github.com/shd101wyy/markdown-preview-enhanced/issues/436).

## v0.12.7 & v0.12.8

- [x] Welcome 페이지이슈를 빠르게 해결합니다. 따라서 이 패키지가 업데이트될 때만 시작 페이지가 열립니다. [#428](https://github.com/shd101wyy/markdown-preview-enhanced/issues/428).

## v0.12.6

- [x] `WELCOME.md` 페이지와 `Markdown Preview Enhanced: Open Welcome Page` 커맨드가 추가됩니다.`WELCOME.md`에는 이 패키지의 변경 사항과 업데이트가 표시됩니다.
- [x] `mathjax_config.js` 파일과 `Markdown Preview Enhanced: Open MathJax Config`커맨드가 추가됩니다. `mathJaxProcessEnvironments`를 구성된 스키마로부터 제거해주세요.그러나 일부 `MathJax` 확장 기능이 잘 동작하지 않습니다.
- [x] 여러 미리 보기를 지원합니다. 패키지 설정에서 '한 개의 미리 보기만 열기'를 선택 취소하여 여러 개의 미리 보기를 활성화하여 각 표시 소스에 미리 보기를 사용할 수 있습니다.
- [x] `cmd-r` 미리보기의 바로 가기 키를 눌러 미리보기를 새로 고칩니다.
- [x] 더 강력한 `@import`:
  1. 온라인 파일 가져오기를 지원합니다.
  2. 이미지 구성 지원
  3. 코드 블록을 렌더링합니다.
  4. Code Chunk
- [x] TOC가 `{.ignore}`를 추가하여 머리글을 무시하도록 지원한다.
- [x] `line-numbers` 클래스를 추가하여 Code Block 및 Code Chunk에 대한 라인 번호를 표시한다.
- [x] 스크롤 동기화 로직이 수정되었습니다(중요한 문제).
- [x] `Markdown Preview Enhanced: Sync Preview` 와 `Markdown Preview Enhanced: Sync Source`를 지원한다 [#424](https://github.com/shd101wyy/markdown-preview-enhanced/issues/424).
- [x] Windows 에서의 `@import` 이슈 해결 [#414](https://github.com/shd101wyy/markdown-preview-enhanced/issues/414).
- [x] PlantUML 렌더링 수정[issue](https://github.com/shd101wyy/markdown-preview-enhanced/commit/4b9f7df66af18a96905b60eb845463771fdd034a).

## 0.12.5

- [x] 이슈 해결 [#418](https://github.com/shd101wyy/markdown-preview-enhanced/issues/418).
- [x] 이슈 해결 [#417](https://github.com/shd101wyy/markdown-preview-enhanced/issues/417)

## 0.12.4

- [x] `zoom`미리보기 지원.
- [x] `viz`를 `v1.8.0`로 업그레이드.
- [x] `plantuml`를`1.2017.13`로 업그레이드.
- [x] `reveal.js`를 `3.5.0`로 업그레이드.
- [x] faster `plantuml` 렌더링 속도 향상에 대해 기여해주신 분에게 감사를 표합니다. [@river0825](https://github.com/river0825).
- [x] TOC 버그 수정 [#406](https://github.com/shd101wyy/markdown-preview-enhanced/issues/406).
- [x] Code Block과 Code Chunk를 지원하기 위한 `class`추가. Code Block과 Code Chunk의 줄 번호를 보여주기 위해`line-numbers` 클래스를 지원한다.
- [x] `sidebar` TOC 지원.
- [x] 전체 참조 자료 목록 절대 파일 경로 문제 수정 [#409](https://github.com/shd101wyy/markdown-preview-enhanced/issues/409).
- [x] `language-diff` 지원 [#415](https://github.com/shd101wyy/markdown-preview-enhanced/issues/415).
- [x] `showBackToTopButton` 제거.
- [x] 이제 다른 미리보기 테마에 따라 스크롤 막대 스타일이 달라집니다.

## 0.12.2 & 0.12.3

- [x] plantuml 파일 import 문제 해결[#398](https://github.com/shd101wyy/markdown-preview-enhanced/issues/398).
- [x] MathJax지원을 위한 `xypic` 추가 [#393](https://github.com/shd101wyy/markdown-preview-enhanced/pull/393).
- [x] `MathJax`버전 `2.7.1`로 업그레이드.
- [x] <code>\`\`\`math</code> Content 이탈 문제 수정.

## 0.12.1

- [x] 이슈 수정 [#387](https://github.com/shd101wyy/markdown-preview-enhanced/issues/387) `Pagebreak command ignored`.
- [x] 이슈 수정 [#388](https://github.com/shd101wyy/markdown-preview-enhanced/issues/388).
- [x] `plantuml` 버전 `1.2017.12`로 업그레이드 [#382](https://github.com/shd101wyy/markdown-preview-enhanced/issues/382).
- [x] 기본 산술 인라인 및 블록 구분 기호를 사용하기 위한`\(...\)` 와 `\[...\]`추가.

## 0.11.1

- [x] add `class` and `id` field to `slide` of presentation & update presentation-intro.md.
- [x] 이슈 해결 [#368](https://github.com/shd101wyy/markdown-preview-enhanced/issues/368), open file whose path has space.
- [x] MathJax cdn 업그레이드[#361](https://github.com/shd101wyy/markdown-preview-enhanced/issues/361).
- [x] Local Style 지원[#351](https://github.com/shd101wyy/markdown-preview-enhanced/issues/351).
- [x] Customzing CSS 관련 문서 추가.
- [ ] <strike>`@import` 쌍 따옴표와 따옴표 </strike>가 잘 작동 안함.
- [x] `id`와`class` front-matter config에 추가.

## 0.10.12

- [x] `file import` 이제 PATH에 공백이 있는 이미지를 가져올 수 있습니다.예시: `@import "test copy.png"`.
- [x] 이슈 해결 [#345](https://github.com/shd101wyy/markdown-preview-enhanced/issues/345).
- [x] 이슈 해결 [#352](https://github.com/shd101wyy/markdown-preview-enhanced/issues/352).
- [x] TOC 번호 목록 TAB 이슈 해결 [#355](https://github.com/shd101wyy/markdown-preview-enhanced/issues/355).
- [x] pandoc parser가 이제 지원됨. `[TOC]`.
- [x] `Pandoc Options: Markdown Flavor` configuration Settings에 추가.
- [x] pandoc parser에 대한 프레젠테이션 지원 추가 [#354](https://github.com/shd101wyy/markdown-preview-enhanced/issues/354).

## 0.10.11

- [x] plantuml `@import` 이슈 해결. [#342](https://github.com/shd101wyy/markdown-preview-enhanced/issues/342).
- [x] `embed image` html export를 위한 추가. [#345](https://github.com/shd101wyy/markdown-preview-enhanced/issues/345).
- [x] wikilink 파일 확장자 옵션 [#346](https://github.com/shd101wyy/markdown-preview-enhanced/issues/346).

## 0.10.10

- [ ] speaker note Windows 이슈 [#199](https://github.com/shd101wyy/markdown-preview-enhanced/issues/199).
- [x] `[TOC]` 지원.
- [x] `whiteBackground` 옵션 추가.
- [x] 프레젠테이션 스크롤 동기화.

## 0.10.9

- [x] 이슈 해결 [#325](https://github.com/shd101wyy/markdown-preview-enhanced/issues/325). Code block이 이제 대소문자를 구분하지 않습니다.
- [x] pandoc parser code chunk 관련 이슈 해결
- [x] `prince` 지원 추가. [doc](./docs/prince.md).
- [x] fix export file style 이슈 해결. `Customize Css` command 변경.
- [x] 이슈 해결[#313](https://github.com/shd101wyy/markdown-preview-enhanced/issues/313).

## 0.10.8

- [x] `pandoc parser`지원 추가 [#315](https://github.com/shd101wyy/markdown-preview-enhanced/issues/315).
- [x] `ebook` export theme 이슈 해결.

## 0.10.7

- [x] `pdfUseGithub`옵션 저장.
- [x] `mpe-github-syntax` Github.com style를 위해 추가.

## 0.10.6

- [x] zen mode style 문제 해결.
- [x] 테마 미리보기 이슈해결

## 0.10.4 & 0.10.5

- [x] 테마 버그 해결
- [x] 공식 `markdown preview` 패키지와 동일한 loading gif 추가.

## 0.10.3

- [x] 테마 버그 수정
- [x] `useGitHubStyle`와`useGitHubSyntaxTheme` 삭제.

## 0.10.2

- [x] 사용하지 않을 때 사용자가 테마를 선택할 수 있도록 허용`Github.com style theme`. [#297](https://github.com/shd101wyy/markdown-preview-enhanced/issues/297#issuecomment-283619527)
- [ ] 이슈 [#298](https://github.com/shd101wyy/markdown-preview-enhanced/issues/298). 하지만 지원되기 어려움.
- [ ] blog(jekyll, hexo, etc...)지원 추가. 하지만 한 번도 사용해본 적이 없어서 어떻게 사용하는지 시간이 좀 걸릴 것 같다.
- [ ] github wiki로 문서 이동.
- [x] `unsafe eval`이슈 해결[#303](https://github.com/shd101wyy/markdown-preview-enhanced/issues/303). 이게 급하므로 위의 3가지는 나중에 완료예정.

## 0.10.1

- [x] `Save as Markdown` code chunk `continue issue`
- [x] <code>\`\`\`math</code>추가 [#295](https://github.com/shd101wyy/markdown-preview-enhanced/issues/295)
- [x] 파일 import를 위한`vhdl` 와 `vhd` 추가 [#294](https://github.com/shd101wyy/markdown-preview-enhanced/issues/294)
- [ ] ~~python3 matplotlib 이슈 해결.~~

## 0.9.12

- [x] 이슈 해결 [#255](https://github.com/shd101wyy/markdown-preview-enhanced/issues/255) deprecated call.
- [x] protocol을 위한 whitelist추가 [#288](https://github.com/shd101wyy/markdown-preview-enhanced/issues/288).
- [x] 문서 업데이트
- [x] `rootDirectoryPath`를 `fileDirectoryPath`로 변수명 변경.

## 0.9.10

- [x] 그래프를 위한 표준 코드 펜싱을 지원[#286](https://github.com/shd101wyy/markdown-preview-enhanced/issues/286).

## 0.9.9

- [x] code chunk 향상. `matplotlib`를 잘 지원. [#280](https://github.com/shd101wyy/markdown-preview-enhanced/issues/280).

```sh
matplotlib: true      # enable inline matplotlib plot.
continue: true | id   # continue last code chunk or code chunk with id.
element: "<canvas id=\"hi\"></canvas>" # element to append.
```

- [x] `Markdown Preview Enhanced: Toggle Live Update` 추가. 그리고 라이브 업데이트를 사용하지 않을 때 스크롤 동기화가 향상.
- [x] `FAQ` 섹션 추가.
- [x] `mathJaxProcessEnvironments`옵션 추가. MathJax를 위해 `processEnvironments`를 허용함.
- [ ] phantomjs를 위한 cnpm url 추가.

## 0.9.8

- [x] 이슈 해결[#273](https://github.com/shd101wyy/markdown-preview-enhanced/issues/273). Pull Request 해준`@cuyl` 감사합니다.
- [x] Code Chunk를 위한 `markdown`결과 추가.

## 0.9.7

- [x] html 내보내기를 위한 상대 이미지 경로 추가 옵션. 이슈 해결 [#264](https://github.com/shd101wyy/markdown-preview-enhanced/issues/264).
- [x] Zen Mode 수정.

## 0.9.6

- [x] 외부 파일 import 지원. [introduction doc](./docs/doc-imports.md)

```javascript
import "test.csv"
import "test.jpg"
import "test.txt"
import "test.md"
import "test.html"
import "test.js"
...
```

- [x] `csv` 파일 import parse를 위해 [PapaParse](https://github.com/mholt/PapaParse)사용
- [x] Syntax 테마 이슈 해결.
- [x] WaveDrom은 이제 엄격한 JSON을 사용할 필요가 없다. javascript 코드도 괜찮다.
- [x] Toggle 이슈 해결.
- [x] 출력 html 파일 크기를 줄입니다.
- [ ] Zen mode 고장...

## 0.9.5

- [x] `mermaid`를 `7.0.0`로 업그레이드, 하지만 class diagram은 아직 동작하지 않는다.
- [x] `reveal.js`를 `1.4.1`로 업그레이드.
- [x] `katex`를 `0.7.1`로 업그레이드, cdn.js 이슈 해결
- [x] `plantuml`를 `8054`버전으로 업그레이드.
- [x] `viz.js`를 `1.7.0` 버전으로 업그레이드, 버그가 심할수도 있다.
- [x] 부분적 이슈 해결[#248](https://github.com/shd101wyy/markdown-preview-enhanced/issues/248). 하지만 anchor로 이동할 수 없다.
- [x] Zen mode를 위한 더 나은 지원이 이루어진다.

## 0.9.4

- [x] git-hub syntax color 이슈 해결 [#243](https://github.com/shd101wyy/markdown-preview-enhanced/issues/243)
- [x] 수직 슬라이드 문제 해결 [#241](https://github.com/shd101wyy/markdown-preview-enhanced/issues/241)

## 0.9.3

- [x] 이슈 해결, 중국어，일본어 이미지 파일 경로 에러. [#236](https://github.com/shd101wyy/markdown-preview-enhanced/issues/236)
- [x] 이슈 해결 [#237](https://github.com/shd101wyy/markdown-preview-enhanced/issues/237)
- [x] CACHE를 복원한 후 firx to top 버튼과 Code Chunk가 `onclick`이벤트를 실행한다.
- [x] markdown을 `front_matter`형식으로 저장.

## 0.9.2

- [x] 이슈 해결 [#223](https://github.com/shd101wyy/markdown-preview-enhanced/issues/223)

## 0.9.1

- [x] 이슈 해결 [#234](https://github.com/shd101wyy/markdown-preview-enhanced/issues/234)

## 0.9.0

- [x] TOC의 soft tabs(탭 여백) [#187](https://github.com/shd101wyy/markdown-preview-enhanced/issues/187)
- [x] 성능 향상을 위한 캐시 지원 추가[#210](https://github.com/shd101wyy/markdown-preview-enhanced/issues/210)
- [x] 발표자 참고 사항(presentation.js) 문제에 대한 지원 추가 [#199](https://github.com/shd101wyy/markdown-preview-enhanced/issues/199)
- [x] 미리보기의 맨 위 단추에 다시 추가 [#222](https://github.com/shd101wyy/markdown-preview-enhanced/issues/222)
- [x] 다수 TOCs 지원 [#130](https://github.com/shd101wyy/markdown-preview-enhanced/issues/130)
- [x] viz.js 엔진 구성
- [x] Markdown으로 저장
- [x] 다수의 dependencies를 `KaTeX`, `saveSvgAsPng`, 등으로 업데이트.

## 0.8.9

- [x] `<kbr>` 스타일이 브라우저에서 일치하지 않습니다.
- [x] 이슈 해결 [#177](https://github.com/shd101wyy/markdown-preview-enhanced/issues/177)
- [x] Code Chunk에 `stdin` 옵션을 추가
- [x] `run` 버튼과 `all` 버튼을 복원하되, 호버할 때만 표시.

## 0.8.8

- [x] ISSUE: 제목을 변경할 때도 MathJax가 업데이트.
- [x] 모든 dependencies를 업데이트.
  - `mermaid`가 아직 `6.0.0`버전으로 보이며 Class diagram이 예상대로 작동하지 않음
- [x] 버그 해결[#168](https://github.com/shd101wyy/markdown-preview-enhanced/issues/168).
- [x] `MathJax` `processEnvironments`불가 [#167](https://github.com/shd101wyy/markdown-preview-enhanced/issues/167).
- [x] 이슈 해결 [#160](https://github.com/shd101wyy/markdown-preview-enhanced/issues/160)
- [x] 이슈 해결 [#150](https://github.com/shd101wyy/markdown-preview-enhanced/issues/150)
- [x] `TOC` 확장. [#171](https://github.com/shd101wyy/markdown-preview-enhanced/issues/171)
- [x] Code Chunk를 위한`run` and `all` 버튼 제거. 또한 다음 파일 업데이트 [code-chunk.md](/docs/code-chunk.md)

## 0.8.7 `minor update`

- [ ] <strike>필요한 경우 캐시된 이미지 다시 로드. (eg: replace `#cached=false` with `#cached=uid`)</strike>[**잘 작동하지 않는다. 이미지가 잘 작동하지 않는다.**]
- [x] MathJax 버그 해결 [#147](https://github.com/shd101wyy/markdown-preview-enhanced/issues/147)
- [ ] mermaid class diagram [#143](https://github.com/shd101wyy/markdown-preview-enhanced/issues/143) [**mermaid bug로 보인다**]
- [ ] pandoc과 ebook 그래프 포함 [**다음 주요 릴리스에서 구현**]
- [x] 더 나은 pandoc error 알림

## 0.8.6

- [x] ebook export 예외 [#136](https://github.com/shd101wyy/markdown-preview-enhanced/issues/136)
- [x] TOC 제목 레벨 버그 [#134](https://github.com/shd101wyy/markdown-preview-enhanced/issues/134)
- [ ] 표 표기법 확장 [#133](https://github.com/shd101wyy/markdown-preview-enhanced/issues/133)
- [x] ERD [#128](https://github.com/shd101wyy/markdown-preview-enhanced/issues/128) [**미래에 제거될 예정**]
- [ ] <strike>gitbook과 같은 전자책 용어집</strike>. [**실행 안됨**]
- [x] graph APIs 변경.
- [ ] parseMD 함수를 콜백과 함께 비동기 함수로 변경
- [ ] pandoc 그래프 포함 [**may be implemented in next version**]
- [x] code block에 대한 스크롤 동기화 버그 해결
- [x] Code Chunk 지원
- [x] `Markdown Preview Enhanced: Toc Create`을 `Markdown Preview Enhanced: Create Toc`로 변경
- [x] 각 ediort의 `codeChunksData` 상태를 저장

## 0.8.5

- [ ] `yaml_table` 지원 [**실행 안됨**]
- [ ] `erd` 지원 [#128](https://github.com/shd101wyy/markdown-preview-enhanced/issues/128) [**실행 안됨**]
- [x] 커서가 마지막 두 줄에 있을 때 맨 아래로 스크롤 미리 보기 클릭 (지금은 마지막줄에 해당)
- [x] ebook 네트워크 이미지 에러 해결 [#129](https://github.com/shd101wyy/markdown-preview-enhanced/issues/129#issuecomment-245778986)
- [x] `ebook-convert` args 옵션 지원
- [x] `ebook` 향상
- [x] `loading preview` 막힘 버그 해결
- [ ] `Markdown Preview Enhanced: Config Header and Footer` 삭제, `front-matter` 사용. [**다음 release에 실행될 예정**]

## 0.8.4

- [ ] 이슈 해결 [#107](https://github.com/shd101wyy/markdown-preview-enhanced/issues/107)
- [ ] TOC 사이드 바 추가 [#117](https://github.com/shd101wyy/markdown-preview-enhanced/issues/117)
- [x] 이슈 해결 [#121](https://github.com/shd101wyy/markdown-preview-enhanced/issues/121) location save
- [x] add default document export path [#120](https://github.com/shd101wyy/markdown-preview-enhanced/issues/120)
- [x] 이슈 해결 [#118](https://github.com/shd101wyy/markdown-preview-enhanced/issues/118) add hint for image paste
- [x] **pandoc** 지원
- [x] add vertical slides for presentation [#123](https://github.com/shd101wyy/markdown-preview-enhanced/issues/123)
- [x] `Markdown Preview Enhanced: Config Presentation`제거, 대신 front-matter 사용

## 0.8.3

- [x] `hide` frontmatter에 옵션 추가.
- [x] `UIUC` license로 변경
- [x] 최신 `electron`과 일치하도록 APIs 업그레이드
- [ ] lagging 이슈 해결
- [ ] header/footer for presentation
- [x] 부드러운 스크롤 동기화

## 0.8.2

- [x] 이슈 해결 [#106](https://github.com/shd101wyy/markdown-preview-enhanced/issues/106)
- [x] add file extensions support [#102](https://github.com/shd101wyy/markdown-preview-enhanced/issues/104)
- [x] 이슈 해결 [#107](https://github.com/shd101wyy/markdown-preview-enhanced/issues/107), 이제 Phantomjs 내보내기에 MathJax를 사용가능.
- [x] zoomFactor 추가 [#93](https://github.com/shd101wyy/markdown-preview-enhanced/issues/93)
- [ ] github처럼 이미지를 drop하여 업로드.

알아야될 이슈:

- `"` mathJax는 탈출 되지않음. `getAttribute('data-original')`

## 0.8.1

- [x] **parseMD** 함수 refactor. (현재 너무 지저분함)
- [x] KaTeX 렌더링의 경우 MathJax와 같은 렌더링 결과를 저장
- [ ] 왼쪽에서 갈라짐 (`atom.workspace.open`처럼 보이며 내가 예상한대로 동작하지 않음)
- [x] typographer [#94](https://github.com/shd101wyy/markdown-preview-enhanced/issues/94)
- [ ] 저장시 markdown format 유지
- [x] `mermaid.css` 수정 [#95](https://github.com/shd101wyy/markdown-preview-enhanced/issues/95)
- [x] 수정 [#97](https://github.com/shd101wyy/markdown-preview-enhanced/issues/97)
- [ ] 수정 [#93](https://github.com/shd101wyy/markdown-preview-enhanced/issues/93) phantomjs를 사용하여 png/png를 내보낼 때 이미지 해상도 지정
- [x] front matter 지원 [#100](https://github.com/shd101wyy/markdown-preview-enhanced/issues/100)
- [ ] Hooks 지원 [#101](https://github.com/shd101wyy/markdown-preview-enhanced/issues/101)
- [ ] **found [issue](https://github.com/marcbachmann/node-html-pdf/issues/156)**, 나중에 내가 직접 phantomjs html2pdf를 구현할 수도...

## 0.8.0

- [ ] 이슈 해결 [#85](https://github.com/shd101wyy/markdown-preview-enhanced/issues/85)
- [x] pull request merge 진행 [#86](https://github.com/shd101wyy/markdown-preview-enhanced/pull/86)
- [ ] presentation pdf link가 동작하지 않음
- [x] epub generation. 유용한 링크 [manual](https://pandoc.org/MANUAL.html) 와 [epub](https://pandoc.org/epub.html)

## 0.7.9

- [x] viz.js dot 언어
- [x] css 커스텀마이징 노출
- [x] 사용자 정의 주석 제목 확인
- [x] shield.io
- [ ] table formatter

## 0.7.7

- [ ] [laverna](https://github.com/Laverna/laverna) 이나 zen 처럼 free writing 모드 분산. [useful link](https://discuss.atom.io/t/set-atom-cursor-to-font-size-not-line-height/11965/5).
- [x] [marp](https://github.com/yhatt/marp)처럼 presentation 모드.
- [x] **html** 와 **pdf**옆에 **phantomjs** 옵션 추가.
- [x] 해결 [issue](https://github.com/shd101wyy/markdown-preview-enhanced/issues/79)

## 0.7.3

- [ ] pdf deadlock issue print수정 (가능하다면...) (_Update_:**electron** 와 연관되어 있어보임, 그러므로 수정 불가.)
- [ ] 이미지 프린트 [capturePage function](https://github.com/electron/electron/blob/master/docs/api/web-contents.md)
- [x] 미리보기에서 마우스 오른쪽 버튼을 클릭하면 상황에 맞는 메뉴에 '인쇄' 옵션이 표시 (**실행하지 않도록 결정**)
- [x] PlantUML 새로운 버전으로 업데이트
- [x] Toggle 버그 해결
- [x] mermaid 커스텀마이징된 init 함수 지원 [see this issue](https://github.com/shd101wyy/markdown-preview-enhanced/issues/9#issuecomment-229552470)
- [ ] [this](https://github.com/shd101wyy/markdown-preview-enhanced/issues/9#issuecomment-231215294) 너무 어려움.
- [x] atom을 통해 다른 파일들을 다음 링크를 통해 염 [see this issue](https://github.com/shd101wyy/markdown-preview-enhanced/issues/72)
- [ ] 사용자가 로컬 Puml jar를 사용하거나 인터넷을 통해 선택할 수 있다. [encode](https://github.com/markushedvall/plantuml-encoder) (자바 필요 없음)(**실행하지 않기로 결정**)
- [x] remove mermaidStyle at markdown-preview-enhanced-view.coffee. (as it is already included in markdown-preview-enhanced.less)
- [x] [WaveDrom](https://github.com/shd101wyy/markdown-preview-enhanced/issues/73) support?
- [x] 미리보기창 텍스트 복사
- [ ] mermaid style:3개의 .css 파일 선택.

## 0.7.2

- [x] 미리 보기 검정색 배경 문제

## 0.7.1

- [x] 사용자 정의 가능한 산술 구분 기호 지원
- [x] MathJax 렌더링 속도 향상
- [x] code block `//` comment 색깔 버그 해결 (现在是黑色的。。。)
- [x] WikiLink 수정 [#45](https://github.com/shd101wyy/markdown-preview-enhanced/issues/45)
- [x] TOC 헤더 버그 해결 [#48](https://github.com/shd101wyy/markdown-preview-enhanced/issues/48)
- [ ] `javascript` 지원 추가 [#47](https://github.com/shd101wyy/markdown-preview-enhanced/issues/47) (可能无法完成)
- [x] 이미지 경로 config [here](https://github.com/shd101wyy/markdown-preview-enhanced/issues/30#issuecomment-224273160)
- [x] 이미지 프로젝트 경로 버그 해결 [here](https://github.com/shd101wyy/markdown-preview-enhanced/issues/34#issuecomment-224303126)

## 0.6.9

- [x] TOC 번호 목록

## 0.3.8

- 커스텀마이징된 markdown down 스타일을 좀 더 나은 방법으로 지원합니다.
- 스타일을 변경합니다.
- markdown parsing 효율성 향상 ( <strong>onDidStopChanging</strong>를 <strong>onDidChange</strong>대신에 사용).
- <strong>TODO</strong>: 향후 스크롤 동기화 지원.

## 0.3.7

- pdf 및 html을 내보낼 때 이미지 경로 버그를 수정.

## 0.3.6

- \_underscore\_ 로 인해 발생되던 연산식 parsing 버스 수정.

## 0.3.5

- \\newpage 지원 추가.

## 0.3.3

- 'Open in Browser' 옵션 추가.
- \$ 버그 수정.

## 0.1.0 - Initial Release

- 모든 기능 추가
- 모든 버그 수정
