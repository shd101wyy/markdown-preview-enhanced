# Code Chunk

**Alterações podem ocorrer no futuro.**

**Markdown Preview Enhanced** permite renderizar a saída de código em documentos.

    ```bash {cmd}
    ls .
    ```

    ```bash {cmd=true}
    ls .
    ```

    ```javascript {cmd="node"}
    const date = Date.now()
    console.log(date.toString())
    ```

> ⚠️ **A execução de scripts está desativada por padrão e precisa ser explicitamente habilitada nas preferências do pacote Atom / extensão VSCode**
>
> Por favor, use esse recurso com cuidado, pois ele pode colocar sua segurança em risco!
> Sua máquina pode ser comprometida se alguém fizer você abrir um markdown com código malicioso enquanto a execução de scripts estiver habilitada.
>
> Nome da opção: `enableScriptExecution`

## Comandos & Atalhos de Teclado

- `Markdown Preview Enhanced: Run Code Chunk` ou <kbd>shift-enter</kbd>
  Executa o code chunk único onde seu cursor está posicionado.
- `Markdown Preview Enhanced: Run All Code Chunks` ou <kbd>ctrl-shift-enter</kbd>
  Executa todos os code chunks.

## Formato

Você pode configurar as opções do code chunk no formato <code>\`\`\`lang {cmd=your_cmd opt1=value1 opt2=value2 ...}</code>.
Quando o valor de um atributo é `true`, ele pode ser omitido (por exemplo, `{cmd hide}` é idêntico a `{cmd=true hide=true}`).

**lang**
A gramática que o bloco de código deve destacar.
Deve ser colocado na frente de tudo.

## Opções Básicas

**cmd**
O comando a ser executado.
Se `cmd` não for fornecido, então `lang` será considerado como o comando.

por exemplo:

    ```python {cmd="/usr/local/bin/python3"}
    print("Isso executará o programa python3")
    ```

**output**
`html`, `markdown`, `text`, `png`, `none`

Define como renderizar a saída do código.
`html` irá acrescentar a saída como HTML.
`markdown` irá analisar a saída como Markdown. (MathJax e gráficos não serão suportados neste caso, mas KaTeX funciona)
`text` irá acrescentar a saída em um bloco `pre`.
`png` irá acrescentar a saída como imagem `base64`.
`none` irá ocultar a saída.

por exemplo:

    ```gnuplot {cmd=true output="html"}
    set terminal svg
    set title "Simple Plots" font ",20"
    set key left box
    set samples 50
    set style data points

    plot [-10:10] sin(x),atan(x),cos(atan(x))
    ```

![screen shot 2017-07-28 at 7 14 24 am](https://user-images.githubusercontent.com/1908863/28716734-66142a5e-7364-11e7-83dc-a66df61971dc.png)

**args**
Argumentos que são acrescentados ao comando. por exemplo:

    ```python {cmd=true args=["-v"]}
    print("Verbose será impresso primeiro")
    ```

    ```erd {cmd=true args=["-i", "$input_file", "-f", "svg"] output="html"}
      # saída em formato svg e acrescentar como resultado html.
    ```

**stdin**
Se `stdin` for definido como true, então o código será passado como stdin em vez de como arquivo.

**hide**
`hide` irá ocultar o code chunk, mas deixar apenas a saída visível. padrão: `false`
por exemplo:

    ```python {hide=true}
    print('você pode ver esta mensagem de saída, mas não este código')
    ```

**continue**
Se definir `continue=true`, então este code chunk continuará a partir do último code chunk.
Se definir `continue=id`, então este code chunk continuará a partir do code chunk com o id fornecido.
por exemplo:

    ```python {cmd=true id="izdlk700"}
    x = 1
    ```

    ```python {cmd=true id="izdlkdim"}
    x = 2
    ```

    ```python {cmd=true continue="izdlk700" id="izdlkhso"}
    print(x) # imprimirá 1
    ```

**class**
Se definir `class="class1 class2"`, então `class1 class2` será adicionado ao code chunk.

- A classe `line-numbers` exibirá números de linha no code chunk.

**element**
O elemento que você quer acrescentar depois.
Veja o exemplo do **Plotly** abaixo.

**run_on_save** `boolean`
Executar o code chunk quando o arquivo Markdown for salvo. Padrão: `false`.

**modify_source** `boolean`
Inserir a saída do code chunk diretamente no arquivo Markdown. Padrão: `false`.

**id**
O `id` do code chunk. Esta opção é útil quando `continue` é usado.

## Macro

- **input_file**
  `input_file` é gerado automaticamente no mesmo diretório do seu arquivo Markdown e será excluído após a execução do código que é copiado para `input_file`.
  Por padrão, é acrescentado no final dos argumentos do programa.
  No entanto, você pode definir a posição do `input_file` na sua opção `args` usando a macro `$input_file`. por exemplo:

      ```program {cmd=true args=["-i", "$input_file", "-o", "./output.png"]}
      ...seu código aqui
      ```

## Matplotlib

Se definir `matplotlib=true`, então o code chunk python irá plotar gráficos inline na visualização.
por exemplo:

    ```python {cmd=true matplotlib=true}
    import matplotlib.pyplot as plt
    plt.plot([1,2,3, 4])
    plt.show() # mostrar figura
    ```

![screen shot 2017-07-28 at 7 12 50 am](https://user-images.githubusercontent.com/1908863/28716704-4009d43a-7364-11e7-9e46-889f961e5afd.png)

## LaTeX

Markdown Preview Enhanced também suporta compilação `LaTeX`.
Antes de usar esse recurso, você precisa ter o [pdf2svg](extra.md?id=install-svg2pdf) e o [mecanismo LaTeX](extra.md?id=install-latex-distribution) instalados.
Então você pode simplesmente escrever LaTeX no code chunk assim:

    ```latex {cmd=true}
    \documentclass{standalone}
    \begin{document}
      Hello world!
    \end{document}
    ```

![screen shot 2017-07-28 at 7 15 16 am](https://user-images.githubusercontent.com/1908863/28716762-8686d980-7364-11e7-9669-71138cb2e6e7.png)

### Configuração de saída LaTeX

**latex_zoom**
Se definir `latex_zoom=num`, então o resultado será escalado `num` vezes.

**latex_width**
A largura do resultado.

**latex_height**
A altura do resultado.

**latex_engine**
O mecanismo latex usado para compilar o arquivo `tex`. Por padrão, `pdflatex` é utilizado.

### Exemplo TikZ

Recomenda-se usar `standalone` ao desenhar gráficos `tikz`.
![screen shot 2017-07-14 at 11 27 56 am](https://user-images.githubusercontent.com/1908863/28221069-8113a5b0-6887-11e7-82fa-23dd68f2be82.png)

## Plotly

Markdown Preview Enhanced permite que você desenhe [Plotly](https://plot.ly/) facilmente.
Por exemplo:
![screen shot 2017-10-20 at 10 41 25 am](https://user-images.githubusercontent.com/1908863/31829580-526a0c06-b583-11e7-82f2-09ea7a0b9672.png)

- A primeira linha `@import "https://cdn.plot.ly/plotly-latest.min.js"` usa a funcionalidade de [importação de arquivo](file-imports.md) para importar o arquivo `plotly-latest.min.js`.
  No entanto, recomenda-se baixar o arquivo js para o disco local para melhor desempenho.
- Em seguida, criamos um code chunk `javascript`.

## Demonstração

Esta demonstração mostra como renderizar um diagrama entidade-relação usando a biblioteca [erd](https://github.com/BurntSushi/erd).

    ```erd {cmd=true output="html" args=["-i", "$input_file" "-f", "svg"]}

    [Person]
    *name
    height
    weight
    +birth_location_id

    [Location]
    *id
    city
    state
    country

    Person *--1 Location
    ```

`erd {cmd=true output="html" args=["-i", "$input_file", "-f", "svg"]}`

- `erd` é o programa que estamos usando. (_você precisa ter o programa instalado primeiro_)
- `output="html"` irá acrescentar o resultado da execução como `html`.
- O campo `args` mostra os argumentos que serão usados.

Então podemos clicar no botão `run` na visualização para executar nosso código.

![erd](https://user-images.githubusercontent.com/1908863/28221395-bcd0bd76-6888-11e7-8c6e-925e228d02cc.gif)

## Demonstrações (desatualizado)

**bash**
![Screen Shot 2016-09-24 at 1.41.06 AM](https://i.imgur.com/v5Y7juh.png)

**gnuplot com saída svg**
![Screen Shot 2016-09-24 at 1.44.14 AM](https://i.imgur.com/S93g7Tk.png)

## Limitações

- Ainda não funciona com `ebook`.
- Pode apresentar bugs ao usar `exportação de documento pandoc`

[➔ Apresentação](presentation.md)
