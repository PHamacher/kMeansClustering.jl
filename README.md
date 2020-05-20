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

```julia
using RDatasets, kMeansClustering, Plots
iris = dataset("datasets", "iris");
features = collect(Matrix(iris[:, 1:4])');
r = mykmeansclustering(features, 3); # split data into k=3 clusters
scatter(iris.PetalLength, iris.PetalWidth, marker_z=r[3],
        color=:lightrainbow, legend=false)
 ```
 ![Screenshot (8)](https://user-images.githubusercontent.com/64922101/82483770-5557e780-9aaf-11ea-90a7-a9d45259aaac.png)

