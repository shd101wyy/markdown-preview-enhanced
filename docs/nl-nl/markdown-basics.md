# Markdown-basisprincipes

Dit artikel is een korte inleiding tot [GitHub Flavored Markdown schrijven](https://guides.github.com/features/mastering-markdown/).

## Wat is Markdown?

`Markdown` is een manier om tekst op het web op te maken. U beheert de weergave van het document; woorden vetgedrukt of cursief opmaken, afbeeldingen toevoegen en lijsten maken zijn slechts een paar dingen die u met Markdown kunt doen. Markdown is grotendeels gewone tekst met een paar niet-alfabetische tekens erbij, zoals `#` of `*`.

## Syntaxgids

### Koppen

```markdown
# Dit is een <h1>-tag

## Dit is een <h2>-tag

### Dit is een <h3>-tag

#### Dit is een <h4>-tag

##### Dit is een <h5>-tag

###### Dit is een <h6>-tag
```

Als u `id` en `class` aan de kop wilt toevoegen, voeg dan gewoon `{#id .class1 .class2}` toe. Bijvoorbeeld:

```markdown
# Deze kop heeft 1 id {#my_id}

# Deze kop heeft 2 klassen {.class1 .class2}
```

> Dit is een MPE-uitgebreide functie.

### Nadruk

<!-- prettier-ignore -->
```markdown
*Deze tekst wordt cursief*
_Dit wordt ook cursief_

**Deze tekst wordt vetgedrukt**
__Dit wordt ook vetgedrukt__

_U **kunt** ze combineren_

~~Deze tekst wordt doorgestreept~~
```

### Lijsten

#### Ongeordende lijst

```markdown
- Item 1
- Item 2
  - Item 2a
  - Item 2b
```

#### Geordende lijst

```markdown
1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b
```

### Afbeeldingen

```markdown
![GitHub Logo](/images/logo.png)
Formaat: ![Alt-tekst](url)
```

### Koppelingen

```markdown
https://github.com - automatisch!
[GitHub](https://github.com)
```

### Blokcitaat

```markdown
Zoals Kanye West zei:

> We leven in de toekomst dus
> het heden is ons verleden.

> [!NOTE]
> Dit is een notitie-blokcitaat.

> [!WARNING]
> Dit is een waarschuwingsblokcitaat.
```

### Horizontale lijn

```markdown
Drie of meer...

---

Koppeltekens

---

Sterretjes

---

Onderstrepingstekens
```

### Inline code

```markdown
Ik denk dat u hier een
`<addr>`-element moet gebruiken.
```

### Omheind codeblok

U kunt omheinde codeblokken maken door driedubbele accenten graves <code>\`\`\`</code> voor en na het codeblok te plaatsen.

#### Syntaxmarkering

U kunt een optionele taalidentifier toevoegen om syntaxmarkering in uw omheinde codeblok in te schakelen.

Bijvoorbeeld voor syntaxmarkering van Ruby-code:

    ```ruby
    require 'redcarpet'
    markdown = Redcarpet.new("Hello World!")
    puts markdown.to_html
    ```

```ruby
require 'redcarpet'
markdown = Redcarpet.new("Hello World!")
puts markdown.to_html
```

#### Codeblokklasse (MPE-uitgebreide functie)

U kunt `class` instellen voor uw codeblokken.

Bijvoorbeeld om `class1 class2` toe te voegen aan een codeblok:

    ```javascript {.class1 .class}
    function add(x, y) {
      return x + y
    }
    ```

##### Regelnummers

U kunt regelnummers inschakelen voor een codeblok door de klasse `line-numbers` toe te voegen.

Bijvoorbeeld:

````markdown
```javascript {.line-numbers}
function add(x, y) {
  return x + y;
}
```
````

![screen shot 2017-07-14 at 1 20 27 am](https://user-images.githubusercontent.com/1908863/28200587-a8582b0a-6832-11e7-83a7-6c3bb011322f.png)

##### Rijen markeren

U kunt rijen markeren door het attribuut `highlight` toe te voegen:

````markdown
```javascript {highlight=10}
```

```javascript {highlight=10-20}
```

```javascript {highlight=[1-10,15,20-22]}
```
````

### Taaklists

```markdown
- [x] @vermeldingen, #verwijzingen, [koppelingen](), **opmaak** en <del>tags</del> worden ondersteund
- [x] lijstsyntax vereist (elke ongeordende of geordende lijst wordt ondersteund)
- [x] dit is een voltooid item
- [ ] dit is een onvoltooid item
```

### Tabellen

U kunt tabellen maken door een lijst met woorden samen te stellen en ze te scheiden met koppeltekens `-` (voor de eerste rij), en vervolgens elke kolom te scheiden met een pijp `|`:

<!-- prettier-ignore -->
```markdown
Eerste kop | Tweede kop
------------ | -------------
Inhoud van cel 1 | Inhoud van cel 2
Inhoud in de eerste kolom | Inhoud in de tweede kolom
```

## Uitgebreide syntaxis

### Tabel

> U moet `enableExtendedTableSyntax` inschakelen in de extensie-instellingen om dit te laten werken.

![screen shot 2017-07-15 at 8 16 45 pm](https://user-images.githubusercontent.com/1908863/28243710-945e3004-699a-11e7-9a5f-d74f6c944c3b.png)

### Emoji & Font-Awesome

> Dit werkt alleen voor `markdown-it parser` maar niet voor `pandoc parser`.  
> Standaard ingeschakeld. U kunt het uitschakelen via de pakketinstellingen.

```
:smile:
:fa-car:
```

### Superscript

```markdown
30^de^
```

### Subscript

```markdown
H~2~O
```

### Voetnoten

```markdown
Inhoud [^1]

[^1]: Hallo! Dit is een voetnoot
```

### Afkorting

```
*[HTML]: Hyper Text Markup Language
*[W3C]: World Wide Web Consortium
De HTML-specificatie
wordt onderhouden door het W3C.
```

### Markering

```markdown
==gemarkeerd==
```

### CriticMarkup

CriticMarkup is standaard **uitgeschakeld**, maar u kunt het inschakelen via de pakketinstellingen.  
Meer informatie over CriticMarkup vindt u in de [CriticMarkup User's Guide](https://criticmarkup.com/users-guide.php).

Er zijn vijf soorten Critic-markeringen:

- Toevoeging `{++ ++}`
- Verwijdering `{-- --}`
- Vervanging `{~~ ~> ~~}`
- Opmerking `{>> <<}`
- Markering `{== ==}{>> <<}`

> CriticMarkup werkt alleen met de markdown-it parser, maar niet met de pandoc parser.

### Admonition

```
!!! note Dit is de admonition-titel
    Dit is de admonition-inhoud
```

> Zie meer informatie op https://squidfunk.github.io/mkdocs-material/reference/admonitions/

## Referenties

- [Mastering Markdown](https://guides.github.com/features/mastering-markdown/)
- [Daring Fireball: Markdown Basics](https://daringfireball.net/projects/markdown/basics)

[➔ Wiskunde](math.md)
