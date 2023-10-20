using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))

parameter = [2.8, 0.043, 100, 1]
population = [rand(0.0:0.01:2.0),rand(0.0:0.01:2.0)]
system = DiscreteDynamicalSystem(eom, population, parameter)


a,b,c = plot_basin(system, xgrid=range(0.0001,1,2000), ygrid=range(0.0001,1,2000))

display(a)
display(b)