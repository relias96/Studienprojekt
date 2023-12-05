using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))


parameter = [2.5, 17.23, 0.1, 3]
population = [0.336, 0.037]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

fig = Figure(resolution=(resolution=(1000,500)))
ax = Axis(fig[1, 1], xlabel = "Time", ylabel = "Value", title = "Supertransient behavior")


plot_timeseries!(ax, system, time_end=10000)

elem_1, elem_2 = (
  [
    MarkerElement(
    color = COLORS[2],
    marker = ●,
    markersize = 15
    )
  ],
  [
    MarkerElement(
    color = COLORS[3],
    marker = ●,
    markersize = 15
    )
  ]
)
Legend(fig[1,2],
[elem_1, elem_2],
["Host", "Parasitoid"],
"Legend")
display(fig)