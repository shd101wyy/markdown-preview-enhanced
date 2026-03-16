# Documento Word

## Visão Geral

Para criar um documento Word, você precisa especificar o formato de saída word_document no front-matter do seu documento:

```yaml
---
title: "Hábitos"
author: João Silva
date: 22 de março de 2005
output: word_document
---

```

## Caminho de Exportação

Você pode definir o caminho de exportação do documento especificando a opção `path`. Por exemplo:

```yaml
---
title: "Hábitos"
output:
  word_document:
    path: /Exports/Habits.docx
---

```

Se `path` não for definido, o documento será gerado no mesmo diretório.

## Realce de Sintaxe

Você pode usar a opção `highlight` para controlar o tema de realce de sintaxe. Por exemplo:

```yaml
---
title: "Hábitos"
output:
  word_document:
    highlight: "tango"
---

```

## Referência de Estilo

Use o arquivo especificado como referência de estilo ao produzir um arquivo docx. Para melhores resultados, o docx de referência deve ser uma versão modificada de um arquivo docx produzido usando pandoc. O conteúdo do docx de referência é ignorado, mas suas folhas de estilo e propriedades do documento (incluindo margens, tamanho de página, cabeçalho e rodapé) são usados no novo docx. Se nenhum docx de referência for especificado na linha de comando, o pandoc procurará um arquivo `reference.docx` no diretório de dados do usuário (veja --data-dir). Se também não for encontrado, serão usados padrões razoáveis.

```yaml
---
title: "Hábitos"
output:
  word_document:
    reference_docx: mystyles.docx
---

```

## Argumentos Pandoc

Se houver recursos pandoc que você deseja usar e que não têm equivalentes nas opções YAML descritas acima, você ainda pode usá-los passando `pandoc_args` personalizados. Por exemplo:

```yaml
---
title: "Hábitos"
output:
  word_document:
    pandoc_args: ["--csl", "/var/csl/acs-nano.csl"]
---

```

## Opções Compartilhadas

Se você quiser especificar um conjunto de opções padrão a serem compartilhadas por vários documentos em um diretório, você pode incluir um arquivo chamado `_output.yaml` no diretório. Observe que nenhum delimitador YAML ou objeto de saída envolvente é usado nesse arquivo. Por exemplo:

**\_output.yaml**

```yaml
word_document:
  highlight: zenburn
```

Todos os documentos localizados no mesmo diretório que `_output.yaml` herdarão suas opções. As opções definidas explicitamente nos documentos substituirão as especificadas no arquivo de opções compartilhadas.
