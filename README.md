# SignalBase

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://haberdashpi.github.io/SignalBase.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://haberdashpi.github.io/SignalBase.jl/dev)
[![Build Status](https://travis-ci.org/haberdashPI/SignalBase.jl.svg?branch=master)](https://travis-ci.org/haberdashPI/SignalBase.jl)

SignalBase defines a basic API to inspect finite or infinite length signals that are regularly sampled in time. It consists of the following functions.

- [`channeltype`](https://haberdashpi.github.io/SignalBase.jl/stable/reference/#SignalBase.channeltype): a type `T <: Number` used to represent each channel, similar in purpose to `eltype`, but some signals may define these two functions differently, and some signals may only define `channeltype`
- [`nchannels`](https://haberdashpi.github.io/SignalBase.jl/stable/reference/#SignalBase.nchannels): the number of channels per frame
- [`framerate`](https://haberdashpi.github.io/SignalBase.jl/stable/reference/#SignalBase.framerate): the number of frames per second, can be a `missing` value.
- [`nframes`](https://haberdashpi.github.io/SignalBase.jl/stable/reference/#SignalBase.nframes): the number of frames; this can be a `missing` value or an `inflen` value (see below)
- [`duration`](https://haberdashpi.github.io/SignalBase.jl/stable/reference/#SignalBase.duration): the duration in seconds of the signal (defaults to nframes(x) / framerate(x)). This value can be a `missing` value or an `inflen` value (see below). This could be defined seperately from nframes if, for example, the framerate is unknown but the duration is known.

For example, one natural definition of an `Array`, interpreted as a signal would be as follows.

```julia
channeltype(x::Array) = eltype(x)
nchannels(x::Array) = size(x,2)
framerate(x::Array) = missing
nframes(x::Array) = size(x,1)
```

Such a definition is provided by [`SignalOperators`](https://github.com/haberdashPI/SignalOperators.jl).

## Infinite and Missing values

Some signals have an unknown but finite length (represented by `missing`) or a known infinite length. An example of an unknown finite length would be a file stream. An example of a known infinite length signal would be a signal defined by a function (e.g. a sine wave). Infinite lengths are represented with the value `inflen`. The value `inflen` interacts with `missing` assuming the missing value is finite: e.g. `inflen*missing == inflen`. It also has overloaded definitions of various operators to play nicely with ordering, arithmetic, and so on, for `Number` types.

## Units

This package also defines a set of utility functions for working with units relevant to signals via [`Unitful`](https://github.com/PainterQubits/Unitful.jl): namely, radians, frames, seconds and Hertz. The `frames` unit is newly defined here so that converstions between frames and units of time is convienient and unambiguous. The other three are already defined by `Unitful`. The following functions are available.

- [`inradians`](https://haberdashpi.github.io/SignalBase.jl/stable/reference/#SignalBase.inradians): converts a quantity to radians
- [`inframes`](https://haberdashpi.github.io/SignalBase.jl/stable/reference/#SignalBase.inframes): converts a quantity to frames
- [`inseconds`](https://haberdashpi.github.io/SignalBase.jl/stable/reference/#SignalBase.inseconds): converts a quantity to seconds
- [`inHz`](https://haberdashpi.github.io/SignalBase.jl/stable/reference/#SignalBase.inHz): converst a quantity to Hertz

These functions apply the following phillosophy: units can be useful as part of a public API, but they should be an optional feature. Therefore, if a value is passed with a given unit type (e.g. `1kHz`), use it. If the value has no unit specified, assume a default unit type: e.g. inHz(10.0) would assume that `10.0` is in units of Hertz. The returned value for all these functions are in the stated units, as a `Float64` value.

The utility functions all properly handle `missing` or `inflen` values.

To make use of the unit names themselves (e.g. `s` for seconds) you can add them via `SignalsBase.Units`. They are only exported in this sub-module to avoid pollutting the namespace with short unit names unless desired. The exported units are: kframes, frames, Hz, s, kHz, ms, dB, °, rad