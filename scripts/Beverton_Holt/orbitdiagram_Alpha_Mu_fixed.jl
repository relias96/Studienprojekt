using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))


## Alpha is fixed and λ varies over the x range

λ = 6.8
α = 10.0
μ = 0.1

parameter = [λ, α, μ , 3]
population = [rand(0.0:0.01:2.0),rand(0.0:0.01:2.0)]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

x_range= 0:0.1:30

for α in enumerate(Vector(1:1:20))
    fig::Figure = Figure(resolution=(2000,600))
    ax = fig[1, 1] = Axis(fig, title="α = " * string(α[2])* " --- μ = "*string(μ), xlabel="α", ylabel="Host",
     xticks=first(x_range):1:last(x_range), xminorticks = IntervalsBetween(10),xminorticksvisible = true, xminorgridvisible = true)
    plot_orbitdiagram!(ax, system, 1,  x_range, params=[(2, α[2])], init_vals=(0.5,0.5))
    cs = "α=" * string(α[2])
    s = joinpath(plotsdir("BevertonHolt_Nondim"),
     string("orbitdiagram/alpha_fixed/",cs,".pdf"))
    wsave(s, fig)
end