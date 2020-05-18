function squared_euclidean_distance(v,w)
    dist = 0
    for d in 1:length(v)
        dist+= (v[d]-w[d])^2
    end
    return dist
end

function agroup(matriz)
    l = [Float64[]]
    pop!(l)
    dim,npontos = size(matriz)
    for p in 1:npontos
        v = Float64[]
        for d in 1:dim
            push!(v,matriz[dim*(p-1)+d])
        end
        push!(l,v)
    end
    return l,dim
end

function compare_distance(p,antigoctr,novoctr)
    antigadist = squared_euclidean_distance(p,antigoctr)
    novadist = squared_euclidean_distance(p,novoctr)
    if novadist<=antigadist
        return novoctr
    end
    return antigoctr
end

function dic(l,centroides)
    dicCentroides = Dict()
    for ctr in centroides
        dicCentroides[ctr] = [Float64[]]
        pop!(dicCentroides[ctr])
    end
    for p in l
        centroide = centroides[1]
        for ctr in centroides
            centroide = compare_distance(p,centroide,ctr)
        end
        c = dicCentroides[centroide]
        push!(c,p)
        dicCentroides[centroide] = c
    end
    return dicCentroides
end

function reorganize(clusters,dim)
    centroides = [Float64[]]
    pop!(centroides)
    for cluster in clusters
        s = zeros(dim)
        for p in cluster
            for n in 1:dim
                s[n]+= p[n]
            end
        end
        medias = Float64[]
        for d in s
            push!(medias,d/length(cluster))
        end
        push!(centroides,medias)
    end
    return centroides
end

function cost(dicCentroides)
    custo = 0
    for (centr,clus) in dicCentroides
        for p in clus
            custo+=squared_euclidean_distance(p,centr)
        end
    end
    return custo
end

function assign(clusters,l)
    dicAssign = Dict()
    for n in 1:length(clusters)
        for el in clusters[n]
            dicAssign[el] = n
        end
    end
    lAssign = Int64[]
    for p in l
        push!(lAssign,dicAssign[p])
    end
    return lAssign
end

function new_format(centroides)
    novo = hcat(centroides[1],centroides[2])
    for p in centroides[3:length(centroides)]
        novo = hcat(novo,p)
    end
    return novo
end

function build_clusters(dicCentroides)
    clusters = [[Float64[]]]
    pop!(clusters)
    for (centroide,cluster) in dicCentroides
        push!(clusters,cluster)
    end
    return clusters
end

function mykmeansclustering(matriz,k)
    l,dim = agroup(matriz)
    centroides = [Float64[]]
    pop!(centroides)
    while length(unique(centroides))<k
        centroides = rand(l,k) # Forgy Method
    end
    iniciais = centroides
    copia = [Float64[]]
    pop!(copia)
    while centroides!=copia
        dicCentroides = dic(l,centroides)
        copia = centroides[1:k]
        clusters = build_clusters(dicCentroides)
        centroides = reorganize(clusters,dim)
    end
    dicCentroides = dic(l,centroides)
    clusters = build_clusters(dicCentroides)
    custo = cost(dicCentroides)
    atribui = assign(clusters,l)
    centroides = new_format(centroides)
    return centroides,custo,atribui,iniciais
end
