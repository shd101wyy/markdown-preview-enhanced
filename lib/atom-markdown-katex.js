/**
 * atom-markdown-katex plugin for atom editor
 * By Yiyi Wang (shd101wyy)
 *
 */
var katex = require("katex");   // for katex
var marked = require("marked"); // for markdown
var highlightjs = require("highlight.js"); // for highlight
var fs = require("fs");
var cheerio = require("cheerio")

// make marked support code highlight
// Synchronous highlighting with highlight.js
marked.setOptions({
  highlight: function (code) {
    return highlightjs.highlightAuto(code).value;
  }
});

// replace string within $...$ or $$...$$ with rendered string
function parseKatex(input_string){
    output_string = "";
    // return end
    function findEnd(start, tag){
        var end = -1;
        var j;
        for (var i = start; i < input_string.length; i++){
            if (input_string[i] === "\\"){
                i += 1;
                continue;
            }
            var match = true;
            for(j = 0; j < tag.length; j++){
                if (i + j >= input_string.length || input_string[i + j] !== tag[j]){
                    match = false;
                    break;
                }
            }
            if (match){
                return i;
            }
        }
        return end;
    }
    for(var i = 0; i < input_string.length; i++){
        if (input_string[i] === "\\"){
            output_string += input_string[i];
            if (i + 1 < input_string.length){
                i += 1;
                output_string += input_string[i];
            }
        }
        else if (input_string[i] === "$" || (i + 1 < input_string.length && input_string[i] === "$" && input_string[i + 1] === "$")){
                var tag = ((i + 1 < input_string.length && input_string[i] === "$" && input_string[i + 1] === "$") ? "$$" : "$");
                var start = i + tag.length;
                var end = findEnd(start, tag);
                if (end !== -1){
                    try{
                        output_string += katex.renderToString(input_string.slice(start, end), {displayMode: (tag === "$" ? false : true)});
                    }
                    catch(e){
                        console.log(e);
                        return (void 0);
                    }
                    i = end + tag.length - 1;
                }
                else{
                    output_string += tag+ input_string.slice(start, input_string.length);
                    break;
                }
        }
        else{
            output_string += input_string[i];
        }
    }
    return output_string;
}

// resolve image path...
function resolveImagePaths(html, directoryPath) {
  $ = cheerio.load(html)
  $('img').each(function(i, imgElement){
    var img = $(imgElement)
    var src = img.attr('src')
    if (src &&
        (!(src.startsWith('http://') ||
           src.startsWith('https://') ||
           src.startsWith('atom://'))) &&
        (src.startsWith('./') ||
         src.startsWith('../') ||
         src[0] !== '/')) {
           img.attr('src', directoryPath + '//' + src)
    }
  })
  return $.html()
}

// parse markdown content to html
function parseMD(input_string, directoryPath){
    // replace math expression
    var replaced = parseKatex(input_string);
    if (replaced === void 0)
        return "<strong>Failed to parse: </strong><br>" + input_string;
    // convert to html
    var html = marked(replaced)
    if (directoryPath)
      return resolveImagePaths(html, directoryPath)
    else
      return html
}


// open new window to show rendered markdown html
function beginMarkdownKatexPreview(){
    // get current selected active editor
    var active_editor = atom.workspace.getActiveTextEditor();
    var filePath = active_editor.buffer.file.path
    var rootDirectoryPath =  atom.project.relativizePath(filePath)

    // already activated
    if (active_editor.markdown_html_view){
        return ;
    }
    active_editor.markdown_html_view = null;

    var uri = "atom-markdown-katex://markdown_katex_preview"; //+ editor.id + ".html";

    atom.workspace.onDidChangeActivePaneItem(function(editor){
        if (editor && editor === active_editor.html_preview_editor){
            //console.log(active_editor.markdown_html_view);
            if (active_editor.markdown_html_view){
                active_editor.markdown_html_view.style.display = "inline";
                active_editor.markdown_html_view.innerHTML = parseMD(active_editor.getText(), rootDirectoryPath[0]);
            }
        }
    });

    // open new pane to show html
    atom.workspace.open(uri,
                        {split: "right",
                         activatePane: false,
                         searchAllPanes: true})
                   .done(function(editor){
        if(active_editor.markdown_html_view === null){
           //console.log("Create view");
           var html_preview_editor = editor;
           // html_preview_editor.setText("Test");
           var textEditorElement = atom.views.getView(html_preview_editor);
           var parent_element = textEditorElement.parentElement;

           var markdown_html_view = document.createElement("div");
           markdown_html_view.style.width = "100%";
           markdown_html_view.style.height = "100%";
           markdown_html_view.style.margin = "0";
           markdown_html_view.style.zIndex= "999";
           markdown_html_view.style.overflow = "scroll";

           markdown_html_view.className = "markdown_katex_preview";

           markdown_html_view.style.backgroundColor = "white";

           // add html view to editor
           parent_element.insertBefore(markdown_html_view, textEditorElement);
           parent_element.removeChild(textEditorElement);

           // add css
           var index_css = document.createElement("link");
           index_css.rel = "stylesheet";
           index_css.type = "text/css";
           index_css.href = __dirname + "/index.css";
           document.getElementsByTagName( "head" )[0].appendChild( index_css );

           // add katex css
           var katex_css = document.createElement("link");
           katex_css.rel = "stylesheet";
           katex_css.type = "text/css";
           katex_css.href = __dirname + "/katex/katex.min.css";
           document.getElementsByTagName( "head" )[0].appendChild( katex_css );

           // add hightlight css
           var highlight_css = document.createElement("link");
           highlight_css.rel = "stylesheet";
           highlight_css.type = "text/css";
           highlight_css.href = __dirname + "/highlight.js/default.css";
           document.getElementsByTagName( "head" )[0].appendChild( highlight_css );

           html_preview_editor.onDidDestroy(function(){
              //console.log("Destory html_preview_editor");
              active_editor.markdown_html_view = null;
              html_preview_editor = null;
           });

           // change markdown content
           active_editor.onDidChange(function(){
               if (active_editor.markdown_html_view){
                   active_editor.markdown_html_view.innerHTML = parseMD(active_editor.getText(), rootDirectoryPath[0]);
               }
           });

           active_editor.markdown_html_view = markdown_html_view;
           active_editor.html_preview_editor = html_preview_editor;
       }

       // set content
       active_editor.markdown_html_view.innerHTML = parseMD(active_editor.getText(), rootDirectoryPath[0]);
    });
}

