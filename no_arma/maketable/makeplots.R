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


    if (plotToScreen){
        require("ggpubr")
        ggarrange(p_pisum, p_fib, ncol = 2, nrow = 1)
    }
}
