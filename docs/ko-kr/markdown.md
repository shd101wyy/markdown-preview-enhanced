# Markdown으로 저장

**Markdown Preview Enhanced**는 내보낸 markdown 파일이 graphs (png 이미지로 변환), code chunks (숨겨서 결과만 포함), math typesettings (이미지로 표시) 등을 모두 포함하여 GitHub에 게시될 수 있도록 **GitHub Flavored Markdown**로 컴파일을 지원한다.

## 사용 방법

미리보기에서 우클릭하여 `Save as Markdown`을 선택한다.

## 환경 설정

이미지 디렉토리와 출력 경로를 front-matter 로 설정할 수 있다.

```yaml
---
markdown:
  image_dir: /assets
  path: output.md
  ignore_from_front_matter: true
  absolute_image_path: false
---

```

**image_dir** `optional`  
생성된 이미지를 저장한 위치를 지정한다. 예를 들어, `/assets` 은 모든 이미지가 프로젝트 디렉토리 하위의 `assets` 디렉토리에 저장된다. 만약 **image_dir** 이 정해지지 않았다면, 패키지 설정의 `Image folder path` 로 저장된다. 기본값은 `/assets`이다.

**path** `optional`  
마크다운 파일의 출력값을 저장할 위치를 지정한다. 만약 **path** 가 정해지지 않았다면, `filename_.md` 에 저장된다.

**ignore_from_front_matter** `optional`  
`false`로 설정하면, `markdown` 필드가 front-matter 에 포함된다.

**absolute_image_path** `optional`  
절대 이미지 경로를 사용할지 상대 이미지 경로를 사용할지 결정한다.

## 저장시 내보내기

아래 코드를 front-matter에 추가한다.

```yaml
---
export_on_save:
  markdown: true
---

```

이후부터는 markdown 파일을 저장할 때마다 markdown 소스 파일이 생성된다.

## 알려진 문제점

- 아직까지는 `WaveDrom`을 사용할 수 없다.
- Math typesettings 표시가 잘못되어 있을 수 있다.
- 아직까지는 `latex` code chunk와 동작하지 않는다.
