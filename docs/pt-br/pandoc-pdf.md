# Documento PDF

## Visão Geral

Para criar um documento PDF, você precisa especificar o formato de saída `pdf_document` no front-matter do seu documento:

```yaml
---
title: "Hábitos"
author: João Silva
date: 22 de março de 2005
output: pdf_document
---

```

## Caminho de Exportação

Você pode definir o caminho de exportação do documento especificando a opção `path`. Por exemplo:

```yaml
---
title: "Hábitos"
output:
  pdf_document:
    path: /Exports/Habits.pdf
---

```

Se `path` não for definido, o documento será gerado no mesmo diretório.

## Índice

Você pode adicionar um índice usando a opção `toc` e especificar a profundidade dos cabeçalhos que ela abrange usando a opção `toc_depth`. Por exemplo:

```yaml
---
title: "Hábitos"
output:
  pdf_document:
    toc: true
    toc_depth: 2
---

```

Se a profundidade do índice não for explicitamente especificada, o padrão é 3 (o que significa que todos os cabeçalhos de nível 1, 2 e 3 serão incluídos no índice).

_Atenção:_ este TOC é diferente do `<!-- toc -->` gerado pelo **Markdown Preview Enhanced**.

Você pode adicionar numeração de seções aos cabeçalhos usando a opção `number_sections`:

```yaml
---
title: "Hábitos"
output:
  pdf_document:
    toc: true
    number_sections: true
---

```

## Realce de Sintaxe

A opção `highlight` especifica o estilo de realce de sintaxe. Os estilos suportados incluem "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn" e "haddock" (especifique null para evitar o realce de sintaxe):

Por exemplo:

```yaml
---
title: "Hábitos"
output:
  pdf_document:
    highlight: tango
---

```

## Opções LaTeX

Muitos aspectos do template LaTeX usado para criar documentos PDF podem ser personalizados usando metadados YAML de nível superior (observe que essas opções não aparecem sob a seção `output`, mas sim no nível superior junto com title, author, etc.). Por exemplo:

```yaml
---
title: "Análise de Culturas Q3 2013"
output: pdf_document
fontsize: 11pt
geometry: margin=1in
---

```

As variáveis de metadados disponíveis incluem:

| Variável                       | Descrição                                                                               |
| ------------------------------ | ----------------------------------------------------------------------------------------- |
| papersize                      | tamanho do papel, ex: `letter`, `A4`                                                           |
| lang                           | Código de idioma do documento                                                                    |
| fontsize                       | Tamanho da fonte (ex: 10pt, 11pt, 12pt)                                                         |
| documentclass                  | Classe de documento LaTeX (ex: article)                                                       |
| classoption                    | Opção para documentclass (ex: oneside); pode ser repetida                                  |
| geometry                       | Opções para a classe geometry (ex: margin=1in); pode ser repetida                             |
| linkcolor, urlcolor, citecolor | Cor para links internos, externos e de citação (red, green, magenta, cyan, blue, black) |
| thanks                         | Especifica o conteúdo da nota de rodapé de agradecimentos após o título do documento.                      |

Mais variáveis disponíveis podem ser encontradas [aqui](https://pandoc.org/MANUAL.html#variables-for-latex).

### Pacotes LaTeX para Citações

Por padrão, as citações são processadas pelo `pandoc-citeproc`, que funciona para todos os formatos de saída. Para saída PDF, às vezes é melhor usar pacotes LaTeX para processar citações, como `natbib` ou `biblatex`. Para usar um desses pacotes, basta definir a opção `citation_package` como `natbib` ou `biblatex`, por exemplo:

```yaml
---
output:
  pdf_document:
    citation_package: natbib
---

```

## Personalização Avançada

### Mecanismo LaTeX

Por padrão, os documentos PDF são renderizados usando `pdflatex`. Você pode especificar um mecanismo alternativo usando a opção `latex_engine`. Os mecanismos disponíveis são "pdflatex", "xelatex" e "lualatex". Por exemplo:

```yaml
---
title: "Hábitos"
output:
  pdf_document:
    latex_engine: xelatex
---

```

### Incluir

Você pode fazer personalizações mais avançadas na saída PDF incluindo diretivas LaTeX adicionais e/ou conteúdo ou substituindo completamente o template pandoc central. Para incluir conteúdo no cabeçalho do documento ou antes/depois do corpo do documento, você usa a opção `includes` da seguinte forma:

```yaml
---
title: "Hábitos"
output:
  pdf_document:
    includes:
      in_header: header.tex
      before_body: doc_prefix.tex
      after_body: doc_suffix.tex
---

```

### Templates Personalizados

Você também pode substituir o template pandoc subjacente usando a opção `template`:

```yaml
---
title: "Hábitos"
output:
  pdf_document:
    template: quarterly_report.tex
---

```

Consulte a documentação sobre [templates pandoc](https://pandoc.org/README.html#templates) para detalhes adicionais sobre templates. Você também pode estudar o [template LaTeX padrão](https://github.com/jgm/pandoc-templates/blob/master/default.latex) como exemplo.

### Argumentos Pandoc

Se houver recursos pandoc que você deseja usar e que não têm equivalentes nas opções YAML descritas acima, você ainda pode usá-los passando `pandoc_args` personalizados. Por exemplo:

```yaml
---
title: "Hábitos"
output:
  pdf_document:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Opções Compartilhadas

Se você quiser especificar um conjunto de opções padrão a serem compartilhadas por vários documentos em um diretório, você pode incluir um arquivo chamado `_output.yaml` no diretório. Observe que nenhum delimitador YAML ou objeto de saída envolvente é usado nesse arquivo. Por exemplo:

**\_output.yaml**

```yaml
pdf_document:
  toc: true
  highlight: zenburn
```

Todos os documentos localizados no mesmo diretório que `_output.yaml` herdarão suas opções. As opções definidas explicitamente nos documentos substituirão as especificadas no arquivo de opções compartilhadas.
