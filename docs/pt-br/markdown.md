# Salvar como Markdown

**Markdown Preview Enhanced** suporta compilação para **GitHub Flavored Markdown**, de modo que o arquivo Markdown exportado incluirá todos os gráficos (como imagens png), code chunks (oculto e incluindo apenas resultados), composições matemáticas (mostradas como imagem) etc. e pode ser publicado no GitHub.

## Uso

Clique com o botão direito na visualização, depois escolha `Save as Markdown`.

## Configurações

Você pode configurar o diretório de imagens e o caminho de saída via front-matter:

```yaml
---
markdown:
  image_dir: /assets
  path: output.md
  ignore_from_front_matter: true
  absolute_image_path: false
---

```

**image_dir** `opcional`  
Especifica onde você quer salvar as imagens geradas. Por exemplo, `/assets` significa que todas as imagens serão salvas no diretório `assets` sob a pasta do projeto. Se **image_dir** não for fornecido, o `Image folder path` nas configurações do pacote será usado. O padrão é `/assets`.

**path** `opcional`  
Especifica onde você quer gerar seu arquivo Markdown. Se **path** não for especificado, `filename_.md` será usado como destino.

**ignore_from_front_matter** `opcional`  
Se definido como `false`, o campo `markdown` será incluído no front-matter.

**absolute_image_path** `opcional`  
Determina se deve usar caminho de imagem absoluto ou relativo.

## Exportar ao salvar

Adicione o front-matter como abaixo:

```yaml
---
export_on_save:
  markdown: true
---

```

Assim o arquivo Markdown será gerado toda vez que você salvar seu arquivo Markdown.

## Problemas conhecidos

- `WaveDrom` ainda não funciona.
- A exibição de composições matemáticas pode estar incorreta.
- Ainda não funciona com o code chunk `latex`.
