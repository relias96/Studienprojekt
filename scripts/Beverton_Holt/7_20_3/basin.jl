using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))


# λ, a, h, type 
parameter = [7.58, 21.2, 3, 3]
population = [rand(0.0:0.01:2.0),rand(0.0:0.01:2.0)]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)


a,b,c = plot_basin(system, xgrid=range(0.0001,1,3000), ygrid=range(0.0001,1,3000), t=string(parameter))

display(a)
display(b)
save(plotsdir("BevertonHolt", "7_20_3", "basin.png"), a)
save(plotsdir("BevertonHolt", "7_20_3", "attr.png"), b)
