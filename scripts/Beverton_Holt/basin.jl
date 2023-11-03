using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))


# λ, a, h, type 
#for Lambda = 7
#[19.7, 20, 20.5, 21.7, 22.75, 23.5, 25.5, 27]


# For Lambda = 7,5

for a in [18.5, 19.0, 19.5, 20, 21.3, 21.9, 22.5, 24, 26, 26.8, 27, 27.7, 28.5]
    parameter = [7.5, a, 3, 3]
    population = [rand(0.0:0.01:2.0),rand(0.0:0.01:2.0)]
    system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

    xgrid=range(0.0001,1,1200)
    ygrid=range(0.0001,1,1200)


    fig = Figure(resolution=(2*length(xgrid),length(ygrid)))
    ax, axis, basin = plot_basin!(fig, system, xgrid, ygrid , string(parameter))

    # plot_statespace!(ax, system, init_vals=(0.75,0.45))

    display(fig)

    save(plotsdir("BevertonHolt","basins_lambda=7,5" , "basin"*string(a)*".png"), fig)
end
