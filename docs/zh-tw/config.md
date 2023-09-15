# 設定

## 全域

有一個全域的 `config.js` 腳本，可用於配置 Markdown Preview Enhanced 擴充功能。您可以執行 `Markdown Preview Enhanced: Open Config Script (Global)` 命令來打開它。

- 對於 Windows，它位於 `%USERPROFILE%\.crossnote\config.js`。
- 對於 \*nix，它位於 `$XDG_CONFIG_HOME/.crossnote/config.js` 或 `$HOME/.local/state/crossnote/config.js`。

以下是 `config.js` 腳本的示例：

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

您可以在此腳本中添加更多配置項。可用配置項的列表可以在[此處](https://github.com/shd101wyy/crossnote#notebook-configuration)找到。

## 工作區

您還可以為每個工作區配置 `Markdown Preview Enhanced` 擴充功能。您可以執行 `Markdown Preview Enhanced: Open Config Script (Workspace)` 命令來打開它。
