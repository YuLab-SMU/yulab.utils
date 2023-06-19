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
    