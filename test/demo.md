# Markdown Preview Enhanced

A super powerful markdown extension for **ATOM** with automatic scroll sync, math typesetting, and many more!

[TOC]

## Math typesetting

$ f(x) = sin(x) + 12 $

$$
u(x) =
  \begin{cases}
   \exp{x} & \text{if } x \geq 0 \\
   1       & \text{if } x < 0
  \end{cases}
$$

## Diagrams

```mermaid
graph LR
  A --> B;
  B --> C;
```

```puml
class Dummy {
  String data
  void methods()
}

class Flight {
   flightNumber : Integer
   departureTime : Date
}
```

```viz
digraph G {
  A -> B;
}
```

## Code Chunk

### GNUPlot

```gnuplot {cmd:true, output:"html"}
set terminal svg
set title "Simple Plots" font ",20"
set key left box
set samples 50
set style data points

plot [-10:10] sin(x),atan(x),cos(atan(x))
```

### LaTeX

> Branched Ring

```latex {cmd:true, latex_zoom:1}
\documentclass{standalone}
\usepackage[utf8]{inputenc}
\usepackage[english]{babel}

\usepackage{chemfig}
\begin{document}
\vspace{.5cm}

\chemfig{A*6(-B=C(-CH_3)-D-E-F(=G)=)}

\end{document}
```

### Python matplotlib

```python {cmd:true, matplotlib:true}
import matplotlib.pyplot as plt
import numpy as np

t = np.arange(0.0, 2.0, 0.01)
s = 1 + np.sin(2*np.pi*t)
plt.plot(t, s)

plt.xlabel('time (s)')
plt.ylabel('voltage (mV)')
plt.title('About as simple as it gets, folks')
plt.grid(True)
plt.show()
```

## Import external files

> You can import local files

@import "test.py" {code_chunk:true, cmd:"python"}

> You can also import online files

@import "https://github.com/atom/markdown-preview/blob/master/LICENSE.md"

> images

@import "https://s3.amazonaws.com/animeeps3/upload/media/posts/2017-01/15/10-anime-similar-to-fuuka-recommendations_1484499773-b.jpg" {width:1200}

> csv

@import "test.csv"

Of course You can do more with `@import`.

## You can even create presentation!
