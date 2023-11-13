using DrWatson
@quickactivate "Studienprojekt"

using CairoMakie

f(a,c,T,Th,H,P) = exp((a*T*H*P)/(1+c*H+Th*H*H))

H = 0:0.1:30
P = 0.001


fig =Figure(resolution=(800, 600), title="Holling Typ wie in den Slides")  
ax = Axis(fig[1,1], title="P =1",xlabel="Hostdensity", ylabel="Number eaten")

a =5
c = 0.1
for c in 0:0.1:1
    z = f.(a,c, 100, 0.01, H,P)
    lines!(ax, H, z, label="c = "* string(c))
end
fig[1, 2] = Legend(fig, ax)

display(fig)