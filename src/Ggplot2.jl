module Ggplot2

import RCall: reval, rcall, @R_str, @rput, @rget, RObject, VecSxp

function __init__()
    R"""
    library(ggplot2)
    """
end

include("macro.jl")
include("plot.jl")

export @ggplot

end
