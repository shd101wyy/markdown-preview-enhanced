# Perguntas Frequentes (FAQ)

1. **Não consigo encontrar este pacote no atom?**  
   Por favor, pesquise pelo nome completo do pacote. `markdown-preview-enhanced`

2. **Exportei um arquivo HTML e quero implantá-lo no meu servidor remoto. Mas a composição matemática (MathJax ou KaTeX) não funciona. O que devo fazer?**  
   Certifique-se de ter marcado `Use CDN hosted resources` ao exportar.
3. **Exportei um arquivo HTML de apresentação e quero colocá-lo no meu GitHub Page ou implantá-lo remotamente?**  
   Por favor, consulte a pergunta anterior.
4. **Como obtenho uma visualização em estilo escuro?**  
   Se você quiser que o estilo da visualização seja consistente com o seu editor atom, vá para as configurações deste pacote e altere o `Preview Theme`.  
   Ou você pode executar o comando `Markdown Preview Enhanced: Customize Css`, depois modificar o arquivo `style.less`. [#68](https://github.com/shd101wyy/markdown-preview-enhanced/issues/68), [#89](https://github.com/shd101wyy/markdown-preview-enhanced/issues/89).
5. **A visualização está muito lenta?**  
   Isso pode acontecer quando seu arquivo Markdown é muito grande, ou você está escrevendo muitas fórmulas matemáticas ou gráficos.  
   Portanto, recomendo desativar a funcionalidade `Live Update`.  
   Você pode executar `Markdown Preview Enhanced: Toggle Live Update` para desativá-la.
6. **O atalho de teclado não funciona?**  
   <kbd>cmd-shift-p</kbd> e escolha `Key Binding Resolver: Toggle`. Verifique se há conflitos de teclas de atalho, ou publique uma issue no GitHub.
