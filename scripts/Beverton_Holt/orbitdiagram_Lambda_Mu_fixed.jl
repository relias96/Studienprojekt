using DrWatson
@quickactivate "Studienprojekt"

include(srcdir("HostParasitoid.jl"))

λ = 6.8
α = 20.0
μ = 0.1

tick_range = 10:1:18

myTheme = Theme(fontsize = 40)
set_theme!(myTheme)

#iterate over all λ values
for λ in enumerate(Vector(1:1:10))
#Initializing the figure and axis
    fig::Figure = Figure(resolution=(3840,2160))
    ax = fig[1, 1] = Axis(fig, title="Orbitdiagram with the Parameters λ = " * string(λ[2])* " --- μ = "*string(μ), xlabel="α",ylabel="Host",
        xticks=tick_range, xminorticks = IntervalsBetween(10),xminorticksvisible = true, xminorgridvisible = true)
# Here we plot the orbitdiagram
    plot_orbitdiagram!(ax,2, plot_range, parameter=[λ, α, μ])
# And then save it
    cs = "orbitdiagram_λ="*string(λ[2])
    s = joinpath(plotsdir("BevertonHolt_Nondim"), string("orbitdiagram/lambda_mu_fixed/",cs,".pdf"))
    wsave(s, fig)
end

