# 수식(Math)

**Markdown Preview Enhanced**는 [KaTeX](https://github.com/Khan/KaTeX) 또는  [MathJax](https://github.com/mathjax/MathJax)를 사용하여 수학 표현식을 렌더링한다.

KaTeX는 MathJax보다 빠르지만, MathJax에 비해 가지고 있는 기능 수가 부족하다. 자세한 내용은 [KaTeX 지원 기능/기호](https://khan.github.io/KaTeX/function-support.html) 에서 확인할 수 있다.

기본적으로:

- `$...$` 또는 `\(...\)` 내의 식은 인라인으로 렌더링된다.
- `$$...$$`, `\[...\]`, 또는 <code>```math</code>내의 식은 블록으로 렌더링된다.

![](https://cloud.githubusercontent.com/assets/1908863/14398210/0e408954-fda8-11e5-9eb4-562d7c0ca431.gif)

수식 렌더링 방법 선택 및 산술 구분 기호를 변경은 [패키지 설정 패널](usages.md?id=package-settings) 에서 확인할 수 있다.

또한, MathJax 구성을 수정할 수 있는데, 이는 <kbd>cmd-shift-p</kbd>를 누른 뒤 `Markdown Preview Enhanced: Open Mathjax config` 명령을 실행시키면 된다.

[➔ Diagrams](diagrams.md)
