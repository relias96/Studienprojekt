using DrWatson
@quickactivate "Studienprojekt"

# Here you may include files from the source directory
include(srcdir("HostParasitoid.jl"))

parameter = [2, 20, 2, 3]
population = [0.5,0.75]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

plot_timeseries(system, time_end=200)


n = 0:0.001:1

#function N(n, p, λ, α, μ)
 #   f = exp((-α*n*p)/(1+μ*n*n))
    return λ*n / (1+(λ-1)*n) * f
#end




fig = Figure()
ax = Axis(fig[1,1])

for p ∈ 1:1:5
    n_next = N.(0:0.001:1,p,2,20,2)
    lines!(ax,n,n_next, label=string(p))
end
axislegend(ax)

display(fig)