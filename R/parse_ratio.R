##' Parse character ratio to double, e.g., `1/5` → `0.2`
##'
##' 
##' @title parse_ratio
##' @param ratio Character vector of ratios
##' @return Numeric vector
##' @export
##' @author Guangchuang Yu
parse_ratio <- function(ratio) {
    x <- as.character(ratio)
    x <- sub("^\\s*", "", x)
    x <- sub("\\s*$", "", x)
    suppressWarnings({
        numerator <- as.numeric(sub("/\\s*\\d+$", "", x))
        denominator <- as.numeric(sub("^\\s*\\d+\\s*/\\s*", "", x))
    })
    bad <- is.na(numerator) | is.na(denominator) | denominator == 0
    res <- numerator/denominator
    res[bad] <- NA_real_
    res
}

