tempplot <- function(){
    require(ggplot2)
    require(scales)

    file_pisum <- "pisum.csv"
    df_pisum <- read.table(file=file_pisum, header=T, sep=",", stringsAsFactors=F)
    print(df_pisum)


#    p <- ggplot( df_pisum, aes(x=names, y=values) ) + geom_bar(position="dodge", stat="identity") #+ coord_trans(y="log10")
#    p <- p + scale_y_log10()
#    p + scale_y_continuous(trans = log2_trans(),
#        breaks = trans_breaks("log2", function(x) 2^x),
#        labels = trans_format("log2", math_format(2^.x)))

#    p <- p + scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
#              labels = trans_format("log10", math_format(10^.x))) 
#    p <- p + annotation_logticks(sides="trbl")
#
#    library("scales")
#    reverselog_trans <- function(base = exp(1)) {
#        trans <- function(x) -log(x, base)
#        inv <- function(x) base^(-x)
#        trans_new(paste0("reverselog-", format(base)), trans, inv, 
#            log_breaks(base = base), 
#            domain = c(1e-100, Inf))
#    }
#    p <- p + scale_y_continuous(trans=reverselog_trans(10))
#
#    p <- p + theme_bw()
    print(p)


}
