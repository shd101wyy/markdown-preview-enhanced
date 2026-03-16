# Documento RTF

## Visão Geral

Para criar um documento RTF a partir do R Markdown, você especifica o formato de saída `rtf_document` no front-matter do seu documento:

```yaml
---
title: "Hábitos"
author: João Silva
date: 22 de março de 2005
output: rtf_document
---

```

## Caminho de Exportação

Você pode definir o caminho de exportação do documento especificando a opção `path`. Por exemplo:

```yaml
---
title: "Hábitos"
output:
  rtf_document:
    path: /Exports/Habits.rtf
---

```

Se `path` não for definido, o documento será gerado no mesmo diretório.

## Índice

Você pode adicionar um índice usando a opção `toc` e especificar a profundidade dos cabeçalhos que ela abrange usando a opção `toc_depth`. Por exemplo:

```yaml
---
title: "Hábitos"
output:
  rtf_document:
    toc: true
    toc_depth: 2
---

```

Se a profundidade do índice não for explicitamente especificada, o padrão é 3 (o que significa que todos os cabeçalhos de nível 1, 2 e 3 serão incluídos no índice).

_Atenção:_ este TOC é diferente do `<!-- toc -->` gerado pelo **Markdown Preview Enhanced**.

## Argumentos Pandoc

Se houver recursos pandoc que você deseja usar e que não têm equivalentes nas opções YAML descritas acima, você ainda pode usá-los passando `pandoc_args` personalizados. Por exemplo:

```yaml
---
title: "Hábitos"
output:
  rtf_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## Opções Compartilhadas

Se você quiser especificar um conjunto de opções padrão a serem compartilhadas por vários documentos em um diretório, você pode incluir um arquivo chamado `_output.yaml` no diretório. Observe que nenhum delimitador YAML ou objeto de saída envolvente é usado nesse arquivo. Por exemplo:

**\_output.yaml**

```yaml
rtf_document:
  toc: true
```

Todos os documentos localizados no mesmo diretório que `_output.yaml` herdarão suas opções. As opções definidas explicitamente nos documentos substituirão as especificadas no arquivo de opções compartilhadas.
