# [Ya no se mantiene]

# Instalación en Atom

> Asegúrate de tener el paquete oficial `markdown-preview` desactivado.

Hay varias formas de instalar este paquete.

## Instalar desde Atom (Recomendado)

Abre el editor **Atom**, ve a `Settings`, haz clic en `Install`, luego busca `markdown-preview-enhanced`.  
Después de la instalación, **debes reiniciar** Atom para que los cambios surtan efecto.  
Se recomienda deshabilitar el paquete integrado `markdown-preview` después de instalar este paquete.

![screen shot 2017-03-19 at 4 07 16 pm](https://cloud.githubusercontent.com/assets/1908863/24084798/260a9fee-0cbf-11e7-83e6-bf17fa9aca77.png)

## Instalar desde la terminal

Abre la terminal y ejecuta el siguiente comando:

```bash
apm install markdown-preview-enhanced
```

## Instalar desde GitHub

- **Clona** este proyecto.
- Navega con `cd` a la carpeta **markdown-preview-enhanced** descargada.
- Ejecuta el comando `yarn install`. Luego ejecuta el comando `apm link`.

```bash
cd the_path_to_folder/markdown-preview-enhanced
yarn install
apm link # <- Esto copiará la carpeta markdown-preview-enhanced a ~/.atom/packages
```

> Si no tienes el comando `npm`, necesitarás instalar [node.js](https://nodejs.org/en/) primero.  
> Si no quieres instalar [node.js](https://nodejs.org/en/) manualmente, después de `apm link`, abre Atom. Presiona <kbd>cmd-shift-p</kbd> y elige el comando `Update Package Dependencies: Update`.

## Para desarrolladores

```bash
apm develop markdown-preview-enhanced
```

- Abre la carpeta **markdown-preview-enhanced** en el **Editor Atom** desde **View->Developer->Open in Dev Mode...**
- Luego puedes modificar el código.
  Cada vez que actualices el código, presiona <kbd>cmd-shift-p</kbd> y elige `Window: Reload` para recargar el paquete y ver los cambios.

[➔ Usos](usages.md)
