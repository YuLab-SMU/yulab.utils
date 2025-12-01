#' convert a matrix to a tidy data frame
#' (from wide to long format as described in the tidyverse concept)
#'
#'
#' @title mat2df
#' @param x the input matrix
#' @return a data.frame in long format with the 'value' column stores the original values
#' and 'row' and 'col' columns stored in row and column index as in x
#' @examples
#' x <- matrix(1:15, nrow = 3)
#' mat2df(x)
#' @export
#' @author Guangchuang Yu
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

#' convert a matrix to a list
#'
#'
#' @title mat2list
#' @param x the input matrix
#' @return a list that contains matrix columns as its elements
#' @examples
#' x <- matrix(1:15, nrow = 3)
#' mat2list(x)
#' @export
mat2list <- function(x){
  lapply(seq_len(ncol(x)), function(i) x[,i])
}
