# Installation on (neo)vim

There are several ways of installing this package. Now they all need
[coc.nvim](https://github.com/neoclide/coc.nvim), and
[coc-webview](https://github.com/weirongxu/coc-webview) is a dependency.
Any problem only related to (neo)vim can be reported to
[coc-markdown-preview-enhanced](https://github.com/weirongxu/coc-markdown-preview-enhanced).

## Install by coc-marketplace

After installing
[coc-marketplace](https://github.com/fannheyward/coc-marketplace),
open `CocList`, then search `marketplace` and press <kbd>Enter</kbd>.

![marketplace](https://user-images.githubusercontent.com/32936898/197322932-16818f2b-0f15-4503-8fb8-691fd5633997.png)

Search `coc-markdown-preview-enhanced` and `coc-webview` and press <kbd>Enter</kbd>.

![coc-markdown-preview-enhanced](https://user-images.githubusercontent.com/32936898/197322933-4a7926f6-0563-4241-b0bc-010a3ded828c.png)

![coc-webview](https://user-images.githubusercontent.com/32936898/197322934-47c1de03-088b-4fa5-bc04-25c18e6973b8.png)

## Install by CocInstall

Input `CocInstall coc-markdown-preview-enhanced coc-webview` directly in command 
mode.

## Install by vimrc (Recommended)

Add
`let g:coc_global_extensions = ['coc-markdown-preview-enhanced', 'coc-webview']`
to your vimrc, then restart your (neo)vim.

Recommend this method is because you can reproduce your develop environment by
backup your vimrc.

[➔ Usages](usages.md)
