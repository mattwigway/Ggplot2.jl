"Wrapper for a GGplot2 plot"
struct Plot
    plot::RObject{VecSxp}
end

"""
    render(io, p, ext)

Render plot `p` to `io` using ggsave and a temporary file, with the file type determined by ggsave using the extension `ext`
"""
function render(io, p, ext)
    # using a temporary directory rather than a file b/c julia doesn't allow setting a file
    # extension with mktemp.
    mktempdir() do path
        output = joinpath(path, "plot.$ext")
        rcall(:ggsave, output, plot=p.plot)

        open(output) do content
            write(io, content)
        end
    end
end

"Show a plot as SVG"
function Base.show(io::IO, ::MIME"image/svg+xml", p::Plot)
    render(io, p, "svg")
end

"Show a plot as PNG"
function Base.show(io::IO, ::MIME"image/png", p::Plot)
    render(io, p, "png")
end