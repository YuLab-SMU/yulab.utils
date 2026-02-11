#' Concatenate vectors into a chunked array
#' 
#' Combine two vector or chunked_array objects into a single
#' chunked_array without copying the underlying data.
#' @title Concatenate Chunked Arrays
#' @param x a vector or chunked_array object
#' @param y a vector or chunked_array object
#' @return A chunked_array object
#' @examples
#' a <- c2(1:100, 101:200)
#' length(a)
#' a[150]
#' @author Guangchuang Yu
#' @export
c2 <- function(x, y) {
    
    if (length(x) == 0) return(as_chunked_array(y))
    if (length(y) == 0) return(as_chunked_array(x))

    same_mode <- (ca_is_numeric(x) && ca_is_numeric(y)) ||
        (ca_is_character(x) && ca_is_character(y))

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

#' Convert to chunked_array
#' 
#' Convert a numeric or character vector to a chunked_array object.
#' If the input is already a chunked_array, it is returned as-is.
#' @param x a vector or chunked_array object
#' @return A chunked_array object
#' @export
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

#' @method c chunked_array
#' @export
c.chunked_array <- function(...) {
    args <- list(...)
    Reduce(c2, args)
}

#' @method as.vector chunked_array
#' @export
as.vector.chunked_array <- function(x, mode = "any") {
    unlist(x$vector_list)
}

#' @method print chunked_array
#' @export
print.chunked_array <- function(x, ...) {
    n <- length(x)
    msg <- sprintf("chunked array with size of %d\n", n)
    cat(msg)
}

#' @method length chunked_array
#' @export
length.chunked_array <- function(x) {
    if (length(x$vector_list) == 0) return(0L)
    last_item(x$idx) + length(last_item(x$vector_list))
}

#' @noRd
last_item <- function(x) {
    if (is.list(x)) return(x[[length(x)]])

    x[length(x)]
}

#' @noRd
ca_is_numeric <- function(x) {
    if (inherits(x, "chunked_array")) return(is.numeric(x$vector_list[[1]]))
    is.numeric(x)
}

#' @noRd
ca_is_character <- function(x) {
    if (inherits(x, "chunked_array")) return(is.character(x$vector_list[[1]]))
    is.character(x)
}

#' @method [ chunked_array
#' @export
`[.chunked_array` <- function(x, i, ...) {
    total_len <- length(x)
    transformed_i <- seq_len(total_len)[i]
    
    if (length(transformed_i) == 0) {
        return(if (is.numeric(x)) numeric(0) else character(0))
    }

    na_mask <- is.na(transformed_i)
    valid_i <- transformed_i[!na_mask]
    
    if (is.numeric(x)) {
        res <- rep(NA_real_, length(transformed_i))
    } else {
        res <- rep(NA_character_, length(transformed_i))
    }

    if (length(valid_i) > 0) {
        chunk_indices <- findInterval(valid_i - 1, x$idx)
        relative_pos <- valid_i - x$idx[chunk_indices]

        if (is.numeric(x)) {
            out_valid <- rep(NA_real_, length(valid_i))
        } else {
            out_valid <- rep(NA_character_, length(valid_i))
        }

        grp <- split(seq_along(valid_i), chunk_indices)
        for (ci in names(grp)) {
            idxs <- grp[[ci]]
            out_valid[idxs] <- x$vector_list[[as.integer(ci)]][relative_pos[idxs]]
        }
        res[!na_mask] <- out_valid
    }
    
    return(res)
}


#' @method is.numeric chunked_array
#' @export
is.numeric.chunked_array <- function(x) {
    is.numeric(x$vector_list[[1]])
}

#' @method is.character chunked_array
#' @export
is.character.chunked_array <- function(x) {
    is.character(x$vector_list[[1]])
}
