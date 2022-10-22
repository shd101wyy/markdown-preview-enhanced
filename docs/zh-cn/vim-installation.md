# (neo)vim 版本安装教程

这里有如下方式安装此插件。目前它们都需要
[coc.nvim](https://github.com/neoclide/coc.nvim) ，并且
[coc-webview](https://github.com/weirongxu/coc-webview) 是一个依赖。
任何只与 (neo)vim 相关的问题可以被报告给
[coc-markdown-preview-enhanced](https://github.com/weirongxu/coc-markdown-preview-enhanced)
。

## 通过 coc-marketplace 安装

在安装
[coc-marketplace](https://github.com/fannheyward/coc-marketplace) 之后，
打开 `CocList` ，然后搜索 `marketplace` ，并输入 <kbd>Enter</kbd>。

![marketplace](https://user-images.githubusercontent.com/32936898/197322932-16818f2b-0f15-4503-8fb8-691fd5633997.png)

搜索 `coc-markdown-preview-enhanced` 和 `coc-webview` ，并输入 <kbd>Enter</kbd> 
。

![coc-markdown-preview-enhanced](https://user-images.githubusercontent.com/32936898/197322933-4a7926f6-0563-4241-b0bc-010a3ded828c.png)

![coc-webview](https://user-images.githubusercontent.com/32936898/197322934-47c1de03-088b-4fa5-bc04-25c18e6973b8.png)

## 通过 CocInstall 安装

直接在命令模式输入 `CocInstall coc-markdown-preview-enhanced coc-webview` 。

## 通过 vimrc 安装 （推荐）

添加
`let g:coc_global_extensions = ['coc-markdown-preview-enhanced', 'coc-webview']`
到你的 vimrc ，然后重启你的 (neo)vim 。

推荐此方法是因为你可以通过备份你的 vimrc 来复现你的开发环境。

[➔ 使用](zh-cn/usages.md)
