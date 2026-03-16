# Opslaan als Markdown

**Markdown Preview Enhanced** ondersteunt compilatie naar **GitHub Flavored Markdown** zodat het geëxporteerde markdown-bestand alle grafieken (als png-afbeeldingen), codeblokken (verborgen en alleen resultaten opgenomen), wiskundige opmaak (weergegeven als afbeelding) enz. bevat en op GitHub kan worden gepubliceerd.

## Gebruik

Klik met de rechtermuisknop op de voorbeeldweergave en kies vervolgens `Save as Markdown`.

## Configuraties

U kunt de afbeeldingsmap en het uitvoerpad configureren via front-matter:

```yaml
---
markdown:
  image_dir: /assets
  path: output.md
  ignore_from_front_matter: true
  absolute_image_path: false
---

```

**image_dir** `optioneel`  
Geeft aan waar u gegenereerde afbeeldingen wilt opslaan. Bijvoorbeeld `/assets` betekent dat alle afbeeldingen worden opgeslagen in de map `assets` onder de projectmap. Als **image_dir** niet is opgegeven, wordt het `Image folder path` in de pakketinstellingen gebruikt. Standaard is `/assets`.

**path** `optioneel`  
Geeft aan waar u uw markdown-bestand wilt uitvoeren. Als **path** niet is opgegeven, wordt `filename_.md` gebruikt als bestemming.

**ignore_from_front_matter** `optioneel`  
Als ingesteld op `false`, wordt het veld `markdown` opgenomen in de front-matter.

**absolute_image_path** `optioneel`  
Bepaalt of absoluut of relatief afbeeldingspad moet worden gebruikt.

## Exporteren bij opslaan

Voeg de front-matter toe zoals hieronder:

```yaml
---
export_on_save:
  markdown: true
---

```

Zodat het markdown-bestand wordt gegenereerd elke keer dat u uw markdown-bronbestand opslaat.

## Bekende problemen

- `WaveDrom` werkt nog niet.
- De weergave van wiskundige opmaak kan onjuist zijn.
- Werkt nog niet met het `latex`-codeblok.
