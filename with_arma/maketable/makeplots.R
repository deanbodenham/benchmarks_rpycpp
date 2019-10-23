makeplots <- function(plotToScreen=F){
    source("hbarplot.R")

    # pisum
    file_pisum <- "pisum.csv"
    df_pisum <- read.table(file=file_pisum, header=T, sep=",", stringsAsFactors=F)
    print(df_pisum)
    p_pisum <- gghbar(df=df_pisum, plot.theme="dark", useNewNames=T, uselog=F, x.axis.show=T, ylab="seconds elapsed", digits=3, suffix="s", title="Pisum")

    # fib
    file_fib <- "fib.csv"
    df_fib <- read.table(file=file_fib, header=T, sep=",", stringsAsFactors=F)
    print(df_fib)
    p_fib <- gghbar(df=df_fib, plot.theme="dark", bar.theme="green", useNewNames=T, uselog=F, x.axis.show=T, ylab="seconds elapsed", digits=4, suffix="s", title="Recursive Fibonnaci")

    # randmatstat
    file_randmatstat <- "randmatstat.csv"
    df_randmatstat <- read.table(file=file_randmatstat, header=T, sep=",", stringsAsFactors=F)
    print(df_randmatstat)
    p_randmatstat <- gghbar(df=df_randmatstat, plot.theme="dark", bar.theme="purple", useNewNames=T, uselog=F, x.axis.show=T, ylab="seconds elapsed, randmatstat", digits=4, suffix="s", title="Random matrix statistics")

    if (plotToScreen){
        require("ggpubr")
        ggarrange(p_pisum, p_fib, p_randmatstat, ncol = 3, nrow = 1)
    }
}
