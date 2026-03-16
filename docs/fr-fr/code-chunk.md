# Code Chunk

**Des modifications pourraient survenir à l'avenir.**

**Markdown Preview Enhanced** vous permet de rendre la sortie de code dans les documents.

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

> ⚠️ **L'exécution de scripts est désactivée par défaut et doit être explicitement activée dans les préférences du paquet Atom / de l'extension VSCode**
>
> Veuillez utiliser cette fonctionnalité avec précaution car elle peut mettre votre sécurité en danger !
> Votre machine peut être piratée si quelqu'un vous fait ouvrir un fichier Markdown avec du code malveillant alors que l'exécution de scripts est activée.
>
> Nom de l'option : `enableScriptExecution`

## Commandes et raccourcis clavier

- `Markdown Preview Enhanced: Run Code Chunk` ou <kbd>shift-enter</kbd>
  exécuter le bloc de code là où se trouve votre curseur.
- `Markdown Preview Enhanced: Run All Code Chunks` ou <kbd>ctrl-shift-enter</kbd>
  exécuter tous les blocs de code.

## Format

Vous pouvez configurer les options du Code Chunk au format <code>\`\`\`lang {cmd=your_cmd opt1=value1 opt2=value2 ...}</code>.
Lorsque la valeur d'un attribut est `true`, elle peut être omise (par exemple, `{cmd hide}` est identique à `{cmd=true hide=true}`).

**lang**
La grammaire que le bloc de code doit mettre en surbrillance.
Il doit être placé en premier.

## Options de base

**cmd**
La commande à exécuter.
Si `cmd` n'est pas fourni, alors `lang` sera considéré comme la commande.

par exemple :

    ```python {cmd="/usr/local/bin/python3"}
    print("This will run python3 program")
    ```

**output**
`html`, `markdown`, `text`, `png`, `none`

Définit comment rendre la sortie du code.
`html` ajoutera la sortie comme html.
`markdown` analysera la sortie comme du markdown. (MathJax et les graphiques ne seront pas pris en charge dans ce cas, mais KaTeX fonctionne)
`text` ajoutera la sortie à un bloc `pre`.
`png` ajoutera la sortie comme image `base64`.
`none` masquera la sortie.

par exemple :

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
arguments ajoutés à la commande. par exemple :

    ```python {cmd=true args=["-v"]}
    print("Verbose will be printed first")
    ```

    ```erd {cmd=true args=["-i", "$input_file", "-f", "svg"] output="html"}
      # output svg format and append as html result.
    ```

**stdin**
Si `stdin` est défini sur true, alors le code sera transmis en tant qu'entrée standard au lieu d'un fichier.

**hide**
`hide` masquera le bloc de code mais ne laissera visible que la sortie. Par défaut : `false`
par exemple :

    ```python {hide=true}
    print('you can see this output message, but not this code')
    ```

**continue**
Si `continue=true` est défini, ce bloc de code continuera à partir du dernier bloc de code.
Si `continue=id` est défini, ce bloc de code continuera à partir du bloc de code avec cet id.
par exemple :

    ```python {cmd=true id="izdlk700"}
    x = 1
    ```

    ```python {cmd=true id="izdlkdim"}
    x = 2
    ```

    ```python {cmd=true continue="izdlk700" id="izdlkhso"}
    print(x) # will print 1
    ```

**class**
Si `class="class1 class2"` est défini, alors `class1 class2` sera ajouté au bloc de code.

- La classe `line-numbers` affichera les numéros de ligne du bloc de code.

**element**
L'élément que vous souhaitez ajouter après.
Consultez l'exemple **Plotly** ci-dessous.

**run_on_save** `boolean`
Exécuter le bloc de code lorsque le fichier markdown est sauvegardé. Par défaut `false`.

**modify_source** `boolean`
Insérer la sortie du bloc de code directement dans le fichier source markdown. Par défaut `false`.

**id**
L'`id` du bloc de code. Cette option est utile si `continue` est utilisé.

## Macro

- **input_file**
  `input_file` est automatiquement généré dans le même répertoire que votre fichier markdown et sera supprimé après l'exécution du code qui y est copié.
  Par défaut, il est ajouté à la toute fin des arguments du programme.
  Cependant, vous pouvez définir la position de `input_file` dans votre option `args` avec la macro `$input_file`. par exemple :

      ```program {cmd=true args=["-i", "$input_file", "-o", "./output.png"]}
      ...your code here
      ```

## Matplotlib

Si `matplotlib=true` est défini, le bloc de code Python tracera des graphiques en ligne dans l'aperçu.
par exemple :

    ```python {cmd=true matplotlib=true}
    import matplotlib.pyplot as plt
    plt.plot([1,2,3, 4])
    plt.show() # show figure
    ```

![screen shot 2017-07-28 at 7 12 50 am](https://user-images.githubusercontent.com/1908863/28716704-4009d43a-7364-11e7-9e46-889f961e5afd.png)

## LaTeX

Markdown Preview Enhanced prend également en charge la compilation `LaTeX`.
Avant d'utiliser cette fonctionnalité, vous devez avoir [pdf2svg](extra.md?id=install-svg2pdf) et [un moteur LaTeX](extra.md?id=install-latex-distribution) installés.
Vous pouvez ensuite simplement écrire du LaTeX dans un bloc de code comme ceci :

    ```latex {cmd=true}
    \documentclass{standalone}
    \begin{document}
      Hello world!
    \end{document}
    ```

![screen shot 2017-07-28 at 7 15 16 am](https://user-images.githubusercontent.com/1908863/28716762-8686d980-7364-11e7-9669-71138cb2e6e7.png)

### Configuration de la sortie LaTeX

**latex_zoom**
Si `latex_zoom=num` est défini, le résultat sera mis à l'échelle `num` fois.

**latex_width**
La largeur du résultat.

**latex_height**
La hauteur du résultat.

**latex_engine**
Le moteur latex utilisé pour compiler le fichier `tex`. Par défaut, `pdflatex` est utilisé.

### Exemple TikZ

Il est recommandé d'utiliser `standalone` lors du dessin de graphiques `tikz`.
![screen shot 2017-07-14 at 11 27 56 am](https://user-images.githubusercontent.com/1908863/28221069-8113a5b0-6887-11e7-82fa-23dd68f2be82.png)

## Plotly

Markdown Preview Enhanced vous permet de dessiner [Plotly](https://plot.ly/) facilement.
Par exemple :
![screen shot 2017-10-20 at 10 41 25 am](https://user-images.githubusercontent.com/1908863/31829580-526a0c06-b583-11e7-82f2-09ea7a0b9672.png)

- La première ligne `@import "https://cdn.plot.ly/plotly-latest.min.js"` utilise la fonctionnalité [d'importation de fichiers](file-imports.md) pour importer le fichier `plotly-latest.min.js`.
  Il est cependant recommandé de télécharger le fichier js sur le disque local pour de meilleures performances.
- Ensuite, nous créons un bloc de code `javascript`.

## Démonstration

Cette démonstration vous montre comment rendre un diagramme entité-relation en utilisant la bibliothèque [erd](https://github.com/BurntSushi/erd).

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

- `erd` est le programme que nous utilisons. (_vous devez d'abord avoir le programme installé_)
- `output="html"` nous ajouterons le résultat d'exécution en tant que `html`.
- Le champ `args` montre les arguments que nous allons utiliser.

Nous pouvons ensuite cliquer sur le bouton `run` dans l'aperçu pour exécuter notre code.

![erd](https://user-images.githubusercontent.com/1908863/28221395-bcd0bd76-6888-11e7-8c6e-925e228d02cc.gif)

## Démonstrations (obsolètes)

**bash**
![Screen Shot 2016-09-24 at 1.41.06 AM](https://i.imgur.com/v5Y7juh.png)

**gnuplot avec sortie svg**
![Screen Shot 2016-09-24 at 1.44.14 AM](https://i.imgur.com/S93g7Tk.png)

## Limitations

- Ne fonctionne pas encore avec `ebook`.
- Peut être instable lors de l'utilisation de l'exportation de documents `pandoc`.

[➔ Présentation](presentation.md)
