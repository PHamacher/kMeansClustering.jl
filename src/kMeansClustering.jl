function SquaredEuclideanDistance(v,w)
    dist=0
    for d in 1:length(v)
        dist+=(v[d]-w[d])^2
    end
    return dist
end

function agrupa(matriz)
    l=[]
    dim=size(matriz)[1]
    npontos=size(matriz)[2]
    for p in 1:npontos
        v=[]
        for d in 1:dim
            push!(v,matriz[dim*(p-1)+d])
        end
        push!(l,v)
    end
    return (l,dim)
end

function ComparaDist(p,antigoctr,novoctr)
    antigadist=SquaredEuclideanDistance(p,antigoctr)
    novadist=SquaredEuclideanDistance(p,novoctr)
    if novadist<=antigadist
        centroide=novoctr
    else
        centroide=antigoctr
    end
    return centroide
end

function dic(l,centroides)
    dicCentroides=Dict()
    for ctr in centroides
        dicCentroides[ctr]=[]
    end
    for p in l
        centroide=centroides[1]
        for ctr in centroides
            centroide=ComparaDist(p,centroide,ctr)
        end
        c=dicCentroides[centroide]
        push!(c,p)
        dicCentroides[centroide]=c
    end
    return dicCentroides
end

function reorganiza(clusters,dim)
    centroides=[]
    for cluster in clusters
        s=zeros(dim)
        for p in cluster
            for n in 1:dim
                s[n]+=p[n]
            end
        end
        medias=[]
        for d in s
            push!(medias,d/length(cluster))
        end
        push!(centroides,medias)
    end
    return centroides
end

function cost(dicCentroides)
    custo=0
    for (centr,clus) in dicCentroides
        for p in clus
            custo+=SquaredEuclideanDistance(p,centr)
        end
    end
    return custo
end

function atribui(clusters,l)
    dicAssign=Dict()
    for n in 1:length(clusters)
        for el in clusters[n]
            dicAssign[el]=n
        end
    end
    lAssign=[]
    for p in l
        push!(lAssign,dicAssign[p])
    end
    return lAssign
end

function AdequaFormato(centroides)
    novo=hcat(centroides[1],centroides[2])
    for p in centroides[3:length(centroides)]
        novo=hcat(novo,p)
    end
    return novo
end

function BuildClusters(dicCentroides)
    clusters=[]
    for (centroide,cluster) in dicCentroides
        push!(clusters,cluster)
    end
    return clusters
end

function mykmeansclustering(matriz,k)
    l,dim=agrupa(matriz)
    centroides=[]
    while length(unique(centroides))<k
        centroides=rand(l,k) # Forgy Method
    end
    copia=[]
    while centroides!=copia
        dicCentroides=dic(l,centroides)
        copia=centroides[1:k]
        clusters=BuildClusters(dicCentroides)
        centroides=reorganiza(clusters,dim)
    end
    dicCentroides=dic(l,centroides)
    clusters=BuildClusters(dicCentroides)
    custo=cost(dicCentroides)
    assign=atribui(clusters,l)
    centroides=AdequaFormato(centroides)
    return centroides,custo,assign
end
