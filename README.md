# ggplot2.jl

This is a direct interface to [ggplot2](https://ggplot2.tidyverse.org/) from Julia. ggplot2 is IMHO the best plotting library out there.

## Usage

Usage should feel very familiar to someone used to `ggplot`. The main differences are that `ggplot` is a macro, and geoms, scales, etc. must go in a begin...end block.

```julia
using Ggplot2

data = DataFrame(a=1:5, b=1:5)

@ggplot data aes(x=a, y=b) begin
    geom_line() +
    xlab("X axis")
end
```

The first argument after the `ggplot` macro is the dataset. At this point the data can only be specified here; you cannot specify additional datasets within the macro (e.g. to add multiple `geom_sf` layers with different underlying datasets). This data will be copied into global state in a child R process (i.e. you can't use ggplot from multiple threads in Julia). The aesthetic comes next, and then with a `begin...end` block everything else you would add to your plot (geoms, themes, etc.). `Ggplot2.jl` will load `ggplot` itself. If you want to load any other packages (e.g. custom geoms or [themes](https://github.com/mattwigway/ggunc)), you can do that by also loading [RCall](https://juliainterop.github.io/RCall.jl/stable/) and loading those libraries with an R"" string, e.g.

```julia

using Ggplot2, RCall

R"library(ggunc)"
```

## Future work

- Specify ggplot layers as an R"" string rather than a macro
- Allow composing plots using `grid.arrange`


[![Build Status](https://github.com/mattwigway/ggplot2.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/mattwigway/ggplot2.jl/actions/workflows/CI.yml?query=branch%3Amain)
