process <- function(){
    t <- c(0.04, 0.005)
    dfout <- data.frame(R=t)
    filename <- "temp.txt"
    row.names(dfout) <- c("pisum", "fib")
    cat("\ndf out:\n")
    print(dfout)

    # write to table
    write.table(file=filename, x=dfout, sep=",", row.names=T, col.names=T, quote=F)

    # read in 
    dfin <- read.table(filename, header=T, sep=",")
    cat("\n\ndf in: \n")
    print(dfin)
}

