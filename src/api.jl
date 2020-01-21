export duration, nframes, framerate, nchannels, sampletype
"""

    duration(x)

Return the duration of the signal in seconds, if known. May return `missing`
or [`inflen`](@ref). The value `missing` always denotes a finite but unknown
length.

!!! note

    A fallback implementation of `duration` uses `nframes(x) / framerate(x)`.
    However, if one or both of these is `missing` and you want `duartion` to
    return a non-missing value, you can define a custom method of `duration`.

"""
duration(x) = nframes(x) / framerate(x)

"""

    nframes(x)

Returns the number of frames in the signal, if known. May return `missing`
 (e.g. for a file stream).

"""
function nframes
end

"""

    framerate(x)

Returns the frame rate of the signal (in Hertz). May return `missing` if the
frame rate is unknown.

"""
function framerate
end

"""

    nchannels(x)

Returns the number of channels in the signal.

"""
function nchannels
end

"""

    sampletype(x)

Returns the element type of an individual channel of a signal (e.g. `Float64`).

!!! note

    The result of `sampletype` and `eltype` (when defined) are often the
    same. They are distinct so that these two can diverge when appropriate.

"""
function sampletype
end
