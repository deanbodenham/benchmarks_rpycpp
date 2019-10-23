assert = function(bool) {
    if (!bool) stop('Assertion failed')
}

perf <- function(){
    library(microbenchmark)
    filename <- "Rcpptimes.csv"
    conv_nanosecond_to_second <- 1e-9
    ans_pisum <- 1.644834071848065
    ans_fib <- 832040
    # should be ans_pisum <- pi^2 / 6
    # 1.6449340668482264061

    #====================================================#
    # R function calling Rcpp function calling cpp function
    assert(abs(pisumR()-ans_pisum) < 1e-12);
    # using nanoseconds, because seems to be buggy askign for seconds
    # unit = nanoseconds
    # options(microbenchmark.unit="ns")
    res <- microbenchmark(pisumR(), times=21L, unit="ns")
    tmed_pisum <- median(res$time)

    # now convert to seconds
    tmed_pisum <- tmed_pisum * conv_nanosecond_to_second
    cat("pisumR: ", tmed_pisum, " seconds \n", sep="")
    #====================================================#

    #====================================================#
    # Rcpp function, calling cpp function
    assert(abs(pisumRcpp()-ans_pisum) < 1e-12);
    # using nanoseconds, because seems to be buggy askign for seconds
    # unit = nanoseconds
    # options(microbenchmark.unit="ns")
    res <- microbenchmark(pisumRcpp(), times=21L, unit="ns")
    tmed_pisum2 <- median(res$time)

    # now convert to seconds
    tmed_pisum2 <- tmed_pisum2 * conv_nanosecond_to_second
    cat("pisumRcpp: ", tmed_pisum2, " seconds \n", sep="")
    #====================================================#

    #====================================================#
    # R function calling Rcpp function calling cpp function
    assert( fibR(30) == ans_fib )
    res <- microbenchmark(fibR(30), times=21L, unit="ns")
    tmed_fib <- median(res$time)

    # now convert to seconds
    tmed_fib <- tmed_fib * conv_nanosecond_to_second
    cat("fibR (calling Rcpp calling cpp): ", tmed_fib, " seconds \n", sep="")
    #====================================================#


    #====================================================#
    # Rcpp function calling cpp function
    assert( fibRcpp(30) == ans_fib )
    res <- microbenchmark(fibRcpp(30), times=21L, unit="ns")
    tmed_fib2 <- median(res$time)

    # now convert to seconds
    tmed_fib2 <- tmed_fib2 * conv_nanosecond_to_second
    cat("fibRcpp (calling cpp): ", tmed_fib2, " seconds \n", sep="")
    #====================================================#

    #====================================================#
    # Rcpp function for randmatstats will not work on OSX, 
    # because having trouble with RppArmadillo installation
    tmed_randmatstats <- 0
    cat("randmatstatsRcpp (not working): ", tmed_randmatstats, " seconds \n", sep="")
    #====================================================#


    tmed <- c(tmed_pisum, tmed_fib, tmed_randmatstats)
    algoNames <- c("pisum", "fib", "randmatstats")
    df <- data.frame(Rcpp=tmed)
    row.names(df) <- algoNames

    # write to table
    write.table(file=filename, x=df, sep=",", row.names=T, col.names=T, quote=F)
    cat("Writing to: ", filename, "\n", sep="")
}

