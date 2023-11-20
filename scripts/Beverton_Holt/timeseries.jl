using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))

parameter = [6.8, 14.8, 0.1, 3]
population = [rand(0.0:0.001:1.0),rand(0.0:0.001:1.0)]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

plot_timeseries(system, time_end=1500)