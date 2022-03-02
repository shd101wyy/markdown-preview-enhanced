# 프레젠테이션 작성

![screen shot 2017-07-14 at 12 33 14 pm](https://user-images.githubusercontent.com/1908863/28223480-2c61461c-6891-11e7-9389-5adec0588c32.png)

Markdown Preview Enhanced는 [reveal.js](https://github.com/hakimel/reveal.js) 를 사용해 프레젠테이션을 아름답게 렌더링한다.

소개를 보려면 [여기를 클릭](https://rawgit.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.html)  (**권장**).

![프레젠테이션](https://user-images.githubusercontent.com/1908863/28202176-caf103c4-6839-11e7-8776-942679f3698b.gif)

## 프레젠테이션 Front-Matter

Markdown 파일에 front-matter를 추가해 프레젠테이션을 구성할 수 있다.   
`presentation` 섹션 아래에 다음과 같이 설정 내용을 적어야 한다.  
예:

```markdown
---
presentation:
  width: 800
  height: 600
---

<!-- slide -->

슬라이드가 여기로 이동한다...
```

해당 프레젠테이션의 크기는 `800x600`이 된다.

### 설정

```yaml
---
presentation:
  # 프레젠테이션 테마
  # === 사용가능한 테마 ===
  # "beige.css"
  # "black.css"
  # "blood.css"
  # "league.css"
  # "moon.css"
  # "night.css"
  # "serif.css"
  # "simple.css"
  # "sky.css"
  # "solarized.css"
  # "white.css"
  # "none.css"
  theme: white.css

  # 프레젠테이션의 "일반" 크기, 가로 세로 비율이 유지된다.
  # 다른 해상도에 맞게 프레젠테이션의 크기를 조정할 수 있다.
  # 백분율 단위를 사용해 지정할 수 있다.
  width: 960
  height: 700

  # display 크기를 결정하는 요소로 내용 주위에 얼마나 비어 있어야 크기 
  margin: 0.1

  # 콘텐츠에 적용할 수 있는 최소/최대 scale의 한계
  minScale: 0.2
  maxScale: 1.5

  # 오른쪽 하단 모서리에 controls 표시
  controls: true

  # 프레젠테이션 진행률 표시줄 표시
  progress: true

  # 현재 슬라이드의 페이지 번호 표시
  slideNumber: false

  # 각 슬라이드 변경 사항을 브라우저 히스토리에 기록
  history: false

  # 네비게이션을 위해 바로가기 키 사용
  keyboard: true

  # 슬라이드 개요 모드 활성화
  overview: true

  # 슬라이드의 수직 중심화
  center: true

  # 터치 입력이 있는 장치에서 터치 네비게이션 활성화
  touch: true

  # 프레젠테이션 반복
  loop: false

  # 프레젠테이션 방향을 RTL로 변경
  rtl: false

  # 프레젠테이션이 로드될 때마다 슬라이드 순서를 임의로 지정
  shuffle: false

  # fragment를 전체적으로 켜거나 끄기
  fragments: true

  # 프레젠테이션이 내장 모드에서 실행 중인 경우 플래그를 지정,
  # 예) 화면의 제한된 부분에 포함됨
  embedded: false

  # 물음표 키를 눌렀을 때 도움말 오버레이를 표시해야 하는지 플래그 지정
  help: true

  # 모든 뷰어가 스피커 노트를 볼 수 있어야 하는지 플래그 지정
  showNotes: false

  # 자동으로 다음 슬라이드로 진행하는 간격(밀리초)
  # 0으로 설정하면 사용 안 함
  # 이 값은 슬라이드의 data-autoslide 속성을 사용하여 덮어쓰기 가능
  autoSlide: 0

  # 사용자 입력 후 자동 슬라이딩 중지
  autoSlideStoppable: true

  # 마우스 휠을 통한 슬라이드 탐색 활성화
  mouseWheel: false

  # 모바일 장치에서 주소 표시줄을 숨기기
  hideAddressBar: true

  # iframe 미리보기 오버레이에서 링크 열기
  previewLinks: false

  # 전환 스타일
  transition: 'default' # none/fade/slide/convex/concave/zoom

  # 전환 속도
  transitionSpeed: 'default' # default/fast/slow

  # 전체 슬라이드 배경에 대한 전환 스타일
  backgroundTransition: 'default' # none/fade/slide/convex/concave/zoom

  # 현재 슬라이드에서 표시하는 슬라이드 수
  viewDistance: 3

  # 시차 배경 이미지
  parallaxBackgroundImage: '' # 예: "'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg'"

  # 시차 배경 크기
  parallaxBackgroundSize: '' # CSS 문법, 예: "2100px 900px"

  # 슬라이드의 시차 배경을 움직일 픽셀 수
  # - 지정되지 않은 경우 자동으로 계산됨
  # - 축을 따라 이동을 비활성화 하려면 0으로 설정
  parallaxBackgroundHorizontal: null
  parallaxBackgroundVertical: null

  # 시차 배경 이미지
  parallaxBackgroundImage: '' # 예: "https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg"

  # 시차 배경 크기
  parallaxBackgroundSize: '' # CSS 문법, 예: "2100px 900px" - 아직까지는 픽셀만 지원. (% 또는 auto를 사용 불가능)

  # 슬라이드의 시차 배경을 움직일 픽셀 수
  # - 지정되지 않은 경우 자동으로 계산됨
  # - 축을 따라 이동을 비활성화 하려면 0으로 설정
  parallaxBackgroundHorizontal: 200
  parallaxBackgroundVertical: 50

  # 스피커 노트 활성화
  enableSpeakerNotes: false
---
```

## 사용자 지정 슬라이드 스타일

특정 슬라이드에 `id` 및 `class`를 추가하려면 아래와 같이 추가하면 된다.

```markdown
<!-- slide id="my-id" class="my-class1 my-class2" -->
```

또는 `n번째` 슬라이드만 사용자 지정하려면 다음과 같이 `less` 파일을 수정한다.

```less
.markdown-preview.markdown-preview {
  // 사용자 정의 프레젠테이션 스타일 
  .reveal .slides {
    // 모든 슬라이드 수정
  }

  .slides > section:nth-child(1) {
    // '첫 번째 슬라이드'만 수정
  }
}
```

[➔ Pandoc](ko-kr/pandoc.md)
