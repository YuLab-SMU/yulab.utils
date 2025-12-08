#' Wrap long strings to multiple lines
#' @family str-utils
#'
#' 
#' @title str_wrap
#' @param string Input string
#' @param width Maximum characters before wrapping
#' @return Updated strings with `"\n"` inserted
#' @export
#' @author Guangchuang Yu
str_wrap <- function(string, width = getOption("width")) {
    result <- vapply(string,
           FUN = function(st) {
               if (!is.numeric(width) || length(width) != 1 || width < 1) {
                   return(st)
               }
               words <- list()
               i <- 1
               while (nchar(st) > width) {
                   if (!grepl(pattern = " ", x = st, perl = use_perl())) break
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


#' Detect patterns at the beginning or end of strings
#' @family str-utils
#'
#' 
#' @title str_starts
#' @rdname str-starts-ends
#' @param string Input string
#' @param pattern Pattern to match
#' @param negate If `TRUE`, return non-matching elements
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


#' Detect presence/absence of a match
#' @family str-utils
#' 
#' 
#' @title str_detect
#' @rdname str-detect
#' @param string Input string
#' @param pattern Pattern to look for
#' @param negate If `TRUE`, invert the result
#' @return Logical vector
#' @export
#' @author Guangchuang Yu
str_detect <- function(string, pattern, negate = FALSE) {
    ## faster than stringr::str_detect

    res <- grepl(pattern = pattern, x = string, perl = use_perl())
    if (negate) res <- !res
    return(res)            
}

#' Extract a substring using a pattern
#' @family str-utils
#' 
#' 
#' @title str_extract
#' @rdname str-extract
#' @param string Input string
#' @param pattern Regular expression to extract
#' @return Substring
#' @export
#' @author Guangchuang Yu
str_extract <- function(string, pattern) {
    i <- regexpr(pattern = pattern, text = string, perl = use_perl())
    j <- attr(i, 'match.length')
    res <- substring(string, i, i+j-1)
    res[res == ""] <- NA
    return(res)
}

