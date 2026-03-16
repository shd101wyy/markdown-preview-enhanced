# Exportar HTML

## Uso

Clique com o botão direito na visualização, clique na aba `HTML`.  
Então escolha:

- `HTML (offline)`
  Escolha esta opção se for usar o arquivo HTML apenas localmente.
- `HTML (cdn hosted)`
  Escolha esta opção se quiser implantar seu arquivo HTML remotamente.

![screen shot 2017-07-14 at 1 14 28 am](https://user-images.githubusercontent.com/1908863/28200455-d5a12d60-6831-11e7-8572-91d3845ce8cf.png)

## Configuração

Valores padrão:

```yaml
---
html:
  embed_local_images: false
  embed_svg: true
  offline: false
  toc: undefined

print_background: false
---

```

Se `embed_local_images` for definido como `true`, todas as imagens locais serão incorporadas no formato `base64`.

Para gerar o TOC lateral, você precisa habilitar [enableScriptExecution](https://shd101wyy.github.io/markdown-preview-enhanced/#/code-chunk?id=code-chunk) nas configurações do MPE no vscode ou atom.

Se `toc` for definido como `false`, o TOC lateral será desabilitado. Se `toc` for definido como `true`, o TOC lateral será habilitado e exibido. Se `toc` não for especificado, o TOC lateral será habilitado, mas não exibido.

## Exportar ao salvar

Adicione o front-matter como abaixo:

```yaml
---
export_on_save:
  html: true
---

```

Assim o arquivo HTML será gerado toda vez que você salvar seu arquivo Markdown.
