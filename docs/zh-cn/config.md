# 配置

## 全局

有一个全局的 `config.js` 脚本，可以用于配置 Markdown Preview Enhanced 扩展。您可以运行 `Markdown Preview Enhanced: Open Config Script (Global)` 命令来打开它。

- 对于 Windows，它位于 `%USERPROFILE%\.crossnote\config.js`。
- 对于 \*nix，它位于 `$XDG_CONFIG_HOME/.crossnote/config.js` 或 `$HOME/.local/state/crossnote/config.js`。

以下是 `config.js` 脚本的示例：

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

您可以在此脚本中添加更多配置项。可用配置项的列表可以在[此处](https://github.com/shd101wyy/crossnote#notebook-configuration)找到。

## 工作区

您还可以为每个工作区配置 `Markdown Preview Enhanced` 扩展。您可以运行 `Markdown Preview Enhanced: Open Config Script (Workspace)` 命令来打开它。
