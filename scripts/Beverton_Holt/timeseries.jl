using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))


for i in 1:100
    #λ = 1.979319
    #α = 10.9233
    #λ = rand(0.1:0.0001:10)
    λ = 6.5
    #α = rand(10:0.0001:20)
    α = 17.4111
    parameter = [λ, α, 0.1]
    population = [rand(0.0:0.001:1.0),rand(0.0:0.001:1.0)]
    system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

    myTheme = Theme(fontsize = 16)
    set_theme!(myTheme)

    fig = Figure()
    ax = Axis(fig[1,1], xminorticks = IntervalsBetween(10),xminorticksvisible = true, xminorgridvisible = true)
    plot_timeseries!(ax, system, time_end=100000)
    display(fig)
end