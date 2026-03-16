# Yapılandırma

## Global

Markdown Preview Enhanced uzantısını yapılandırmak için kullanılabilecek global bir `config.js` betiği vardır. Açmak için `Markdown Preview Enhanced: Open Config Script (Global)` komutunu çalıştırabilirsiniz.

- Windows için `%USERPROFILE%\.crossnote\config.js` konumundadır.
- \*nix için `$XDG_CONFIG_HOME/.crossnote/config.js` veya `$HOME/.local/state/crossnote/config.js` konumundadır.

Aşağıda `config.js` betiğinin bir örneği verilmektedir:

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

Bu betiğe daha fazla yapılandırma ekleyebilirsiniz. Mevcut yapılandırmaların listesi [burada](https://github.com/shd101wyy/crossnote#notebook-configuration) bulunabilir.

## Çalışma Alanı

Markdown Preview Enhanced uzantısını her çalışma alanı için de yapılandırabilirsiniz. Açmak için `Markdown Preview Enhanced: Open Config Script (Workspace)` komutunu çalıştırabilirsiniz.
