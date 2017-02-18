# Markdown Preview Enhanced - Code Chunk  

```{javascript output:"markdown", id:"izap3ln0"}
var add = require('./test.js')
add(3, 4)
```

```{javascript cmd:"node", id:"izape715"}
console.log("Hello World haha")
```

## Python Matplotlib
```{python matplotlib: true, output:"html", id:"izbp0zt9"}
import matplotlib.pyplot as plt
plt.plot([1,2,3, 4])
plt.show()
```

```{python id:"izbqm7em", output:"html"}
import matplotlib.pyplot as plt, mpld3
from mpld3 import fig_to_html, plugins
fig = plt.figure()
plt.plot([3,1,4,1,5], 'ks-', mec='w', mew=5, ms=20)
print(fig_to_html(fig))
```



```{python matplotlib: true, id:"izbptu9w"}
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np


def randrange(n, vmin, vmax):
    '''
    Helper function to make an array of random numbers having shape (n, )
    with each number distributed Uniform(vmin, vmax).
    '''
    return (vmax - vmin)*np.random.rand(n) + vmin

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

n = 100

# For each set of style and range settings, plot n random points in the box
# defined by x in [23, 32], y in [0, 100], z in [zlow, zhigh].
for c, m, zlow, zhigh in [('r', 'o', -50, -25), ('b', '^', -30, -5)]:
    xs = randrange(n, 23, 32)
    ys = randrange(n, 0, 100)
    zs = randrange(n, zlow, zhigh)
    ax.scatter(xs, ys, zs, c=c, marker=m)

ax.set_xlabel('X Label')
ax.set_ylabel('Y Label')
ax.set_zlabel('Z Label')
```

## Plotly
```{javascript id:"izbr5wl4", element:'<div id="tester" style="width:600px;height:250px;"></div>'}

var Plotly = require('./lib/plotly-latest.min.js')
TESTER = document.getElementById('tester');
Plotly.plot( TESTER, [{
x: [1, 2, 3, 4, 5],
y: [1, 2, 4, 8, 16] }], {

margin: { t: 0 } } );
```

## Chart.js  
```{javascript output:"markdown", element:'<canvas id="myChart" width="400" height="400"></canvas>', id:"izap3ln0", require: ["./lib/Chart.bundle.min.js"]}
var Chart = require('./lib/Chart.bundle.min.js')
var ctx = document.getElementById("myChart");
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
        datasets: [{
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
```