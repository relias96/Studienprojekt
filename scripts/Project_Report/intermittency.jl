using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))

for i in 0:10
parameter = [6.5, 17.4111, 0.1, 3]
population = [rand(0.0:0.001:1.0),rand(0.0:0.001:1.0)]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

fig = Figure(resolution=(1000,500))
ax = Axis(fig[1, 1], xlabel = "Time", ylabel = "Value", title = "Intermittency")


plot_timeseries!(ax, system, time_end=5000)

elem_1, elem_2 = (
  [
    MarkerElement(
    color = COLORS[2],
    marker = :circ,
    markersize = 15
    )
  ],
  [
    MarkerElement(
    color = COLORS[3],
    marker = :circ,
    markersize = 15
    )
  ]
)
Legend(fig[1,2],
[elem_1, elem_2],
["Host", "Parasitoid"],
"Legend")
display(fig)

end