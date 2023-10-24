using DrWatson
@quickactivate "Studienprojekt"



# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))

parameter = [2.8, 0.043, 100, 1]
population = [rand(0.0:0.01:2.0),rand(0.0:0.01:2.0)]
system = DiscreteDynamicalSystem(Moran_Ricker, population, parameter)



steps = Vector(0.1:0.1:3)

for r in enumerate(steps)
    o = plot_orbitdiagram(system, 0.03:0.0001:0.05, params=[(1,r[2])], init_vals=(0.9,0.6), title="r = " * string(r[2]))
    #display(o)
    #params = Dict([("r", replace(string(r), "." => ","))])
    cs = string(r[1]-1, pad = 4)
    s = joinpath(plotsdir("orbit"),
     #savename("orbitdiagram", params, "png"),
     string("orbitdiagram/",cs,".png"))
    wsave(s, o)
end


