# Índice (TOC)

**Markdown Preview Enhanced** pode criar `TOC` para seu arquivo Markdown.
Você pode pressionar <kbd>cmd-shift-p</kbd> e escolher `Markdown Preview Enhanced: Create Toc` para criar o `TOC`.
Múltiplos TOCs podem ser criados.
Para excluir um cabeçalho do `TOC`, acrescente `{ignore=true}` **após** seu cabeçalho.

![screen shot 2018-03-14 at 12 03 00 pm](https://user-images.githubusercontent.com/1908863/37418218-bb624e62-277f-11e8-88f5-8747a1c2e012.png)

> O TOC será atualizado quando você salvar o arquivo Markdown.
> Você precisa manter a visualização aberta para que o TOC seja atualizado.

## Configuração

- **orderedList**
  Usar ou não lista ordenada.
- **depthFrom**, **depthTo**
  `[1~6]` inclusivo.
- **ignoreLink**
  Se definido como `true`, as entradas do TOC não serão hiperlinks.

## [TOC]

Você também pode criar um `TOC` inserindo `[TOC]` no seu arquivo Markdown.
Por exemplo:

```markdown
[TOC]

# Cabeçalho 1

## Cabeçalho 2 {ignore=true}

O Cabeçalho 2 será ignorado no TOC.
```

No entanto, **desta forma o TOC só será exibido na visualização**, sem alterar o conteúdo do editor.

## Configuração do [TOC] e do TOC Lateral

Você pode configurar o `[TOC]` e o TOC lateral escrevendo front-matter:

```markdown
---
toc:
  depth_from: 1
  depth_to: 6
  ordered: false
---
```

[➔ Importar Arquivos](file-imports.md)
