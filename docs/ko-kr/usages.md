# 사용법

## 명령어

Atom 편집기에서 <kbd>cmd-shift-p</kbd>를 눌러 <strong> Command Palette </strong>로 전환할 수 있다.

> _Windows_ 에서 <kbd>cmd</kbd> 키는 <kbd>ctrl</kbd>이다.

_Markdown 소스_

- <strong>Markdown Preview Enhanced: Toggle</strong>  
  <kbd>ctrl-shift-m</kbd>  
  Markdown 파일 미리보기 전환.  

- <strong>Markdown Preview Enhanced: Toggle Zen Mode </strong>  
  자유로운 글쓰기 모드 전환.

- <strong>Markdown Preview Enhanced: Customize Css</strong>  
  미리보기 페이지 css 커스터마이징.  
  간단한 튜토리얼은 [여기](customize-css.md) 에서 확인할 수 있다.

- <strong>Markdown Preview Enhanced: Create Toc </strong>  
  TOC 생성 (미리보기 토글 필요). [문서는 여기](toc.md).

- <strong>Markdown Preview Enhanced: Toggle Scroll Sync </strong>  
  미리 보기를 위해 스크롤 동기화 활성화/비활성화.

- <strong>Markdown Preview Enhanced: Sync Source </strong>  
  <kbd>ctrl-shift-s</kbd>  
  미리보기 스크롤 시 markdown 소스의 커서 위치와 일치시키기.

- <strong>Markdown Preview Enhanced: Toggle Live Update </strong>  
   미리 보기용 라이브 업데이트를 활성화/비활성화.  
   비활성화된 경우, 파일이 저장될 때만 미리보기가 렌더링된다.

- <strong>Markdown Preview Enhanced: Toggle Break On Single Newline </strong>  
  단일 줄 바꿈 활성화/비활성화.

- <strong>Markdown Preview Enhanced: Insert New Slide </strong>  
  새 슬라이드를 삽입한 후, [프레젠테이션 모드](presentation.md) 로 들어가기.

- <strong>Markdown Preview Enhanced: Insert Table </strong>  
  Markdown 표 삽입.

- <strong>Markdown Preview Enhanced: Insert Page Break </strong>  
  페이지 구분 삽입.

- <strong> Markdown Preview Enhanced: Open Mermaid Config</strong><br>
  `mermaid` 초기 구성 편집.

- <strong> Markdown Preview Enhanced: Open Mathjax Config </strong><br>
  `MathJax` 초기 구성 편집.

- <strong>Markdown Preview Enhanced: Image Helper</strong>  
  자세한 내용은 [이 문서](image-helper.md)를 참조.  
   Image Helper는 [imgur](https://imgur.com/) 또는 [sm.ms](https://sm.ms/) 에서 제공되는 이미지 URL 빠른 삽입, 이미지 붙여넣기 및 이미지 업로드를 지원한다.
  ![screen shot 2017-06-06 at 3 42 31 pm](https://user-images.githubusercontent.com/1908863/26850896-c43be8e2-4ace-11e7-802d-6a7b51bf3130.png)

- <strong>Markdown Preview Enhanced: Show Uploaded Images</strong>  
  업로드된 이미지들을 저장하는 `image_history.md`를 연다.  
  `image_history.md` 파일은 자유롭게 수정 가능하다.

- <strong>Markdown Preview Enhanced: Run Code Chunk </strong>  
  <kbd>shift-enter</kbd>  
  하나의 [Code Chunk](code-chunk.md) 실행.

- <strong>Markdown Preview Enhanced: Run All Code Chunks </strong>  
  <kbd>ctrl-shift-enter</kbd>  
  모든 [Code Chunks](code-chunk.md) 실행.

- <strong>Markdown Preview Enhanced: Extend Parser</strong>  
  [Extend Markdown Parser](extend-parser.md).

---

_미리보기_

미리보기에서 **우클릭**을 통해 상황에 맞는 메뉴 열기:

![screen shot 2017-07-14 at 12 30 54 am](https://user-images.githubusercontent.com/1908863/28199502-b9ba39c6-682b-11e7-8bb9-89661100389e.png)

- <kbd>cmd-=</kbd> or <kbd>cmd-shift-=</kbd>.  
  미리보기 확대.

- <kbd>cmd--</kbd> or <kbd>cmd-shift-\_</kbd>.  
  미리보기 축소.

- <kbd>cmd-0</kbd>  
  미리보기 확대/축소 초기화.

- <kbd>cmd-shift-s</kbd>  
  미리보기 위치와 일치하도록 markdown 편집기 스크롤.

- <kbd>esc</kbd>  
  사이드바 TOC 전환.

## 키보드 단축키

| 단축키                                      | Functionality                      |
| ------------------------------------------- | ---------------------------------  |
| <kbd>ctrl-shift-m</kbd>                     | 미리보기 전환                      |
| <kbd>cmd-k v</kbd>                          | `VSCode Only` 모드로 미리보기 열기 |
| <kbd>ctrl-shift-s</kbd>                     | 미리보기 동기화 / 원본 동기화       |
| <kbd>shift-enter</kbd>                      | Code Chunk 실행                   |
| <kbd>ctrl-shift-enter</kbd>                 | 모든 Code Chunks 실행              |
| <kbd>cmd-=</kbd> or <kbd>cmd-shift-=</kbd>  | 미리보기 확대                      |
| <kbd>cmd--</kbd> or <kbd>cmd-shift-\_</kbd> | 미리보기 축소                      |
| <kbd>cmd-0</kbd>                            | 미리보기 확대/축소/초기화           |
| <kbd>esc</kbd>                              | 사이드바 TOC 전환                  |

## 패키지 설정

### Atom

패키지 설정을 열려면 <kbd>cmd-shift-p</kbd>를 누른 후, `Settings View: Open`를 선택해 `Packages`를 클릭한다.

`Installed Packages`에서  `markdown-preview-enhanced` 검색.  
![screen shot 2017-06-06 at 3 57 22 pm](https://user-images.githubusercontent.com/1908863/26851561-d6b1ca30-4ad0-11e7-96fd-6e436b5de45b.png)

`Settings` 버튼 클릭:

![screen shot 2017-07-14 at 12 35 13 am](https://user-images.githubusercontent.com/1908863/28199574-50595dbc-682c-11e7-9d94-264e46387da8.png)

### VS Code

`Preferences: Open User Settings` 명령을 실행해 `markdown-preview-enhanced` 검색.  
![screen shot 2017-07-14 at 12 34 04 am](https://user-images.githubusercontent.com/1908863/28199551-2719acb8-682c-11e7-8163-e064ad8fe41c.png)
