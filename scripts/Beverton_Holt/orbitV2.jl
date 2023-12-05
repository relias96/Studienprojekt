using DrWatson
@quickactivate "Studienprojekt"

include(srcdir("HostParasitoid.jl"))


# λ, a, h, type
λ = 7
#α = 21.5:0.01=21.7
α_range = 21.5:0.01:21.7
μ = 2.5


parameter = [λ, α, μ]



myTheme = Theme(fontsize = 40)
set_theme!(myTheme)

fig::Figure = Figure(resolution=(3840,2160))
ax = fig[1, 1] = Axis(fig, title="Orbitdiagram with the Parameters  λ = " * string(λ)* " --- μ = "*string(μ), xlabel="α",ylabel="Host", xlimits=[19, 20],
    xminorticks = IntervalsBetween(10),xminorticksvisible = true, xminorgridvisible = true )


for i in α_range 
    parameter = [λ, i, μ]
    population = [rand(0.0:0.01:2.0),rand(0.0:0.01:2.0)]
    system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)
    data = get_basin(system,  Ttr=0, consecutive_recurrences = 1600, attractor_locate_steps = 10000)

    for m in data[2]
        s = length(m[2][:,1])
        if s > 50
            scatter!(ax, i .* ones(s), m[2][:,1], label="Attractor " * string(m[1]), markersize=8,color=(COLORS[m[1]],0.2))
        else
            plo = scatter!(ax, i .* ones(s), m[2][:,1], label="Attractor " * string(m[1]), markersize=8,color=COLORS[m[1]])
        end
    end
    display(fig)
end