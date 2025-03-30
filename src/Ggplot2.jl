module Ggplot2

import RCall: reval, rcall, @R_str, @rput, @rget, RObject, VecSxp

function __init__()
    # allow the package to load in CI
    if !haskey(ENV, "JULIA_REGISTRYCI_AUTOMERGE") || ENV["JULIA_REGISTRYCI_AUTOMERGE"] ≠ "true"
        R"""
        library(ggplot2)
        """
    end
end

include("macro.jl")
include("plot.jl")

export @ggplot

end
