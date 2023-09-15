# 설정

## 전역 설정

Markdown Preview Enhanced 확장을 구성하는 데 사용할 수 있는 전역 `config.js` 스크립트가 있습니다. 이를 열려면 `Markdown Preview Enhanced: Open Config Script (Global)` 명령을 실행하십시오.

- Windows의 경우 `%USERPROFILE%\.crossnote\config.js`에 위치합니다.
- \*nix의 경우 `$XDG_CONFIG_HOME/.crossnote/config.js` 또는 `$HOME/.local/state/crossnote/config.js`에 위치합니다.

아래는 `config.js` 스크립트의 예입니다:

```javascript
({
  katexConfig: {
    macros: {},
  },

  mathjaxConfig: {
    tex: {},
    options: {},
    loader: {},
  },

  mermaidConfig: {
    startOnLoad: false,
  },
});
```

이 스크립트에 추가 설정을 추가할 수 있습니다. 사용 가능한 설정 목록은 여기에서 확인할 수 있습니다.

## 워크스페이스 설정

각 워크스페이스에 대해 `Markdown Preview Enhanced` 확장을 구성할 수도 있습니다. 이를 열려면 `Markdown Preview Enhanced: Open Config Script (Workspace)` 명령을 실행하십시오.
