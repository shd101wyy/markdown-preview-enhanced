var katex = require("katex");   // for katex
var marked = require("marked"); // for markdown
var highlightjs = require("highlight.js"); // for highlight
var fs = require("fs");

// Synchronous highlighting with highlight.js
marked.setOptions({
  highlight: function (code) {
    return highlightjs.highlightAuto(code).value;
  }
});

// replace string within $...$ with rendered string
function parseKatex(input_string){
    output_string = "";
    for(var i = 0; i < input_string.length; i++){
        if (input_string[i] === "\\"){
            output_string += input_string[i];
            if (i + 1 < input_string.length){
                i += 1;
                output_string += input_string[i];
            }
        }
        else if (input_string[i] === "$"){
                var start = i + 1;
                var end = -1;
                for (i = start; i < input_string.length; i++){
                    if (input_string[i] === "\\"){
                        i += 1;
                    }
                    else if (input_string[i] === "$"){
                        end = i;
                        break;
                    }
                }
                if (end !== -1){
                    try{
                        output_string += katex.renderToString(input_string.slice(start, end));
                    }
                    catch(e){
                        console.log(e);
                        return (void 0);
                    }
                }
                else{
                    output_string += "$" + input_string.slice(start, input_string.length);
                }
        }
        else{
            output_string += input_string[i];
        }
    }
    return output_string;
}

// parse markdown content to html
function parseMD(input_string){
    // replace math expression
    var replaced = parseKatex(input_string);
    if (replaced === void 0)
        return "error";
    // convert to html
    return marked(replaced);
}


// open new window to show rendered markdown html
function beginMarkdownKatexPreview(){
    var editor = atom.workspace.getActiveTextEditor();
    //addPreviewForEditor(editor);
    var uri = "markdown-katex-preview://editor/" + "markdown_katex_preview"; //+ editor.id + ".html";
    var markdown_html_view;

    // open new pane to show html
    atom.workspace.open(uri,
                        {split: "right",
                         activatePane: false,
                         searchAllPanes: true})
                   .done(function(html_preview_editor){
                       // html_preview_editor.setText("Test");
                       var textEditorElement = atom.views.getView(html_preview_editor);
                       var parent_element = textEditorElement.parentElement;
                       markdown_html_view = document.createElement("div");
                       markdown_html_view.style.width = "100%";
                       markdown_html_view.style.height = "100%";

                       markdown_html_view.className = "markdown_katex_preview";

                       markdown_html_view.style.backgroundColor = "white";

                       // set content
                       markdown_html_view.innerHTML = parseMD(editor.getText());

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
                       var hightlight_css = document.createElement("link");
                       hightlight_css.rel = "stylesheet";
                       hightlight_css.type = "text/css";
                       hightlight_css.href = __dirname + "/highlight.js/default.css";
                       document.getElementsByTagName( "head" )[0].appendChild( hightlight_css );
                });
    // change markdown content
    editor.onDidChange(function(){
        console.log(__dirname);
        var content = editor.getText();
        markdown_html_view.innerHTML = parseMD(content);
    });
}

function outputPDF(){
    console.log("output pdf");
    var editor = atom.workspace.getActiveTextEditor();
    var html_content = parseMD(editor.getText());

    // load css
    var index_css = fs.readFileSync(__dirname + "/index.css", 'utf8');
    // cannot embed katex_css directly
    // failed to load font -> wrong path
    // var katex_css = fs.readFileSync(__dirname + "/katex/katex.min.css", 'utf8');
    var hightlight_css = fs.readFileSync(__dirname + "/highlight.js/default.css", 'utf8');

    html_content = '<!DOCTYPE html><html><head><title>pdf_preview</title>  <meta charset="utf-8">' +
              '<style>' + index_css + '</style>' +
              '<style>' + hightlight_css + '</style>' +
              '<link rel="stylesheet" href="' + __dirname + '/katex/katex.min.css">' +
              '</head><body class="markdown_katex_preview">' + html_content + "</body></html>";
    console.log(html_content);
    var iframe = document.createElement('iframe');

    iframe.style.visibility = 'hidden';
    iframe.style.position = 'fixed';
    iframe.style.right = 0;
    iframe.style.bottom = 0;

    document.body.appendChild(iframe);

    iframe.contentWindow.document.write(html_content);

    function close(){
        document.body.removeChild(iframe);
    }

    iframe.contentWindow.onbeforeunload = close;
    iframe.contentWindow.onafterprint = close;
    iframe.contentWindow.print();
}

var activate_fn = function() {
    atom.commands.add("atom-workspace", "markdown-katex-preview-output-pdf", outputPDF);
    return atom.commands.add("atom-workspace", "markdown-katex-preview:toggle", beginMarkdownKatexPreview);
};
module.exports = {
    activate: activate_fn
};
