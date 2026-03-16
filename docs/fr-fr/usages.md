# Utilisation

## Commandes

Vous pouvez appuyer sur <kbd>cmd-shift-p</kbd> dans l'éditeur Atom pour ouvrir la <strong>Palette de commandes</strong>.

> La touche <kbd>cmd</kbd> sur _Windows_ correspond à <kbd>ctrl</kbd>.

_Source Markdown_

- <strong>Markdown Preview Enhanced: Toggle</strong>  
  <kbd>ctrl-shift-m</kbd>  
  Activer/Désactiver l'aperçu du fichier Markdown.

- <strong>Markdown Preview Enhanced: Toggle Zen Mode </strong>  
  Activer/Désactiver le mode d'écriture sans distraction.

- <strong>Markdown Preview Enhanced: Customize Css</strong>  
  Personnaliser le CSS de la page d'aperçu.  
  Voici un [tutoriel](customize-css.md) rapide.

- <strong>Markdown Preview Enhanced: Create Toc </strong>  
  Générer la TOC (l'aperçu doit être actif). [La documentation est ici](toc.md).

- <strong>Markdown Preview Enhanced: Toggle Scroll Sync </strong>  
  Activer/Désactiver la synchronisation du défilement pour l'aperçu.

- <strong>Markdown Preview Enhanced: Sync Source </strong>  
  <kbd>ctrl-shift-s</kbd>  
  Faire défiler l'aperçu pour correspondre à la position du curseur dans la source Markdown.

- <strong>Markdown Preview Enhanced: Toggle Live Update </strong>  
   Activer/Désactiver la mise à jour en direct de l'aperçu.  
   Si désactivé, l'aperçu ne sera rendu que lors de la sauvegarde du fichier.

- <strong>Markdown Preview Enhanced: Toggle Break On Single Newline </strong>  
  Activer/Désactiver le saut de ligne sur une seule nouvelle ligne.

- <strong>Markdown Preview Enhanced: Insert New Slide </strong>  
  Insérer une nouvelle diapositive et entrer en [mode présentation](presentation.md)

- <strong>Markdown Preview Enhanced: Insert Table </strong>  
  Insérer un tableau Markdown.

- <strong>Markdown Preview Enhanced: Insert Page Break </strong>  
  Insérer un saut de page.

- <strong> Markdown Preview Enhanced: Open Mermaid Config</strong>  
  Modifier la configuration d'initialisation de `mermaid`.

- <strong> Markdown Preview Enhanced: Open Mathjax Config </strong>  
   Modifier la configuration d'initialisation de `MathJax`.

- <strong>Markdown Preview Enhanced: Image Helper</strong>  
  Pour plus d'informations, consultez [cette documentation](image-helper.md).  
   L'aide aux images prend en charge l'insertion rapide d'URL d'images, le collage d'images et le téléchargement d'images via [imgur](https://imgur.com/) et [sm.ms](https://sm.ms/).  
  ![screen shot 2017-06-06 at 3 42 31 pm](https://user-images.githubusercontent.com/1908863/26850896-c43be8e2-4ace-11e7-802d-6a7b51bf3130.png)

- <strong>Markdown Preview Enhanced: Show Uploaded Images</strong>  
  Ouvrir `image_history.md` qui contient les informations de vos images téléversées.  
  Vous êtes libre de modifier le fichier `image_history.md`.

- <strong>Markdown Preview Enhanced: Run Code Chunk </strong>  
  <kbd>shift-enter</kbd>  
  Exécuter un seul [Code Chunk](code-chunk.md).

- <strong>Markdown Preview Enhanced: Run All Code Chunks </strong>  
  <kbd>ctrl-shift-enter</kbd>  
  Exécuter tous les [Code Chunks](code-chunk.md).

- <strong>Markdown Preview Enhanced: Extend Parser</strong>  
  [Étendre le parseur Markdown](extend-parser.md).

---

_Aperçu_

**Cliquez avec le bouton droit** sur l'aperçu pour ouvrir le menu contextuel :

![screen shot 2017-07-14 at 12 30 54 am](https://user-images.githubusercontent.com/1908863/28199502-b9ba39c6-682b-11e7-8bb9-89661100389e.png)

- <kbd>cmd-=</kbd> ou <kbd>cmd-shift-=</kbd>.  
  Zoom avant sur l'aperçu.

- <kbd>cmd--</kbd> ou <kbd>cmd-shift-\_</kbd>.  
  Zoom arrière sur l'aperçu.

- <kbd>cmd-0</kbd>  
  Réinitialiser le zoom.

- <kbd>cmd-shift-s</kbd>  
  Faire défiler l'éditeur Markdown pour correspondre à la position de l'aperçu.

- <kbd>esc</kbd>  
  Afficher/Masquer la TOC dans la barre latérale.

## Raccourcis clavier

| Raccourcis                                  | Fonctionnalité                      |
| ------------------------------------------- | ----------------------------------- |
| <kbd>ctrl-shift-m</kbd>                     | Activer/Désactiver l'aperçu         |
| <kbd>cmd-k v</kbd>                          | Ouvrir l'aperçu `VSCode uniquement` |
| <kbd>ctrl-shift-s</kbd>                     | Synchroniser l'aperçu / la source   |
| <kbd>shift-enter</kbd>                      | Exécuter Code Chunk                 |
| <kbd>ctrl-shift-enter</kbd>                 | Exécuter tous les Code Chunks       |
| <kbd>cmd-=</kbd> ou <kbd>cmd-shift-=</kbd>  | Zoom avant de l'aperçu              |
| <kbd>cmd--</kbd> ou <kbd>cmd-shift-\_</kbd> | Zoom arrière de l'aperçu            |
| <kbd>cmd-0</kbd>                            | Réinitialiser le zoom de l'aperçu   |
| <kbd>esc</kbd>                              | Afficher/Masquer la TOC latérale    |

## Paramètres du paquet

### Atom

Pour ouvrir les paramètres du paquet, appuyez sur <kbd>cmd-shift-p</kbd> puis choisissez `Settings View: Open`, ensuite cliquez sur `Packages`.

Recherchez `markdown-preview-enhanced` sous `Installed Packages` :  
![screen shot 2017-06-06 at 3 57 22 pm](https://user-images.githubusercontent.com/1908863/26851561-d6b1ca30-4ad0-11e7-96fd-6e436b5de45b.png)

Cliquez sur le bouton `Settings` :

![screen shot 2017-07-14 at 12 35 13 am](https://user-images.githubusercontent.com/1908863/28199574-50595dbc-682c-11e7-9d94-264e46387da8.png)

### VS Code

Exécutez la commande `Preferences: Open User Settings`, puis recherchez `markdown-preview-enhanced`.

![screen shot 2017-07-14 at 12 34 04 am](https://user-images.githubusercontent.com/1908863/28199551-2719acb8-682c-11e7-8163-e064ad8fe41c.png)