// print PDF file
// using webkit
function exportPDF(){
    console.log("output pdf");
    var editor = atom.workspace.getActiveTextEditor();
    var html_content = parseMD(editor.getText());

    var index_css = fs.readFileSync(__dirname+"/index.css", 'utf8');
    var highlight_css = fs.readFileSync(__dirname+"/highlight.js/default.css", 'utf8');

    html_content = '<!DOCTYPE html><html><head><title>pdf_preview</title>  <meta charset="utf-8">' +
            '<style>' + index_css + '</style>' +
            '<style>' + highlight_css + '</style>' +
            //'<link rel="stylesheet" href="' + __dirname + '/highlight.js/default.css">' +
            //'<link rel="stylesheet" href="' + __dirname + '/index.css">' +
            //'<link rel="stylesheet" href="' + __dirname + '/katex/katex.min.css">' +
            '</head><body class="markdown_katex_preview">' + html_content + "</body></html>";

    var iframe = document.createElement('iframe');
    document.body.appendChild(iframe);

    iframe.style.visibility = 'hidden';
    iframe.style.position = 'fixed';
    iframe.style.right = 0;
    iframe.style.bottom = 0;
    iframe.id = "markdown_katex_preview_pdf";


    iframe.contentWindow.document.write(html_content);


    // add katex css
    var katex_css = iframe.contentWindow.document.createElement("link");
    katex_css.rel = "stylesheet";
    katex_css.type = "text/css";
    katex_css.href = __dirname + "/katex/katex.min.css";
    iframe.contentWindow.document.getElementsByTagName("head")[0].appendChild( katex_css );

    /*
    Doesn't work
    function close(){
        console.log("done print");
        document.body.removeChild(iframe);
    }

    function beforePrint(){
        console.log("Begin to print pdf");
    }
    iframe.contentWindow.onbeforeprint = beforePrint;
    iframe.contentWindow.onbeforeunload = close;
    iframe.contentWindow.onafterprint = close;
    */

   // have to wait 1s to print correctly
    setTimeout(function(){
        iframe.contentWindow.print();
        iframe.contentWindow.close();
        document.body.removeChild(iframe);
    }, 2000);
}

// copy HTML to clipboard
function exportHTML(){
    var editor = atom.workspace.getActiveTextEditor();
    var html_content = parseMD(editor.getText());

    var index_css = fs.readFileSync(__dirname+"/index.css", 'utf8');
    var highlight_css = fs.readFileSync(__dirname+"/highlight.js/default.css", 'utf8');

    html_content = '<!DOCTYPE html><html><head><title>pdf_preview</title>  <meta charset="utf-8">' +
            '<style>' + index_css + '</style>' +
            '<style>' + highlight_css + '</style>' +
            // this requires internet
            '<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.3.0/katex.min.css">' +
            '</head><body class="markdown_katex_preview">' + html_content + "</body></html>";

    atom.clipboard.write(html_content);

    alert("HTML content has bee saved to clipboard");
}
// customize markdown preview css
function customizeCSS(){
    atom.workspace.open(__dirname + "/index.css");
}

var activate_fn = function() {
    atom.commands.add("atom-workspace", "markdown-katex-preview-export-pdf", exportPDF);
    atom.commands.add("atom-workspace",
    "markdown-katex-preview-export-html", exportHTML);
    atom.commands.add("atom-workspace", "markdown-katex-preview-customize-css", customizeCSS);
    return atom.commands.add("atom-workspace", "markdown-katex-preview:toggle", beginMarkdownKatexPreview);
};
module.exports = {
    activate: activate_fn
};
