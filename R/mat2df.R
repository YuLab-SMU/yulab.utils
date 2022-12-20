##' convert a matrix to a tidy data frame (from wide to long format as described in the tidyverse concetp)
##'
##'
##' @title mat2df
##' @param x the input matrix
##' @return a data.frame in long format with the 'value' column stores the original values and 'row' and 'col' columns stored in row and column index as in x
##' @examples
##' x <- matrix(1:15, nrow = 3)
##' mat2df(x)
##' @export
##' @author Guangchuang Yu
mat2df <- function(x) {
    nr <- nrow(x)
    nc <- ncol(x)
    d <- data.frame(
        value = as.vector(x),
        row = rep(1:nr, times = nc),
        col = rep(1:nc, each = nr)
    )
    return(d)
}

