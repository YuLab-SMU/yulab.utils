##' Check whether the input packages are installed
##'
##' This function check whether the input packages are installed
##' @title is.installed
##' @param packages package names
##' @return logical vector
##' @export
##' @examples
##' is.installed(c("dplyr", "ggplot2"))
##' @author Guangchuang Yu
is.installed <- function(packages) {
  vapply(packages, function(package) {
    system.file(package=package) != ""
  }, logical(1))
}



##' load function from package
##'
##'
##' @title get_fun_from_pkg
##' @param pkg package
##' @param fun function
##' @return function
##' @export
##' @examples
##' get_fun_from_pkg('utils', 'zip')
##' @author Guangchuang Yu
get_fun_from_pkg <- function(pkg, fun) {
    ## v1
    ##
    ## requireNamespace(pkg)
    ## eval(parse(text=paste0(pkg, "::", fun)))

    ## v2
    ##
    ## require(pkg, character.only = TRUE)
    ## eval(parse(text = fun))

    utils::getFromNamespace(fun, pkg)
}
