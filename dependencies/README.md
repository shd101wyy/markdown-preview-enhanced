I managed many libraries by myself instead of through npm to reduce overall file size.

**Versions**
```json
{
    "mermaid": "7.0.0",
    "plantuml": "8054",
    "wavedrom": "1.4.1",
    "reveal": "3.4.1",
    "viz": "1.7.0",
    "save-svg-as-png": "v1.1.0",
    "MathJax": "v2.7.0",
    "mpld3": "v0.3.0",
}
```  

*Attention*: Need to add `window.WaveSkin = WaveSkin` at the end of **wavedrom/default.js**

*Attention*: Need to remove `font: inherit;` from `reveal.css`. Otherwise `KaTeX` and `MathJax` will have trouble rendering.

**cheerio 0.20.0** has bug rendering subgraph html(). `div` inside `svg` will be self-closed automatically, which is wrong. Therefore I downgrade it to 0.15.0

**cheerio 0.22.0** is buggy, restore to 0.15.0.  

*Attention*: Need to append `.mermaid ` to all selectors in `mermaid.css`, `mermaid.dark.css`, and `mermaid.forest.css`. Otherwise it will pollute `viz` graph.

*Attention*: Need to modify `pdf_a4_portrait.js` file to make it work with *MathJax*.

*Attention*: **viz.js 1.4.1** will cause `EvalError: Refused to evaluate a string as JavaScript` error.
Need to modify `eval` to eliminate `unsafe-eval` issue.  
Check [#75](https://github.com/mdaines/viz.js/issues/75).  

*Attention*: **mpld3.v0.3.min.js** min version actually has problem, so use not minified version.  


