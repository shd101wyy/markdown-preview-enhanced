# Documento Beamer

## Visão Geral

Para criar uma apresentação Beamer com o **Markdown Preview Enhanced**, você especifica o formato de saída `beamer_presentation` no front-matter do seu documento.  
Você pode criar uma apresentação de slides dividida em seções usando as tags de cabeçalho `#` e `##` (você também pode criar um novo slide sem cabeçalho usando uma linha horizontal (`----`).  
Por exemplo, aqui está uma apresentação simples:

```markdown
---
title: "Hábitos"
author: João Silva
date: 22 de março de 2005
output: beamer_presentation
---

# De manhã

## Acordando

- Desligar o alarme
- Sair da cama

## Café da manhã

- Comer ovos
- Beber café

# À noite

## Jantar

- Comer macarrão
- Beber vinho

---

![foto de macarrão](images/spaghetti.jpg)

## Indo dormir

- Deitar na cama
- Contar ovelhas
```

## Caminho de Exportação

Você pode definir o caminho de exportação do documento especificando a opção `path`. Por exemplo:

```yaml
---
title: "Hábitos"
output:
  beamer_presentation:
    path: /Exports/Habits.pdf
---

```

Se `path` não for definido, o documento será gerado no mesmo diretório.

## Marcadores Incrementais

Você pode renderizar marcadores de forma incremental adicionando a opção `incremental`:

```yaml
---
output:
  beamer_presentation:
    incremental: true
---

```

Se você quiser renderizar marcadores de forma incremental em alguns slides, mas não em outros, você pode usar esta sintaxe:

```markdown
> - Comer ovos
> - Beber café
```

## Temas

Você pode especificar temas Beamer usando as opções `theme`, `colortheme` e `fonttheme`:

```yaml
---
output:
  beamer_presentation:
    theme: "AnnArbor"
    colortheme: "dolphin"
    fonttheme: "structurebold"
---

```

## Índice

A opção `toc` especifica que um índice deve ser incluído no início da apresentação (apenas os cabeçalhos de nível 1 serão incluídos no índice). Por exemplo:

```yaml
---
output:
  beamer_presentation:
    toc: true
---

```

## Nível do Slide

A opção `slide_level` define o nível de cabeçalho que define os slides individuais. Por padrão, este é o nível de cabeçalho mais alto na hierarquia que é seguido imediatamente por conteúdo e não por outro cabeçalho em algum lugar do documento. Este padrão pode ser substituído especificando um `slide_level` explícito:

```yaml
---
output:
  beamer_presentation:
    slide_level: 2
---

```

## Realce de Sintaxe

A opção `highlight` especifica o estilo de realce de sintaxe. Os estilos suportados incluem "default", "tango", "pygments", "kate", "monochrome", "espresso", "zenburn" e "haddock" (especifique null para evitar o realce de sintaxe):

Por exemplo:

```yaml
---
title: "Hábitos"
output:
  beamer_presentation:
    highlight: tango
---

```

## Argumentos Pandoc

Se houver recursos pandoc que você deseja usar e que não têm equivalentes nas opções YAML descritas acima, você ainda pode usá-los passando `pandoc_args` personalizados. Por exemplo:

```yaml
---
title: "Hábitos"
output:
  beamer_presentation:
    pandoc_args: ["--no-tex-ligatures"]
---

```

## Opções Compartilhadas

Se você quiser especificar um conjunto de opções padrão a serem compartilhadas por vários documentos em um diretório, você pode incluir um arquivo chamado `_output.yaml` no diretório. Observe que nenhum delimitador YAML ou objeto de saída envolvente é usado nesse arquivo. Por exemplo:

**\_output.yaml**

```yaml
beamer_presentation:
  toc: true
```

Todos os documentos localizados no mesmo diretório que `_output.yaml` herdarão suas opções. As opções definidas explicitamente nos documentos substituirão as especificadas no arquivo de opções compartilhadas.
