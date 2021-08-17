##' read clipboard
##'
##'
##' @title read.cb
##' @param ... parameters for read.table
##' @return data.frame
##' @author Guangchuang Yu
##' @importFrom utils read.table
##' @export
read.cb <- function(...) {
    os <- Sys.info()[1]
    if (os == "Darwin") {
        read.table(pipe("pbpaste"), ...)
    } else {
        read.table("clipboard", ...)
    }
}

