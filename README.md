# ggplot2.jl

This is a direct interface to [ggplot2](https://ggplot2.tidyverse.org/) from Julia. ggplot2 is IMHO the best plotting library out there.

## Usage

Usage should feel very familiar to someone used to ggplot. The main differences are that `ggplot` is a macro, and geoms, scales, etc. must go in a begin...end block.

```julia
data = DataFrame(a=1:5, b=1:5)

@ggplot data aes(x=a, y=b) begin
    geom_line()
end
```

## Future work

- Specify ggplot layers as an R"" string rather than a macro
- Allow composing plots using `grid.arrange`
- Make output play nice with VSCode and Quarto


[![Build Status](https://github.com/mattwigway/ggplot2.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/mattwigway/ggplot2.jl/actions/workflows/CI.yml?query=branch%3Amain)
