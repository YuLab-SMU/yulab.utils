##' rbind a list
##'
##'
##' @title rbindlist
##' @param x a list that have similar elements that can be rbind to a data.frame
##' @return data.frame
##' @author Guangchuang Yu
##' @export
rbindlist <- function(x) {
    do.call('rbind', x)
}
