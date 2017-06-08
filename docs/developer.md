# Developer
## Develop this package  
Feel free to post pull request, report issues, or request new features!


To modify and develop **markdown-preview-enhanced** package, you need to perform [local installation](installation.md?id=install-from-github).  

After you have done installing the package, follow these steps:  

* Open **markdown-preview-enhanced** folder in **Atom Editor** from **View->Developer->Open in Dev Mode...**
* Then you can modify the code.
Every time after you update the code, you need to <kbd>cmd-shift-p</kbd> then choose `Window: Reload` to reload the package to see the update.

---

## How to write extensions
APIs design is still in *beta stage*, so there might be changes in the future.  
The idea is from [issue #101](https://github.com/shd101wyy/markdown-preview-enhanced/issues/101).

<!-- toc orderedList:0 -->

* [Developer](#developer)
  * [Develop this package](#develop-this-package)
  * [How to write extensions](#how-to-write-extensions)
  * [Synchronous](#synchronous)
    * [::onWillParseMarkdown(callback)](#onwillparsemarkdowncallback)
    * [::onDidParseMarkdown(callback)](#ondidparsemarkdowncallback)
  * [Asynchronous](#asynchronous)
    * [::onDidRenderPreview(callback)](#ondidrenderpreviewcallback)

<!-- tocstop -->

---

First of all, you need to open your **Atom** `init.coffee` file by <kbd>cmd-shift-p</kbd> then choose `Application: Open Your Init Script`.

Then you can add the following code:  

```coffeescript
atom.packages.onDidActivatePackage (pkg) ->
  if pkg.name is 'markdown-preview-enhanced'
    # Write your extension here
    # for example:
    pkg.mainModule.onWillParseMarkdown (markdown)->
      markdown + '\nadd this extra line.'
```

*Two* types of **Event Subscriptions** are provided:
* **Synchronous**
* **Asynchronous**

---  

## Synchronous  
### ::onWillParseMarkdown(callback)
Calls your `callback` before the `markdown` string is parsed by [remarkable](https://github.com/jonschlinkert/remarkable).    

| Argument | Description |    
|---|---|   
| callback(`markdown`) | Function |     
| &nbsp;&nbsp;&nbsp;&nbsp;`markdown` | String |

`callback` function here **has to** return a string that will be parsed to markdown parser in the future.  
*Example:*
```coffeescript  
pkg.mainModule.onWillParseMarkdown (markdown)->
  "# This is heading will be added in front\n" + markdown
```
<br>  
### ::onDidParseMarkdown(callback)
Calls your `callback` after parsing markdown.  

| Argument | Description |    
|---|---|   
| callback(`htmlString`) | Function |     
| &nbsp;&nbsp;&nbsp;&nbsp;`htmlString` | String |    

`callback` function here **has to** return a HTML string that will be rendered on preview in the future.  
*Example:*
```coffeescript
pkg.mainModule.onDidParseMarkdown (htmlString)->
  htmlString + "<h1>This heading will be added at the end of html</h1>"
```

---  

## Asynchronous
`callback` doesn't have to return a value   
<br>  
### ::onDidRenderPreview(callback)  
Calls your `callback` after the preview has rendered html   

| Argument | Description |    
|---|---|   
| callback(`event`) | Function |     
| &nbsp;&nbsp;&nbsp;&nbsp;`event` | Object |  
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `.htmlString`| String |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `.previewElement`| DOM |  

*Example*
```coffeescript
pkg.mainModule.onDidRenderPreview (event)->
  previewElement = event.previewElement
  previewElement.innerHTML += '<h1>This heading will be added at the end of html</h1>'  
```
