# Configuração

## Global

Há um script global `config.js` que pode ser usado para configurar a extensão Markdown Preview Enhanced. Você pode executar o comando `Markdown Preview Enhanced: Open Config Script (Global)` para abri-lo.

- No Windows, está localizado em `%USERPROFILE%\.crossnote\config.js`.
- No \*nix, está localizado em `$XDG_CONFIG_HOME/.crossnote/config.js` ou `$HOME/.local/state/crossnote/config.js`.

Abaixo está um exemplo do script `config.js`:

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

Você pode adicionar mais configurações a este script. Uma lista de configurações disponíveis pode ser encontrada [aqui](https://github.com/shd101wyy/crossnote#notebook-configuration).

## Workspace

Você também pode configurar a extensão Markdown Preview Enhanced para cada workspace. Você pode executar o comando `Markdown Preview Enhanced: Open Config Script (Workspace)` para abri-lo.
