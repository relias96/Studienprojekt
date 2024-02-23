using DrWatson
@quickactivate "Studienprojekt"

include(srcdir("HostParasitoid.jl"))


#create 100 plots with given paramter combination and random initial conditions
for i in 1:100
# initialize System
    λ = 6.5
    α = 17.4111
    μ = 0.1
    parameter = [λ, α, μ]
    population = [rand(0.0:0.001:1.0),rand(0.0:0.001:1.0)]
    system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

    myTheme = Theme(fontsize = 16)
    set_theme!(myTheme)
# create Figure
    fig = Figure()
    ax = Axis(fig[1,1], xminorticks = IntervalsBetween(10),xminorticksvisible = true, xminorgridvisible = true)
    plot_timeseries!(ax, system, time_end=100000)
    display(fig)
end