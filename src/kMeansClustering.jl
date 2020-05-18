module kMeansClustering

function squared_euclidean_distance(v::Array{Float64},w::Array{Float64})
    dist = 0
    for d in 1:length(v)
        dist+= (v[d]-w[d])^2
    end
    return dist
end

function agroup(matrix::Matrix{Float64})
    l = [Float64[]]
    pop!(l)
    dim,n_points = size(matrix)
    for p in 1:n_points
        v = Float64[]
        for d in 1:dim
            push!(v,matrix[dim*(p-1)+d])
        end
        push!(l,v)
    end
    return l,dim
end

function compare_distance(p::Array{Float64},old_ctr::Array{Float64},new_ctr::Array{Float64})
    old_dist = squared_euclidean_distance(p,old_ctr)
    new_dist = squared_euclidean_distance(p,new_ctr)
    if new_dist<=old_dist
        return new_ctr
    end
    return old_ctr
end

function dic(l::Array{Array{Float64}},centers::Array{Array{Float64}})
    dic_centers = Dict()
    for ctr in centers
        dic_centers[ctr] = [Float64[]]
        pop!(dic_centers[ctr])
    end
    for p in l
        center = centers[1]
        for ctr in centers
            center = compare_distance(p,center,ctr)
        end
        c = dic_centers[center]
        push!(c,p)
        dic_centers[center] = c
    end
    return dic_centers
end

function reorganize(clusters::Array{Array{Array{Float64}}},dim::Int64)
    centers = [Float64[]]
    pop!(centers)
    for cluster in clusters
        s = zeros(dim)
        for p in cluster
            for n in 1:dim
                s[n]+= p[n]
            end
        end
        means = Float64[]
        for d in s
            push!(means,d/length(cluster))
        end
        push!(centers,means)
    end
    return centers
end

function cost(dic_centers::Dict{Array{Float64},Array{Array{Float64}}})
    cst = 0
    for (centr,clus) in dic_centers
        for p in clus
            cst+=squared_euclidean_distance(p,centr)
        end
    end
    return cst
end

function assign(clusters::Array{Array{Array{Float64}}},l::Array{Array{Float64}})
    dic_assign = Dict()
    for n in 1:length(clusters)
        for el in clusters[n]
            dic_assign[el] = n
        end
    end
    l_assign = Int64[]
    for p in l
        push!(l_assign,dic_assign[p])
    end
    return l_assign
end

function new_format(centers::Array{Array{Float64}})
    new = hcat(centers[1],centers[2])
    for p in centers[3:length(centers)]
        new = hcat(new,p)
    end
    return new
end

function build_clusters(dic_centers::Dict{Array{Float64},Array{Array{Float64}}})
    clusters = [[Float64[]]]
    pop!(clusters)
    for (center,cluster) in dic_centers
        push!(clusters,cluster)
    end
    return clusters
end

function mykmeansclustering(matrix::Matrix{Float64},k::Int64)
    l,dim = agroup(matrix)
    centers = [Float64[]]
    pop!(centers)
    while length(unique(centers))<k
        centers = rand(l,k) # Forgy Method
    end
    initials = centers
    cop = [Float64[]]
    pop!(cop)
    while centers!=cop
        dic_centers = dic(l,centers)
        cop = centers[1:k]
        clusters = build_clusters(dic_centers)
        centers = reorganize(clusters,dim)
    end
    dic_centers = dic(l,centers)
    clusters = build_clusters(dic_centers)
    cst = cost(dic_centers)
    assignment = assign(clusters,l)
    centers = new_format(centers)
    initials = new_format(initials)
    return centers,cst,assignment,initials
end

export mykmeansclustering

end

