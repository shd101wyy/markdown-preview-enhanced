# [Plus maintenu]

# Installation sur Atom

> Veuillez vous assurer que le paquet officiel `markdown-preview` est désactivé.

Il existe plusieurs façons d'installer ce paquet.

## Installer depuis Atom (Recommandé)

Ouvrez l'éditeur **atom**, allez dans `Settings`, cliquez sur `Install`, puis recherchez `markdown-preview-enhanced`.  
Après l'installation, vous **devez redémarrer** Atom pour que les modifications prennent effet.  
Il est recommandé de désactiver le paquet intégré `markdown-preview` après avoir installé ce paquet.

![screen shot 2017-03-19 at 4 07 16 pm](https://cloud.githubusercontent.com/assets/1908863/24084798/260a9fee-0cbf-11e7-83e6-bf17fa9aca77.png)

## Installer depuis le terminal

Ouvrez le terminal, puis exécutez la commande suivante :

```bash
apm install markdown-preview-enhanced
```

## Installer depuis GitHub

- **Clonez** ce projet.
- `cd` vers le dossier **markdown-preview-enhanced** téléchargé.
- Exécutez la commande `yarn install`. Puis exécutez la commande `apm link`.

```bash
cd the_path_to_folder/markdown-preview-enhanced
yarn install
apm link # <- Cela copiera le dossier markdown-preview-enhanced vers ~/.atom/packages
```

> Si vous n'avez pas la commande `npm`, vous devrez d'abord installer [node.js](https://nodejs.org/en/).  
> Si vous ne souhaitez pas installer [node.js](https://nodejs.org/en/) vous-même, après `apm link`, ouvrez l'éditeur Atom. Appuyez sur <kbd>cmd-shift-p</kbd> puis choisissez la commande `Update Package Dependencies: Update`.

## Pour les développeurs

```bash
apm develop markdown-preview-enhanced
```

- Ouvrez le dossier **markdown-preview-enhanced** dans **Atom Editor** via **View->Developer->Open in Dev Mode...**
- Vous pouvez alors modifier le code.
  Après chaque mise à jour du code, vous devez appuyer sur <kbd>cmd-shift-p</kbd> puis choisir `Window: Reload` pour recharger le paquet et voir les modifications.

[➔ Utilisation](usages.md)
