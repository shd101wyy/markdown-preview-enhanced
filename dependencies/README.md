I managed many libraries by myself instead of through npm to reduce overall file size.

**Versions**
```json
{
    "mermaid": "6.0.0",
    "plantuml": "8048",
    "wavedrom": "1.4.1",
    "reveal": "3.3.0",
    "viz": "1.3.0",
    "save-svg-as-png": "September 23, 2016",
    "MathJax": "v2.7.0"
}
```  

*Attention*: Need to add `window.WaveSkin = WaveSkin` at the end of **wavedrom/default.js**

*Attention*: Need to remove `font: inherit;` from `reveal.css`. Otherwise `KaTeX` and `MathJax` will have trouble rendering.

**cheerio 0.20.0** has bug rendering subgraph html(). `div` inside `svg` will be self-closed automatically, which is wrong. Therefore I downgrade it to 0.15.0

*Attention*: Need to append `.mermaid ` to all selectors in `mermaid.css`, `mermaid.dark.css`, and `mermaid.forest.css`. Otherwise it will pollute `viz` graph.

*Attention*: Need to modify `pdf_a4_portrait.js` file to make it work with *MathJax*.
