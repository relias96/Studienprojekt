using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))


## Alpha and Lambda is fixed and Mu varies over the x range

λ = 10
α = 10.0
μ = 0.1

parameter = [λ, α, μ , 3]
population = [rand(0.0:0.01:2.0),rand(0.0:0.01:2.0)]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

x_range= 0:0.01:10

for λ in enumerate(Vector(1:1:10))
    fig::Figure = Figure(resolution=(2000,600))
    ax = fig[1, 1] = Axis(fig, title="λ = " * string(λ[2])* " --- α = "*string(α), xlabel="μ", ylabel="Host",
     xticks=first(x_range):1:last(x_range), xminorticks = IntervalsBetween(10),xminorticksvisible = true, xminorgridvisible = true)
    plot_orbitdiagram!(ax, system, 3,  x_range, params=[(1, λ[2]),(2,α)], init_vals=(0.5,0.5))
    cs = "λ=" * string(λ[2])
    s = joinpath(plotsdir("BevertonHolt_Nondim"),
     string("orbitdiagram/lambda_alpha_fixed/",cs,".pdf"))
    wsave(s, fig)
end