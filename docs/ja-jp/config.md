# 設定

## グローバル

Markdown Preview Enhanced 拡張機能を設定するために使用できる `config.js` スクリプトがあります。これを開くには `Markdown Preview Enhanced: Open Config Script (Global)` コマンドを実行します。

- Windows の場合、`%USERPROFILE%\.crossnote\config.js` にあります。
- \*nix の場合、`$XDG_CONFIG_HOME/.crossnote/config.js` または `$HOME/.local/state/crossnote/config.js` にあります。

以下は `config.js` スクリプトの例です：

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

このスクリプトにさらに設定を追加できます。使用可能な設定のリストは[こちら](https://github.com/shd101wyy/crossnote#notebook-configuration)で確認できます。

## ワークスペース

各ワークスペースに対して `Markdown Preview Enhanced` 拡張機能を設定することもできます。これを開くには `Markdown Preview Enhanced: Open Config Script (Workspace)` コマンドを実行します。
