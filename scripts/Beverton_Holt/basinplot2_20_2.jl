using DrWatson
@quickactivate "Studienprojekt"

include(srcdir("HostParasitoid.jl"))

#=
# λ, a, h, type 
parameter = [2, 20, 2, 3]
population = [rand(0.0:0.01:2.0),rand(0.0:0.01:2.0)]
system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)


a,b,c = plot_basin(system, xgrid=range(0.0001,1,2000), ygrid=range(0.0001,1,2000), t=string(parameter))

display(a)
display(b)
=#
open(datadir("sims", "BevertonHolt_3Attr.txt"),"a+") do io
    for i in 1:10
        parameter = [rand(2:0.01:9), rand(12:0.01:25), 3, 3]
        population = [rand(0.0:0.01:2.0),rand(0.0:0.01:2.0)]
        system = DiscreteDynamicalSystem(Beverton_Holt, population, parameter)
        title = string("λ = "*string(parameter[1]), "   a = "*string(parameter[2]), "   h = "*string(parameter[3]), "   type = "*string(parameter[4]))
        
        a,b,c = plot_basin(system, xgrid=range(0.0001,1,2000), ygrid=range(0.0001,1,2000), 
        t=title)

        if length(c) > 1
            display(a)
            display(b)
        end

        if length(c) > 1
            println(io, title)
        end
    end
end