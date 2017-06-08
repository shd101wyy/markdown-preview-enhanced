# FAQ  

1. **在 atom 的插件市場中找不到這個插件啊？**  
請搜索全稱 `markdown-preview-enhanced`。[#269](https://github.com/shd101wyy/markdown-preview-enhanced/issues/269)。
1. **我導出了一個 html 文件，想把它放到我的服務器上。但是數學符號等不能正確顯示，該怎麼辦？**  
請確定導出 html 文件的時候，`Use CDN hosted resources` 這一選項勾上了。  
1. **我導出了一個 presentation 的 html 文件，想把它放到我的服務器上，但是無法正確顯示？**  
請參考上一個問題。
1. **我想用黑色的預覽主題，該怎麼做？**  
如果你想要你的預覽和你的 atom 編輯器風格顏色一致，你可以到該插件的設置中，更改 `Preview Theme` 項。 [#281](https://github.com/shd101wyy/markdown-preview-enhanced/issues/281)   
還有一種方法是運行 `Markdown Preview Enhanced: Customize Css` 命令，然後修改 `style.less` 文件。[#68](https://github.com/shd101wyy/markdown-preview-enhanced/issues/68)，[#89](https://github.com/shd101wyy/markdown-preview-enhanced/issues/89)。
1. **預覽特別特別卡，該怎麼做？**  
如果你的預覽特別卡，那麼可能是你的文件太大了，或者用到的數學式，畫的圖過多。  
這裡我建議關閉 `Live Update` 的功能。可以運行 `Markdown Preview Enhanced: Toggle Live Update` 來關閉（disable）。然後預覽就只會在你保存文件的時候刷新了，這樣就不會卡了。  
1. **快捷鍵沒用啊？**  
<kbd>cmd-shift-p</kbd> 然後選擇 `Key Binding Resolver: Toggle`。查看一下有沒有快捷鍵沖突，或者直接給我發個 issue／  
