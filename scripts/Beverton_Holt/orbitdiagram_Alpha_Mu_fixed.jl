using DrWatson
@quickactivate "Studienprojekt"

include(srcdir("HostParasitoid.jl"))

## μ is fixed and for different α-values, λ varies over the x range

λ = 6.8
μ = 0.1

x_range= 0:.1:30

#creates orbitdiagrams and saves them
for α in Vector(1:1:20)
    fig::Figure = Figure(resolution=(2000,600))
    ax = fig[1, 1] = Axis(fig, title="α = " * string(α)* " --- μ = "*string(μ), xlabel="α", ylabel="Host",
     xticks=first(x_range):1:last(x_range), xminorticks = IntervalsBetween(10),xminorticksvisible = true, xminorgridvisible = true)
    plot_orbitdiagram!(ax, 1,  x_range, parameter=[λ, α , μ])
    cs = "α=" * string(α)
    s = joinpath(plotsdir("BevertonHolt_Nondim"), string("orbitdiagram/alpha_fixed/",cs,".pdf"))
    wsave(s, fig)
end