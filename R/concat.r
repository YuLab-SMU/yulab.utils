c2 <- function(x, y) {
    # copy values without actually combining them.
    # todo: without copy values :)

    same_mode <- (is.numeric(x) && is.numeric(y)) ||
        (is.character(x) && is.character(y))

    if (!same_mode) stop("x and y should be both numeric or character vector.")

    if (!inherits(x, "chunked_array")) {
        vector_list <- list(x, y)
        n <- sapply(vector_list, length)
        last_size <- n[length(n)]
        idx <- cumsum(c(0, n[-length(n)]))
        res <- structure(
            list(
                vector_list = vector_list,
                is_numeric = is.numeric(y),
                idx = idx,
                last_size = last_size
            ),
            class = "chunked_array")
        return(res)        
    }


    x$vector_list <- c(x$vector_list, list(y))
    x$idx <- c(x$idx, x$idx[length(x$idx)] + x$last_size)
    x$last_size <- length(y)

    return(x)
}

#' @method as.vector chunked_array
as.vector.chunked_array <- function(x, mode = "any") {
    do.call('c', x$vector_list)
}

#' @method print chunked_array
print.chunked_array <- function(x) {
    n <- x$idx[length(x$idx)] + x$last_size
    msg <- sprintf("chunked array with size of %d\n", n)
    cat(msg)
}

#' @method [ chunked_array
`[.chunked_array` <- function(x, i, ...) {
    j <- sapply(i, function(ii) {
        nn <- which(ii > x$idx)
        nn[length(nn)]
    })

    pos <- i - x$idx[j]

    sapply(seq_along(pos), function(k) {
        x$vector_list[[j[k]]][pos[k]]
    })
}


#' @method is.numeric chunked_array
is.numeric.chunked_array <- function(x) {
    x$is_numeric
}

#' @method is.character chunked_array
is.character.chunked_array <- function(x) {
    !is.numeric(x)
}
