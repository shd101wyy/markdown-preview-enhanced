# Matemática

**Markdown Preview Enhanced** usa [KaTeX](https://github.com/Khan/KaTeX) ou [MathJax](https://github.com/mathjax/MathJax) para renderizar expressões matemáticas.

KaTeX é mais rápido que MathJax, mas carece de muitos recursos que MathJax possui. Você pode verificar as [funções/símbolos suportados pelo KaTeX](https://khan.github.io/KaTeX/function-support.html).

Por padrão:

- Expressões dentro de `$...$` ou `\(...\)` serão renderizadas inline.
- Expressões dentro de `$$...$$` ou `\[...\]` ou <code>```math</code> serão renderizadas em bloco.

![](https://cloud.githubusercontent.com/assets/1908863/14398210/0e408954-fda8-11e5-9eb4-562d7c0ca431.gif)

Você pode escolher o método de renderização matemática e alterar os delimitadores matemáticos no [painel de configurações do pacote](usages.md?id=package-settings).

Você também pode modificar a configuração do MathJax pressionando <kbd>cmd-shift-p</kbd> e escolhendo o comando `Markdown Preview Enhanced: Open Mathjax config`.

[➔ Diagramas](diagrams.md)
