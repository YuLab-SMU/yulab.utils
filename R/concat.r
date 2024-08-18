c2 <- function(x, y) {
    same_mode <- (is.numeric(x) && is.numeric(y)) ||
        (is.character(x) && is.character(y))

    if (!same_mode) stop("x and y should be both numeric or character vector.")

    X <- as_chunked_array(x)
    Y <- as_chunked_array(y)
    
    res <- structure(
        list(
            vector_list = c(X$vector_list, Y$vector_list),
            idx = c(X$idx, Y$idx + length(X))
        ),
        class = "chunked_array"
    )

    return(res)
}

as_chunked_array <- function(x) {
    if (inherits(x, "chunked_array")) return(x)

    if (!is.numeric(x) && !is.character(x)) {
        stop("only numeric/character vector supported")
    }

    structure(
        list(
            vector_list = list(x),
            idx = 0
        ),
        class = "chunked_array"
    )
}


#' @method as.vector chunked_array
as.vector.chunked_array <- function(x, mode = "any") {
    unlist(x$vector_list)
}

#' @method print chunked_array
print.chunked_array <- function(x) {
    n <- length(x)
    msg <- sprintf("chunked array with size of %d\n", n)
    cat(msg)
}

#' @method length chunked_array
length.chunked_array <- function(x) {
    last_item(x$idx) + length(last_item(x$vector_list))
}

last_item <- function(x) {
    if (is.list(x)) return(x[[length(x)]])

    x[length(x)]
}

#' @method [ chunked_array
`[.chunked_array` <- function(x, i, ...) {
    array_idx <- vapply(i, \(ii) last_item(which(ii > x$idx)), numeric(1))

    pos <- i - x$idx[array_idx]

    output <- ifelse(is.numeric(x), numeric(1), character(1))
    vapply(seq_along(i), \(j) x$vector_list[[array_idx[j]]][pos[j]], output)
}


#' @method is.numeric chunked_array
is.numeric.chunked_array <- function(x) {
    is.numeric(x$vector_list[[1]])
}

#' @method is.character chunked_array
is.character.chunked_array <- function(x) {
    is.character(x$vector_list[[1]])
}
