# [Niet langer onderhouden]

# Installatie op Atom

> Zorg ervoor dat u het officiële `markdown-preview`-pakket hebt uitgeschakeld.

Er zijn verschillende manieren om dit pakket te installeren.

## Installeren vanuit atom (Aanbevolen)

Open de **atom**-editor, ga naar `Settings`, klik op `Install` en zoek naar `markdown-preview-enhanced`.  
Na de installatie **moet u atom opnieuw starten** om de wijzigingen door te voeren.  
Het wordt aanbevolen om het ingebouwde `markdown-preview`-pakket uit te schakelen nadat u dit pakket hebt geïnstalleerd.

![screen shot 2017-03-19 at 4 07 16 pm](https://cloud.githubusercontent.com/assets/1908863/24084798/260a9fee-0cbf-11e7-83e6-bf17fa9aca77.png)

## Installeren via terminal

Open een terminal en voer de volgende opdracht uit:

```bash
apm install markdown-preview-enhanced
```

## Installeren vanuit GitHub

- **Kloon** dit project.
- `cd` naar de gedownloade map **markdown-preview-enhanced**.
- Voer de opdracht `yarn install` uit. Voer vervolgens de opdracht `apm link` uit.

```bash
cd the_path_to_folder/markdown-preview-enhanced
yarn install
apm link # <- Hiermee wordt de map markdown-preview-enhanced gekopieerd naar ~/.atom/packages
```

> Als u de opdracht `npm` niet heeft, moet u eerst [node.js](https://nodejs.org/en/) installeren.  
> Als u [node.js](https://nodejs.org/en/) niet zelf wilt installeren, open dan na `apm link` de atom-editor. Druk op <kbd>cmd-shift-p</kbd> en kies de opdracht `Update Package Dependencies: Update`.

## Voor ontwikkelaars

```bash
apm develop markdown-preview-enhanced
```

- Open de map **markdown-preview-enhanced** in **Atom Editor** via **View->Developer->Open in Dev Mode...**
- Vervolgens kunt u de code aanpassen.
  Elke keer nadat u de code heeft bijgewerkt, moet u op <kbd>cmd-shift-p</kbd> drukken en vervolgens `Window: Reload` kiezen om het pakket opnieuw te laden zodat de wijzigingen zichtbaar worden.

[➔ Toepassingen](usages.md)
