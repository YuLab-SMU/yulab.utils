#' Row-bind a list
#'
#'
#' @title rbindlist
#' @param x List with similar elements that can be row-bound
#' @return `data.frame`
#' @author Guangchuang Yu
#' @export
rbindlist <- function(x) {
    do.call('rbind', x)
}


#' Convert a list of vectors to a data.frame
#'
#'
#' @title Convert a list of vectors (e.g., gene IDs) to `data.frame`
#' @param inputList List of vectors
#' @return `data.frame`
#' @export
ls2df <- function(inputList) {
    # ldf <- lapply(1:length(inputList), function(i) {
    ldf <- lapply(seq_len(length(inputList)), function(i) {
        data.frame(category=rep(names(inputList[i]),
                                  length(inputList[[i]])),
                   value=inputList[[i]])
    })

    do.call('rbind', ldf)
}

