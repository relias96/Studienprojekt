using DrWatson
@quickactivate "Studienprojekt"

include(srcdir("HostParasitoid.jl"))

λ = 7
α = 15.55
μ = 2.5

parameter = [λ, α, μ]

axis_range = 14:1:23.0

set_theme!(Theme(fontsize = 50))

fig::Figure = Figure(resolution=(3000,2000),fmt = :svg)
ax = fig[1, 1] = Axis(fig, title="Orbitdiagram", xlabel="α",ylabel="Host", xticks=axis_range, 
    xminorticks = IntervalsBetween(10),xminorticksvisible = true, xminorgridvisible = true,
    yminorticks = IntervalsBetween(10),yminorticksvisible = true, yminorgridvisible = true)

plot_orbitdiagram!(ax, 2, axis_range; parameter=parameter, n=10, m=30)
display(fig)
save("Orbit14-23.png", fig)

