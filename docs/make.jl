using Documenter, SignalBase

DocMeta.setdocmeta!(SignalBase, :DocTestSetup, :(using SignalBase; using SignalBase.Units); recursive=true)

makedocs(;
    modules=[SignalBase],
    format=Documenter.HTML(),
    pages=[
        "Reference" => "index.md",
    ],
    repo="https://github.com/haberdashpi/SignalBase.jl/blob/{commit}{path}#L{line}",
    sitename="SignalBase.jl",
    authors="David F. Little",
)

deploydocs(;
    repo="github.com/haberdashPI/SignalBase.jl",
)