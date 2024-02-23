using DynamicalSystems
using CairoMakie
using OrdinaryDiffEq
using Serialization

include("colorscheme.jl")

"Definiert das Host-Parasitoid System aus dem Paper"
function Moran_Ricker(Population, Parameter, Time)
    N, P = Population
    r, a, T, T_h = Parameter
    N_next = N * exp(r*(1 - N) - ((a * T * P)/(1 + a * T_h * N)))
    P_next = N * (1 - exp((-a * T * P)/(1 + a * T_h * N)))
    return SVector(N_next, P_next)
end

"Definiert das Host-Parasitoid System aus dem meinem Projektbericht"
function Beverton_Holt(Popultation, Parameter, Time)
    n, p = Popultation
    λ, α, μ = Parameter
    f = exp((-α*n*p)/(1+μ*n*n))
    n_next = λ*n / (1+(λ-1)*n) * f
    p_next = n*(1 - f)
    return SVector(n_next, p_next)
end


"Plottet ein Bifurkationsdiagramm für unser Host-Parasitoid System"
function plot_orbitdiagram!(ax::Axis, variation_parameter_index::Int64, axis_range::StepRangeLen; 
    parameter=[] ::Vector{Tuple{Int64, Float64}}, n = 5, m = 10)

    stepsize = (last(axis_range)-first(axis_range))/800
    variation_parameter_range = first(axis_range):stepsize:last(axis_range)

    o = [Vector{Float64}(undef, 250) for _ = 1:length(variation_parameter_range)]
    population = Vector{Float64}(undef,2)

    function get_unique(x::Vector{Vector{Float64}})
        map(x -> unique!(round.(x,digits = 4)),x)
    end

    for counter in 0:1:m
        population = [rand(0.01:0.000001:1),rand(0.01:0.00001:1.0)]
        system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)

        o::Vector{Vector{Float64}} = get_unique(orbitdiagram(system , 1, variation_parameter_index, variation_parameter_range, Ttr= 800, n=250, u0=population; show_progress = true))
        
        for (j,p)  in enumerate(variation_parameter_range)
            l = length(o[j])
            if l < 100
                scatter!(ax, p .* ones(l),o[j], markersize=3, color=:black, dpi=300)
            elseif counter < n 
                scatter!(ax, p .* ones(l),o[j] , markersize=5, color=(:black,0.015), dpi=300)
            end
        end 
        println("progress " * string(counter+1)*"/"*string(m+1))
    end
end

"Plottet eine Zeitreihe"
function plot_timeseries!(ax, system; time_end=100)
   println(system.u)
    "Erstellen einer Zeitreihe"
    data, time = trajectory(system, time_end)

    scatter!(ax, time, data[:, 2], label="parasitoid", markersize=4, color=COLORS[2],dpi=300)
    scatter!(ax, time, data[:,1], label="host", markersize=4, color = COLORS[3],dpi=300)
    #axislegend(ax)
end

"Plottet den Statespace"
function plot_statespace!(
    ax,
    system,
    time_end=100;
    init_vals=(0.5,0.5))
    data, time = trajectory(system, time_end,init_vals, Ttr=0)
    scatter!(ax, data[:,1], data[:, 2], color="black")
end

function get_basin(
    system,
    xgrid=range(0.001,1;length=1000),
    ygrid=range(0.001,1;length=1000);
    
    Ttr=4000,
    consecutive_recurrences = 1400,
    attractor_locate_steps = 10000
    )

    p = system.p
    bname = joinpath(datadir("exp_raw"),replace("basin"*"λ="*string(p[1])*"α="*string(p[2])*"μ="*string(p[3]),"."=>",")*".jls")
    aname = joinpath(datadir("exp_raw"),replace("attractor"*"λ="*string(p[1])*"α="*string(p[2])*"μ="*string(p[3]),"."=>",")*".jls")

    try 
        basin = open(deserialize, bname)
        attractors = open(deserialize, aname)
        return basin, attractors
    catch
        grid = (xgrid, ygrid)
        mapper = AttractorsViaRecurrences(system, grid, sparse = true, Ttr= Ttr,consecutive_recurrences = consecutive_recurrences , attractor_locate_steps = attractor_locate_steps, consecutive_attractor_steps=8)
        basin, attractors = basins_of_attraction(mapper,grid)

        open(f -> serialize(f,basin), bname, "w")
        open(f -> serialize(f,attractors), aname, "w");
        return basin, attractors
    end
end

function plot_basin!(system, fig :: Figure, data;
    xgrid=range(0.001,1;length=1000),
    ygrid=range(0.001,1;length=1000)
    )

    theme!()
    basin, attractors = data
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
    ax1 = Axis(fig[1,1],
        aspect = 1,
        xlabel="Host",
        ylabel="Parasitoid",
        #title = string("λ = "* string(system.p[1]) *"  ---  α = "*string(system.p[2])*"  ---  μ = "* string(system.p[3]))
        title="Basin"
        )
    hm = heatmap!(ax1,xgrid,ygrid,basin, colormap = cmap, colorrange = (ids[1] - 0.5, ids[end]+0.5,))



    ax2 = Axis(fig[1, 2],
        aspect = 1,
        limits = (first(xgrid), last(xgrid), first(ygrid), last(ygrid) ),
        xlabel="Host",
        title="Statespace matching the Basin",
    )
    for m in attractors
        if length(m[2][:,1]) < 500
            scatter!(ax2, m[2][:,1], m[2][:,2], label="Attractor " * string(m[1]),color=COLORS[m[1]], markersize=16)
        else
            scatter!(ax2, m[2][:,1], m[2][:,2], label="Attractor " * string(m[1]),color=COLORS[m[1]], markersize=2)
        end
    end
    #axislegend()

    cb = Colorbar(fig[1,3], hm)
    l = string.(ids)
    if 0 ∈ ids
        l[1] = "-1"
    end 
    cb.ticks = (ids, l)

    linkyaxes!(ax1, ax2)
    return ax1, ax2
end

function generate_cmap(n)
    if n > length(COLORS)
        return :viridis
    elseif n ==1
        return cgrad(COLORS[1:n], n+1; categorical = true)
    else
        return cgrad(COLORS[1:n], n; categorical = true)
    end
end

function theme!()
    myTheme = Theme(
    fontsize=40,
    Axis=(
        xlabelsize=35,xlabelpadding=-5, ylabelsize=35,
        xgridstyle=:dash, ygridstyle=:dash,
        xtickalign=1, ytickalign=1,
        yticksize=15, xticksize=15,
        yticklabelsize=25, xticklabelsize=25,
        ),
    Colorbar=(ticksize=16, spinewidth=0.8),
    )
    set_theme!(myTheme)
    
end