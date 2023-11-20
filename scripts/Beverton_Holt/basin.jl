using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))



21.85
for a in [21.85]
    parameter = [7, a, 0.1, 3]
    population = [rand(0.0:0.01:2.0),rand(0.0:0.01:2.0)]
    system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

    xgrid=range(0.0001,1,1000)
    ygrid=range(0.0001,1,1000)


    fig = Figure(resolution=(2*length(xgrid),1*length(ygrid)))

    data = get_basin(system)



    ax, axis = plot_basin!(system, fig, data)

    plot_statespace!(ax, system,10000, init_vals=(0.3,0.2))
    plot_statespace!(ax, system,10000, init_vals=(0.31,0.21))

    display(fig)


    #save(plotsdir("BevertonHolt","basins_lambda=20" , "basin_a="*string(a)*".png"), fig)
end
