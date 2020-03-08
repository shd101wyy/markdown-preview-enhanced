# 使用

## 命令

你可以在 atom 编辑器中按 <kbd>cmd-shift-p</kbd> 键来打开 <strong> Command Palette </strong>。

> <kbd>cmd</kbd> 键在 `Windows` 中就是 <kbd>ctrl</kbd>

_Markdown 源文件_

- <strong>Markdown Preview Enhanced: Toggle</strong>  
  <kbd>ctrl-shift-m</kbd>  
  开／关 Markdown 文件预览。

- <strong>Markdown Preview Enhanced: Toggle Zen Mode </strong>  
  开关无干扰式写作模式。

- <strong>Markdown Preview Enhanced: Customize Css</strong>  
  自定义预览 CSS。  
  这里有一个[快速教程](zh-cn/customize-css.md)。

- <strong>Markdown Preview Enhanced: Create Toc </strong>  
  生成 TOC（需要预览实现打开）。 [文档在这里](zh-cn/toc.md)。

- <strong>Markdown Preview Enhanced: Toggle Scroll Sync </strong>  
  开／关预览滑动同步。

- <strong>Markdown Preview Enhanced: Sync Source </strong>  
  <kbd>ctrl-shift-s</kbd>  
  滑动预览到编辑器中的光标位置。

- <strong>Markdown Preview Enhanced: Toggle Live Update </strong>  
   开／关预览实时更新。
  如果关闭了，则预览只会在 markdown 文件保存时才会更新。

- <strong>Markdown Preview Enhanced: Toggle Break On Single Newline </strong>  
  开关回车换行。  
  如果关闭了，则需要在句子后面打上**两个空格**然后回车进行换行。

- <strong>Markdown Preview Enhanced: Insert New Slide </strong>  
  插入新的幻灯片并且进入 [presentation 模式](zh-cn/presentation.md)。

- <strong>Markdown Preview Enhanced: Insert Table </strong>  
  插入 markdown 表格。

- <strong>Markdown Preview Enhanced: Insert Page Break </strong>  
  插入断页符。

- <strong> Markdown Preview Enhanced: Open Mermaid Config</strong>  
  打开 `mermaid` 设置文件。

- <strong> Markdown Preview Enhanced: Open Mathjax Config </strong>  
   打开 `MathJax` 设置文件。

- <strong>Markdown Preview Enhanced: Image Helper</strong>  
  更多详细信息请查看[这个文档](zh-cn/image-helper.md)。  
  图片助手支持快速插入图片链接，拷贝本地图片，和上传图片（powered by [imgur](https://imgur.com/) and [sm.ms](https://sm.ms/)）。  
  国内用户推荐使用 `sm.ms`，墙内不限量免费上传图片。  
  ![screen shot 2017-06-06 at 3 42 31 pm](https://user-images.githubusercontent.com/1908863/26850896-c43be8e2-4ace-11e7-802d-6a7b51bf3130.png)

- <strong>Markdown Preview Enhanced: Show Uploaded Images</strong>  
  打开 `image_history.md` 显示图片上传历史。  
  你可以随意编辑 `image_history.md` 文件。

- <strong>Markdown Preview Enhanced: Run Code Chunk </strong>  
  <kbd>shift-enter</kbd>  
  运行单个 [Code Chunk](zh-cn/code-chunk.md)。

- <strong>Markdown Preview Enhanced: Run All Code Chunks </strong>  
  <kbd>ctrl-shift-enter</kbd>  
  运行所有 [Code Chunks](zh-cn/code-chunk.md)。

- <strong>Markdown Preview Enhanced: Extend Parser</strong>  
  [扩展 Markdown Parser](zh-cn/extend-parser.md)。

---

_预览_

**右键点击** 预览打开菜单：

![screen shot 2017-07-14 at 12 30 54 am](https://user-images.githubusercontent.com/1908863/28199502-b9ba39c6-682b-11e7-8bb9-89661100389e.png)

- <kbd>cmd-=</kbd> or <kbd>cmd-shift-=</kbd>.  
  放大预览。

- <kbd>cmd--</kbd> or <kbd>cmd-shift-\_</kbd>.  
  缩小预览。

- <kbd>cmd-0</kbd>  
  重置预览缩放。

- <kbd>cmd-shift-s</kbd>  
  滑动 markdown 编辑器到预览的位置。

- <kbd>esc</kbd>  
  开／关边栏 TOC。

## 快捷键

| Shortcuts                                   | Functionality                       |
| ------------------------------------------- | ----------------------------------- |
| <kbd>ctrl-shift-m</kbd>                     | 开／关预览                          |
| <kbd>cmd-k v</kbd>                          | 打开预览 `仅 VSCode 可用`           |
| <kbd>ctrl-shift-s</kbd>                     | 滑动同步预览 / 滑动同步 markdown 源 |
| <kbd>shift-enter</kbd>                      | 运行 Code Chunk                     |
| <kbd>ctrl-shift-enter</kbd>                 | 运行所有的 Code Chunks              |
| <kbd>cmd-=</kbd> or <kbd>cmd-shift-=</kbd>  | 预览放大                            |
| <kbd>cmd--</kbd> or <kbd>cmd-shift-\_</kbd> | 预览缩小                            |
| <kbd>cmd-0</kbd>                            | 预览缩放重置                        |
| <kbd>esc</kbd>                              | 开／关边栏 TOC                      |

## 插件设置

### Atom

如果你想要打开插件设置，请按下 <kbd>cmd-shift-p</kbd> 然后选择 `Settings View: Open`。

在 `Settings` 页面中，接着点击 `Packages`。  
在 `Installed Packages` 下面搜索 `markdown-preview-enhanced`：
![screen shot 2017-06-06 at 3 57 22 pm](https://user-images.githubusercontent.com/1908863/26851561-d6b1ca30-4ad0-11e7-96fd-6e436b5de45b.png)

点击 `Settings` 按钮：

![screen shot 2017-07-14 at 12 35 13 am](https://user-images.githubusercontent.com/1908863/28199574-50595dbc-682c-11e7-9d94-264e46387da8.png)

### VS Code

运行 `Preferences: Open User Settings` 命令，然后搜索 `markdown-preview-enhanced`。

![screen shot 2017-07-14 at 12 34 04 am](https://user-images.githubusercontent.com/1908863/28199551-2719acb8-682c-11e7-8163-e064ad8fe41c.png)
