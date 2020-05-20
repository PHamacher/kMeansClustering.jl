# kMeansClustering

[![Build Status](https://travis-ci.com/PHamacher/kMeansClustering.jl.svg?branch=master)](https://travis-ci.com/PHamacher/kMeansClustering.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/PHamacher/kMeansClustering.jl?svg=true)](https://ci.appveyor.com/project/PHamacher/kMeansClustering-jl)
[![Codecov](https://codecov.io/gh/PHamacher/kMeansClustering.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/PHamacher/kMeansClustering.jl)
[![Coveralls](https://coveralls.io/repos/github/PHamacher/kMeansClustering.jl/badge.svg?branch=master)](https://coveralls.io/github/PHamacher/kMeansClustering.jl?branch=master)
  
# Features
Perform the clustering algorithm k-means, which split a set of points into k clusters.

# Example
```julia

using kMeansClustering, Random
  
mat = rand(3,100) # generate 100 3-dimensional points
r = mykmeansclustering(mat,4) # organize mat in k=4 clusters
```
    r[1] -> centers
  
    r[2] -> total cost
  
    r[3] -> assignments
  
    r[4] -> initial centers used (Forgy method)
```

