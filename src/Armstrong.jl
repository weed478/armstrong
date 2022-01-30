module Armstrong

using Primes

# ndigits - base(ndigits+1) encoding (maximum number of digits)
# len - actual number of digits

function getdigitmap(n, ndigits)
    digitmap = 0
    for d in digits(n)
        digitmap += (ndigits + 1)^d
    end
    digitmap
end

function getsump(digitmap, ndigits, len)
    digitmap ÷= ndigits + 1 # remove 0s count
    # force vars to use Int128 so no calculations overflow
    Σ::Int128 = 0
    for d::Int128 in 1:9
        digitmap, dcount::Int128 = divrem(digitmap, ndigits + 1)
        Σ += dcount * d ^ len
    end
    Σ
end

function testsump(digitmap, ndigits, len)
    sump = getsump(digitmap, ndigits, len)
    # quickly reject non-prime numbers
    if Primes.isprime(sump) && getdigitmap(sump, ndigits) == digitmap
        println(sump)
    end
    nothing
end

# checks all numbers with "ndigits" digits
function forallcombos(ndigits, depth=10, digitmap=0, clen=0)
    if depth == 0
        testsump(digitmap, ndigits, clen)
    else
        # change to second line to use only 1 thread
        Threads.@threads for i in 0:ndigits - clen
        # for i in 0:ndigits - clen
            forallcombos(ndigits, depth - 1, digitmap * (ndigits + 1) + i, clen + i)
        end
    end
    nothing
end

function main()
    # biggest armstrong number has 23 digits
    ndigits = 23
    println("Starting armstrong")
    time = @elapsed forallcombos(ndigits)
    println("Took $time seconds")
    nothing
end

# Example run:
# $ julia -tauto src/main.jl
# Activating project at `~/aghproj/armstrong`
# Precompiling project...
#   1 dependency successfully precompiled in 0 seconds (1 already precompiled)
# [ Info: Running on 24 threads
# [ Info: To use all threads: julia -tauto src/main.jl
# Starting armstrong
# 2
# 3
# 5
# 35452590104031691935943
# 7
# 449177399146038697307
# 28116440335967  <- last number prints a few seconds before end of program
# Took 20.811174646 seconds <- total runtime (checking all 23 digit numbers, not knowing there are only 7)

end # module
