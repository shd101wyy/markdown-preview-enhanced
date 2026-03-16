# Éditeur de présentations

![screen shot 2017-07-14 at 12 33 14 pm](https://user-images.githubusercontent.com/1908863/28223480-2c61461c-6891-11e7-9389-5adec0588c32.png)

Markdown Preview Enhanced utilise [reveal.js](https://github.com/hakimel/reveal.js) pour rendre de belles présentations.

[Cliquez ici](https://rawgit.com/shd101wyy/markdown-preview-enhanced/master/docs/presentation-intro.html) pour voir l'introduction (**Recommandé**).

![presentation](https://user-images.githubusercontent.com/1908863/28202176-caf103c4-6839-11e7-8776-942679f3698b.gif)

## Front-Matter de présentation

Vous pouvez configurer votre présentation en ajoutant un front-matter à votre fichier Markdown.  
Vous devez écrire vos paramètres sous la section `presentation`.  
Par exemple :

```markdown
---
presentation:
  width: 800
  height: 600
---

<!-- slide -->

Vos diapositives ici...
```

La présentation ci-dessus aura une taille de `800x600`

### Paramètres

```yaml
---
presentation:
  # thème de la présentation
  # === thèmes disponibles ===
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

  # La taille "normale" de la présentation, le ratio d'aspect sera préservé
  # lorsque la présentation est mise à l'échelle pour différentes résolutions. Peut être
  # spécifié en unités de pourcentage.
  width: 960
  height: 700

  # Facteur de la taille d'affichage devant rester vide autour du contenu
  margin: 0.1

  # Limites pour la plus petite/grande échelle possible à appliquer au contenu
  minScale: 0.2
  maxScale: 1.5

  # Afficher les contrôles dans le coin inférieur droit
  controls: true

  # Afficher une barre de progression de la présentation
  progress: true

  # Afficher le numéro de page de la diapositive actuelle
  slideNumber: false

  # Pousser chaque changement de diapositive dans l'historique du navigateur
  history: false

  # Activer les raccourcis clavier pour la navigation
  keyboard: true

  # Activer le mode de vue d'ensemble des diapositives
  overview: true

  # Centrage vertical des diapositives
  center: true

  # Active la navigation tactile sur les appareils avec entrée tactile
  touch: true

  # Mettre en boucle la présentation
  loop: false

  # Changer la direction de la présentation en RTL
  rtl: false

  # Randomise l'ordre des diapositives à chaque chargement de la présentation
  shuffle: false

  # Active/désactive les fragments globalement
  fragments: true

  # Indique si la présentation fonctionne en mode intégré,
  # c'est-à-dire dans une portion limitée de l'écran
  embedded: false

  # Indique si une aide contextuelle doit être affichée lorsque la touche
  # point d'interrogation est pressée
  help: true

  # Indique si les notes du conférencier doivent être visibles par tous
  showNotes: false

  # Nombre de millisecondes entre le passage automatique à la
  # diapositive suivante, désactivé lorsque défini à 0, cette valeur peut être écrasée
  # en utilisant un attribut data-autoslide sur vos diapositives
  autoSlide: 0

  # Arrêter le défilement automatique après une saisie utilisateur
  autoSlideStoppable: true

  # Activer la navigation par diapositives via la molette de la souris
  mouseWheel: false

  # Masque la barre d'adresse sur les appareils mobiles
  hideAddressBar: true

  # Ouvre les liens dans un aperçu iframe
  previewLinks: false

  # Style de transition
  transition: 'default' # none/fade/slide/convex/concave/zoom

  # Vitesse de transition
  transitionSpeed: 'default' # default/fast/slow

  # Style de transition pour les arrière-plans de diapositives plein écran
  backgroundTransition: 'default' # none/fade/slide/convex/concave/zoom

  # Nombre de diapositives à partir de la position actuelle qui sont visibles
  viewDistance: 3

  # Image d'arrière-plan parallaxe
  parallaxBackgroundImage: '' # ex. "'https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg'"

  # Taille de l'arrière-plan parallaxe
  parallaxBackgroundSize: '' # Syntaxe CSS, ex. "2100px 900px"

  # Nombre de pixels pour déplacer l'arrière-plan parallaxe par diapositive
  # - Calculé automatiquement sauf si spécifié
  # - Définir à 0 pour désactiver le mouvement sur un axe
  parallaxBackgroundHorizontal: null
  parallaxBackgroundVertical: null

  # Image d'arrière-plan parallaxe
  parallaxBackgroundImage: '' # ex. "https://s3.amazonaws.com/hakim-static/reveal-js/reveal-parallax-1.jpg"

  # Taille de l'arrière-plan parallaxe
  parallaxBackgroundSize: '' # Syntaxe CSS, ex. "2100px 900px" - seuls les pixels sont actuellement pris en charge (n'utilisez pas % ou auto)

  # Nombre de pixels pour déplacer l'arrière-plan parallaxe par diapositive
  # - Calculé automatiquement sauf si spécifié
  # - Définir à 0 pour désactiver le mouvement sur un axe
  parallaxBackgroundHorizontal: 200
  parallaxBackgroundVertical: 50

  # Activer les notes du conférencier
  enableSpeakerNotes: false
---
```

## Personnaliser le style des diapositives

Vous pouvez ajouter un `id` et une `class` à une diapositive spécifique comme ceci :

```markdown
<!-- slide id="my-id" class="my-class1 my-class2" -->
```

Ou si vous souhaitez uniquement personnaliser la `nième` diapositive, modifiez votre fichier `less` comme ceci :

```less
.markdown-preview.markdown-preview {
  // style de présentation personnalisé
  .reveal .slides {
    // modifier toutes les diapositives
  }

  .slides > section:nth-child(1) {
    // ceci modifiera `la première diapositive`
  }
}
```

[➔ Pandoc](pandoc.md)
