#' Concatenates bar name and value
#'
getNewNames <- function(df, valueString, nameString, suffix="", digits=NA){
    newName <- df[[nameString]]
    val <- df[[valueString]]
    if (is.numeric(digits)){
        fmt <- paste0("%.", digits, "f")
        val <- sprintf(fmt, val)
    }

    n <- length(newName)
    for (i in seq_len(n)){
        newName[i] <- paste0(newName[i], "   ", val[i], suffix)
    }
    return(newName)
}


#' A nice horizontal bar plot
#'
#' Uses ggplot to make nice horizontal bar plot
#'
#' @param df A data frame, where the first column is the names and second 
#'           column is the values. Order of the names matters; will display
#'           names top to bottom.
#'
#' @param plot.theme Either \code{"light"} (default) or \code{"dark"}.
#'
#' @param bar.theme One of 
#'               \code{c("red", "orange", "yellow", "blue", "green", "purple")}.
#'               If not one of these, then will use \code{"blue"} (default).
#'
#' @param xlab x-axis label; default is \code{NULL}, which is empty.
#'
#' @param ylab y-ayis label; default is \code{NULL}, which is empty.
#'
#' @param ylab title label; default is \code{NULL}, which is empty.
#'
#' @param suffix Character string that will be appended to new names.
#'               Default is \code{""}.
#'
#' @param x.text.size Size of text on x-axis. Default is code{8}.
#'
#' @param y.text.size Size of text on y-axis. Default is code{10}.
#'
#' @param title.text.size Size of text on titleaxis. Default is code{14}.
#'
#' @param text.face One of \code{c("plain", "italic", "bold", "bold.italic")}. 
#'                  Default is \code{"bold"}.
#'
#' @param useNewNames If \code{TRUE} (default), will add value of bar to the 
#'                    bar name.
#'
#' @param uselog If \code{TRUE} (default is \code{FALSE}), will log the 
#'               x-axis scale.
#'
#' @param digits Number of digits for rounding values for new names.
#'
#' @param x.axis.show If \code{TRUE} (default is \code{FALSE}), will show
#'               the x-axis tick marks and values.
#'
gghbar <- function(df=data.frame(names=c("Z", "X", "Y"), values=c(12, 10, 5), 
                                 stringsAsFactors=F), 
                   plot.theme="light", 
                   bar.theme="blue", 
                   bar.width=0.5,
                   xlab=NULL, 
                   ylab=NULL, 
                   title=NULL, 
                   suffix="",
                   x.text.size=8,
                   y.text.size=10, 
                   title.text.size=14, 
                   text.face="bold", 
                   useNewNames=T, 
                   uselog=F,
                   digits=NA,
                   x.axis.show=F){

    # load ggplot2
    suppressMessages(require(ggplot2))
    df <- df[rev(seq_len(nrow(df))), ]
    if (useNewNames){
        newName <- getNewNames(df, names(df)[2], names(df)[1], suffix=suffix, digits=digits)
        df[[1]] <- newName
    }
    names(df) <- c("namesCol", "valuesCol")

    backcol <- NA
    textcol <- "black"
    if (plot.theme == "dark"){
        backcol <- "#181818"
        textcol <- "#FFFFFF"
    } 

    #mycol <- "#69b3a2"
    # BLUE is default
    fillCol <- "#4da6ff"
    outCol <- "#1a8cff"
    # lightblue <- "#4da6ff"
    # darkblue <- "#1a8cff"

    if ( bar.theme=="red" ){
        fillCol <- "#F03838"
        outCol <- "#D02F2F"
    }

    if ( bar.theme=="orange" ){
        #fillCol <- "#FF9933"
        fillCol <- "#FF8000"
        outCol <- "#CC6600"
    }

    if ( bar.theme=="yellow" ){
        fillCol <- "#FFFF00"
        outCol <- "#CCCC00"
    }

    if ( bar.theme=="green" ){
        fillCol <- "#3BD464"
        outCol <- "#26A548"
    }

    if ( bar.theme=="blue" ){
        fillCol <- "#4da6ff"
        outCol <- "#1a8cff"
    }

    if ( bar.theme=="purple" ){
        fillCol <- "#7F00FF"
        outCol <- "#6600CC"
    }

#    mywidth <- 0.5
    #backcol <- "black"
    #textcol <- "white"
    #backcol <- "white"
    #textcol <- "black"
    #ylabstring <- NULL
#    ylab <- "87,317 responses; select all that apply "
#    xlabstring <- NULL
    p <- ggplot(df, aes(namesCol, valuesCol)) + geom_col(fill=fillCol, color=outCol, width=bar.width) 
    p <- p + xlab(xlab) + ylab(ylab) + ggtitle(title)
    p <- p + coord_flip()
    p <- p  + scale_x_discrete(limits = df$namesCol)
    p <- p + theme_classic()

    p <- p + theme(axis.text.y = element_text(colour=textcol, size=y.text.size, face=text.face, margin=margin(0,0,0,0,"cm")),
                   axis.title.x = element_text(colour = textcol, size=x.text.size),
                   title = element_text(colour = textcol, size=title.text.size),
                   plot.background = element_rect(fill = backcol, color=NA), 
                   #plot.background = element_rect(fill = backcol), 
                   panel.background = element_rect(fill = backcol),
                   axis.ticks.y = element_blank(),   
                   axis.line.y = element_blank())

    if (uselog){
        p <- p + scale_y_log10()
#        p <- p + scale_y_continuous(trans='log10')
    }

    if (x.axis.show==F){
        p <- p + theme( axis.text.x = element_blank(), 
                        axis.ticks.x = element_blank(), 
                        axis.line.x = element_blank())
    } else {
        p <- p + theme( axis.text.x = element_text(colour=textcol), 
                        axis.ticks.x = element_line(colour=textcol), 
                        axis.line.x = element_line(colour=textcol) )
    }
    return(p)
}

#' Sample data, from Stackoverflow
#' 
#' A dataframe containing a selection of development environments
#' and the proportion of users who use them
#' 
getIDEData <- function(){
    dfstring <- 
        "VisualStudioCode,50.7\n
    VisualStudio,31.5\n
    Notepad++,30.5\n
    Vim,25.4\n
    SublimeText,23.4\n
    Eclipse,14.4\n
    PyCharm,13.4\n
    Atom,13.3\n
    IPython/Jupyter,9.5\n
    Emacs,4.5\n
    RStudio,3.4\n
    TextMate,0.9\n"

    #df <- read.table(file=filename, header=F, sep=",", stringsAsFactors=F)
    df <- read.table(text=dfstring, header=F, sep=",", stringsAsFactors=F)
    names(df) <- c("ide", "perc")
    return(df)
}
