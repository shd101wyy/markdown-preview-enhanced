# Exportation HTML

## Utilisation

Cliquez avec le bouton droit sur l'aperçu, cliquez sur l'onglet `HTML`.  
Puis choisissez :

- `HTML (offline)`
  Choisissez cette option si vous n'allez utiliser ce fichier html que localement.
- `HTML (cdn hosted)`
  Choisissez cette option si vous souhaitez déployer votre fichier html à distance.

![screen shot 2017-07-14 at 1 14 28 am](https://user-images.githubusercontent.com/1908863/28200455-d5a12d60-6831-11e7-8572-91d3845ce8cf.png)

## Configuration

Valeurs par défaut :

```yaml
---
html:
  embed_local_images: false
  embed_svg: true
  offline: false
  toc: undefined

print_background: false
---

```

Si `embed_local_images` est défini sur `true`, toutes les images locales seront intégrées au format `base64`.

Pour générer une TOC dans la barre latérale, vous devez activer [enableScriptExecution](https://shd101wyy.github.io/markdown-preview-enhanced/#/code-chunk?id=code-chunk) dans les paramètres MPE de vscode ou atom.

Si `toc` est défini sur `false`, la TOC de la barre latérale sera désactivée. Si `toc` est défini sur `true`, la TOC de la barre latérale sera activée et affichée. Si `toc` n'est pas spécifié, la TOC de la barre latérale sera activée, mais pas affichée.

## Exporter à la sauvegarde

Ajoutez le front-matter comme ci-dessous :

```yaml
---
export_on_save:
  html: true
---

```

Ainsi, le fichier html sera généré à chaque fois que vous sauvegardez votre fichier Markdown.
