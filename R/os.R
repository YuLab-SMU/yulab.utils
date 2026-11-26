#' run system command
#' @family os-utils
#'
#'
#' @title exec
#' @param command system command to run
#' @return An `exec` instance that stores system command outputs
#' @export
#' @author Guangchuang Yu
exec <- function(command) {
    res <- system(command, intern=TRUE)
    structure(res, class = "exec")
}



#' @method print exec
#' @export
print.exec <- function(x, ...) {
    cat(x, sep='\n')
}
    


which_cmd <- function(bin) {
    os <- which_os()
    which <- "which"
    if (os == "Windows") {
        which <- "where"
    }

    command <- sprintf("%s %s", which, bin)

    return(command)
}

has_bin <- function(bin) {
    command <- which_cmd(bin)

    exit_code <- system(command, 
        ignore.stdout = TRUE, 
        ignore.stderr = TRUE)

    return(exit_code == 0)    
}


where <- function(bin) {
    if (!has_bin(bin)) return("")
    
    command <- which_cmd(bin)
    exec(command)
}

#' test for internect connection via reading lines from a URL
#' @family os-utils
#'
#'
#' @title has_internet
#' @param site URL to test connection
#' @return logical value
#' @export
#' @author Guangchuang Yu
has_internet <- function(site = "https://www.baidu.com/") {
    ret <- tryCatch(
        suppressWarnings(readLines(site, n = 1)),
        error = function(e) NULL
    )
    
    return(!is.null(ret))
}

which_os <- function() {
    Sys.info()[["sysname"]]
}

#' get the user dir to save app caches, logs and data (a wrapper function of `tools::R_user_dir()`)
#' @family os-utils
#' 
#' @title user_dir
#' @param appname App name (a single directory name)
#' @param which one of "data", "config" or "cache", see `tools::R_user_dir()`
#' @param appauthor ignored, kept for backward compatibility
#' @param ... passed on to `tools::R_user_dir()`
#' @return a directory (created if not exists)
#'
#' @details
#' `tools::R_user_dir()` is used instead of `rappdirs::user_data_dir()`
#' because it honors the `R_USER_<which>_DIR` environment variables, with
#' which `R CMD check` (and CRAN) redirects all user-level directories to a
#' temporary location. A directory written outside of `tempdir()` during
#' checks violates the CRAN policy.
#' @export
#' @author Guangchuang Yu
user_dir <- function(appname = NULL, which = c("data", "config", "cache"), appauthor = NULL, ...) {
    which <- match.arg(which)
    if (is.null(appname)) {
        stop("'appname' is required")
    }
    dir <- tools::R_user_dir(package = appname, which = which, ...)

    if (!dir.exists(dir)) dir.create(dir, recursive = TRUE)
    
    return(dir)
}
