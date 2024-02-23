using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))


## α is fixed and for different λ-values, μ varies over the x range

α = 10.0
μ = 0.1

x_range= 0:0.01:10

for λ in enumerate(Vector(1:1:10))
#Initializing the figure and axis
    fig::Figure = Figure(resolution=(2000,600))
    ax = fig[1, 1] = Axis(fig, title="λ = " * string(λ[2])* " --- α = "*string(α), xlabel="μ", ylabel="Host",
     xticks=first(x_range):1:last(x_range), xminorticks = IntervalsBetween(10),xminorticksvisible = true, xminorgridvisible = true)
# Here we plot the orbitdiagram
    plot_orbitdiagram!(ax, 3,  x_range, parameter=[λ, α, μ])
# And then save it
    cs = "λ=" * string(λ[2])
    s = joinpath(plotsdir("BevertonHolt_Nondim"),
     string("orbitdiagram/lambda_alpha_fixed/",cs,".pdf"))
    wsave(s, fig)
end