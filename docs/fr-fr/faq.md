# FAQ

1. **Je ne trouve pas ce paquet dans Atom ?**  
   Veuillez rechercher le nom complet de ce paquet. `markdown-preview-enhanced`

2. **J'ai exporté un fichier html, et je souhaite le déployer sur mon propre serveur distant. Mais la composition mathématique (MathJax ou KaTeX) ne fonctionne pas, que dois-je faire ?**  
   Veuillez vous assurer d'avoir coché `Use CDN hosted resources` lors de l'exportation.
3. **J'ai exporté un fichier html de présentation, et je souhaite le mettre sur ma page GitHub ou le déployer à distance ?**  
   Veuillez consulter la dernière question.
4. **Comment obtenir un aperçu en style sombre ?**  
   Si vous souhaitez que le style de l'aperçu soit cohérent avec votre éditeur atom, allez dans les paramètres de ce paquet, puis changez le `Preview Theme`.  
   Ou vous pouvez exécuter la commande `Markdown Preview Enhanced: Customize Css`, puis modifier le fichier `style.less`. [#68](https://github.com/shd101wyy/markdown-preview-enhanced/issues/68), [#89](https://github.com/shd101wyy/markdown-preview-enhanced/issues/89).
5. **L'aperçu est très très lent ?**  
   Cela peut se produire lorsque votre fichier Markdown est trop grand, ou que vous écrivez trop de formules mathématiques ou de graphiques.  
   Je vous recommande donc de désactiver la fonctionnalité `Live Update`.  
   Vous pouvez exécuter `Markdown Preview Enhanced: Toggle Live Update` pour la désactiver.
6. **Les raccourcis clavier ne fonctionnent pas ?**  
   <kbd>cmd-shift-p</kbd> puis choisissez `Key Binding Resolver: Toggle`. Vérifiez s'il y a des conflits de touches, ou postez un problème sur GitHub.
