#' Suppress messages and output from `x`
#' @title quiet
#' @param x some code
#' @return the result of `x`
#' @importFrom utils capture.output
#' @export
quiet <- function(x) {
    suppressMessages(capture.output(force(x), invisible = TRUE))
    invisible(force(x))
}
