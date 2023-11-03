using DynamicalSystems
using CairoMakie
using OrdinaryDiffEq

include("colorscheme.jl")

"Definiert das Host-Parasitoid System aus dem Paper"
function Moran_Ricker(Population, Parameter, Time)
    N, P = Population
    r, a, T, T_h = Parameter
    N_next = N * exp(r*(1 - N) - ((a * T * P)/(1 + a * T_h * N)))
    P_next = N * (1 - exp((-a * T * P)/(1 + a * T_h * N)))
    return SVector(N_next, P_next)
end

function Beverton_Holt(Popultation, Parameter, Time)
    H, P = Popultation
    λ, a, h, type = Parameter
    if type == 2
        f = exp((-a*P)/(1+h*H))
    end
    if type == 3
        f = exp((-a*H*P)/(1+h*H*H))
    end
    H_next = λ*H / (1+(λ-1)*H) * f
    P_next = H*(1 - f)
    return SVector(H_next, P_next)
end


"Plottet ein Bifurkationsdiagramm für unser Host-Parasitoid System"
function plot_orbitdiagram!(
    ax,
    system,
    x_range::StepRangeLen;
    params=[] ::Vector{Tuple{Int64, Float64}},  #Tuple Index and Value
    init_vals= (0.5, 0.5) ::Tuple{Float64, Float64})

    for p in params
        set_parameter!(system, p[1], p[2])
    end

    if init_vals != []
        set_state!(system, init_vals)
    end

    o::Vector{Vector{Float64}} = orbitdiagram(system , 1, 2, x_range, Ttr= 10000, n=500, u0=init_vals)

    for i  in zip(x_range, o::Vector{Vector{Float64}})
        scatter!(ax, fill(i[1],size(i[2])), i[2], markersize=1, color="black", dpi=300)
    end 
end

"Plottet eine Zeitreihe"
function plot_timeseries(
    system;
    time_end=100
    )
    "Erstellen einer Zeitreihe"
    data, time = trajectory(system, time_end)

    fig = Figure()
    ax = Axis(fig[1, 1], xlabel = "Time", ylabel = "Value", title = "Timeseries")
    lines!(ax, time, data[:, 2], label="parasitoid")
    lines!(ax, time, data[:,1], label="host")
    axislegend(ax)
    return fig
end

"Plottet den Statespace"
function plot_statespace!(
    ax,
    system,
    time_end=100;
    init_vals=(0.5,0.5))
    data, time = trajectory(system, time_end,init_vals, Ttr=0)
    #fig = Figure()
    #ax = Axis(fig[1, 1], xlabel = "Host", ylabel = "Parasitoid", title = "Statespace")
    scatter!(ax, data[:,1], data[:, 2], color="black")
    #return fig
end

function generate_cmap(n)
    if n > length(COLORS)
        return :viridis
    else
        return cgrad(COLORS[1:n], n; categorical = true)
    end
end

function plot_basin!(
    fig :: Figure,
    system,
    xgrid=range(0.001,1;length=1000),
    ygrid=range(0.001,1;length=1000),
    t=""
    )

    theme!(length(xgrid)/50)
    grid = (xgrid, ygrid)
    mapper = AttractorsViaRecurrences(system, grid, sparse = true, Ttr= 0,consecutive_recurrences = 1000, attractor_locate_steps = 10000)
    basin, attractors = basins_of_attraction(mapper,grid)
    fracs = basins_fractions(basin)
    #println(fracs)
    ###########
    ids = sort!(unique(basin))
    # Modification in case attractor labels are not sequential:
    for i in 2:length(ids)
        if ids[i] - ids[i-1] ≠ 1
            replace!(basin, ids[i] => ids[i-1]+1)
            replace!(ids, ids[i] => ids[i-1]+1)
        end
    end

    cmap = generate_cmap(length(ids))

 ###############   

    #bas = Figure(resolution=(length(xgrid),length(ygrid)))
    ax = Axis(fig[1,1],
        xlabel="Host",
        ylabel="Parasitoid",
        title=t)
    hm = heatmap!(ax,xgrid,ygrid,basin, colormap = cmap, colorrange = (ids[1] - 0.5, ids[end]+0.5),)

    cb = Colorbar(fig[1,3], hm)
    l = string.(ids)
    if 0 ∈ ids
        l[1] = "-1"
    end 
    cb.ticks = (ids, l)

    set_theme!()
    ####

    #statespace = Figure()
    axis = Axis(fig[1, 2],
        limits = (first(xgrid), last(xgrid), first(ygrid), last(ygrid)),
        xlabel="Host",
        ylabel="Parasitoid",
        title="statespace matching the basin Plot",
    )
    for m in attractors
        scatter!(axis, m[2][:,1], m[2][:,2], label="Attractor " * string(m[1]),color=COLORS[m[1]+1], markersize=8)
    end
    axislegend()

    return ax, axis, basin
    #return fig, statespace, attractors
end

function plot_statespace_Ntimes(
    system=system,
    time_end=200;
    n=100
    )
    fig = Figure() 
    ax = Axis(fig[1, 1], xlabel = "Host", ylabel = "Parasitoid", title = "Statespace")
    for i in 1:1:n
        data, time = trajectory(system, time_end, (rand(),rand()), Ttr=20000)
        scatter!(ax, data[:,1], data[:, 2], label=string(i))
    end
    axislegend()
    return fig
end

function theme!(n = 26::Int32)
    set_theme!(;
        palette = (color = COLORS,), 
        fontsize = n,
    )
end