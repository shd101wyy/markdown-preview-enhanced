# Fundamentos do Markdown

Este artigo é uma breve introdução à [escrita em GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

## O que é Markdown?

`Markdown` é uma forma de estilizar texto na web. Você controla a exibição do documento; formatar palavras em negrito ou itálico, adicionar imagens e criar listas são apenas algumas das coisas que podemos fazer com Markdown. Na maioria das vezes, Markdown é simplesmente texto comum com alguns caracteres não alfabéticos inseridos, como `#` ou `*`.

## Guia de sintaxe

### Cabeçalhos

```markdown
# Este é um tag <h1>

## Este é um tag <h2>

### Este é um tag <h3>

#### Este é um tag <h4>

##### Este é um tag <h5>

###### Este é um tag <h6>
```

Se você quiser adicionar `id` e `class` ao cabeçalho, basta acrescentar `{#id .class1 .class2}`. Por exemplo:

```markdown
# Este cabeçalho tem 1 id {#my_id}

# Este cabeçalho tem 2 classes {.class1 .class2}
```

> Este é um recurso estendido do MPE.

### Ênfase

<!-- prettier-ignore -->
```markdown
*Este texto ficará em itálico*
_Este também ficará em itálico_

**Este texto ficará em negrito**
__Este também ficará em negrito__

_Você **pode** combiná-los_

~~Este texto ficará tachado~~
```

### Listas

#### Lista não ordenada

```markdown
- Item 1
- Item 2
  - Item 2a
  - Item 2b
```

#### Lista ordenada

```markdown
1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b
```

### Imagens

```markdown
![Logo do GitHub](/images/logo.png)
Formato: ![Texto Alternativo](url)
```

### Links

```markdown
https://github.com - automático!
[GitHub](https://github.com)
```

### Citação em bloco

```markdown
Como disse Kanye West:

> Estamos vivendo o futuro então
> o presente é nosso passado.

> [!NOTE]
> Esta é uma citação de nota.

> [!WARNING]
> Esta é uma citação de aviso.
```

### Linha horizontal

```markdown
Três ou mais...

---

Hífens

---

Asteriscos

---

Underscores
```

### Código inline

```markdown
Acho que você deveria usar um
elemento `<addr>` aqui.
```

### Bloco de código delimitado

Você pode criar blocos de código delimitados colocando três crases <code>\`\`\`</code> antes e depois do bloco de código.

#### Realce de sintaxe

Você pode adicionar um identificador de linguagem opcional para habilitar o realce de sintaxe no seu bloco de código delimitado.

Por exemplo, para destacar código Ruby:

    ```ruby
    require 'redcarpet'
    markdown = Redcarpet.new("Hello World!")
    puts markdown.to_html
    ```

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

#### Classe de bloco de código (recurso estendido do MPE)

Você pode definir `class` para seus blocos de código.

Por exemplo, para adicionar `class1 class2` a um bloco de código:

    ```javascript {.class1 .class}
    function add(x, y) {
      return x + y
    }
    ```

##### números de linha

Você pode habilitar números de linha para um bloco de código adicionando a classe `line-numbers`.

Por exemplo:

````markdown
```javascript {.line-numbers}
function add(x, y) {
  return x + y;
}
```
````

![screen shot 2017-07-14 at 1 20 27 am](https://user-images.githubusercontent.com/1908863/28200587-a8582b0a-6832-11e7-83a7-6c3bb011322f.png)

##### destacar linhas

Você pode destacar linhas adicionando o atributo `highlight`:

````markdown
```javascript {highlight=10}
```

```javascript {highlight=10-20}
```

```javascript {highlight=[1-10,15,20-22]}
```
````

### Listas de tarefas

```markdown
- [x] @mentions, #refs, [links](), **formatação** e <del>tags</del> suportados
- [x] sintaxe de lista necessária (qualquer lista ordenada ou não ordenada é aceita)
- [x] este item está completo
- [ ] este item está incompleto
```

### Tabelas

Você pode criar tabelas montando uma lista de palavras e dividindo-as com hífens `-` (para a primeira linha) e separando cada coluna com um pipe `|`:

<!-- prettier-ignore -->
```markdown
Primeiro Cabeçalho | Segundo Cabeçalho
------------ | -------------
Conteúdo da célula 1 | Conteúdo da célula 2
Conteúdo na primeira coluna | Conteúdo na segunda coluna
```

## Sintaxe estendida

### Tabela

> É necessário habilitar `enableExtendedTableSyntax` nas configurações da extensão para que funcione.

![screen shot 2017-07-15 at 8 16 45 pm](https://user-images.githubusercontent.com/1908863/28243710-945e3004-699a-11e7-9a5f-d74f6c944c3b.png)

### Emoji & Font-Awesome

> Isso funciona apenas com o `analisador markdown-it`, mas não com o `analisador pandoc`.  
> Habilitado por padrão. Você pode desativá-lo nas configurações do pacote.

```
:smile:
:fa-car:
```

### Sobrescrito

```markdown
30^th^
```

### Subscrito

```markdown
H~2~O
```

### Notas de rodapé

```markdown
Conteúdo [^1]

[^1]: Olá! Esta é uma nota de rodapé
```

### Abreviação

```
*[HTML]: Hyper Text Markup Language
*[W3C]: World Wide Web Consortium
A especificação HTML
é mantida pelo W3C.
```

### Marca

```markdown
==marcado==
```

### CriticMarkup

CriticMarkup está **desabilitado** por padrão, mas você pode habilitá-lo nas configurações do pacote.  
Para mais informações sobre CriticMarkup, consulte o [Guia do Usuário CriticMarkup](https://criticmarkup.com/users-guide.php).

Há cinco tipos de marcas Critic:

- Adição `{++ ++}`
- Exclusão `{-- --}`
- Substituição `{~~ ~> ~~}`
- Comentário `{>> <<}`
- Destaque `{== ==}{>> <<}`

> CriticMarkup só funciona com o analisador markdown-it, não com o analisador pandoc.

### Admonição

```
!!! note Este é o título da admonição
    Este é o corpo da admonição
```

> Consulte mais informações em https://squidfunk.github.io/mkdocs-material/reference/admonitions/

### Wikilinks

> Disponível desde vscode-mpe 0.8.25 / crossnote 0.9.23. Links entre notas no estilo Obsidian.

```markdown
[[Note]]                       <!-- link para Note (resolve para Note.md por padrão) -->
[[Note|Texto exibido]]         <!-- link com texto de exibição personalizado -->
[[Note#Heading]]               <!-- link para um título específico dentro de Note -->
[[Note^block-id]]              <!-- link para um ^block-id específico dentro de Note -->
[[Note#Heading^block-id]]      <!-- combinação título + referência de bloco -->
[[#Heading]]                   <!-- link para um título na nota atual -->
[[^block-id]]                  <!-- link para um bloco na nota atual -->
```

Na pré-visualização, clique em qualquer wikilink para navegar. No editor, alt+clique (Ctrl+clique no macOS) para seguir o link. Passe o cursor sobre um wikilink para visualizar o conteúdo do destino (início do arquivo, seção do título, ou corpo do bloco — conforme o que o link aponta).

Se você clicar em `[[NewNote]]` e `NewNote.md` ainda não existir, o arquivo é criado com um esqueleto `# NewNote` e aberto — mesmo comportamento do fluxo "clicar para criar" do Obsidian.

Chaves de configuração (notebook config):

- `wikiLinkTargetFileExtension` (padrão `.md`) — extensão adicionada quando o link não a possui. Defina como `.markdown` / `.mdx` / `.qmd` para notebooks que não usem `.md`.
- `useGitHubStylePipedLink` (padrão `false`) — quando `true`, a ordem é `[[exibir|link]]` (estilo GitHub); quando `false`, `[[link|exibir]]` (estilo Obsidian / Wikipedia).

### Incorporação de notas (`![[…]]`)

O prefixo `!` incorpora o conteúdo do destino em linha:

```markdown
![[Note]]                      <!-- incorpora a nota inteira -->
![[Note#Heading]]              <!-- incorpora apenas a seção do título -->
![[Note^block-id]]             <!-- incorpora apenas aquele bloco -->
![[Note|Título a exibir]]      <!-- incorpora com um título personalizado -->
![[image.png]]                 <!-- incorporação padrão de imagem (qualquer extensão de imagem) -->
```

A recursão é limitada a 3 níveis — um ciclo de incorporação não vai inflar a pré-visualização.

### Referências de bloco (`^block-id`)

Acrescente `^block-id` ao final de um parágrafo ou item de lista para marcá-lo como um bloco referenciável:

```markdown
Este parágrafo pode ser referenciado. ^my-block

- Um item de lista também. ^another-block
```

Referencie-o de qualquer lugar do workspace:

```markdown
Veja [[Note^my-block]] ou incorpore: ![[Note^my-block]]
```

O comando `Markdown Preview Enhanced: Copy Block Reference` (paleta de comandos) gera um `^id` para o parágrafo no cursor (ou reaproveita o existente) e copia um link `[[Note#^id]]` pronto para colar na sua área de transferência.

### Tags

Sintaxe `#tag-name` no texto:

```markdown
Este pensamento está marcado com #important e #project/q1.
```

- **Tags aninhadas** via `/`: `#parent/child`, e mais profundo (`#a/b/c`).
- As tags não disparam quando uma linha contém apenas `#` (assim `# Título`, `## Título` etc. continuam funcionando).
- Clique em uma tag na pré-visualização para abrir um Quick Pick listando todas as notas que a mencionam.
- A configuração `enableTagSyntax` (padrão `true`) ativa/desativa a funcionalidade.

## Referências

- [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
- [Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)

[➔ Matemática](math.md)
