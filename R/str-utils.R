#' wraping long string to multiple lines
#'
#' 
#' @title str_wrap
#' @param string input string
#' @param width the maximum number of characters before wrapping to a new line
#' @return update strings with new line character inserted
#' @export
#' @author Guangchuang Yu
str_wrap <- function(string, width = getOption("width")) {
    ##
    ## speed comparison
    ##   str_wrap() > stringr::str_wrap() > paste0(base::strwrap(), collapse = "\n")
    ##

    result <- vapply(string,
           FUN = function(st) {
               words <- list()
               i <- 1
               while(nchar(st) > width) {
                   if (length(grep(pattern = " ", x = st, perl = use_perl())) == 0) break
                   y <- gregexpr(pattern = ' ', text = st, perl = use_perl())
                   y <- y[[1]]                  
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


#' Detect the presence or absence of a pattern at the beginning or end of a string or string vector.
#'
#' 
#' @title str_starts
#' @rdname str-starts-ends
#' @param string input string
#' @param pattern pattern with which the string starts or ends
#' @param negate if TRUE, return non-matching elements
#' @return a logical vector
#' @export
#' @author Guangchuang Yu
str_starts <- function(string, pattern, negate=FALSE) {
    pattern <- paste0('^', pattern)
    str_detect(string, pattern, negate)
}

#' @rdname str-starts-ends
#' @export
str_ends <- function(string, pattern, negate=FALSE) {
    pattern <- paste0(pattern, '$')
    str_detect(string, pattern, negate)
}


#' Detect the presentce/absence of a match
#' 
#' 
#' @title str_detect
#' @rdname str-detect
#' @param string input string
#' @param pattern pattern to look for
#' @param negate if TRUE, inverts the resulting boolen vector
#' @return logical vector
#' @export
#' @author Guangchuang Yu
str_detect <- function(string, pattern, negate = FALSE) {
    ## faster than stringr::str_detect

    res <- grepl(pattern = pattern, x = string, perl = use_perl())
    if (negate) res <- !res
    return(res)            
}

#' Extract a substring using a pattern
#' 
#' 
#' @title str_extract
#' @rdname str-extract
#' @param string input string
#' @param pattern a regular expression to describe the pattern to extracted from the 'string'
#' @return substring
#' @export
#' @author Guangchuang Yu
str_extract <- function(string, pattern) {
    i <- regexpr(pattern = pattern, text = string, perl = use_perl())
    j <- attr(i, 'match.length')
    res <- substring(string, i, i+j-1)
    res[res == ""] <- NA
    return(res)
}

