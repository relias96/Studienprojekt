using DrWatson
@quickactivate "Studienprojekt"

include(srcdir("HostParasitoid.jl"))


# λ, a, h, type
λ = 7.58
a = 23.12
h = 3.0

parameter = [λ, a, h , 3]
population = [rand(0.0:0.0005:2.0),rand(0.0:0.01:2.0)]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)



o = plot_orbitdiagram(system, 20.0:0.001:24, params=[(1,λ)], init_vals=(0.5,0.5), title="λ = " * string(λ))

display(o)