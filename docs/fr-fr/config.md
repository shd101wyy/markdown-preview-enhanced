# Configuration

## Globale

Il existe un script global `config.js` qui peut être utilisé pour configurer l'extension Markdown Preview Enhanced. Vous pouvez exécuter la commande `Markdown Preview Enhanced: Open Config Script (Global)` pour l'ouvrir.

- Pour Windows, il se trouve à `%USERPROFILE%\.crossnote\config.js`.
- Pour \*nix, il se trouve à `$XDG_CONFIG_HOME/.crossnote/config.js` ou `$HOME/.local/state/crossnote/config.js`.

Voici un exemple du script `config.js` :

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

Vous pouvez ajouter d'autres configurations à ce script. Une liste des configurations disponibles peut être trouvée [ici](https://github.com/shd101wyy/crossnote#notebook-configuration).

## Espace de travail

Vous pouvez également configurer l'extension Markdown Preview Enhanced pour chaque espace de travail. Vous pouvez exécuter la commande `Markdown Preview Enhanced: Open Config Script (Workspace)` pour l'ouvrir.
