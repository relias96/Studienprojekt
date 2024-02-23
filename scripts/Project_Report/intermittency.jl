using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))
set_theme!(Theme(fontsize = 35))

# Create 10 Plots and choose the one with the most intermittent behavior
for i in 0:10
  parameter = [6.5, 17.4111, 0.1, 3]
  population = [rand(0.0:0.001:1.0),rand(0.0:0.001:1.0)]
  system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

  fig = Figure(resolution=(2000,1000))
  ax = Axis(fig[1, 1], xlabel = "Time", ylabel = "Host / Parasitoid Value", xticks= 0:1000:10000, xticklabelrotation = pi/4)

  plot_timeseries!(ax, system, time_end=5000)

  elem_1, elem_2 = [MarkerElement(color = COLORS[2], marker = :circ, markersize = 20)],[MarkerElement(color = COLORS[3], marker = :circ, markersize = 20)]
  Legend(fig[1,2],[elem_1, elem_2],["Host", "Parasitoid"],"Legend")
  display(fig)
end