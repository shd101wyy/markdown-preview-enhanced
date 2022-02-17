# 개발자에게

## Atom용 패키지 개발

부담없이 pull request, issues 보고하거나 새로운 기능 요청을 요청 해주기 바란다!

**markdown-preview-enhanced**를 수정하고 개발하려면 [local installation](installation.md?id=install-from-github) 이 필요하다.

패키지 설치가 완료되면 다음 단계를 진행하라:

- **markdown-preview-enhanced** 폴더를 **Atom Editor** 에서 **View->Developer->Open in Dev Mode...** 를 통해 연다.
- 코드를 수정한다. 
  코드를 수정한 뒤엔, <kbd>cmd-shift-p</kbd> 에서 `Window: Reload` 를 실행해서 패키지를 다시 로드하여 업데이트를 확인할 수 있다.

> Atom 버전은 TypeScript로 작성되었으므로 패키지 개발을 위해 `atom-typescript`를 설치하는 것을 권장한다.  
> 사실은... Atom 버전은 vscode 를 사용해 개발됐다.

## VS Code 용 패키지 개발

[vscode-markdown-preview-enhanced](https://github.com/shd101wyy/vscode-markdown-preview-enhanced) 를 clone하고 `yarn install`한 뒤, **vscode** 에서 열면 디버깅을 시작할 수 있다.
