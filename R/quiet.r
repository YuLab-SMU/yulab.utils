#' Suppress messages and output from `x`
#' @title quiet
#' @param x some code
#' @return the result of `x`
#' @importFrom utils capture.output
#' @export
quiet <- function(x) {
    res <- suppressMessages({
        out <- NULL
        capture.output({
            out <- force(x)
        }, file = NULL)
        out
    })
    invisible(res)
}
