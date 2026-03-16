# Uso

## Comandos

Você pode pressionar <kbd>cmd-shift-p</kbd> no editor atom para abrir a <strong> Paleta de Comandos </strong>.

> A tecla <kbd>cmd</kbd> no _Windows_ é <kbd>ctrl</kbd>.

_Fonte Markdown_

- <strong>Markdown Preview Enhanced: Toggle</strong>  
  <kbd>ctrl-shift-m</kbd>  
  Ativar/desativar a visualização do arquivo Markdown.

- <strong>Markdown Preview Enhanced: Toggle Zen Mode </strong>  
  Ativar/desativar o modo de escrita sem distrações.

- <strong>Markdown Preview Enhanced: Customize Css</strong>  
  Personalizar o CSS da página de visualização.  
  Aqui está um [tutorial](customize-css.md) rápido.

- <strong>Markdown Preview Enhanced: Create Toc </strong>  
  Gerar TOC (é necessário ter a visualização ativa). [documentação aqui](toc.md).

- <strong>Markdown Preview Enhanced: Toggle Scroll Sync </strong>  
  Ativar/Desativar sincronização de rolagem para a visualização.

- <strong>Markdown Preview Enhanced: Sync Source </strong>  
  <kbd>ctrl-shift-s</kbd>  
  Rolar a visualização para corresponder à posição do cursor na fonte Markdown.

- <strong>Markdown Preview Enhanced: Toggle Live Update </strong>  
   Ativar/Desativar atualização ao vivo para a visualização.  
   Se desativado, a visualização só será renderizada quando o arquivo for salvo.

- <strong>Markdown Preview Enhanced: Toggle Break On Single Newline </strong>  
  Ativar/Desativar quebra de linha em nova linha única.

- <strong>Markdown Preview Enhanced: Insert New Slide </strong>  
  Inserir um novo slide e entrar no [modo de apresentação](presentation.md)

- <strong>Markdown Preview Enhanced: Insert Table </strong>  
  Inserir uma tabela Markdown.

- <strong>Markdown Preview Enhanced: Insert Page Break </strong>  
  Inserir uma quebra de página.

- <strong> Markdown Preview Enhanced: Open Mermaid Config</strong>  
  Editar configuração de inicialização do `mermaid`.

- <strong> Markdown Preview Enhanced: Open Mathjax Config </strong>  
   Editar configuração de inicialização do `MathJax`.

- <strong>Markdown Preview Enhanced: Image Helper</strong>  
  Para mais informações, consulte [este documento](image-helper.md).  
   O Auxiliar de Imagem suporta inserção rápida de URL de imagem, colagem de imagem e upload de imagem usando [imgur](https://imgur.com/) e [sm.ms](https://sm.ms/).  
  ![screen shot 2017-06-06 at 3 42 31 pm](https://user-images.githubusercontent.com/1908863/26850896-c43be8e2-4ace-11e7-802d-6a7b51bf3130.png)

- <strong>Markdown Preview Enhanced: Show Uploaded Images</strong>  
  Abrir o arquivo `image_history.md` que armazena as informações das imagens enviadas.  
  Você pode modificar livremente o arquivo `image_history.md`.

- <strong>Markdown Preview Enhanced: Run Code Chunk </strong>  
  <kbd>shift-enter</kbd>  
  Executar um único [Code Chunk](code-chunk.md).

- <strong>Markdown Preview Enhanced: Run All Code Chunks </strong>  
  <kbd>ctrl-shift-enter</kbd>  
  Executar todos os [Code Chunks](code-chunk.md).

- <strong>Markdown Preview Enhanced: Extend Parser</strong>  
  [Estender o Parser Markdown](extend-parser.md).

---

_Visualização_

**Clique com o botão direito** na visualização para abrir o menu de contexto:

![screen shot 2017-07-14 at 12 30 54 am](https://user-images.githubusercontent.com/1908863/28199502-b9ba39c6-682b-11e7-8bb9-89661100389e.png)

- <kbd>cmd-=</kbd> ou <kbd>cmd-shift-=</kbd>.  
  Ampliar a visualização.

- <kbd>cmd--</kbd> ou <kbd>cmd-shift-\_</kbd>.  
  Reduzir a visualização.

- <kbd>cmd-0</kbd>  
  Redefinir o zoom.

- <kbd>cmd-shift-s</kbd>  
  Rolar o editor Markdown para corresponder à posição da visualização.

- <kbd>esc</kbd>  
  Alternar TOC lateral.

## Atalhos de Teclado

| Atalho                                      | Funcionalidade             |
| ------------------------------------------- | -------------------------- |
| <kbd>ctrl-shift-m</kbd>                     | Alternar visualização      |
| <kbd>cmd-k v</kbd>                          | Abrir Visualização `Somente VSCode` |
| <kbd>ctrl-shift-s</kbd>                     | Sincronizar visualização / Sincronizar fonte |
| <kbd>shift-enter</kbd>                      | Executar Code Chunk        |
| <kbd>ctrl-shift-enter</kbd>                 | Executar todos os Code Chunks |
| <kbd>cmd-=</kbd> ou <kbd>cmd-shift-=</kbd>  | Ampliar visualização       |
| <kbd>cmd--</kbd> ou <kbd>cmd-shift-\_</kbd> | Reduzir visualização       |
| <kbd>cmd-0</kbd>                            | Redefinir zoom da visualização |
| <kbd>esc</kbd>                              | Alternar TOC lateral       |

## Configurações do Pacote

### Atom

Para abrir as configurações do pacote, pressione <kbd>cmd-shift-p</kbd> e escolha `Settings View: Open`, depois clique em `Packages`.

Pesquise `markdown-preview-enhanced` em `Installed Packages`:  
![screen shot 2017-06-06 at 3 57 22 pm](https://user-images.githubusercontent.com/1908863/26851561-d6b1ca30-4ad0-11e7-96fd-6e436b5de45b.png)

Clique no botão `Settings`:

![screen shot 2017-07-14 at 12 35 13 am](https://user-images.githubusercontent.com/1908863/28199574-50595dbc-682c-11e7-9d94-264e46387da8.png)

### VS Code

Execute o comando `Preferences: Open User Settings`, depois pesquise `markdown-preview-enhanced`.

![screen shot 2017-07-14 at 12 34 04 am](https://user-images.githubusercontent.com/1908863/28199551-2719acb8-682c-11e7-8163-e064ad8fe41c.png)
