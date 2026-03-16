# [Não é mais mantido]

# Instalação no Atom

> Certifique-se de ter o pacote oficial `markdown-preview` desativado.

Há várias formas de instalar este pacote.

## Instalar pelo atom (Recomendado)

Abra o editor **atom**, vá em `Settings`, clique em `Install`, depois pesquise `markdown-preview-enhanced`.  
Após a instalação, você **deve reiniciar** o atom para que as alterações entrem em vigor.  
Recomenda-se desativar o pacote integrado `markdown-preview` após instalar este pacote.

![screen shot 2017-03-19 at 4 07 16 pm](https://cloud.githubusercontent.com/assets/1908863/24084798/260a9fee-0cbf-11e7-83e6-bf17fa9aca77.png)

## Instalar pelo terminal

Abra o terminal e execute o seguinte comando:

```bash
apm install markdown-preview-enhanced
```

## Instalar pelo GitHub

- **Clone** este projeto.
- Navegue até a pasta **markdown-preview-enhanced** baixada com `cd`.
- Execute o comando `yarn install`. Em seguida, execute o comando `apm link`.

```bash
cd the_path_to_folder/markdown-preview-enhanced
yarn install
apm link # <- Isso copiará a pasta markdown-preview-enhanced para ~/.atom/packages
```

> Se você não tiver o comando `npm`, precisará instalar o [node.js](https://nodejs.org/en/) primeiro.  
> Se não quiser instalar o [node.js](https://nodejs.org/en/) manualmente, após o `apm link`, abra o editor atom. Pressione <kbd>cmd-shift-p</kbd> e escolha o comando `Update Package Dependencies: Update`.

## Para desenvolvedores

```bash
apm develop markdown-preview-enhanced
```

- Abra a pasta **markdown-preview-enhanced** no **Atom Editor** em **View->Developer->Open in Dev Mode...**
- Então você pode modificar o código.
  Toda vez que atualizar o código, você precisa pressionar <kbd>cmd-shift-p</kbd> e escolher `Window: Reload` para recarregar o pacote e ver as alterações.

[➔ Uso](usages.md)
