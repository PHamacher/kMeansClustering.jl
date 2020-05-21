using kMeansClustering
using Test
using Random
using Clustering

@testset "kMeansClustering.jl" begin
    Random.seed!(1)
    n_points=1000
    dim=4
    mat = rand(dim,n_points)
    k = 10
    r = mykmeansclustering(mat,k) # organize mat into k clusters
    @test size(r[1]) == (dim,k)
    @test length(r[3]) == n_points
    c=r[4]
    kmeans!(mat,c)
    @test sortslices(r[1],dims=2) == sortslices(c,dims=2)
end
