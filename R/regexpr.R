#' @rdname regexpr-style
#' @export
set_PCRE <- function() {
    options(regexpr_use_perl = TRUE)
}

#' @rdname regexpr-style
#' @export
set_TRE <- function() {
    options(regexpr_use_perl = FALSE)
}

#' @rdname regexpr-style
#' @export
use_perl <- function() {
    res <- getOption("regexpr_use_perl", default = auto_set_regexpr_style())
    return(res)
}


#' switch regular expression style (PCRE vs TRE)
#'
#' The `set_regexpr_style()` allows user to specify which style to be used, 
#' while the `auto_set_regexpr_style()` automatically set the style depdending on 
#' the operating system (TRE for Windows and PCRE for other OSs (Linux and Mac)).
#' 
#' `set_PCRE()` force to use PCRE style while `set_TRE()` force to use TRE. 
#' 
#' Note that all these functions are not change the behavior of `gsub()` and `regexpr()`. 
#' The functions are just set a global option to store the user's choice of whether using `perl = TRUE`.
#'
#' Users can access the option via `use_perl()` and pass the return value to `gusb()` or `regexpr()` to specify the style in use.
#' 
#' @rdname regexpr-style
#' @param style one of 'PCRE' or 'TRE'
#' @return logical value of whether use perl
#' @references <https://stackoverflow.com/questions/47240375/regular-expressions-in-base-r-perl-true-vs-the-default-pcre-vs-tre>
#' @export
#' @author Guangchuang Yu
set_regexpr_style <- function(style) {
    if (missing(style)) {
        message("style is not specific, set automatically.")
        auto_set_regexpr_style()
    } else {
        style <- match.arg(style, c("PCRE", "TRE"))
        if (style == "PCRE") {
            set_PCRE()
        } else {
            set_TRE()
        }
    }
    res <- getOption("regexpr_use_perl")
    invisible(res)
}

#' @rdname regexpr-style
#' @export
auto_set_regexpr_style <- function() {
    if (which_os() == "Windows") {
        set_TRE()
        res <- FALSE
    } else {
        set_PCRE()
        res <- TRUE
    }
    invisible(res)
}
