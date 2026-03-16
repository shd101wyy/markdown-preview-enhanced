# Configuración

## Global

Hay un script global `config.js` que se puede usar para configurar la extensión Markdown Preview Enhanced. Puedes ejecutar el comando `Markdown Preview Enhanced: Open Config Script (Global)` para abrirlo.

- En Windows, se encuentra en `%USERPROFILE%\.crossnote\config.js`.
- En \*nix, se encuentra en `$XDG_CONFIG_HOME/.crossnote/config.js` o `$HOME/.local/state/crossnote/config.js`.

A continuación se muestra un ejemplo del script `config.js`:

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

Puedes añadir más configuraciones a este script. Una lista de configuraciones disponibles se puede encontrar [aquí](https://github.com/shd101wyy/crossnote#notebook-configuration).

## Espacio de trabajo

También puedes configurar la extensión Markdown Preview Enhanced para cada espacio de trabajo. Puedes ejecutar el comando `Markdown Preview Enhanced: Open Config Script (Workspace)` para abrirlo.
