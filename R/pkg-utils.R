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

##' Check whether the input packages are installed
##'
##' This function check whether the input packages are installed. If not, it asks the user whether to install the missing packages. 
##' @title check_pkg
##' @param pkg package names
##' @param reason the reason to check the pkg. If NULL, it will set the reason to the parent call.
##' @param ... additional parameters that passed to `rlang::check_installed()`
##' @return see also [check_installed][rlang::check_installed]
##' @export
##' @importFrom rlang check_installed
##' @author Guangchuang Yu
check_pkg <- function(pkg, reason=NULL, ...) {
  # v1
  #
  # if (!is.installed(pkg)) {
  #    msg <- sprintf("%s is required, please install it first", pkg)
  #    stop(msg)
  # }

  if (is.null(reason)) {
    call=sys.call(1L)
    reason <- sprintf("for %s()", as.character(call)[1])
  }
  rlang::check_installed(pkg, reason, ...)
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

  check_pkg(pkg)    
  utils::getFromNamespace(fun, pkg)
}



##' print md text of package with link to homepage (CRAN or Bioconductor)
##'
##'
##' @rdname cran-bioc-pkg
##' @param pkg package name
##' @return md text string
##' @export
##' @author Guangchuang Yu
CRANpkg <- function (pkg) {
    cran <- "https://CRAN.R-project.org/package"
    fmt <- "[%s](%s=%s)"
    sprintf(fmt, pkgfmt(pkg), cran, pkg)
}

##' @rdname cran-bioc-pkg
##' @export
Biocpkg <- function (pkg) {
    sprintf("[%s](http://bioconductor.org/packages/%s)", pkgfmt(pkg), pkg)
}

##' print md text of package with link to github repo
##'
##'
##' @title Githubpkg
##' @param user github user
##' @param pkg package name
##' @return md text string
##' @export
##' @author Guangchuang Yu
Githubpkg <- function (user, pkg) {
    gh <- "https://github.com"
    fmt <- "[%s](%s/%s/%s)"
    sprintf(fmt, pkgfmt(pkg), gh, user, pkg)
}

##' print md text of link to a pakcage
##' 
##'
##' @title mypkg
##' @param pkg package name
##' @param url package url
##' @return md text string
##' @export
##' @author Guangchuang Yu
mypkg <- function(pkg, url) {
    fmt <- "[%s](%s)"
    sprintf(fmt, pkgfmt(pkg), url)
}


pkgfmt <- function(pkg) {
  fmt <- getOption('yulab.utils_pkgfmt', default="%s")
  sprintf(fmt, pkg)
}

