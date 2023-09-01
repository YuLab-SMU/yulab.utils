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


##' Convert a list of vector to a data.frame object.
##'
##'
##' @title Convert a list of vector (e.g, gene IDs) to a data.frame object
##' @param inputList A list of vector
##' @return a data.frame object.
##' @export
ls2df <- function(inputList) {
    # ldf <- lapply(1:length(inputList), function(i) {
    ldf <- lapply(seq_len(length(inputList)), function(i) {
        data.frame(category=rep(names(inputList[i]),
                                  length(inputList[[i]])),
                   value=inputList[[i]])
    })

    do.call('rbind', ldf)
}

