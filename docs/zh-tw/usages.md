# 使用

## 命令

你可以在 atom 編輯器中按 <kbd>cmd-shift-p</kbd> 鍵來打開 <strong> Command Palette </strong>。

> <kbd>cmd</kbd> 鍵在 `Windows` 中就是 <kbd>ctrl</kbd>

_Markdown 源文件_

- <strong>Markdown Preview Enhanced: Toggle</strong>  
  <kbd>ctrl-shift-m</kbd>  
  開／關 Markdown 文件預覽。

- <strong>Markdown Preview Enhanced: Toggle Zen Mode </strong>  
  開關無干擾式寫作模式。

- <strong>Markdown Preview Enhanced: Customize Css</strong>  
  自定義預覽 CSS。  
  這裡有一個[快速教程](zh-tw/customize-css.md)。

- <strong>Markdown Preview Enhanced: Create Toc </strong>  
  生成 TOC（需要預覽實現打開）。 [文檔在這裡](zh-tw/toc.md)。

- <strong>Markdown Preview Enhanced: Toggle Scroll Sync </strong>  
  開／關預覽滑動同步。

- <strong>Markdown Preview Enhanced: Sync Source </strong>  
  <kbd>ctrl-shift-s</kbd>  
  滑動預覽到編輯器中的光標位置。

- <strong>Markdown Preview Enhanced: Toggle Live Update </strong>  
   開／關預覽實時更新。
  如果關閉了，則預覽只會在 markdown 文件保存時才會更新。

- <strong>Markdown Preview Enhanced: Toggle Break On Single Newline </strong>  
  開關回車換行。  
  如果關閉了，則需要在句子後面打上**兩個空格**然後回車進行換行。

- <strong>Markdown Preview Enhanced: Insert New Slide </strong>  
  插入新的幻燈片並且進入 [presentation 模式](zh-tw/presentation.md)。

- <strong>Markdown Preview Enhanced: Insert Table </strong>  
  插入 markdown 表格。

- <strong>Markdown Preview Enhanced: Insert Page Break </strong>  
  插入斷頁符。

- <strong> Markdown Preview Enhanced: Open Mermaid Config</strong>  
  打開 `mermaid` 設置文件。

- <strong> Markdown Preview Enhanced: Open Mathjax Config </strong>  
   打開 `MathJax` 設置文件。

- <strong>Markdown Preview Enhanced: Image Helper</strong>  
  更多詳細信息請查看[這個文檔](zh-tw/image-helper.md)。  
  圖片助手支持快速插入圖片鏈接，拷貝本地圖片，和上傳圖片（powered by [imgur](https://imgur.com/) and [sm.ms](https://sm.ms/)）。  
  國內用戶推薦使用 `sm.ms`，牆內不限量免費上傳圖片。  
  ![screen shot 2017-06-06 at 3 42 31 pm](https://user-images.githubusercontent.com/1908863/26850896-c43be8e2-4ace-11e7-802d-6a7b51bf3130.png)

- <strong>Markdown Preview Enhanced: Show Uploaded Images</strong>  
  打開 `image_history.md` 顯示圖片上傳歷史。  
  你可以隨意編輯 `image_history.md` 文件。

- <strong>Markdown Preview Enhanced: Run Code Chunk </strong>  
  <kbd>shift-enter</kbd>  
  運行單個 [Code Chunk](zh-tw/code-chunk.md)。

- <strong>Markdown Preview Enhanced: Run All Code Chunks </strong>  
  <kbd>ctrl-shift-enter</kbd>  
  運行所有 [Code Chunks](zh-tw/code-chunk.md)。

- <strong>Markdown Preview Enhanced: Extend Parser</strong>  
  [擴展 Markdown Parser](zh-tw/extend-parser.md)。

---

_預覽_

**右鍵點擊** 預覽打開菜單：

![screen shot 2017-07-14 at 12 30 54 am](https://user-images.githubusercontent.com/1908863/28199502-b9ba39c6-682b-11e7-8bb9-89661100389e.png)

- <kbd>cmd-=</kbd> or <kbd>cmd-shift-=</kbd>.  
  放大預覽。

- <kbd>cmd--</kbd> or <kbd>cmd-shift-\_</kbd>.  
  縮小預覽。

- <kbd>cmd-0</kbd>  
  重置預覽縮放。

- <kbd>cmd-shift-s</kbd>  
  滑動 markdown 編輯器到預覽的位置。

- <kbd>esc</kbd>  
  開／關邊欄 TOC。

## 快捷鍵

| Shortcuts                                   | Functionality                       |
| ------------------------------------------- | ----------------------------------- |
| <kbd>ctrl-shift-m</kbd>                     | 開／關預覽                          |
| <kbd>cmd-k v</kbd>                          | 打開預覽 `僅 VSCode 可用`           |
| <kbd>ctrl-shift-s</kbd>                     | 滑動同步預覽 / 滑動同步 markdown 源 |
| <kbd>shift-enter</kbd>                      | 運行 Code Chunk                     |
| <kbd>ctrl-shift-enter</kbd>                 | 運行所有的 Code Chunks              |
| <kbd>cmd-=</kbd> or <kbd>cmd-shift-=</kbd>  | 預覽放大                            |
| <kbd>cmd--</kbd> or <kbd>cmd-shift-\_</kbd> | 預覽縮小                            |
| <kbd>cmd-0</kbd>                            | 預覽縮放重置                        |
| <kbd>esc</kbd>                              | 開／關邊欄 TOC                      |

## 插件設置

### Atom

如果你想要打開插件設置，請按下 <kbd>cmd-shift-p</kbd> 然後選擇 `Settings View: Open`。

在 `Settings` 頁面中，接著點擊 `Packages`。  
在 `Installed Packages` 下面搜索 `markdown-preview-enhanced`：
![screen shot 2017-06-06 at 3 57 22 pm](https://user-images.githubusercontent.com/1908863/26851561-d6b1ca30-4ad0-11e7-96fd-6e436b5de45b.png)

點擊 `Settings` 按鈕：

![screen shot 2017-07-14 at 12 35 13 am](https://user-images.githubusercontent.com/1908863/28199574-50595dbc-682c-11e7-9d94-264e46387da8.png)

### VS Code

運行 `Preferences: Open User Settings` 命令，然後搜索 `markdown-preview-enhanced`。

![screen shot 2017-07-14 at 12 34 04 am](https://user-images.githubusercontent.com/1908863/28199551-2719acb8-682c-11e7-8163-e064ad8fe41c.png)
