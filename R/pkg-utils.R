##' loading a package
##'
##' The function use 'library()' to load the package. 
##' If the package is not installed, the function will try to install it before loading it.
##' @title pload
##' @param package package name
##' @param action function used to install package. 
##' If 'action = "auto"', it will try to use 'BiocManager::install()' if it is available.
##' @return the selected package loaded to the R session
##' @importFrom rlang as_name
##' @importFrom rlang enquo
##' @importFrom rlang check_installed
##' @importFrom cli cli_h2
##' @importFrom utils getFromNamespace
##' @export
##' @author Guangchuang Yu
pload <- function(package, action = "auto") {
    pkg <- as_name(enquo(package))
    if (action == "auto") {
        if (is.installed("BiocManager")) {
            install <- getFromNamespace("install", "BiocManager")
            action <- function(package, ask=FALSE, update=FALSE, ...){
                install(package, ask=ask, update = update, ...)
            }
        } else {
            action <- NULL
        }
    }
    check_installed(pkg, action = action)
    cli::cli_h2(sprintf("loading the package: %s", pkg))
    library(pkg, character.only = TRUE)
}


##' get reverse dependencies
##'
##'
##' @title get_dependencies
##' @param pkg package name
##' @param repo 'CRAN' and/or 'BioC'
##' @return reverse dependencies
## @importFrom BiocInstaller biocinstallRepos
##' @importFrom tools package_dependencies
##' @export
##' @author Guangchuang Yu
get_dependencies <- function(pkg, repo=c("CRAN", "BioC")) {
  rp <- get_repo(repo)

  db <- utils::available.packages(repo=rp)

  tools::package_dependencies(pkg, db=db, reverse=TRUE)
}

get_repo <- function(repo = c("CRAN", "BioC")) {
    rp <- c()
    if ('CRAN' %in% repo) {
        cran <- getOption("repos")["CRAN"]
        if (is.null(cran)) {
            cran <- "http://cloud.r-project.org/"
        }
        rp <- c(rp, cran)
    }
    if ('BioC' %in% repo) {
        bioc <- getOption("BioC_mirror")
        if (is.null(bioc)) {
            bioc <- "https://mirrors.tuna.tsinghua.edu.cn/bioconductor/"
        }
        rp <- c(rp, bioc)
    }
    ## options(repos = biocinstallRepos())

    sub("/$", "", rp)
}

##' Extract package title
##'
##'
##' @title packageTitle
##' @param pkg package name
##' @param repo 'CRAN' and/or 'BioC'
##' @return reverse dependencies
##' @importFrom utils packageDescription
##' @export
##' @author Guangchuang Yu
packageTitle <- function(pkg, repo='CRAN') {
    title <- tryCatch(packageDescription(pkg)$Title, error=function(e) NULL)

    if (is.null(title)) {
      repo_url <- get_repo(repo)
      if (repo == "CRAN") {
        url <- sprintf("%s/package=%s", repo_url, pkg)
      } else {
        bioc_type <- c("bioc", "workflows", "data/annotation", "data/experiment")
        url <- sprintf("%s/packages/release/%s/html/%s.html", repo_url, bioc_type, pkg)
      }

      ## x <- tryCatch(readLines(url), error = function(e) NULL)
      ## if (is.null(x)) return("")
      for (u in url) {      
        x <- tryCatch(yread(u), error = function(e) NULL)
        if (!is.null(x)) {
          break()
        }
      }

      if (is.null(x)) {
        return(NA)
      }

      i <- grep('^\\s*<h2>', x)
      if (grepl("</h2>$", x[i])) {
          xx <- x[i]
      } else {
          j <- grep('</h2>$', x)
          xx <- paste(x[i:j], collapse=" ")
      }

      title <- gsub('</h2>$', '', gsub('\\s*<h2>', '', xx))
    }
    sub("^\\w+\\s*:\\s*", "", gsub("\n", " ", title))
}


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
    call <- sys.call(1L)
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

  # check_pkg(pkg)
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
CRANpkg <- function(pkg) {
    cran <- "https://CRAN.R-project.org/package"
    fmt <- "[%s](%s=%s)"
    sprintf(fmt, pkgfmt(pkg), cran, pkg)
}

##' @rdname cran-bioc-pkg
##' @export
Biocpkg <- function(pkg) {
    sprintf("[%s](http://bioconductor.org/packages/%s)", pkgfmt(pkg), pkg)
}

##' print md text of package with link to github repo
##'
##'
##' @rdname github-pkg
##' @param user github user
##' @param pkg package name
##' @return md text string
##' @export
##' @author Guangchuang Yu
Githubpkg <- function(user, pkg) {
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

