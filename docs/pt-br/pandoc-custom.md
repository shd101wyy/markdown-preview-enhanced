# Documento Personalizado

## Visão Geral

**Documento Personalizado** concede a você a capacidade de utilizar plenamente o poder do `pandoc`.  
Para criar um documento personalizado, você precisa especificar o formato de saída `custom_document` no front-matter do seu documento, **e** o `path` **deve ser definido**.

O exemplo de código abaixo se comportará de forma semelhante ao [documento pdf](pdf.md).

```yaml
---
title: "Hábitos"
author: João Silva
date: 22 de março de 2005
output:
  custom_document:
    path: /Exports/test.pdf
    toc: true
---

```

O exemplo de código abaixo se comportará de forma semelhante à [apresentação beamer](pandoc-beamer.md).

```yaml
---
title: "Hábitos"
author: João Silva
date: 22 de março de 2005
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["-t", "beamer"]
---

```

## Argumentos Pandoc

Se houver recursos pandoc que você deseja usar e que não têm equivalentes nas opções YAML descritas acima, você ainda pode usá-los passando `pandoc_args` personalizados. Por exemplo:

```yaml
---
title: "Hábitos"
output:
  custom_document:
    path: /Exports/test.pdf
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Opções Compartilhadas

Se você quiser especificar um conjunto de opções padrão a serem compartilhadas por vários documentos em um diretório, você pode incluir um arquivo chamado `_output.yaml` no diretório. Observe que nenhum delimitador YAML ou objeto de saída envolvente é usado nesse arquivo. Por exemplo:

**\_output.yaml**

```yaml
custom_document:
  toc: true
  highlight: zenburn
```

Todos os documentos localizados no mesmo diretório que `_output.yaml` herdarão suas opções. As opções definidas explicitamente nos documentos substituirão as especificadas no arquivo de opções compartilhadas.
