function f(n)
#k=3
l=[]
for m in 1:n
    p=rand(3)
    push!(l,p)
end
centroides=rand(l,3)
copia=[]
while centroides!=copia
    c1,c2,c3=[],[],[]
    for p in l
        d1=(p[1]-centroides[1][1])^2+(p[2]-centroides[1][2])^2+(p[3]-centroides[1][3])^2
        d2=(p[1]-centroides[2][1])^2+(p[2]-centroides[2][2])^2+(p[3]-centroides[2][3])^2
        d3=(p[1]-centroides[3][1])^2+(p[2]-centroides[3][2])^2+(p[3]-centroides[3][3])^2
        menor=min(d1,d2,d3)
        s+=menor
        if menor==d1
            push!(c1,p)
        elseif menor==d2
            push!(c2,p)
        elseif menor==d3
            push!(c3,p)
        end
    end
    copia=centroides[1:3]
    clusters=[c1,c2,c3]
    centroides=[]
    for cluster in clusters
        x,y,z=0,0,0
        for p in cluster
            x+=p[1]
            y+=p[2]
            z+=p[3]
        end
        push!(centroides,[x/length(cluster),y/length(cluster),z/length(cluster)])
    end
end
return centroides
end
println(f(10000))
