using DrWatson
@quickactivate "Studienprojekt"

using CairoMakie

f(a,h,H,P) = exp((a*H*P)/(1+h*H*H))

H = 0:0.1:5
A = 0.5:0.5:5
P = 1:1:5

fig =Figure(resolution=(600,1600), title="Holling Typ wie in den Slides")  

for p in enumerate(P)
    ax = Axis(fig[p[1],1], title="P = "*string(p[2]),xlabel="Hostdensity", ylabel="Number eaten")
    for a in A
        z = f.(a, 1,H,p[2])
        scatter!(ax, H, z, label="a = "*string(a))
    end
    fig[p[1], 2] = Legend(fig, ax)
end

save("FunctionalResponse.png", fig)
display(fig)

###################### 

f(a,h,H) = exp((a*H*H)/(1+h*H*H))

H = 0:0.1:5
A = 0.5:0.5:5

fig =Figure(resolution=(800,600))  

ax = Axis(fig[1,1], xlabel="Hostdensity", ylabel="Number eaten", title="Holling Typ wie im Lehrbuch")
for a in A
    z = f.(a, 1,H)
    scatter!(ax, H, z, label="a = "*string(a))
end
fig[1, 2] = Legend(fig, ax)

save("FunctionalResponse1.png", fig)
display(fig)