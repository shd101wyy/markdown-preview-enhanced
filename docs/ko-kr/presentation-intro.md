---
presentation:
  enableSpeakerNotes: true
---

<!-- slide -->

# 프레젠테이션 작성자

by **Markdown Preview Enhanced**
powered by [reveal.js](https://github.com/hakimel/reveal.js)
<br>

<p style="font-size: 18px;">키보드 도움말을 보려면 <kbd>?</kbd> 키를 누른다.</p>
<p style="font-size: 18px;">노트 창을 열려면 <kbd>s</kbd> 키를 누른다.</p>
<p style="font-size: 18px;"><kbd>화살표</kbd> 키를 눌러 탐색한다.</p>
<p style="font-size: 18px;">개요를 전환하려면 <kbd>esc</kbd> 키를 누른다.</p>

<!-- slide -->

프레젠테이션을 아름답게 만들려면 간단하게 아래 명령을 실행하거나

`Markdown Preview Enhanced: Insert New Slide`

markdown 파일에 `<!-- slide -->`를 삽입한다.

<!-- slide -->

여러 프레젠테이션 테마가 지원되므로 확장 설정에서 쉽게 변경할 수 있다.

- vscode  
  @import "https://i.loli.net/2017/07/12/5965b5c7783fb.png" {width: 60%}
- atom  
  @import "https://i.imgur.com/lwaogVZ.png" {width: 60%}

<!-- slide -->

**Markdown Preview Enhanced**의 모든 기능이 지원된다.

$$
f(x) = \int_{-\infty}^\infty
    \hat f(\xi)\,e^{2 \pi i \xi x}
    \,d\xi
$$

<!-- slide -->

프레젠테이션의 초기화 구성을 설정할 수 있다.
프레젠테이션 markdown 파일에 front-matter를 추가하기만 하면 된다.

```yaml
---
presentation:
  width: 800
  height: 600
  controls: false
---

```

Front-matter 설정에 대한 자세한 내용은 [여기](https://shd101wyy.github.io/markdown-preview-enhanced/#/presentation) 에서 확인할 수 있다.

<!-- slide data-notes="This is speaker note"-->

**스피커 노트** 또한 지원된다 (미리보기에서는 지원되지 않음).
키보드에서 <kbd>s</kbd> 키를 눌러 노트 창을 열 수 있다.

<!-- slide -->

스피커 노트를 활성화하려면 front-matter를 다음과 같이 설정:

```yaml
---
presentation:
  enableSpeakerNotes: true
---

```

노트를 추가하려면 `data-notes` 속성을 설정:

```html
<!-- slide data-notes="여기에 메모를 작성" -->
```

자세한 내용은 [Reveal.js 스피커 노트](https://github.com/hakimel/reveal.js#speaker-notes) 섹션을 참조한다.

<!-- slide -->

기본적으로 모든 슬라이드는 수평으로 정렬되지만, `vertical=true`를 추가해 수직 슬라이드를 만들 수  있다.  
예:

```html
<!-- slide vertical=true -->
```

<!-- slide vertical=true -->

이제 수직 슬라이드를 사용할 수 있습니다!

<!-- slide -->

슬라이드에 `id` 와 `class` 를 설정하려면 다음과 같이 사용하면 된다.

```html
<!-- slide id="my-id" class="my-class1 my-class2" -->
```

<!-- slide -->

손쉬운 슬라이드 배경 설정 예시:

```html
<!-- slide data-background-color="#ff0000" -->
```

<!-- slide data-background-color="#ffebcf"-->

슬라이드 **배경**에 관한 더 많은 작업.

- `data-background-image`
  표시할 이미지의 URL이다. 슬라이드가 열리면 GIF가 다시 시작.
- `data-background-size`
  MDN의 [background-size](https://developer.mozilla.org/docs/Web/CSS/background-size) 참조.
- `data-background-position`
  MDN의 [background-position](https://developer.mozilla.org/docs/Web/CSS/background-position) 참조.
- `data-background-repeat`
  MDN의 [background-repeat](https://developer.mozilla.org/docs/Web/CSS/background-repeat) 참조.

<!-- slide -->

**비디오 배경** 및 **iframe 배경** 설정.

- `data-background-video`
  단일 비디오 소스 또는 쉼표로 구분된 비디오 소스 목록.
- `data-background-video-loop`
  비디오 반복 재생을 위한 플래그 지정.
- `data-background-video-muted`
  오디오를 음소거를 위한 플래그 지정.
- `data-background-iframe`
  웹 페이지를 배경으로 설정.

<!-- slide -->

Fragment도 지원된다.

```
- Item 1 <!-- .element: class="fragment" data-fragment-index="2" -->
- Item 2 <!-- .element: class="fragment" data-fragment-index="1" -->
```

- 다양한 fragment 애니메이션을 위해 [여기](https://github.com/hakimel/reveal.js#fragments) 를 참조 <!-- .element: class="fragment" -->
- Item 1 <!-- .element: class="fragment" data-fragment-index="2" -->
- Item 2 <!-- .element: class="fragment" data-fragment-index="1" -->

<!-- slide -->

예를 들어, 아래의 markdown snippet은 다음과 같은 슬라이드를 생성한다.

```html
<!-- slide data-background-image="https://i.loli.net/2017/07/12/5965b7edd3a2a.jpeg" data-transition="zoom" -->
<p style="color: #fff;">国漫大法好！</p>
<p style="color: #fff;">国漫大法好！</p>
<p style="color: #fff;">国漫大法好！</p>
```

<!-- slide data-background-image="https://i.loli.net/2017/07/12/5965b7edd3a2a.jpeg"
data-transition="zoom"
-->
<p style="color: #fff;">国漫大法好！</p>
<p style="color: #fff;">国漫大法好！</p>
<p style="color: #fff;">国漫大法好！</p>

<!-- slide -->

손쉽게 프레젠테이션 css를 커스터마이징하기 위해 `Markdown Preview Enhanced: Customize Css` 명령어를 실행한 후, 다음과 같이 편집한다.

```less
.markdown-preview.markdown-preview {
  .slides {
    // 모든 슬라이드가 수정된다.
  }
  .slides > section:nth-child(1) {
    // `첫 번째 슬라이드`만 수정한다.
    background-color: blue;
  }
}
```

<!-- slide -->

브라우저에서 프레젠테이션을 확인하기 위해서는 미리보기에서 마우스 우클릭을 통해 `Open in Browser`를 선택한다. 

<!-- slide -->

**Markdown Preview Enhanced**는 프레젠테이션에 사용될 **HTML** 또는 **PDF** 파일을 생성할  수도 있다.

<!-- slide -->

#### 해당 프로젝트가 마음에 들었다면 star을 눌러주세요 ;)

- Github Repository는 [여기](https://github.com/shd101wyy/markdown-preview-enhanced) 에서 확인할 수 있다.
- Issues 또는 새로운 기능 요청은 [여기](https://github.com/shd101wyy/markdown-preview-enhanced/issues) 에서 할 수 있다.
- 이 프레젠테이션의 소스 코드는 [여기](https://github.com/shd101wyy/markdown-preview-enhanced/blob/master/docs/presentation-intro.md) [(raw)](https://raw.githubusercontent.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.md) 에서 확인할 수 있다.

<!-- slide data-background-image="https://ooo.0o0.ooo/2016/07/18/578c66da6a5a3.jpg" -->
