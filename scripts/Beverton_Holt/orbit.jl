using DrWatson
@quickactivate "Studienprojekt"

include(srcdir("HostParasitoid.jl"))


# λ, a, h, type
λ = 6.8
α = 20.0
μ = 0.1


parameter = [λ, α, μ , 3]
population = [rand(0.2:0.0005:1.0),rand(0.2:0.01:1.0)]
#population=[0.01,0.01]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)


x_range = 14.5:0.0005:15


fig::Figure = Figure(resolution=(2000,600))
ax = fig[1, 1] = Axis(fig, title="λ = " * string(λ)* " --- h = "*string(h), xticks=first(x_range):0.5:last(x_range))

plot_orbitdiagram!(ax, system, x_range, params=[(1,λ)], init_vals=population)

display(fig)