using kMeansClustering
using Test
using Random

@testset "kMeansClustering.jl" begin
    Random.seed!(1)
    X = rand(2,100)
    Y = X
    @test mykmeansclustering(X,4)[1:3] == mykmeansclustering(Y,4)[1:3]
end
