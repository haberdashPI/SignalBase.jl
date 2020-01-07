using Documenter, SignalBase

makedocs(;
    modules=[SignalBase],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/haberdashpi/SignalBase.jl/blob/{commit}{path}#L{line}",
    sitename="SignalBase.jl",
    authors="David F. Little",
    assets=String[],
)
