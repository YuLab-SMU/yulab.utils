##' install github package 
##'
##' it download the zip file first and use `install_zip` to install it
##' @title install_zip_gh
##' @param repo github repo
##' @param ref github branch, default is master
##' @param args argument to build package
##' @return NULL
##' @export
##' @author Guangchuang Yu
install_zip_gh <- function(repo, ref = "master", args = "--no-build-vignettes") {
    ## repo <- 'GuangchuangYu/nCov2019'
    url <- paste0('https://codeload.github.com/', repo, '/zip/', ref)
    f <- tempfile(fileext=".zip")
    downloader::download(url, destfile=f)
    install_zip(f, args=args)
}

##' install R package from zip file of source codes
##'
##' 
##' @title install_zip
##' @param file zip file
##' @param args argument to build package
##' @return NULL
##' @export
##' @author Guangchuang Yu
install_zip <- function(file, args = "--no-build-vignettes") {
    dir <- tempfile()
    utils::unzip(file, exdir=dir)
    fs <- list.files(path=dir, full.names=T)
    if (length(fs) == 1 && dir.exists(fs)) {
        dir <- fs
    } 
    ## dir <- paste0(dir, '/', basename(repo), '-master')
    ## remotes::install_local(path=dir, ..., force=TRUE)
    pkg <- pkgbuild::build(dir, args=args)
    install.packages(pkg)
}
