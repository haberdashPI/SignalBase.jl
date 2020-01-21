using SignalBase
using SignalBase.Units
using Unitful
using Test

@testset "SignalBase.jl" begin
    @test inframes(1s,44.1kHz) == 44100
    @test inframes(Int,0.5s,44.1kHz) == 22050
    @test inframes(Int,5frames) == 5
    @test inframes(Int,5) == 5
    @test inframes(5) == 5
    @test inframes(1.0s,44.1kHz) isa Float64
    @test ismissing(inframes(missing))
    @test ismissing(inframes(Int,missing))
    @test ismissing(inframes(Int,missing,5))
    @test ismissing(inframes(missing,5))
    @test ismissing(inframes(10s))

    @test inHz(10) === 10
    @test inHz(10Hz) === 10
    @test inHz(Float64,10Hz) === 10.0
    @test inHz(Int,10.5Hz) === 10
    @test ismissing(inHz(missing))

    @test inseconds(50ms) == 1//20
    @test inseconds(50ms,10Hz) == 1//20
    @test inseconds(10frames,10Hz) == 1
    @test inseconds(1s,44.1kHz) == 1
    @test inseconds(1,44.1kHz) == 1
    @test inseconds(1) == 1
    @test ismissing(inseconds(missing))

    @test inradians(15) == 15
    @test_throws Unitful.DimensionError inradians(15frames)
    @test inradians(180°) ≈ π
    @test ismissing(inseconds(2frames))
end
