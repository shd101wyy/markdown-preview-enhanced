# [Artık bakımı yapılmıyor]

# Atom'a Kurulum

> Lütfen resmi `markdown-preview` paketinin devre dışı bırakıldığından emin olun.

Bu paketi kurmanın birkaç yolu vardır.

## Atom'dan kurulum (Önerilen)

**Atom** editörünü açın, `Settings`'i açın, `Install`'a tıklayın, ardından `markdown-preview-enhanced` arayın.  
Kurulumdan sonra, değişikliklerin geçerli olması için atom'u **yeniden başlatmanız gerekir**.  
Bu paketi kurduktan sonra yerleşik `markdown-preview` paketini devre dışı bırakmanız önerilir.

![screen shot 2017-03-19 at 4 07 16 pm](https://cloud.githubusercontent.com/assets/1908863/24084798/260a9fee-0cbf-11e7-83e6-bf17fa9aca77.png)

## Terminalden kurulum

Terminali açın ve aşağıdaki komutu çalıştırın:

```bash
apm install markdown-preview-enhanced
```

## GitHub'dan kurulum

- Bu projeyi **klonlayın**.
- İndirilen **markdown-preview-enhanced** klasörüne `cd` ile gidin.
- `yarn install` komutunu çalıştırın. Ardından `apm link` komutunu çalıştırın.

```bash
cd the_path_to_folder/markdown-preview-enhanced
yarn install
apm link # <- Bu, markdown-preview-enhanced klasörünü ~/.atom/packages dizinine kopyalayacak
```

> `npm` komutuna sahip değilseniz, önce [node.js](https://nodejs.org/en/) kurmanız gerekecektir.  
> [node.js](https://nodejs.org/en/) kurmak istemiyorsanız, `apm link` işleminden sonra atom editörünü açın. <kbd>cmd-shift-p</kbd> tuşlarına basın, ardından `Update Package Dependencies: Update` komutunu seçin.

## Geliştiriciler için

```bash
apm develop markdown-preview-enhanced
```

- **markdown-preview-enhanced** klasörünü **Atom Editörü**'nde **View->Developer->Open in Dev Mode...** menüsünden açın.
- Ardından kodu değiştirebilirsiniz.
  Kodu her güncelledikten sonra, paketi yeniden yükleyerek değişiklikleri görmek için <kbd>cmd-shift-p</kbd> tuşlarına basıp `Window: Reload` seçeneğini seçin.

[➔ Kullanım](usages.md)
