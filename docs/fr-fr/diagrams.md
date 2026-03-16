# Diagrammes

**Markdown Preview Enhanced** prend en charge le rendu des `organigrammes`, `diagrammes de séquence`, `mermaid`, `PlantUML`, `WaveDrom`, `GraphViz`, `Vega & Vega-lite`, `Ditaa`.
Vous pouvez également rendre `TikZ`, `Python Matplotlib`, `Plotly` et toutes sortes d'autres graphiques et diagrammes en utilisant [Code Chunk](code-chunk.md).

> Veuillez noter que certains diagrammes ne fonctionnent pas bien avec les exportations de fichiers comme PDF, pandoc, etc.

## Mermaid

Markdown Preview Enhanced utilise [mermaid](https://github.com/knsv/mermaid) pour rendre les organigrammes et les diagrammes de séquence.

- Les blocs de code avec la notation `mermaid` seront rendus par [mermaid](https://github.com/knsv/mermaid).
- Consultez la [documentation mermaid](https://mermaid-js.github.io/mermaid) pour plus d'informations sur la création d'organigrammes et de diagrammes de séquence
  ![screen shot 2017-06-05 at 8 04 58 pm](https://cloud.githubusercontent.com/assets/1908863/26809423/42afb410-4a2a-11e7-8a18-57e7c67caa9f.png)

Trois thèmes mermaid sont fournis, et vous pouvez choisir un thème depuis les [paramètres du paquet](usages.md?id=package-settings) :

- `mermaid.css`
- `mermaid.dark.css`
- `mermaid.forest.css`
  ![screen shot 2017-06-05 at 8 47 00 pm](https://cloud.githubusercontent.com/assets/1908863/26810274/555562d0-4a30-11e7-91ca-98742d6afbd5.png)

Vous pouvez également modifier la configuration d'initialisation de mermaid en exécutant la commande `Markdown Preview Enhanced: Open Mermaid Config`.

De plus, vous pouvez enregistrer des logos d'icônes dans head.html (ouvert via la commande `Markdown Preview Enhanced: Customize Preview Html Head`) comme suit :

```html
<script type="text/javascript">
  const configureMermaidIconPacks = () => {
    window["mermaid"].registerIconPacks([
      {
        name: "logos",
        loader: () =>
          fetch("https://unpkg.com/@iconify-json/logos/icons.json").then(
            (res) => res.json()
          ),
      },
    ]);
  };

  if (document.readyState !== 'loading') {
    configureMermaidIconPacks();
  } else {
    document.addEventListener("DOMContentLoaded", () => {
      configureMermaidIconPacks();
    });
  }
</script>
```

## PlantUML

Markdown Preview Enhanced utilise [PlantUML](https://plantuml.com/) pour créer différents types de graphiques. (**Java** doit être installé)

- Vous pouvez installer [Graphviz](https://www.graphviz.org/) (non obligatoire) pour générer tous les types de diagrammes.
- Les blocs de code avec la notation `puml` ou `plantuml` seront rendus par [PlantUML](https://plantuml.com/).

![screen shot 2017-06-05 at 8 05 55 pm](https://cloud.githubusercontent.com/assets/1908863/26809436/65414084-4a2a-11e7-91ee-7b03b0496513.png)

Si `@start...` n'est pas trouvé, alors `@startuml ... @enduml` sera automatiquement inséré.

## WaveDrom

Markdown Preview Enhanced utilise [WaveDrom](https://wavedrom.com/) pour créer des diagrammes de timing numériques.

- Les blocs de code avec la notation `wavedrom` seront rendus par [WaveDrom](https://github.com/drom/wavedrom).

![screen shot 2017-06-05 at 8 07 30 pm](https://cloud.githubusercontent.com/assets/1908863/26809462/9dc3eb96-4a2a-11e7-90e7-ad6bcb8dbdb1.png)

Les diagrammes [Bitfield](https://github.com/wavedrom/bitfield) sont également pris en charge. Veuillez utiliser `bitfield` comme identifiant de langage.

## GraphViz

Markdown Preview Enhanced utilise [Viz.js](https://github.com/mdaines/viz.js) pour rendre les diagrammes en [langage dot](https://tinyurl.com/kjoouup).

- Les blocs de code avec la notation `viz` ou `dot` seront rendus par [Viz.js](https://github.com/mdaines/viz.js).
- Vous pouvez choisir différents moteurs en spécifiant `{engine="..."}`. Les moteurs `circo`, `dot`, `neato`, `osage` ou `twopi` sont pris en charge. Le moteur par défaut est `dot`.

![screen shot 2018-03-18 at 3 18 17 pm](https://user-images.githubusercontent.com/1908863/37570596-a565306e-2abf-11e8-8904-d73306f675ec.png)

## Vega et Vega-lite

Markdown Preview Enhanced prend en charge les diagrammes **statiques** [vega](https://vega.github.io/vega/) et [vega-lite](https://vega.github.io/vega-lite/).

- Les blocs de code avec la notation `vega` seront rendus par [vega](https://vega.github.io/vega/).
- Les blocs de code avec la notation `vega-lite` seront rendus par [vega-lite](https://vega.github.io/vega-lite/).
- Les entrées `JSON` et `YAML` sont toutes deux prises en charge.

![screen shot 2017-07-28 at 7 59 58 am](https://user-images.githubusercontent.com/1908863/28718265-d023e1c2-736a-11e7-8678-a29704f3a23c.png)

Vous pouvez également [@importer](file-imports.md) un fichier `JSON` ou `YAML` comme diagramme `vega`, par exemple :

```markdown
@import "your_vega_source.json" {as="vega"}
@import "your_vega_lite_source.json" {as="vega-lite"}
```

## Kroki

Markdown Preview Enhanced prend en charge [Kroki](https://kroki.io/), qui supporte différents types de diagrammes. Il suffit de définir `kroki=true` ou `kroki=DIAGRAM_TYPE` dans les attributs du bloc de code pour l'activer.

````markdown
```blockdiag {kroki=true}
blockdiag {
  Kroki -> generates -> "Block diagrams";
  Kroki -> is -> "very easy!";

  Kroki [color = "greenyellow"];
  "Block diagrams" [color = "pink"];
  "very easy!" [color = "orange"];
}
```

```javascript {kroki="wavedrom"}
{
  signal: [
    { name: "clk", wave: "p.....|..." },
    {
      name: "Data",
      wave: "x.345x|=.x",
      data: ["head", "body", "tail", "data"],
    },
    { name: "Request", wave: "0.1..0|1.0" },
    {},
    { name: "Acknowledge", wave: "1.....|01." },
  ]
}
```
````

---

Si vous ne souhaitez pas rendre les graphiques mais seulement afficher le bloc de code, vous pouvez ajouter `{code_block=true}` comme ci-dessous :

    ```mermaid {code_block=true}
    // votre code mermaid ici
    ```

---

Vous pouvez définir des attributs pour le conteneur du diagramme.
Par exemple :

    ```puml {align="center"}
    a->b
    ```

placera le diagramme puml au centre de l'aperçu.

---

Lorsque vous exportez votre fichier markdown en [GFM Markdown](markdown.md), les diagrammes seront enregistrés comme images png dans votre `imageFolderPath` défini dans les paramètres du paquet.
Vous pouvez contrôler le nom du fichier image exporté en déclarant `{filename="your_file_name.png"}`.

Par exemple :

    ```mermaid {filename="my_mermaid.png"}
    ...
    ```

[➔ TOC](toc.md)
