# SignalBase

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://haberdashpi.github.io/SignalBase.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://haberdashpi.github.io/SignalBase.jl/dev)
[![Build Status](https://travis-ci.com/haberdashPI/SignalBase.jl.svg?branch=master)](https://travis-ci.com/haberdashPI/SignalBase.jl)

SignalBase defines a basic API to inspect signals that are regularly sampled in time. It consists of the following functions.

- [`sampletype`](https://haberdashpi.github.io/SignalBase.jl/dev/#SignalBase.sampletype): a type `T <: Number` used to represent each sample, similar in purpose to `eltype`, but some signals may define these two functions differently.
- [`nchannels`](https://haberdashpi.github.io/SignalBase.jl/dev/#SignalBase.nchannels): the number of samples per frame
- [`framerate`](https://haberdashpi.github.io/SignalBase.jl/dev/#SignalBase.framerate): the number of frames per second, can be a `missing` value.
- [`nframes`](https://haberdashpi.github.io/SignalBase.jl/dev/#SignalBase.nframes): the number of frames; this can be a `missing` value
- [`duration`](https://haberdashpi.github.io/SignalBase.jl/dev/#SignalBase.duration): the duration in seconds of the signal (defaults to nframes(x) / framerate(x)). This value can be a `missing` value. This could be defined seperately from nframes if, for example, the framerate is unknown but the duration is known.

For example, one natural definition of an `Array`, interpreted as a signal would be as follows.

```julia
sampletype(x::Array) = eltype(x)
nchannels(x::Array) = size(x,2)
framerate(x::Array) = missing
nframes(x::Array) = size(x,1)
```

Such a definition is provided by [`SignalOperators`](https://github.com/haberdashPI/SignalOperators.jl).

## Units

This package also defines a set of utility functions for working with units relevant to signals via [`Unitful`](https://github.com/PainterQubits/Unitful.jl): namely, radians, frames, seconds and Hertz. The `frames` unit is newly defined here so that converstions between frames and units of time is convienient and unambiguous. The other three are already defined by `Unitful`. The following functions are available.

- [`inradians`](https://haberdashpi.github.io/SignalBase.jl/dev/#SignalBase.inradians): converts a quantity to radians
- [`inframes`](https://haberdashpi.github.io/SignalBase.jl/dev/#SignalBase.inframes): converts a quantity to frames
- [`inseconds`](https://haberdashpi.github.io/SignalBase.jl/dev/#SignalBase.inseconds): converts a quantity to seconds
- [`inHz`](https://haberdashpi.github.io/SignalBase.jl/dev/#SignalBase.inHz): converst a quantity to Hertz

These functions apply the following phillosophy: units can be useful as part of a public API, but they should be an optional feature. Therefore, if a value is passed with a given unit type (e.g. `1kHz`), use it. If the value has no unit specified, assume a default unit type: e.g. inHz(10.0) would assume that `10.0` is in units of Hertz. The returned value for all these functions are in the stated units, as a `Float64` value.

The utility functions all properly handle `missing` values.

To make use of the unit names themselves (e.g. `s` for seconds) you can add them via `SignalsBase.Units`. They are only exported in this sub-module to avoid pollutting the namespace with short unit names unless desired. The exported units are: kframes, frames, Hz, s, kHz, ms, dB, °, rad