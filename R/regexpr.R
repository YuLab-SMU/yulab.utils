#' @rdname regexpr-style
#' @family regex-utils
#' @export
set_PCRE <- function() {
    options(regexpr_use_perl = TRUE)
}

#' @rdname regexpr-style
#' @family regex-utils
#' @export
set_TRE <- function() {
    options(regexpr_use_perl = FALSE)
}

#' @rdname regexpr-style
#' @family regex-utils
#' @export
use_perl <- function() {
    res <- getOption("regexpr_use_perl", default = auto_set_regexpr_style())
    return(res)
}


#' Switch regular expression style (PCRE vs TRE)
#' @family regex-utils
#'
#' - `set_regexpr_style()` selects the style explicitly.
#' - `auto_set_regexpr_style()` chooses based on OS (TRE on Windows; PCRE elsewhere).
#' - `set_PCRE()` and `set_TRE()` force the style.
#'
#' These functions do not change the behavior of `gsub()`/`regexpr()` directly.
#' They set a global option that you can read via `use_perl()` and pass to `gsub()`/`regexpr()`.
#'
#' @rdname regexpr-style
#' @param style one of 'PCRE' or 'TRE'
#' @return Logical indicating whether to use `perl`
#' @references https://stackoverflow.com/questions/47240375/regular-expressions-in-base-r-perl-true-vs-the-default-pcre-vs-tre
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
