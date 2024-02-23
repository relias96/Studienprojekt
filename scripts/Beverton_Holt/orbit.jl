using DrWatson
@quickactivate "Studienprojekt"

include(srcdir("HostParasitoid.jl"))
set_theme!(Theme(fontsize = 50))

λ = 7
α = 15.55
μ = 2.5
parameter = [λ, α, μ]
axis_range = 19.5:0.5:23

# Initialize Figure and Axis
fig::Figure = Figure(resolution=(2000,2000))
ax = fig[1, 1] = Axis(fig, title="Orbitdiagram", xlabel="α",ylabel="Host", xticks=axis_range, 
    xminorticks = IntervalsBetween(10),xminorticksvisible = true, xminorgridvisible = true,
    yminorticks = IntervalsBetween(10),yminorticksvisible = true, yminorgridvisible = true  )
# Create Orbitdiagram
plot_orbitdiagram!(ax,2, axis_range; parameter=parameter , n=7, m=7)
display(fig)
