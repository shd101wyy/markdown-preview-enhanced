# Configuration

## Global

There is a global `config.js` script that could be used to configure the Markdown Preview Enhanced extension. You can run `Markdown Preview Enhanced: Open Config Script (Global)` command to open it.

- For Windows, it is located at `%USERPROFILE%\.crossnote\config.js`.
- For \*nix, it is located at `$XDG_CONFIG_HOME/.crossnote/config.js` or `$HOME/.local/state/crossnote/config.js`.

Below is an example of the `config.js` script:

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

You can add more configurations to this script. A list of available configurations can be found [here](https://github.com/shd101wyy/crossnote#notebook-configuration).

## Workspace

You can also configure the Markdown Preview Enhanced extension for each workspace. You can run `Markdown Preview Enhanced: Open Config Script (Workspace)` command to open it.
