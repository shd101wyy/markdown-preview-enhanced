# HTML 내보내기

## 사용 방법

미리보기에서 마우스 우클릭하면 나오는 메뉴에서 `HTML` 탭을 클릭한다.  
이후 아래 중 하나를 선택한다.

- `HTML (offline)`
  html 파일을 로컬에서만 사용하려면 해당 옵션 선택.
- `HTML (cdn hosted)`
  html 파일을 원격으로 배포하려면 해당 옵션 선택.

![screen shot 2017-07-14 at 1 14 28 am](https://user-images.githubusercontent.com/1908863/28200455-d5a12d60-6831-11e7-8572-91d3845ce8cf.png)

## 환경 설정

기본값:

```yaml
---
html:
  embed_local_images: false
  embed_svg: true
  offline: false
  toc: undefined

print_background: false
---

```

`embed_local_images`를 `true`로 설정하면, 모든 로컬 이미지가 `base64` 형식으로 적용된다.

사이드바 TOC를 생성하려면 vscode 또는 atom의 MPE 설정에서 [enableScriptExecution](https://shd101wyy.github.io/markdown-preview-enhanced/#/code-chunk?id=code-chunk) 을 설정해야 한다.

`toc`를 `false`로 설정하면 사이드바 TOC가 비활성화된다.  
`toc`를 `true`로 설정하면 사이드바 TOC가 활성화되어 나타난다.  
`toc`를 불분명하게 설정하면 사이드바 TOC가 활성화되지만 나타나지는 않는다.

## 저장 시 내보내기

Front-matter에 아래와 같은 코드를 추가한다.

```yaml
---
export_on_save:
  html: true
---

```

이후부터는 markdown 파일을 저장할 때마다 html파일이 생성된다.