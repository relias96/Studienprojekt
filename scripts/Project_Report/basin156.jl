using DrWatson
@quickactivate "Studienprojekt"

include(srcdir("HostParasitoid.jl"))
theme!()

λ = 7
α = 15.6
μ = 2.5
parameter = [λ, α, μ]
population = [rand(0.0:0.01:2.0),rand(0.0:0.01:2.0)]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

xgrid=range(0.0001,1,1000)
ygrid=range(0.0001,1,1000)

fig = Figure(resolution=(2*length(xgrid),1*length(ygrid)))
data = get_basin(system)
ax, axis = plot_basin!(fig, data)
display(fig)
#save(plotsdir("BevertonHolt","basins_lambda=20" , "basin_a="*string(a)*".png"), fig)