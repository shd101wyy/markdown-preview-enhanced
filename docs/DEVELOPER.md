# Developer's Doc
Feel free to post pull request, report issues, or request new features!


To modify and develop **markdown-preview-enhanced** package, you need to follow these steps:
* **fork** and then **clone** the project.
If you don't want to **fork** this project, you can also choose to download the latest zip file from the github repo page.
* `cd` to downloaded **markdown-preview-enhanced** folder. Run `apm link` command. Then run `npm install` command
```shell
cd the_path_to_folder/markdown-preview-enhanced
npm install
apm link # local installation

cd ../
apm develop markdown-preview-enhanced
```
* Open **markdown-preview-enhanced** folder in **Atom Editor** from **View->Developer->Open in Dev Mode...**
* Then you can modify the code.
Every time after you update the code, you need to `cmd+shift+p` then choose `Window: Reload` to reload the package to see the update.

---

## Write Extension
How to write extensions can be found [here](./extension.md).