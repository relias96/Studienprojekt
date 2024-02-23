using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))
set_theme!(Theme(fontsize = 35))

parameter = [2.5, 17.23, 0.1]
population = [0.336, 0.037]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

fig = Figure(resolution=(resolution=(2000,1000)))
ax = Axis(fig[1, 1], xlabel = "Time", ylabel = "Host / Parasitoid Value", xticks= 0:1000:10000, xticklabelrotation = pi/4)

plot_timeseries!(ax, system, time_end=10000)

elem_1, elem_2 = ([MarkerElement(color = COLORS[2],marker = :circ,markersize = 20)],[MarkerElement(color = COLORS[3],marker = :circ,markersize = 20)])
Legend(fig[1,2],[elem_1, elem_2],["Host", "Parasitoid"],"Legend")
display(fig)