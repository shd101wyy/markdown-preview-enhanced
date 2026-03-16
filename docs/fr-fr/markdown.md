# Enregistrer en Markdown

**Markdown Preview Enhanced** prend en charge la compilation en **GitHub Flavored Markdown** afin que le fichier markdown exporté inclue tous les graphiques (en tant qu'images png), les blocs de code (masqués et incluant uniquement les résultats), les compositions mathématiques (affichées sous forme d'image), etc. et puisse être publié sur GitHub.

## Utilisation

Cliquez avec le bouton droit sur l'aperçu, puis choisissez `Save as Markdown`.

## Configurations

Vous pouvez configurer le répertoire des images et le chemin de sortie via le front-matter

```yaml
---
markdown:
  image_dir: /assets
  path: output.md
  ignore_from_front_matter: true
  absolute_image_path: false
---

```

**image_dir** `optionnel`  
Spécifie l'emplacement où vous souhaitez enregistrer les images générées. Par exemple, `/assets` signifie que toutes les images seront enregistrées dans le répertoire `assets` sous le dossier du projet. Si **image_dir** n'est pas fourni, le `Image folder path` dans les paramètres du paquet sera utilisé. La valeur par défaut est `/assets`.

**path** `optionnel`  
Spécifie l'emplacement où vous souhaitez générer votre fichier markdown. Si **path** n'est pas spécifié, `filename_.md` sera utilisé comme destination.

**ignore_from_front_matter** `optionnel`  
Si défini sur `false`, alors le champ `markdown` sera inclus dans le front-matter.

**absolute_image_path** `optionnel`  
Détermine s'il faut utiliser un chemin d'image absolu ou relatif.

## Exporter à la sauvegarde

Ajoutez le front-matter comme ci-dessous :

```yaml
---
export_on_save:
  markdown: true
---

```

Ainsi, le fichier markdown sera généré à chaque fois que vous sauvegardez votre fichier source Markdown.

## Problèmes connus

- `WaveDrom` ne fonctionne pas encore.
- L'affichage des compositions mathématiques peut être incorrect.
- Ne fonctionne pas encore avec le bloc de code `latex`.
