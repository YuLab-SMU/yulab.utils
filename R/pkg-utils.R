#' Load a package
#'
#' Uses `library()` to load `package`. If not installed, attempts installation
#' via `rlang::check_installed()` (optionally using `BiocManager::install()`).
#' @title pload
#' @param package package name
#' @param action Installation function; `"auto"` tries `BiocManager::install()` if available
#' @return the selected package loaded to the R session
#' @importFrom rlang as_name
#' @importFrom rlang enquo
#' @importFrom rlang check_installed
#' @importFrom cli cli_h2
#' @importFrom utils getFromNamespace
#' @export
#' @author Guangchuang Yu
#' @family pkg-utils
pload <- function(package, action = "auto") {
    pkg <- as_name(enquo(package))
    if (action == "auto") {
        if (is.installed("BiocManager")) {
            install <- getFromNamespace("install", "BiocManager")
            action <- function(package, ask=FALSE, update=FALSE, ...) {
                install(package, ask=ask, update = update, ...)
            }
        } else {
            action <- NULL
        }
    }
    check_installed(pkg, action = action)
    pkg <- sub("\\w+/", "", pkg) # for github pkg: repo/pkg
    cli::cli_h2(sprintf("loading the package: %s", pkg))
    library(pkg, character.only = TRUE)
}


#' Get reverse dependencies
#'
#'
#' @title get_dependencies
#' @param pkg package name
#' @param repo 'CRAN' and/or 'BioC'
#' @return reverse dependencies
## @importFrom BiocInstaller biocinstallRepos
#' @importFrom tools package_dependencies
#' @export
#' @author Guangchuang Yu
#' @family pkg-utils
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

#' Extract package title
#'
#'
#' @title packageTitle
#' @param pkg package name
#' @param repo 'CRAN' and/or 'BioC'
#' @return reverse dependencies
#' @importFrom utils packageDescription
#' @export
#' @author Guangchuang Yu
#' @family pkg-utils
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

      for (u in url) {
        x <- tryCatch({
          if (is.installed("httr2")) {
            req <- httr2::request(u) |> httr2::req_timeout(5)
            resp <- httr2::req_perform(req)
            httr2::resp_body_string(resp)
          } else {
            yread(u)
          }
        }, error = function(e) NULL)
        if (!is.null(x)) {
          break()
        }
      }

      if (is.null(x)) {
        return(NA)
      }

      if (length(grep("<h2", x)) == 0) {
        # fallback: try <title>
        tt <- sub(".*<title>\\s*(.*?)\\s*</title>.*", "\\1", paste(x, collapse = " "))
        title <- tt
      } else {
        i <- grep('^\\s*<h2>', x)
        if (grepl("</h2>$", x[i])) {
            xx <- x[i]
        } else {
            j <- grep('</h2>$', x)
            xx <- paste(x[i:j], collapse=" ")
        }
        title <- gsub('</h2>$', '', gsub('\\s*<h2>', '', xx))
      }
    }
    sub("^\\w+\\s*:\\s*", "", gsub("\n", " ", title))
}


#' Check whether packages are installed
#' @title is.installed
#' @param packages package names
#' @return logical vector
#' @export
#' @examples
#' is.installed(c("dplyr", "ggplot2"))
#' @author Guangchuang Yu
#' @family pkg-utils
is.installed <- function(packages) {
  vapply(packages, function(package) {
    system.file(package=package) != ""
  }, logical(1))
}



#' load function from package
#'
#'
#' @title get_fun_from_pkg
#' @param pkg package
#' @param fun function
#' @return function
#' @export
#' @examples
#' get_fun_from_pkg('utils', 'zip')
#' @author Guangchuang Yu
#' @family pkg-utils
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



#' Markdown link to CRAN/Bioconductor
#'
#'
#' @rdname cran-bioc-pkg
#' @param pkg package name
#' @return md text string
#' @export
#' @author Guangchuang Yu
#' @family pkg-utils
CRANpkg <- function(pkg) {
    cran <- "https://CRAN.R-project.org/package"
    fmt <- "[%s](%s=%s)"
    sprintf(fmt, pkgfmt(pkg), cran, pkg)
}

#' @rdname cran-bioc-pkg
#' @export
Biocpkg <- function(pkg) {
    sprintf("[%s](http://bioconductor.org/packages/%s)", pkgfmt(pkg), pkg)
}

#' Markdown link to GitHub
#'
#'
#' @rdname github-pkg
#' @param user github user
#' @param pkg package name
#' @return md text string
#' @export
#' @author Guangchuang Yu
#' @family pkg-utils
Githubpkg <- function(user, pkg) {
    gh <- "https://github.com"
    fmt <- "[%s](%s/%s/%s)"
    sprintf(fmt, pkgfmt(pkg), gh, user, pkg)
}

#' Markdown link to a package
#' 
#'
#' @title mypkg
#' @param pkg package name
#' @param url package url
#' @return md text string
#' @export
#' @author Guangchuang Yu
#' @family pkg-utils
mypkg <- function(pkg, url) {
    fmt <- "[%s](%s)"
    sprintf(fmt, pkgfmt(pkg), url)
}


pkgfmt <- function(pkg) {
  fmt <- getOption('yulab.utils_pkgfmt', default="%s")
  sprintf(fmt, pkg)
}

