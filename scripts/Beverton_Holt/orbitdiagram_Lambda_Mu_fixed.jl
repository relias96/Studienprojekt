using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))


λ = 6.8
α = 20.0
μ = 0.1

parameter = [λ, α, μ]

tick_range = 10:1:18

myTheme = Theme(fontsize = 40)
set_theme!(myTheme)

#iterate over all λ values
for λ in enumerate(Vector(1:1:10))

    fig::Figure = Figure(resolution=(3840,2160))
    
    ax = fig[1, 1] = Axis(fig, title="Orbitdiagram with the Parameters λ = " * string(λ[2])* " --- μ = "*string(μ), xlabel="α",ylabel="Host",
     xticks=tick_range, xminorticks = IntervalsBetween(10),xminorticksvisible = true, xminorgridvisible = true)
    
    # 20 times plot with different startvalues and different steprange
    for i in 0:20
        plot_range = first(tick_range):rand(0.01:0.000000001:0.02):last(tick_range)
        population = [rand(0.01:0.0000001:1),rand(0.01:0.00000001:1)]
        plot_orbitdiagram!(ax,2, plot_range, parameter=parameter)
    end

    cs = "orbitdiagram_λ="*string(λ[2])
    s = joinpath(plotsdir("BevertonHolt_Nondim"), string("orbitdiagram/lambda_mu_fixed/",cs,".pdf"))
    wsave(s, fig)
end