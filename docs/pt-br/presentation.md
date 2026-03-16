# Editor de Apresentações

![screen shot 2017-07-14 at 12 33 14 pm](https://user-images.githubusercontent.com/1908863/28223480-2c61461c-6891-11e7-9389-5adec0588c32.png)

Markdown Preview Enhanced usa [reveal.js](https://github.com/hakimel/reveal.js) para renderizar apresentações bonitas.

[Clique aqui](https://rawgit.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.html) para ver a introdução (**Recomendado**).

![presentation](https://user-images.githubusercontent.com/1908863/28202176-caf103c4-6839-11e7-8776-942679f3698b.gif)

## Front-Matter da Apresentação

Você pode configurar sua apresentação adicionando front-matter ao seu arquivo Markdown.  
Você precisa escrever suas configurações na seção `presentation`.  
Por exemplo:

```markdown
---
presentation:
  width: 800
  height: 600
---

<!-- slide -->

Seus slides aqui...
```

A apresentação acima terá o tamanho `800x600`

### Configurações

```yaml
---
presentation:
  # tema da apresentação
  # === temas disponíveis ===
  # "beige.css"
  # "black.css"
  # "blood.css"
  # "league.css"
  # "moon.css"
  # "night.css"
  # "serif.css"
  # "simple.css"
  # "sky.css"
  # "solarized.css"
  # "white.css"
  # "none.css"
  theme: white.css

  # O tamanho "normal" da apresentação, a proporção será preservada
  # quando a apresentação for escalada para diferentes resoluções. Pode ser
  # especificado em unidades percentuais.
  width: 960
  height: 700

  # Fator do tamanho de exibição que deve permanecer vazio ao redor do conteúdo
  margin: 0.1

  # Limites para a menor/maior escala possível a ser aplicada ao conteúdo
  minScale: 0.2
  maxScale: 1.5

  # Exibir controles no canto inferior direito
  controls: true

  # Exibir uma barra de progresso da apresentação
  progress: true

  # Exibir o número de página do slide atual
  slideNumber: false

  # Enviar cada mudança de slide para o histórico do navegador
  history: false

  # Habilitar atalhos de teclado para navegação
  keyboard: true

  # Habilitar o modo de visão geral dos slides
  overview: true

  # Centralização vertical dos slides
  center: true

  # Habilitar navegação por toque em dispositivos com entrada touch
  touch: true

  # Fazer loop na apresentação
  loop: false

  # Alterar a direção da apresentação para RTL
  rtl: false

  # Aleatorizar a ordem dos slides cada vez que a apresentação carregar
  shuffle: false

  # Ativar/desativar fragmentos globalmente
  fragments: true

  # Indica se a apresentação está rodando em modo incorporado,
  # ou seja, contida em uma parte limitada da tela
  embedded: false

  # Indica se deve mostrar uma sobreposição de ajuda quando a tecla
  # de interrogação for pressionada
  help: true

  # Indica se as notas do palestrante devem ser visíveis para todos os espectadores
  showNotes: false

  # Número de milissegundos entre avanços automáticos para o
  # próximo slide, desabilitado quando definido como 0, este valor pode ser sobrescrito
  # usando um atributo data-autoslide nos seus slides
  autoSlide: 0

  # Parar o avanço automático após entrada do usuário
  autoSlideStoppable: true

  # Habilitar navegação por roda do mouse
  mouseWheel: false

  # Ocultar a barra de endereços em dispositivos móveis
  hideAddressBar: true

  # Abrir links em uma sobreposição de visualização iframe
  previewLinks: false

  # Estilo de transição
  transition: 'default' # none/fade/slide/convex/concave/zoom

  # Velocidade de transição
  transitionSpeed: 'default' # default/fast/slow

  # Estilo de transição para fundos de slides em tela cheia
  backgroundTransition: 'default' # none/fade/slide/convex/concave/zoom

  # Número de slides afastados do atual que são visíveis
  viewDistance: 3

  # Imagem de fundo paralaxe
  parallaxBackgroundImage: '' # ex: "'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg'"

  # Tamanho do fundo paralaxe
  parallaxBackgroundSize: '' # sintaxe CSS, ex: "2100px 900px"

  # Número de pixels para mover o fundo paralaxe por slide
  # - Calculado automaticamente, a menos que especificado
  # - Definir como 0 para desabilitar o movimento ao longo de um eixo
  parallaxBackgroundHorizontal: null
  parallaxBackgroundVertical: null

  # Imagem de fundo paralaxe
  parallaxBackgroundImage: '' # ex: "https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg"

  # Tamanho do fundo paralaxe
  parallaxBackgroundSize: '' # sintaxe CSS, ex: "2100px 900px" - atualmente apenas pixels são suportados (não use % ou auto)

  # Número de pixels para mover o fundo paralaxe por slide
  # - Calculado automaticamente, a menos que especificado
  # - Definir como 0 para desabilitar o movimento ao longo de um eixo
  parallaxBackgroundHorizontal: 200
  parallaxBackgroundVertical: 50

  # Habilitar Notas do Palestrante
  enableSpeakerNotes: false
---
```

## Personalizar Estilo do Slide

Você pode adicionar `id` e `class` a um slide específico assim:

```markdown
<!-- slide id="my-id" class="my-class1 my-class2" -->
```

Ou se você quiser personalizar apenas o `n-ésimo` slide, modifique seu arquivo `less` assim:

```less
.markdown-preview.markdown-preview {
  // estilo personalizado de apresentação
  .reveal .slides {
    // modificar todos os slides
  }

  .slides > section:nth-child(1) {
    // isso irá modificar `o primeiro slide`
  }
}
```

[➔ Pandoc](pandoc.md)
