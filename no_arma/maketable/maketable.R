maketable <- function(){
    Rfilename <- "../R/Rtimes.csv"
    Rcppfilename <- "../Rcpp/perfRcpp/Rcpptimes.csv"
    cppfilename <- "../cpp/cpptimes.csv"
    pythonfilename <- "../python/pytimes.txt"
    cythonfilename <- "../cython/cythontimes.txt"
    MATLABfilename <- "../MATLAB/MATLABtimes.csv"
    fib_filename <- "fib.csv"
    pisum_filename <- "pisum.csv"

    dfR <- read.table(Rfilename, header=T, sep=",")
    dfcpp <- read.table(cppfilename, header=T, sep=",")
    dfRcpp <- read.table(Rcppfilename, header=T, sep=",")
    dfpython <- read.table(pythonfilename, header=T, sep=",")
    dfcython <- read.table(cythonfilename, header=T, sep=",")
    dfMATLAB <- read.table(MATLABfilename, header=T, sep=",")
    print(dfcpp)

    dfall <- cbind(dfR, dfpython, dfcpp, dfRcpp, dfcython, dfMATLAB)
    #dfall <- cbind(dfR, dfpython, dfcpp, dfRcpp, dfcython)
    print(dfall)

    pisum_vec <- as.numeric(dfall["pisum", ])
    fib_vec <- as.numeric(dfall["fib", ])

    pisum_df <- data.frame(names=colnames(dfall), values=pisum_vec)
    fib_df <- data.frame(names=colnames(dfall), values=fib_vec)
    print(pisum_df)
    print(fib_df)

    write.table(x=pisum_df, file=pisum_filename, quote=F, sep=",", row.names=F, col.names=T)
    write.table(x=fib_df, file=fib_filename, quote=F, sep=",", row.names=F, col.names=T)
    cat("writing to: ", pisum_filename, "\n", sep="")
    cat("writing to: ", fib_filename, "\n", sep="")
}
maketable()
