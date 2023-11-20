using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))


# λ, a, h, type
parameter = [1, 0.2, 0.1, 3]
population = [rand(0.0:0.01:2.0),rand(0.0:0.01:2.0)]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

steps = Vector(1:0.1:20)

for λ in enumerate(steps)
    o = plot_orbitdiagram(system, 0.5:0.01:30, params=[(1,λ[2])], init_vals=(0.5,0.5), title="λ = " * string(λ[2]))
    cs = string(λ[1]-1, pad = 4)
    s = joinpath(plotsdir("BevertonHolt_Nondim"),
     #savename("orbitdiagram", params, "png"),
     string("orbitdiagram/",cs,".pdf"))
    wsave(s, o)
end