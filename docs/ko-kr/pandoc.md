# Pandoc

**Markdown Preview Enhanced**는 `RStudio Markdown`과 유사하게 작동하는 `pandoc document export` 기능을 지원한다.  
이 기능을 사용하려면 [pandoc](https://pandoc.org/) 이 설치되어 있어야 한다.  
pandoc 설치 지침은 [여기](https://pandoc.org/installing.html) 에서 확인할 수 있다.  
`pandoc document export`는 미리보기에서 마우스 우클릭을 했을 때 나타나는 메뉴에서 확인할 수 있다.

---

## Pandoc Parser

기본적으로 **Markdown Preview Enhanced**는 [markdown-it](https://github.com/markdown-it/markdown-it) 을 사용해 markdown을 파싱한다.  
패키지 설정에서 `pandoc` parser로 설정할 수도 있다.

![Screen Shot 2017-03-07 at 10.05.25 PM](https://i.imgur.com/NdCJBgR.png)

또한, front-matter를 작성하여 개별 파일에 대한 pandoc 전달인자를 설정할 수 있다.

```markdown
---
pandoc_args: ["--toc", "--toc-depth=2"]
---
```

참고: Front-matter에 `references`나 `bibliography`가 있다면 `--filter=pandoc-citeproc`가 자동으로 추가된다.

**주의**: 위 기능은 아직 실험 단계이므로 자유롭게 issue나 제안을 올려주세요.  
**알려진 문제점 및 제한**:

1. `ebook` 내보내기 문제.
2. `Code Chunk`에 간헐적인 버그.

## Front-Matter

`pandoc 문서로 내보내기`는 `front-matter`작성이 필수적이다.  
`Front-matter`를 작성하는 방법에 대한 자세한 튜토리얼은 [여기](https://jekyllrb.com/docs/frontmatter/) 에서 확인할 수 있다.

## 내보내기

앞서 언급한 `Pandoc Parser`를 사용하여 파일을 내보낼 필요는 없다.

현재 지원되는 형식은 다음과 같다. **향후 더 많은 형식이 지원된다.**  
(몇 가지 예는 [RStudio Markdown](https://rmarkdown.rstudio.com/formats.html) 를 참고하였다.)  
특정 내보내기 문서 형식은 아래 링크에서 확인할 수 있다.

- [PDF](ko-kr/pandoc-pdf.md)
- [Word](ko-kr/pandoc-word.md)
- [RTF](ko-kr/pandoc-rtf.md)
- [Beamer](ko-kr/pandoc-beamer.md)

사용자 정의 문서를 직접 정의하는 방법:

- [custom](ko-kr/pandoc-custom.md)

## 저장 시 내보내기

아래와 같이 프론트 구성을 추가:

```yaml
---
export_on_save:
  pandoc: true
---

```

이후부터는 markdown 소스 파일을 저장할 때마다 pandoc이 실행된다.

## 글

- [참고 문헌 및 인용문](pandoc-bibliographies-and-citations.md)

## 주의

`mermaid, wavedrom`은 `pandoc 문서로 내보내기`가 적용되지 않는다.  
[code chunk](ko-kr/code-chunk.md)는 `pandoc 문서로 내보내기`와 부분적으로 호환된다.
