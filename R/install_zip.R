##' install github package 
##'
##' it download the zip file first and use `install_zip` to install it
##' @title install_zip_gh
##' @param repo github repo
##' @param ref github branch, default is master
##' @param args argument to build package
##' @return No return value, called for installing github package
##' @importFrom utils download.file
##' @export
##' @author Guangchuang Yu
install_zip_gh <- function(repo, ref = "master", args = "--no-build-vignettes") {
    ## repo <- 'GuangchuangYu/nCov2019'
    url <- paste0('https://codeload.github.com/', repo, '/zip/', ref)
    f <- tempfile(fileext=".zip")
    method <- "auto"
    if (.Platform$OS.type == "windows") method <- "curl"
    utils::download.file(url, destfile=f, method = method)
    if (!is_valid_zip(f)) {
        stop("Invalid zip file downloaded, please check the 'ref' parameter to set a correct github branch.")
    }
    install_zip(f, args=args)
}

##' install R package from zip file of source codes
##'
##' 
##' @title install_zip
##' @param file zip file
##' @param args argument to build package
##' @return No return value, called for install R package from zip file of source codes
##' @export
##' @author Guangchuang Yu
install_zip <- function(file, args = "--no-build-vignettes") {
    dir <- tempfile()
    utils::unzip(file, exdir=dir)
    fs <- list.files(path=dir, full.names=T)
    #if (length(fs) == 1 && dir.exists(fs)) {
    #    dir <- fs
    #}
    ## dir <- paste0(dir, '/', basename(repo), '-master')
    dir <- fs[which.max(file.info(fs)$atime)]

    if ("INDEX" %in% list.files(dir)) {
        # file is binary package
        pkg <- file
    } else {  
        # file is zip of package source
        ## remotes::install_local(path=dir, ..., force=TRUE)
        ## pkg <- pkgbuild::build(dir, args=args)
        build <- get_fun_from_pkg('pkgbuild', 'build')
        pkg <- build(dir, args=args)
    }
    utils::install.packages(pkg, repos=NULL)
}


is_valid_zip <- function(zipfile) {
    fs <- tryCatch(utils::unzip(zipfile, list=TRUE), error = function(e) NULL)
    if (is.null(fs)) return(FALSE)
    return(TRUE)
}

