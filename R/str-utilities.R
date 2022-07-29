##' wraping long string to multiple lines
##'
##' 
##' @title str_wrap
##' @param string input string
##' @param width the maximum number of characters before wrapping to a new line
##' @return update strings with new line character inserted
##' @export
##' @author Guangchuang Yu and Erqiang Hu
str_wrap <- function(string, width = getOption("width")) {
    # x <- gregexpr(' ', string)
    # vapply(seq_along(x),
    #        FUN = function(i) {
    #            y <- x[[i]]
    #            n <- nchar(string[i])
    #            len <- (c(y,n) - c(0, y)) ## length + 1
    #            idx <- len > width
    #            j <- which(!idx)
    #            if (length(j) && max(j) == length(len)) {
    #                j <- j[-length(j)]
    #            }
    #            if (length(j)) {
    #                idx[j] <- len[j] + len[j+1] > width
    #            }
    #            idx <- idx[-length(idx)] ## length - 1
    #            start <- c(1, y[idx] + 1)
    #            end <- c(y[idx] - 1, n)
    #            words <- substring(string[i], start, end)
    #            paste0(words, collapse="\n")
    #        },
    #        FUN.VALUE = character(1)
    # )
    result <- vapply(string,
           FUN = function(st) {
               words <- list()
               i <- 1
               while(nchar(st) > width) {
                   if (length(grep(" ", st)) == 0) break
                   y <- gregexpr(' ', st)[[1]]                  
                   n <- nchar(st)
                   y <- c(y,n)
                   idx <- which(y < width)
                   # When the length of first word > width
                   if (length(idx) == 0) idx <- 1
                   # Split the string into two pieces
                   # The length of first piece is small than width
                   words[[i]] <- substring(st, 1, y[idx[length(idx)]] - 1)
                   st <- substring(st, y[idx[length(idx)]] + 1, n)  
                   i <- i + 1
               }
               words[[i]] <- st
               paste0(unlist(words), collapse="\n")
           },
           FUN.VALUE = character(1)
    )
    names(result) <- NULL
    result
}

##' Detect the presence or absence of a pattern at the beginning or end of a string or string vector.
##'
##' 
##' @title str_starts
##' @rdname str-starts-ends
##' @param string input string
##' @param pattern pattern with which the string starts or ends
##' @param negate if TRUE, return non-matching elements
##' @return a logical vector
##' @export
##' @author Guangchuang Yu
str_starts <- function(string, pattern, negate=FALSE) {
    pattern <- paste0('^', pattern)
    str_detect(string, pattern, negate)
}

##' @rdname str-starts-ends
##' @export
str_ends <- function(string, pattern, negate=FALSE) {
    pattern <- paste0(pattern, '$')
    str_detect(string, pattern, negate)
}

##' @importFrom stats setNames
str_detect <- function(string, pattern, negate) {
    res <- setNames(
        vapply(string, grepl, pattern=pattern, 
                FUN.VALUE=logical(1)),
        NULL)
    if (negate) res <- !res
    return(res)            
}