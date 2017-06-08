# 安裝教程

如下是安裝該插件的幾種方式。

## 通過 atom 安裝（推薦）
打開 **atom** 編輯器，打開 `Settings`，點擊 `Install`，然后搜索 `markdown-preview-enhanced`。
安裝結束后，你**必須重啟** atom 來生效。    

![screen shot 2017-03-19 at 4 07 16 pm](https://cloud.githubusercontent.com/assets/1908863/24084798/260a9fee-0cbf-11e7-83e6-bf17fa9aca77.png)

## 通過 Terminal 終端安裝
打開 terminal，運行以下的命令
```bash
apm install markdown-preview-enhanced
```

## 通過 GitHub 安裝  
* **Clone** 這個項目。
* `cd` 到下載好的 **markdown-preview-enhanced** 目錄。
* 運行 `npm install` 命令。然后運行 `apm link` 命令。    

```bash  
cd the_path_to_folder/markdown-preview-enhanced
npm install
apm link # <- 這個會拷貝 markdown-preview-enhanced 文件夾到 ~/.atom/packages
```

> 如果你沒有 `npm` 命令，那麼你就需要安裝好 [node.js](https://nodejs.org/en/) 先。    
> 如果你不想要安裝 [node.js](https://nodejs.org/en/)，那麼在 `apm link` 之后，打開 atom 編輯器。<kbd>cmd-shift-p</kbd> 接著選擇 `Update Package Dependencies: Update` 命令。  

## 對於開發人員
```bash
apm develop markdown-preview-enhanced
```
* 在**Atom**編輯器中通過 **View->Developer->Open in Dev Mode...** 打開 **markdown-preview-enhanced** 文件夾  
* 然后您就可以修改代碼
每次更新代碼，您都需要通過 <kbd>cmd-shift-p</kbd> 鍵搜索選擇 `Window: Reload` 重新載入項目。


[➔ 使用](zh-tw/usages.md)