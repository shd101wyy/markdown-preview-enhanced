# Geração de eBook

Inspirado pelo _GitBook_  
**Markdown Preview Enhanced** pode exportar conteúdo como ebook (ePub, Mobi, PDF).

![Screen Shot 2016-09-08 at 9.42.43 PM](https://ooo.0o0.ooo/2016/09/09/57d221c0a618a.png)

Para gerar um ebook, você precisa ter o `ebook-convert` instalado.

## Instalando ebook-convert

**macOS**  
Baixe o [Calibre Application](https://calibre-ebook.com/download). Após mover o `calibre.app` para sua pasta de Aplicativos, crie um link simbólico para a ferramenta `ebook-convert`:

```shell
$ sudo ln -s ~/Applications/calibre.app/Contents/MacOS/ebook-convert /usr/local/bin
```

**Windows**  
Baixe e instale o [Calibre Application](https://calibre-ebook.com/download).  
Adicione `ebook-convert` ao seu `$PATH`.

## Exemplo de eBook

Um projeto de exemplo de eBook pode ser encontrado [aqui](https://github.com/shd101wyy/ebook-example).

## Começar a escrever um eBook

Você pode configurar um ebook simplesmente adicionando `ebook front-matter` ao seu arquivo Markdown.

```yaml
---
ebook:
  theme: github-light.css
  title: Meu eBook
  authors: shd101wyy
---

```

---

## Demonstração

`SUMMARY.md` é um arquivo de entrada de exemplo. Ele também deve ter um TOC para ajudar a organizar o livro:

```markdown
---
ebook:
  theme: github-light.css
  title: Markdown Preview Enhanced
  author: shd101wyy
---

# Prefácio

Este é o prefácio, mas não é necessário.

# Índice

- [Capítulo 1](/chapter1/README.md)
  - [Introdução ao Markdown Preview Enhanced](/chapter1/intro.md)
  - [Funcionalidades](/chapter1/feature.md)
- [Capítulo 2](/chapter2/README.md)
  - [Problemas conhecidos](/chapter2/issues.md)
```

A última lista no arquivo Markdown é considerada como TOC.

O título do link é usado como título do capítulo, e o destino do link é o caminho para o arquivo desse capítulo.

---

Para exportar o ebook, abra o `SUMMARY.md` com a visualização aberta. Depois clique com o botão direito na visualização, escolha `Export to Disk`, depois escolha a opção `EBOOK`. Você pode então exportar seu ebook.

### Metadados

- **theme**
  O tema a ser usado para o eBook. Por padrão, usará o tema de visualização. A lista de temas disponíveis pode ser encontrada na seção `previewTheme` em [este documento](https://github.com/shd101wyy/crossnote/#notebook-configuration).
- **title**  
  Título do seu livro
- **authors**  
  autor1 & autor2 & ...
- **cover**  
  https://path-to-image.png
- **comments**  
  Definir a descrição do ebook
- **publisher**  
  Quem é o editor?
- **book-producer**  
  Quem é o produtor do livro
- **pubdate**  
  Data de publicação
- **language**  
  Definir o idioma
- **isbn**  
  ISBN do livro
- **tags**  
  Definir as tags para o livro. Deve ser uma lista separada por vírgulas.
- **series**  
  Definir a série a que este ebook pertence.
- **rating**  
  Definir a classificação. Deve ser um número entre 1 e 5.
- **include_toc**  
  `padrão: true` Se deve incluir ou não o TOC que você escreveu no seu arquivo de entrada.

Por exemplo:

```yaml
ebook:
  title: Meu eBook
  author: shd101wyy
  rating: 5
```

### Aparência e Layout

As seguintes opções são fornecidas para ajudar a controlar a aparência e o layout da saída

- **asciiize** `[true/false]`  
  `padrão: false`, Transliterar caracteres unicode para uma representação ASCII. Use com cuidado, pois isso substituirá caracteres unicode por ASCII.
- **base-font-size** `[number]`  
  O tamanho base da fonte em pts. Todos os tamanhos de fonte no livro produzido serão redimensionados com base neste tamanho. Escolhendo um tamanho maior, você pode tornar as fontes na saída maiores e vice-versa. Por padrão, o tamanho base da fonte é escolhido com base no perfil de saída que você selecionou.
- **disable-font-rescaling** `[true/false]`  
  `padrão: false` Desabilitar todo o redimensionamento de tamanhos de fonte.
- **line-height** `[number]`  
  A altura da linha em pts. Controla o espaçamento entre linhas consecutivas de texto. Aplica-se apenas a elementos que não definem sua própria altura de linha. Na maioria dos casos, a opção de altura mínima de linha é mais útil. Por padrão, nenhuma manipulação de altura de linha é realizada.
- **margin-top** `[number]`  
  `padrão: 72.0` Definir a margem superior em pts. O padrão é 72. Definir como menos de zero não definirá margem (a configuração de margem no documento original será preservada). Nota: 72 pts equivale a 1 polegada.
- **margin-right** `[number]`  
  `padrão: 72.0`
- **margin-bottom** `[number]`  
  `padrão: 72.0`
- **margin-left** `[number]`  
  `padrão: 72.0`
- **margin** `[number/array]`  
  `padrão: 72.0`  
  Você pode definir **margin top/right/bottom/left** ao mesmo tempo. Por exemplo:

```yaml
ebook:
  margin: 5 # margin-top = margin-right = margin-bottom = margin-left = 5
```

```yaml
ebook:
  margin: [4, 8] # margin-top = margin-bottom = 4, margin-left = margin-right = 8
```

```yaml
ebook:
  margin: [1, 2, 3, 4] # margin-top=1, margin-right=2, margin-bottom=3, margin-left=4
```

Por exemplo:

```yaml
ebook:
  title: Meu eBook
  base-font-size: 8
  margin: 72
```

## Formatos de Saída

Atualmente você pode exportar ebook nos formatos `ePub`, `mobi`, `pdf`, `html`.

### ePub

Para configurar a saída `ePub`, basta adicionar `epub` após `ebook`.

```yaml
---
ebook:
  epub:
    no-default-epub-cover: true
    pretty-print: true
---

```

As seguintes opções são fornecidas:

- **no-default-epub-cover** `[true/false]`  
  Normalmente, se o arquivo de entrada não tiver capa e você não especificar uma, uma capa padrão é gerada com o título, autores, etc. Esta opção desabilita a geração dessa capa.
- **no-svg-cover** `[true/false]`  
  Não usar SVG para a capa do livro. Use esta opção se o seu EPUB for utilizado em um dispositivo que não suporta SVG, como o iPhone ou o JetBook Lite. Sem esta opção, esses dispositivos exibirão a capa como uma página em branco.
- **pretty-print** `[true/false]`  
  Se especificado, o plugin de saída tentará criar saída que seja o mais legível possível por humanos. Pode não ter efeito para alguns plugins de saída.

### PDF

Para configurar a saída `pdf`, basta adicionar `pdf` após `ebook`.

```yaml
ebook:
  pdf:
    paper-size: letter
    default-font-size: 12
    header-template: "<span> Written by shd101wyy _PAGENUM_ </span>"
```

As seguintes opções são fornecidas:

- **paper-size**  
  O tamanho do papel. Este tamanho será sobrescrito quando um perfil de saída não padrão for usado. O padrão é letter. As opções são `a0`, `a1`, `a2`, `a3`, `a4`, `a5`, `a6`, `b0`, `b1`, `b2`, `b3`, `b4`, `b5`, `b6`, `legal`, `letter`
- **default-font-size** `[number]`  
  O tamanho de fonte padrão
- **footer-template**  
  Um template HTML usado para gerar rodapés em cada página. As strings `_PAGENUM_`, `_TITLE_`, `_AUTHOR_` e `_SECTION_` serão substituídas por seus valores atuais.
- **header-template**  
  Um template HTML usado para gerar cabeçalhos em cada página. As strings `_PAGENUM_`, `_TITLE_`, `_AUTHOR_` e `_SECTION_` serão substituídas por seus valores atuais.
- **page-numbers** `[true/false]`  
  `padrão: false`  
  Adicionar números de página na parte inferior de cada página no arquivo PDF gerado. Se você especificar um template de rodapé, ele terá prioridade sobre esta opção.
- **pretty-print** `[true/false]`  
  Se especificado, o plugin de saída tentará criar saída que seja o mais legível possível por humanos. Pode não ter efeito para alguns plugins de saída.

### HTML

Exportar `.html` não depende de `ebook-convert`.  
Se você estiver exportando um arquivo `.html`, todas as imagens locais serão incluídas como dados `base64` dentro de um único arquivo `html`.  
Para configurar a saída `html`, basta adicionar `html` após `ebook`.

```yaml
ebook:
  html:
    cdn: true
```

- **cdn**  
  Carregar arquivos CSS e JavaScript de `cdn.js`. Esta opção só é usada ao exportar arquivo `.html`.

## Argumentos ebook-convert

Se houver recursos do `ebook-convert` que você deseja usar e que não têm equivalentes nas opções YAML descritas acima, você ainda pode usá-los passando `args` personalizados. Por exemplo:

```yaml
---
ebook:
  title: Meu eBook
  args: ["--embed-all-fonts", "--embed-font-family"]
---

```

Você pode encontrar uma lista de argumentos no [manual do ebook-convert](https://manual.calibre-ebook.com/generated/en/ebook-convert.html).

## Exportar ao salvar

Adicione o front-matter como abaixo:

```yaml
---
export_on_save:
  ebook: true
  // ou
  ebook: "epub"
  ebook: "pdf"
  ebook: "mobi"
  ebook: "html"
  ebook: ["pdf", ...]
---
```

Assim os ebooks serão gerados toda vez que você salvar seu arquivo Markdown.

## Problemas & Limitações Conhecidos

- A geração de eBook ainda está em desenvolvimento.
- Todos os gráficos SVG gerados por `mermaid`, `PlantUML`, etc., não funcionarão no ebook gerado. Apenas `viz` funciona.
- Apenas **KaTeX** pode ser usado para Composição Tipográfica Matemática.  
  E o arquivo ebook gerado não renderiza expressões matemáticas corretamente no **iBook**.
- A geração de **PDF** e **Mobi** apresenta bugs.
- **Code Chunk** não funciona com a geração de eBook.
