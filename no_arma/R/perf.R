# Code From:
# https://github.com/JuliaLang/Microbenchmarks/blob/master/perf.R


# nested for loop, trying to compute sum_{i=1}^{10000} (1/i^2), 500 times

## pi_sum ##
pisum = function() {
    t = 0.0
    for (j in 1:1000) {
        t = 0.0
        for (k in 1:10000) {
            t = t + 1.0/(k*k)
        }
    }
    return(t)
}

## pi_sum_vec ##
pisumvec = function() {
    r = 1:10000
    return(replicate(1000, sum(1/((r)^2)))[1])
}


## Fibonacci
fib = function(n) {
    if (n < 2) {
        return(n)
    } else {
        return(fib(n-1) + fib(n-2))
    }
}



assert = function(bool) {
    if (!bool) stop('Assertion failed')
}


perf <- function(){
    library(microbenchmark)
    filename <- "Rtimes.csv"
    conv_nanosecond_to_second <- 1e-9
    ans_pisum <- 1.644834071848065
    ans_fib <- 832040
    #ans_pisum <- 1.6449106278707863
    # should be ans_pisum <- pi^2 / 6
    # 1.6449340668482264061

    assert(abs(pisum()-ans_pisum) < 1e-12)
    # using nanoseconds, because seems to be buggy askign for seconds
    # unit = nanoseconds
    # options(microbenchmark.unit="ns")

    res <- microbenchmark(pisum(), times=21L, unit="ns")
    tmed_pisum <- median(res$time)

    # now convert to seconds
    tmed_pisum <- tmed_pisum * conv_nanosecond_to_second
    cat("median time is (pisum, for loop): ", tmed_pisum, " seconds \n", sep="")
    
    assert( fib(30) == ans_fib )
    res <- microbenchmark(fib(30), times=21L, unit="ns")
    tmed_fib <- median(res$time)

    # now convert to seconds
    tmed_fib <- tmed_fib * conv_nanosecond_to_second
    cat("median time is (fib, recursive): ", tmed_fib, " seconds \n", sep="")



    tmed <- c(tmed_pisum, tmed_fib)
    algoNames <- c("pisum", "fib")
    df <- data.frame(R=tmed)
    row.names(df) <- algoNames

    # write to table
    write.table(file=filename, x=df, sep=",", row.names=T, col.names=T, quote=F)
    cat("Writing to: ", filename, "\n", sep="")
}

perf()
