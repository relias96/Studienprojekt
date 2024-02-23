using DrWatson
@quickactivate "Studienprojekt"

include(srcdir("HostParasitoid.jl"))

λ = 7
α = 15.55
μ = 2.5

parameter = [λ, α, μ]

axis_range = 21.55:0.1:21.65

#set_theme!(Theme(fontsize = 70))

fig::Figure = Figure(resolution=(2000,2000),fmt = :svg)
ax = fig[1, 1] = Axis(fig, title="Orbitdiagram", xlabel="Parameter α",ylabel="Host", xticks=axis_range, 
    xminorticks = IntervalsBetween(10),xminorticksvisible = true, xminorgridvisible = true,
    yminorticks = IntervalsBetween(10),yminorticksvisible = true, yminorgridvisible = true)

plot_orbitdiagram!(ax, 2, axis_range; parameter=parameter, n=8, m=20)
display(fig)
