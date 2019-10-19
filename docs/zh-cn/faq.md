# FAQ

1. **在 atom 的插件市场中找不到这个插件啊？**  
   请搜索全称 `markdown-preview-enhanced`。[#269](https://github.com/shd101wyy/markdown-preview-enhanced/issues/269)。
1. **我导出了一个 html 文件，想把它放到我的服务器上。但是数学符号等不能正确显示，该怎么办？**  
   请确定导出 html 文件的时候，`Use CDN hosted resources` 这一选项勾上了。
1. **我导出了一个 presentation 的 html 文件，想把它放到我的服务器上，但是无法正确显示？**  
   请参考上一个问题。
1. **我想用黑色的预览主题，该怎么做？**  
   如果你想要你的预览和你的 atom 编辑器风格颜色一致，你可以到该插件的设置中，更改 `Preview Theme` 项。  
   还有一种方法是运行 `Markdown Preview Enhanced: Customize Css` 命令，然后修改 `style.less` 文件。[#68](https://github.com/shd101wyy/markdown-preview-enhanced/issues/68)，[#89](https://github.com/shd101wyy/markdown-preview-enhanced/issues/89)。
1. **预览特别特别卡，该怎么做？**  
   如果你的预览特别卡，那么可能是你的文件太大了，或者用到的数学式，画的图过多。  
   这里我建议关闭 `Live Update` 的功能。可以运行 `Markdown Preview Enhanced: Toggle Live Update` 来关闭（disable）。然后预览就只会在你保存文件的时候刷新了，这样就不会卡了。
1. **快捷键没用啊？**  
   <kbd>cmd-shift-p</kbd> 然后选择 `Key Binding Resolver: Toggle`。查看一下有没有快捷键冲突，或者直接给我发个 issue／
