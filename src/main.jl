import Pkg
Pkg.activate("$(@__DIR__)/..")
Pkg.instantiate()
Pkg.precompile()
@info "Running on $(Threads.nthreads()) threads"
@info "To use all threads: julia -tauto src/main.jl"
include("Armstrong.jl")
Armstrong.main()
