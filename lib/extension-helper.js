'úse strict'

// referred from the official Markdown Preview extension-helper.coffee
let scopesForLanguageName = {
  'sh': 'source.shell',
  'bash': 'source.shell',
  'c': 'source.c',
  'c++': 'source.cpp',
  'cpp': 'source.cpp',
  'coffee': 'source.coffee',
  'coffeescript': 'source.coffee',
  'coffee-script': 'source.coffee',
  'cs': 'source.cs',
  'csharp': 'source.cs',
  'css': 'source.css',
  'scss': 'source.css.scss',
  'sass': 'source.sass',
  'erlang': 'source.erl',
  'go': 'source.go',
  'html': 'text.html.basic',
  'java': 'source.java',
  'js': 'source.js',
  'javascript': 'source.js',
  'json': 'source.json',
  'less': 'source.less',
  'mustache': 'text.html.mustache',
  'objc': 'source.objc',
  'objective-c': 'source.objc',
  'php': 'text.html.php',
  'py': 'source.python',
  'python': 'source.python',
  'rb': 'source.ruby',
  'ruby': 'source.ruby',
  'text': 'text.plain',
  'toml': 'source.toml',
  'xml': 'text.xml',
  'yaml': 'source.yaml',
  'yml': 'source.yaml',
}

module.exports.scopeForLanguageName  = function(language) {
  return scopesForLanguageName[language] || ('source.' + language)
}
