# Configuratie

## Globaal

Er is een globaal `config.js`-script dat kan worden gebruikt om de Markdown Preview Enhanced-extensie te configureren. U kunt de opdracht `Markdown Preview Enhanced: Open Config Script (Global)` uitvoeren om het te openen.

- Voor Windows bevindt het zich op `%USERPROFILE%\.crossnote\config.js`.
- Voor \*nix bevindt het zich op `$XDG_CONFIG_HOME/.crossnote/config.js` of `$HOME/.local/state/crossnote/config.js`.

Hieronder is een voorbeeld van het `config.js`-script:

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

U kunt meer configuraties aan dit script toevoegen. Een lijst met beschikbare configuraties is [hier](https://github.com/shd101wyy/crossnote#notebook-configuration) te vinden.

## Werkruimte

U kunt de Markdown Preview Enhanced-extensie ook configureren voor elke werkruimte. U kunt de opdracht `Markdown Preview Enhanced: Open Config Script (Workspace)` uitvoeren om het te openen.
