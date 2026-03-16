# Code Chunk

**Wijzigingen kunnen in de toekomst optreden.**

**Markdown Preview Enhanced** stelt u in staat code-uitvoer in documenten te renderen.

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

> ⚠️ **Scriptuitvoering is standaard uitgeschakeld en moet expliciet worden ingeschakeld in de Atom-pakket- / VSCode-extensieinstellingen**
>
> Gebruik deze functie voorzichtig omdat het uw beveiliging in gevaar kan brengen!
> Uw computer kan worden gehackt als iemand u een markdown-bestand met kwaadaardige code laat openen terwijl scriptuitvoering is ingeschakeld.
>
> Optienaam: `enableScriptExecution`

## Opdrachten & Sneltoetsen

- `Markdown Preview Enhanced: Run Code Chunk` of <kbd>shift-enter</kbd>
  Voer een enkel codeblok uit waar uw cursor zich bevindt.
- `Markdown Preview Enhanced: Run All Code Chunks` of <kbd>ctrl-shift-enter</kbd>
  Voer alle codeblokken uit.

## Formaat

U kunt Code Chunk-opties configureren in het formaat <code>\`\`\`lang {cmd=your_cmd opt1=value1 opt2=value2 ...}</code>.
Wanneer een attribuutwaarde `true` is, kan het worden weggelaten (bijv. `{cmd hide}` is identiek aan `{cmd=true hide=true}`).

**lang**
De grammatica die het codeblok moet markeren.
Dit moet vooraan worden geplaatst.

## Basisopties

**cmd**
De uit te voeren opdracht.
Als `cmd` niet is opgegeven, wordt `lang` beschouwd als opdracht.

bijv.:

    ```python {cmd="/usr/local/bin/python3"}
    print("Dit zal het python3-programma uitvoeren")
    ```

**output**
`html`, `markdown`, `text`, `png`, `none`

Definieert hoe code-uitvoer wordt gerenderd.
`html` voegt uitvoer toe als html.
`markdown` parseert uitvoer als markdown. (MathJax en grafieken worden in dit geval niet ondersteund, maar KaTeX werkt wel)
`text` voegt uitvoer toe aan een `pre`-blok.
`png` voegt uitvoer toe als `base64`-afbeelding.
`none` verbergt de uitvoer.

bijv.:

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
Argumenten die aan de opdracht worden toegevoegd. bijv.:

    ```python {cmd=true args=["-v"]}
    print("Verbose wordt eerst afgedrukt")
    ```

    ```erd {cmd=true args=["-i", "$input_file", "-f", "svg"] output="html"}
      # uitvoer svg-formaat en toevoegen als html-resultaat.
    ```

**stdin**
Als `stdin` is ingesteld op true, wordt de code doorgegeven als stdin in plaats van als bestand.

**hide**
`hide` verbergt het codeblok maar laat alleen de uitvoer zichtbaar. standaard: `false`
bijv.:

    ```python {hide=true}
    print('u kunt dit uitvoerbericht zien, maar niet deze code')
    ```

**continue**
Als `continue=true` is ingesteld, gaat dit codeblok door vanuit het laatste codeblok.
Als `continue=id` is ingesteld, gaat dit codeblok door vanuit het codeblok met het opgegeven id.
bijv.:

    ```python {cmd=true id="izdlk700"}
    x = 1
    ```

    ```python {cmd=true id="izdlkdim"}
    x = 2
    ```

    ```python {cmd=true continue="izdlk700" id="izdlkhso"}
    print(x) # drukt 1 af
    ```

**class**
Als `class="class1 class2"` is ingesteld, worden `class1 class2` toegevoegd aan het codeblok.

- De klasse `line-numbers` toont regelnummers voor het codeblok.

**element**
Het element dat u wilt toevoegen na.
Zie het **Plotly**-voorbeeld hieronder.

**run_on_save** `boolean`
Voer het codeblok uit wanneer het markdown-bestand wordt opgeslagen. Standaard `false`.

**modify_source** `boolean`
Voeg de uitvoer van het codeblok direct in het markdown-bronbestand in. Standaard `false`.

**id**
De `id` van het codeblok. Deze optie is nuttig als `continue` wordt gebruikt.

## Macro

- **input_file**
  `input_file` wordt automatisch gegenereerd in dezelfde map als uw markdown-bestand en wordt verwijderd nadat de code die is gekopieerd naar `input_file` is uitgevoerd.
  Standaard wordt het toegevoegd aan het einde van de programmaargumenten.
  U kunt de positie van `input_file` in uw `args`-optie instellen met de macro `$input_file`. bijv.:

      ```program {cmd=true args=["-i", "$input_file", "-o", "./output.png"]}
      ...uw code hier
      ```

## Matplotlib

Als `matplotlib=true` is ingesteld, worden grafieken inline in de voorbeeldweergave weergegeven door het Python-codeblok.
bijv.:

    ```python {cmd=true matplotlib=true}
    import matplotlib.pyplot as plt
    plt.plot([1,2,3, 4])
    plt.show() # toon figuur
    ```

![screen shot 2017-07-28 at 7 12 50 am](https://user-images.githubusercontent.com/1908863/28716704-4009d43a-7364-11e7-9e46-889f961e5afd.png)

## LaTeX

Markdown Preview Enhanced ondersteunt ook `LaTeX`-compilatie.
Voordat u deze functie gebruikt, moet u [pdf2svg](extra.md?id=install-svg2pdf) en een [LaTeX-engine](extra.md?id=install-latex-distribution) hebben geïnstalleerd.
Vervolgens kunt u eenvoudig LaTeX in een codeblok schrijven zoals dit:

    ```latex {cmd=true}
    \documentclass{standalone}
    \begin{document}
      Hello world!
    \end{document}
    ```

![screen shot 2017-07-28 at 7 15 16 am](https://user-images.githubusercontent.com/1908863/28716762-8686d980-7364-11e7-9669-71138cb2e6e7.png)

### LaTeX-uitvoerconfiguratie

**latex_zoom**
Als `latex_zoom=num` is ingesteld, wordt het resultaat `num` keer vergroot.

**latex_width**
De breedte van het resultaat.

**latex_height**
De hoogte van het resultaat.

**latex_engine**
De latex-engine die wordt gebruikt om het `tex`-bestand te compileren. Standaard wordt `pdflatex` gebruikt.

### TikZ-voorbeeld

Het wordt aanbevolen `standalone` te gebruiken bij het tekenen van `tikz`-grafieken.
![screen shot 2017-07-14 at 11 27 56 am](https://user-images.githubusercontent.com/1908863/28221069-8113a5b0-6887-11e7-82fa-23dd68f2be82.png)

## Plotly

Markdown Preview Enhanced stelt u in staat om eenvoudig [Plotly](https://plot.ly/)-grafieken te tekenen.
Bijvoorbeeld:
![screen shot 2017-10-20 at 10 41 25 am](https://user-images.githubusercontent.com/1908863/31829580-526a0c06-b583-11e7-82f2-09ea7a0b9672.png)

- De eerste regel `@import "https://cdn.plot.ly/plotly-latest.min.js"` gebruikt de functionaliteit [bestandsimport](file-imports.md) om het bestand `plotly-latest.min.js` te importeren.
  Het wordt echter aanbevolen om het js-bestand naar de lokale schijf te downloaden voor betere prestaties.
- Vervolgens hebben we een `javascript`-codeblok aangemaakt.

## Demo

Deze demo laat zien hoe u een entiteitsrelatiediagram rendert met behulp van de bibliotheek [erd](https://github.com/BurntSushi/erd).

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

- `erd` het programma dat we gebruiken. (_u moet het programma eerst installeren_)
- `output="html"` we voegen het uitvoerresultaat toe als `html`.
- Het veld `args` toont de argumenten die we zullen gebruiken.

Vervolgens kunnen we op de knop `uitvoeren` in de voorbeeldweergave klikken om onze code uit te voeren.

![erd](https://user-images.githubusercontent.com/1908863/28221395-bcd0bd76-6888-11e7-8c6e-925e228d02cc.gif)

## Showcases (verouderd)

**bash**
![Screen Shot 2016-09-24 at 1.41.06 AM](https://i.imgur.com/v5Y7juh.png)

**gnuplot met svg-uitvoer**
![Screen Shot 2016-09-24 at 1.44.14 AM](https://i.imgur.com/S93g7Tk.png)

## Beperkingen

- Werkt nog niet met `ebook`.
- Kan fouten bevatten bij gebruik van `pandoc document export`.

[➔ Presentatie](presentation.md)
