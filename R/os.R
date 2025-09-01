##' run system command
##'
##'
##' @title exec
##' @param command system command to run
##' @return An `exec` instance that stores system command outputs
##' @export
##' @author Guangchuang Yu
exec <- function(command) {
    res <- system(command, intern=TRUE)
    structure(res, class = "exec")
}



##' @method print exec
##' @export
print.exec <- function(x, ...) {
    cat(x, sep='\n')
}
    

has_bin <- function(bin) {
    os <- which_os()
    which <- "which"
    if (os == "Windows") {
        which <- "where"
    }

    command <- sprintf("%s %s", which, bin)

    exit_code <- system(command, 
        ignore.stdout = TRUE, 
        ignore.stderr = TRUE)

    return(exit_code == 0)    
}

##' test for internect connection via reading lines from a URL
##'
##'
##' @title has_internet
##' @param site URL to test connection
##' @return logical value
##' @export
##' @author Guangchuang Yu
has_internet <- function(site = "https://www.baidu.com/") {
    ret <- tryCatch(
        suppressWarnings(readLines(site, n = 1)),
        error = function(e) NULL
    )
    
    return(!is.null(ret))
}

which_os <- function() {
    Sys.info()[1]
}

#' get the user dir to save app caches, logs and data (a wrapper function of `rappdirs::user_cache_dir()`)
#' 
#' @title user_dir
#' @param appname App name
#' @param appauthor App author
#' @param ... additional parameters
#' @return a directory (created if not exists)
#' @importFrom rappdirs user_data_dir
#' @export
#' @author Guangchuang Yu
user_dir <- function(appname = NULL, appauthor = NULL, ...) {
    dir <- rappdirs::user_data_dir(
        appname = appname, 
        appauthor = appauthor, 
        ...)

    if (!dir.exists(dir)) dir.create(dir, recursive = TRUE)
    
    return(dir)
}
