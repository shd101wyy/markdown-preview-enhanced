# Installation

There are several ways of installing this package.  

## Install from atom (Recommended)
Open **atom** editor, open `Settings`, click `Install`, then search `markdown-preview-enhanced`.  
After installation, you **must restart** atom to take effects.   
It is recommended to disable the builtin `markdown-preview` package after you install this package.      

![screen shot 2017-03-19 at 4 07 16 pm](https://cloud.githubusercontent.com/assets/1908863/24084798/260a9fee-0cbf-11e7-83e6-bf17fa9aca77.png)

## Install from terminal
Open terminal, then run the following command:   
```bash
apm install markdown-preview-enhanced
```

## Install from GitHub  
* **Clone** this project.
* `cd` to the downloaded **markdown-preview-enhanced** folder.
* Run `npm install` command. Then run `apm link` command.  

```bash  
cd the_path_to_folder/markdown-preview-enhanced
npm install
apm link # <- This will copy markdown-preview-enhanced folder to ~/.atom/packages
```

> If you don't have `npm` command, then you will need to install [node.js](https://nodejs.org/en/) first.  
> If you don't want to install [node.js](https://nodejs.org/en/) yourself, then after `apm link`, open atom editor. Keyboard <kbd>cmd-shift-p</kbd> then choose `Update Package Dependencies: Update` command.  

## For developer  
```bash
apm develop markdown-preview-enhanced
```    
* Open **markdown-preview-enhanced** folder in **Atom Editor** from **View->Developer->Open in Dev Mode...**
* Then you can modify the code.
Every time after you update the code, you need to <kbd>cmd-shift-p</kbd> then choose `Window: Reload` to reload the package to see the update.

[➔ Usages](usages.md)