
function find_arg_vector(expr)
    for arg in expr.args
        if arg isa Expr
            first, rest = Iterators.peel(arg.args)
            if first == :+
                return collect(rest)
            end
        end
    end

    # if we haven't found anything, it's probably a single expr
    return [last(expr.args)]
end

"""
    @ggplot data aes() begin
        geom_line() +
        theme_minimal()...
    end

Create a ggplot. Data should be a Tables.jl compatible table. Specify
aesthetic mappings in aes(), and then normal ggplot layers/scales/themes/etc
between begin and end
"""
macro ggplot(data, aes, expr)
    # construct the R code
    rcode = IOBuffer()

    arg_vector = find_arg_vector(expr)

    print(rcode, "ggplot(plot_data, ")
    Base.show_unquoted(rcode, aes)
    print(rcode, ")")

    for element in arg_vector
        println(rcode, " +")
        Base.show_unquoted(rcode, element)
    end

    rcode_str = String(take!(rcode))

    println(rcode_str)

    return quote
        plot_data = $(esc(data))
        @rput plot_data
        Plot(reval($rcode_str))
    end
end