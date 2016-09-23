# Graphs
**Markdown Preview Enhanced** supports variety types of graphs.

## erd   
erd translates a plain text description of a relational database schema to a graphical entity-relationship diagram.  
[erd github repo](https://github.com/BurntSushi/erd)  

### Installation  
`erd` requires [Haskell](https://www.haskell.org/platform/) to be installed.  
```sh
$ brew cask install haskell-platform  # if you haven't install haskell-platform and you are using macOS  

$ git clone git@github.com:BurntSushi/erd.git
$ cd erd
$ cabal install graphviz
$ cabal configure
$ cabal build
```  

After build, `erd` binary will be generated under `./dist/build/erd/erd`. We need to add `erd` to system path.

```sh
mv ./dist/build/erd/erd /usr/local/bin
```

### Create graph
you can create `erd` graph within `{erd}` code block. You can find more at [erd github repo](https://github.com/BurntSushi/erd).  

    ```{erd}
    # Entities are declared in '[' ... ']'. All attributes after the entity header
    # up until the end of the file (or the next entity declaration) correspond
    # to this entity.
    [Person]
    *name
    height
    weight
    +birth_location_id

    [Location]
    *id
    city
    state
    country

    # Each relationship must be between exactly two entities, which need not
    # be distinct. Each entity in the relationship has exactly one of four
    # possible cardinalities:
    #
    # Cardinality    Syntax
    # 0 or 1         ?
    # exactly 1      1
    # 0 or more      *
    # 1 or more      +
    Person *--1 Location
    $ erd -i simple.er -o simple.pdf
    ```


